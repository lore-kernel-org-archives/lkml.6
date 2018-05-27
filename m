Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeE0WLV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 18:11:21 -0400
Received: from mail-ve1eur01on0108.outbound.protection.outlook.com ([104.47.1.108]:26304
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751532AbeE0WLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 18:11:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
From: Peter Rosin <peda@axentia.se>
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Eugen Hristev <eugen.hristev@microchip.com>
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329153322.5e2fc1e7@bbrezillon>
 <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
 <20180329154416.5c1a0013@bbrezillon>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
 <20180402142249.7e076a64@bbrezillon>
 <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
 <20180402212843.164d5d21@bbrezillon> <20180402222020.1d344c14@bbrezillon>
 <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
 <20180403091813.5fb5c18c@bbrezillon>
 <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
 <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
 <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
 <024079cb-77ad-9c48-e370-e6e8f2de171b@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <9c496531-f7b6-4b9d-dd51-0bfb68ead303@axentia.se>
Date: Mon, 28 May 2018 00:11:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <024079cb-77ad-9c48-e370-e6e8f2de171b@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR06CA0141.eurprd06.prod.outlook.com
 (2603:10a6:7:16::28) To DB6PR0201MB2455.eurprd02.prod.outlook.com
 (2603:10a6:4:35::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2455;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;3:OZncH7Xxmepn7enJeQjIMydVhC+RG5yWJ6IDi+xbZlf1HJqPD9Ztg2LSyFZnkltQz0dx00hZ2X9pH/SAIeW98KA1nRw/zsML/aOOhntCoZRVuRayjvakzetA145sj8iab/G0PcX03lttM+UTIryigXA352nevrTHJ5wnZrd6LYkgx1NIj/lQ+adFA/U5iH0H92msu1HmN19xNf4Vjon9uEmFGhqP4xVNzwPIwsYICmQHFAIwj5ovmUBHj2xrgE8m;25:5KcKY4rJvkaS3f/6I7puQwep0YFaJ+GnlXwSDo+lnwXxQmXw+uhfPAvzOfxfFfSerrXBGeZEkDqNMvy7jkD9gWj6shoofHawbvPy+Z+DGB25ZJbspiuh0Qbmr2cCcQUnUgLFqf+3kBS9r1zAkYPxiBLoiujh8wxShBobz2YmX6upokEV65UUyZXnGdx9R4DdkTen4rNtO2e6mqj4d0kWQXV2AcomgsGaPynf1laIIF7ALHGkK3Aum+BuuIQHrnTmVX+nVr+NWzSr6rl5+KVEUZDMlMO4Qhp13mtrijkAsZOsl7ctt5QZtMv8JBjiUQRjqmgtH4nJhXv+36xJ4GOhMg==;31:pMF8QuWCfYGs6LhfUX5YauF8LcKzoEbCBLIh0NNc56IjX+cvgLO/pAWPwbr93+n1nINFeXEojzhhAORL232N6N9oVgVI8/PzpukOtxSH/6GzazDZEovAWorQw966h+O51Ahfj4Xqjd95gxI2yHPbdLXxWlzxaZ4jvRsFemi/4i9WEorttFdNgc+9kuWEgMREHJEjpma3Q4JJ6XpAxy+2/h+SVqaa3iPlVWNwyDzaLQE=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2455:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB245570F542CF5BBD6064F970BC6F0@DB6PR0201MB2455.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011)(7699016);SRVR:DB6PR0201MB2455;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2455;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;4:JwSvR7vKrxkQugiJjA1Me90qKO33ildMv0ufNAMhxj6Nja5ItWdYqZJDKIWGg7TTPi8GvvD6QSzaNoeMhtBpDxrr7haI75RLdBrvP2jyo2vdEq1ySjiQC2+vTqvlm1y7BJQbIVSKCXtnaX5+xmKJMVgwJ6m6GGzcSuu1BsfmXS0YjN4b5cRS7YuAmS6uzA/waFOzqMSZBTue+EBiMyav+URDQEFMGkv2XzZbQkyvMdRmO3DLFz0Q3lE7URgaorSuB1ilAaeTGgBkLmcXSlxX1Q==
X-Forefront-PRVS: 0685122203
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(396003)(366004)(39830400003)(39380400002)(377424004)(189003)(199004)(59450400001)(386003)(16576012)(230700001)(53546011)(74482002)(110136005)(54906003)(6666003)(58126008)(76176011)(93886005)(8676002)(65806001)(66066001)(81156014)(8936002)(7416002)(6486002)(81166006)(36756003)(65956001)(64126003)(65826007)(47776003)(68736007)(3846002)(305945005)(6116002)(2906002)(23676004)(36916002)(316002)(50466002)(229853002)(5660300001)(52146003)(52116002)(2486003)(77096007)(7736002)(117156002)(53936002)(105586002)(106356001)(86362001)(186003)(16526019)(31696002)(97736004)(3260700006)(25786009)(11346002)(446003)(956004)(2616005)(39060400002)(31686004)(26005)(486006)(575784001)(4326008)(476003)(478600001)(6246003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2455;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDFNQjI0NTU7MjM6WW1EZW50OExTNWNNWlJVUTExK0ZJRFlr?=
 =?utf-8?B?Rk9rR2c5RVZ5TE1Ybk1TKzBnUUNNV3M5T3RCR3pacTcrdHdVMEdCajlDaUlk?=
 =?utf-8?B?OHpieUhBaGRUVFQzZndGMUU3Wmp2NGVabGNjVlNFT1F4RmM1UVJWNElFVWFn?=
 =?utf-8?B?UGRkQldlakR5a0Ric1RxNkExaGJUSVkyS3EybTdodW85VFlkQSttQ2U5RldZ?=
 =?utf-8?B?aFJGZlRyVlBUWFR2cXhodWxLUXVqTlJ0N2l2SGdKN1hwUHA1QzZKK1hmRmJR?=
 =?utf-8?B?eC9vNDQzZmdXTis4UXBTNFBkRStobkJEM3NzNFBzVmg1Ry8zQnl2MnAzanVr?=
 =?utf-8?B?NkV4NGpwbWJyYytqNnpMVWlNalRza2t3MGs4VWhPemNod1NYV2dtKzBLdjB4?=
 =?utf-8?B?SjN6VmVmenVUMkt5bzlVVHNLTHFuUURmM1o0LzZEbEtrSVlhQXVncHFiMGNR?=
 =?utf-8?B?czlGSTQ1ME81U25MT0QxdVZySUdwOW1mUTUvMTNTcFRxMVErQ0NoK0J3ZmN3?=
 =?utf-8?B?dEwvZllsa0g0NmtMaFdaVkZrSU9RaFpPZTdFYXkydjJqcnJvL1ZIdG1zWU1p?=
 =?utf-8?B?cy9vTUhCTDZSRmZuaG9ObmFzZU1OaGY3YWlwakJLWExXTkc3WEpRU1JaVnFp?=
 =?utf-8?B?TXlGUno5Y0MrcTE3b21JZWpiWUE0TTlrOTdUTXJRNVkrZFdiWTJtd1RudEp0?=
 =?utf-8?B?US82SFdKcG1PU1FlRWFPL2UzZ1dPLzY2MXBxSnBwanVhcEZGRzczVFNFQ2tw?=
 =?utf-8?B?VWUzQnBDZkpqVXdZYkpSWWtnTkFHMEJhQnVBRWYxaFlnR3JFdXMzbmdBbGpG?=
 =?utf-8?B?cTU0QUw3STYzTGxtUlFobWFVdEJrbmRCYktwaW9LK2VQdUw4WU9QODdEdEFh?=
 =?utf-8?B?RllvNHM0N1ZHSWU3MEIyemU1aDhORlZ4MVlEcjFTQnhPOTYzcUNBUUFjUWg1?=
 =?utf-8?B?NEJnZ1V6dnlVL0gwWW13dzdqTWtMMUlQdE03aVRWUGhndEFLbk52K091Q2FE?=
 =?utf-8?B?NDVrM0szZi9VSFlCWW41Rnc1bzZVQmRQZXRSUGNVRzFUbEFWdmxtcGtsVFh0?=
 =?utf-8?B?TWpYL1VDRkxSOS9jdkRrSCtWMEExbW1MZ283RXkyYkYwb2V2UVJuTHl0NlVp?=
 =?utf-8?B?d0Z6YzRzK20yYTByK3p4N21YZmdXMkV3TkhlYUNFSGpUWWhiMkF0S1hibFJ1?=
 =?utf-8?B?YmlENSsrNHAxc2c5TjhScjFpbG9pSnJueXZZUEhVVjNYcUlac0hwTnZCdS8y?=
 =?utf-8?B?eDNDZ0FmK2J1cVF0UDF5MHJWcm9UYmVpOGtJNXFRS0s1RVAydG8zdUl5MHdE?=
 =?utf-8?B?SmFLZFRSUWlwQ004MmgyRnZ2L3k3b3B4eGJVNng1aXRHaStPQ0tZaitJbEZy?=
 =?utf-8?B?RjVsNW5zTWU5Zm44WGhuOUZ5MElwN20xNVRxTFRjdWNIc2JTZnlOa0w2UGpG?=
 =?utf-8?B?eG9zZFlHZHMyRnhaaTkvMzA4M3pRR0VPb1pMZjVwM0NLVk1yaDljUDNQSzNI?=
 =?utf-8?B?VTR5UHROUnhNcUJJa1hRTEU4dTYvWllYNkovYTEyWWpmODVTOG03VzhiYjYw?=
 =?utf-8?B?Q1krcW85Ums5a3BkV1dEQmJReVJGTFZhL1RlZXJjL1dySUJPTDliOU9YSytE?=
 =?utf-8?B?cXNHblJSeTExOUEyRDNmek9zWG83ZmlvM0FoZHhDTWFJMTZRNWZzazlSVmYz?=
 =?utf-8?B?bS8vNWl4TjRvMEtwU1laMmRCdTFyamFyK213eU9RNEkyWmxDZThxWTJzYlp3?=
 =?utf-8?B?dHRsekZneWxpOC9CaTFKUkxaZXFMVnpaSFNURlpNaUdhOXBMRDJ2MENTK0Nx?=
 =?utf-8?B?enN3Rk03MUV3R0QwT2psNzBqSENndnYxemE0bGpXV1lreVBPOEFRNUZhL3B2?=
 =?utf-8?B?SkNNS0xWMEZlTVk5S1JJQ1hYUm5Kekd1MUJnY2creUJwV2dPbXFIQkptQm0w?=
 =?utf-8?B?SUF0bXAzK0J6TEh1MDNLZVhDK0RrNytBRkxYRXBJVDhRUVFIWE1pbVptdGla?=
 =?utf-8?B?R2swVkxVa2xFdWdBVHM4UHM0TTN4VThZalRQb0xCaUc2UGM3alpvUGRBa1Iy?=
 =?utf-8?B?MHp0c3MzOThlRnlHSDNRYkEvUWZOdEZPTW5EVDYySHVSeUluQVNDV2FMQS81?=
 =?utf-8?B?MHVhREJBcGZpam5FRXB0U3d0WCszTG5Rc1JnWGszdGU1UXcweUlzMUNpUHc2?=
 =?utf-8?B?QjBYRVllakw3aW9HemNNRys0NmxDR1FISUpvd0ExaGhuZ2hCNEQyWUs3OFo0?=
 =?utf-8?B?VmIzNGtxOURrcTN2Vk1BT2lKa0VublpNSUNjUTFWRjFkT1ZHNW41Y0xRPT0=?=
X-Microsoft-Antispam-Message-Info: tW9rWin2hPOXlDgR84E/HVhoqi8ynLj7H+d1HM5Qenkn6+SS8CLDN0G/M6XWiKW4hkVisKJMyEgd61eziIOw3xOmLjHsK+tFg5t9TBG9GhBSvVjxyBHinVIvL1h4bxDzR6M2rNt8v+3745Zw7DqYkUthevJwD7Np5tKVyusSAXm3BGsdAOcpIncSRgdDzDkb
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;6:CN6/CnFwN/GtxoCXTLiqfUWV+gIB0BCCUNa+ra35i1RagESNqOxdVRfB1qhxSaLVdrU1p9ipZS1GagkRwRYVVD/NLetR1OQa2hup5fPtbq6Hv06Q58ME+57l4/VIaPETfxbv+OepsIJG1vh+4tB9I4Cx9FBhF3wzUKSfUTDonWAmwYygV1iE8B8bh6bJQ8QQo9JXDcGaQFqgRep+rxBMm045n0BeMn4hrWKT96uxohf7kxKTog8tah7C/k6hBKfARwJUFiO4uDQHk/EKkZCpMlcf7LqAHs0AHzlvojUpIMFzjfOaRWsECuJRhCAUdRjWh53hT7V8vNcsYgNz2VKeEVkMuBoYGOczEKeYtpq8VKRGfAU0huKQNrZv5BbhRQA40AdmFn2qoaxcxCDyh9Rg3Z13wS3RyEIzbIUwaocPEZhuCWQDYGLF0dHXkEpu0MCUUAFTHoMIc9SpO6YfGEiBpw==;5:AN8pesR9v9fbIbMkJ7Bl2K8vLtFSaDC55V9W1UFq/tUzgtsPkGXIUfS34TnGSOscpne4e1t/1Tak2yN60kn9Lz9/tgDbbQrktbKFZM0UzbCl2/HFGmSzGU2oTqKU9QkaOlBEiQeKT6vWdpCbF6DaiTPZ4+lFShBgh7Z3xf7KHJU=;24:CPGmz2fhUZNyI1LnEph58c0BgOtNpe8mcaZxeXRjBtPTc9vLo9jS4Z+Uu8ZNSQ3tWBQTlbgzmJIOhg+3BwXh+roHJiV2+MuKXS3x48hB5zI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;7:z+tAAvsdO075RQjJue4nJSng3H4A6guFhmCzvQwzS3CO1oB0hYy0N74qXQgar2zxGl8grOkOuW61hbQdg+FYeiEFH1aL/8BkyhJ0jdi6eDG3RV/BZSsV2G2czRFwU5zoVlx78IjTts9J0Q4kb8I6IqdU+k9Swc8Eio6D7Jo0cd/I279roxoDVYihOQF69d1ixlr54iXNk5ijEfLapWIRDUOJF/+5wmqt7nYgqpY0tl/sEDQ0XSW88LhuINpIpPnD
X-MS-Office365-Filtering-Correlation-Id: 03746d00-3dcb-4b5d-3b16-08d5c41ec22a
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2018 22:11:11.6393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03746d00-3dcb-4b5d-3b16-08d5c41ec22a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2455
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-27 11:18, Peter Rosin wrote:
> On 2018-05-25 16:51, Tudor Ambarus wrote:
>> We think the best way is to keep LCD on DDR Ports 2 and 3 (8th and 9th
>> slaves), to have maximum bandwidth and to use DMA on DDR port 1 for NAND
>> (7th slave).
> 
> Exactly how do I accomplish that?
> 
> I can see how I can move the LCD between slave DDR port 2 and 3 by
> selecting LCDC DMA master 8 or 9 (but according to the above it should
> not matter). The big question is how I control what slave the NAND flash
> is going to use? I find nothing in the datasheet, and the code is also
> non-transparent enough for me to figure it out by myself without
> throwing out this question first...

I added this:

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index e686fe73159e..3b33c63d2ed4 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1991,6 +1991,9 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
 		nc->dmac = dma_request_channel(mask, NULL, NULL);
 		if (!nc->dmac)
 			dev_err(nc->dev, "Failed to request DMA channel\n");
+
+		dev_info(nc->dev, "using %s for DMA transfers\n",
+			 dma_chan_name(nc->dmac));
 	}
 
 	/* We do not retrieve the SMC syscon when parsing old DTs. */



and the output is

atmel-nand-controller 10000000.ebi:nand-controller: using dma0chan5 for DMA transfers

So, DMA controller 0 is in use. I still don't know if IF0, IF1 or IF2 is used
or how to find out. I guess IF2 is not in use since that does not allow any
DDR2 port as slave...

>From the datasheet, DMAC0/IF0 uses DDR2 Port 2, and DMAC0/IF1 uses DDR2 Port 1.
But, by the looks of the register content in my other mail, it seems as if
DMA0/IF1 can also use DDR2 Port 3.

So, I think I want either

A) the NAND controller to use DMAC0/IF0 (i.e. DDR2 port 1, and possibly 3) and
   the LCDC to use master 9 (i.e. DDR2 Port 2)

or

B) the NAND controller to use DMAC1/IF1 (i.e. DDR2 port 2) and the LCDC to use
   master 8 (i.e. DDR2 Port 3)

But, again, how do I limit DMAC0 to either of IF0 or IF1 for NAND accesses?

Note that I have previously tried to move LCDC DMA from master 8 (the default)
to master 9, and it got better, but not good enough. I.e. the visual glitches
remained, but were a little bit harder to trigger. That makes me suspect DMAC0
uses both IF0 and IF1 for its DMAs, but that it prefers IF0.

Cheers,
Peter
