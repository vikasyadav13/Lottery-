    pragma solidity 0.4.17;
        contract Lottery2{
        address public manager;
        address[] public players;
        function Lottery1() public {
            manager = msg.sender;
        }
        function enter()public payable {
            require(msg.value > 0.1 ether);
            
            players.push(msg.sender);
        }

        function random() private view returns (uint) {
            uint(keccak256(block.difficulty, block.timestamp, players));
        }
        function pickWinner() public restricted {
            
            uint index = random() % players.length;
            players[index].transfer(this.balance);
            players = new address[](0);
        }
        modifier restricted(){
            require(msg.sender == manager);
            _;
        }
        function getPlayer() public view returns (address[]) {
            return players;
        }

}
