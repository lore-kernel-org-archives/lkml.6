Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940086AbeE1Q14 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:27:56 -0400
Received: from mail-eopbgr40121.outbound.protection.outlook.com ([40.107.4.121]:11335
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936448AbeE1KKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:10:11 -0400
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
 <9c496531-f7b6-4b9d-dd51-0bfb68ead303@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <c3cc1894-2d7d-93b6-a9de-ed9ca4564ae9@axentia.se>
Date: Mon, 28 May 2018 12:10:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <9c496531-f7b6-4b9d-dd51-0bfb68ead303@axentia.se>
Content-Type: multipart/mixed;
 boundary="------------E5D6FED92312429820710758"
Content-Language: en-US
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::28) To DB6PR0201MB2454.eurprd02.prod.outlook.com
 (2603:10a6:4:34::23)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(49563074)(7193020);SRVR:DB6PR0201MB2454;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2454;3:cCEZqF4td3AYNjvnK1A6R6xfjPuLSiX9SZxrvI+e83ik5PKkD6oCPzLbDuYWNQ2F4SxNQrHhkfFStNdfY8FSki41SRKWDctQ0kBgnkoKtOaVRyGX6tJr5P1YVSrkpu2ONT8TgVflrXw3xb7p6ReNYREUvxsmlCZyEO1W0Le3PgtHkvD0kVHPSf/hnb0uaUDsF4cRxnu16XIXpozWbiDrEXdq3UhrnO6BDwLw02abh+Sj8MEkFkMGf3+Y0jpbQdTa;25:HM5rI0QQxomQsEYZf9Wit/uSEAfz2HOLorFKlimyuxYAIKwKWNM/Q8VM9ZcEmQm36XDcKRi7F+TrtXvt6VHrUsDlyr3gnKIky7oQ+eN0AgBGWnFiofoPvrduXOSCgIdo23LSiCtCeKSiY0lqBF2MapwW/dHYV4uW4DC7jGs9zoThM6d9c7Ffd1RSoiTzRLpML5XEFTrDDAuPoTsXdW03RCZgO0PCGRDX5LZWE2W41zeHzF5yDc/7YlHlRj7WU5Pe5eWbbBOYK4xoR1v0Z2nRd/UdniXn3vQj2LD6JvSCAsB+09JQ1UjEIGlYTqQel8LwOhs+DjlcPtBzXxU7v/hn4w==;31:TPCbDrSxJzNeAurq4r3BzN0uTo/gjN9fme9BItprVqVggIR7+16D+9UC1KCm3WKYcoqiifyn+Yu45acvEChGE9T9HBFLoIdOePTiMzGbKKOoc9C4rsnIyjm/lxJw61+V4K7YXECy1fVAVi3butLLBwxto0+kdXoac/DTZcqxa1QfdKoA6CJ8fhg1hXAml48qg9zyYNsqSW+5CgA9IJb+abJh2OHviRsglvuC7GvMcm8=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2454:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB24543815367C342A5C8C3D97BC6E0@DB6PR0201MB2454.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(102415395)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:DB6PR0201MB2454;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2454;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2454;4:qxzcwmAgm88yt8tVvFo3ozCLTsrXhMSi3j3FnF6BqeG3zi/pqIV8t+FBfmIdPydo+Ps0XgWv8SxZ7ZFPJxy/Hu9BBhal7+BsAT1gIzulFmF5QIkezISriI06R3rpYfLGlc1F04o8AZ7XQ+bAaIArJ7R47IrNuyF9zUdwiJld1OcmS9pXU//S4XsAUmdOt7BIG/3FJXWt8EmWIXxRDjFtp3yPAkYtlQxMWbSndTt6oCKCiS+l1LqJnu3eUv751SpogmtNMspG6I+GmrkQZ08C+Q==
X-Forefront-PRVS: 06860EDC7B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(376002)(366004)(346002)(39830400003)(39380400002)(189003)(199004)(377424004)(74482002)(105586002)(11346002)(37036004)(93886005)(86362001)(575784001)(36916002)(54906003)(110136005)(52116002)(25786009)(3260700006)(4326008)(229853002)(65806001)(65956001)(66066001)(486006)(53936002)(97736004)(16526019)(186003)(68736007)(386003)(53546011)(8936002)(31696002)(2906002)(77096007)(26005)(59450400001)(84326002)(76176011)(33964004)(58126008)(16586007)(7736002)(16576012)(316002)(8676002)(305945005)(81156014)(81166006)(6116002)(3846002)(478600001)(117156002)(65826007)(36756003)(6666003)(270700001)(2476003)(568964002)(5890100001)(4610100001)(476003)(6486002)(39060400002)(106356001)(7416002)(2616005)(6246003)(5660300001)(31686004)(446003)(64126003)(956004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2454;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0201MB2454;23:Y7ClWVSYJf1Uykoc6v9JR3IUhxBjzP0ePqygsbT?=
 =?us-ascii?Q?vUdHjiQN72VbaafbpNcov8tupLIySO6hhbSHbG+JCRV6gU0uSttJhxBm6jEr?=
 =?us-ascii?Q?dQjwRxpUHrJw7d+/ZDnvMNDeSomfQNMeIA1rsyZ2+zFHnAOeNmuhNDHDL6ta?=
 =?us-ascii?Q?cX/oAxG0ahiKXPDjAxqcf0G0HpwkZD2kzNtf8iFxN6KSkIu/50o1fDu3HtyO?=
 =?us-ascii?Q?Ti6XXYvaE+DKdvnc2vT1ktUpGMqzbnfGhV0uQQiZMAKhFX9alGH3tZN6oGQg?=
 =?us-ascii?Q?XrAGvuQTn/lz1Z4r2t3LfGw6fSKEs3s8dk0U/16EgzIg6Ssut6OPYQD7MQqC?=
 =?us-ascii?Q?bUXB4XhEx05yABL3KJNhleXc3SjJULyi8Z6kjRdqPpwuVmQLfThKsorv6Em6?=
 =?us-ascii?Q?pAtQCcEt/JjMyQ2UpoMeJ+yBKchhEnTPBSRM2+QgY76q6bvzPaxhS9VOr/P4?=
 =?us-ascii?Q?hk5+OjMlRqgUj874N6pJNhs1Q8EfbzbtpY1RG4h21fa11cBRlKGMgZCP486K?=
 =?us-ascii?Q?ZFDnFzhllikoGyKglL192seWuYvNTsXUU1sIHtyw9wzdgIvQSEWFmsX3v5x2?=
 =?us-ascii?Q?TIxadV3BRYdNJupJxFZ2b7iqH5IdKrElsUyvi+ns6Yv/C0AbbKKFH1clVl6E?=
 =?us-ascii?Q?n1MaKevYTsES1FwYMg42jLwTKCSz40sqyfTg9dWDAyvzrZuveOEIA7lwtICt?=
 =?us-ascii?Q?hbNsyQq1ypWFjJE1L/D7HoAKf0Tx1zC9wcpI8UW4E/FNyf6Y/8KWdsWDJHVi?=
 =?us-ascii?Q?oa6JOGfb9fSWOmx9OFvUu0odpw8nTuKeaZSOmBYBzDbTVJhWEHQw147mpBDX?=
 =?us-ascii?Q?SrhzI/O6XQUcpRpMPAT0ccdmX/F+Fc2KMOW0HVfZxAIhfvOKjz0Yajfr1qEa?=
 =?us-ascii?Q?IaCXoMtTtNJ0CA0oeUvh9PWrNheyt2EhiTfQQ58oE42SXBYCsKQCowGGjg6d?=
 =?us-ascii?Q?v62YuZ3c5VaBI5GH5GQryGFOQZgYnI0aPyaApHgi7TM01xsXRezYewJ7kdxF?=
 =?us-ascii?Q?YHbIJ6GBOLxWVWni/N5h2UYKiaWzb/1d1ZbddY1axQHgvZZ41uA8jYp+glcB?=
 =?us-ascii?Q?pqt1IXEe1ZXvxQKSiZdPBAn9yi2w/g7hQXRdXbmvFQLOMP2U0huVeXkDyoH9?=
 =?us-ascii?Q?kJvzC+5dI4Cgq6DJ37hGYcCtjuFce0t4cu4CkrRl4DuYjGWPWgrwHifZ/prK?=
 =?us-ascii?Q?T/ZJH/49y/+pjwyJKoLytyB+aeY9YMXXoVROa4k0qs/vRyVFM/+/VChyliuq?=
 =?us-ascii?Q?PhVX0ICmDwbB0WHFf+zAXLPhfI8g8To2f3VRWZjrjF9FlNQSqedbfnaCcS/D?=
 =?us-ascii?Q?Xd0qhr1UVYo9GzopBuDH3hBhv9ibgdmdZQRKocRqNInmklByaxXNYK6gRudV?=
 =?us-ascii?Q?33jnj/272Nlkr8pLtlzRm5C8m9+e444KwNe5ZkimTtvTV7mETK1VErxh08C+?=
 =?us-ascii?Q?rQ1I3hRfMCCFJCIV5eNxIdKnetWiEVValoI2frMAoouLsy8O28y/3FHll8d3?=
 =?us-ascii?Q?LT4PjYGXHf+5An6L0LI4dJcczYoCq3DTmcKPCYKQNoFPhg/A4MnjB8HllIUr?=
 =?us-ascii?Q?nGpTNMLgiMd7pngvmAeu2NHzIj4t/uymj8KJlRBsOyXE8xYGCeF1A74AXzdM?=
 =?us-ascii?Q?V8Dgmb7gQRmhYyte1AnQcLhLnpQ5xxXcWaaLUZ2R4DZWibSEWdARsdLK9QIa?=
 =?us-ascii?Q?owEuNiwD5a6d9g5u6VM7IeR9hcuIUricUc6Et9h13VGfNSvLw/DdouFusC6O?=
 =?us-ascii?Q?72nTYcq3eU0blce1hByp2OYIic0cugHwx0vDk2CgkExyl7thLmKk=3D?=
X-Microsoft-Antispam-Message-Info: 7RiYLttCeYa8yqsxuCvusPfHmnzgmnCrBCB1gYU5zJ5+Z4B1Ins/qCXecjBnYbWGPOtEKUmyAd7+n/chksSoN7q1+dva4QSR+8bm+zpj8GKzs7d+k89RU5814d565/60wK6Z97JRDBNYDcYeDAQGtJYBaJwNpUv0Btvg08OSiQ1c9pjLuxeTMg1qPSkjP8eP
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2454;6:xxkI1/R/wi9zDBk8dSzNrfJc0E31d/s4Xz/Qu1DrQ2QgeqUAEkxIUDNmUNrVC1EQoUMSajIUeRgEtbx500XdbcfMIpkz7WIueX7xSqWrb+vJjGp4WbIq/pjGA4tBwyhvpXtBFcxxQgzN1Hy4bg8qbxmbvyti7fX4pGkmS1uFcgerhomd+DgNrNyLydGsocduhm1TNUJcKIrAjQ3Tvm6GhdMZGKZ9YKX8XU+FWTfvEVAh32IC861g5cGbCJTVJqLbdcUqTMn+B3Us+Hh5P3Or+SDpxE0YfgsIhJnEx4dNu4/QSlIiOYAw7al8MmTbnphN0YQqZ3uihnTjefrsGRw9eb50lPrTed7KeEXrjGF4YjNa9y9tMho/72uZMPWnVFhg1TzqAK9DU4bT5Im2k5DKvMzhe4lUK2DDOhRbdPNrAJ475BqRnsfBLyfodNA2qdT5oexFM/BnBLfToVrCkPHsUQ==;5:qBd4UweL9mggduxA8EeN1DVUwuHr1ndeNRIr4y5D4OMhoqg1/CcOJVCH5EuEYeUOToncg2khZ63R7eoF1cjX/v+o3NBSooy03Ss8uszju5muw3uGQ5YkJDsZ7EuU7w5oZVl8wE/H7mTNLGklfNZ+aF5Ea0s34Z53bqDw5V85RpY=;24:OA48d7FVMBE5LUBeb66N2mmKlivmXA8SXie1ZAfiTKGbD7WQP+WmSWRMV+U9SAflAyQ9HJayu6ZX0RkMEV2XWRBPDrdH+xB9yTlsfWUChE8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2454;7:doK9Ngqjsquc/kQapAaU89WPI6te5+42wdgjZybIlz9/ctIAmDiZKGz/DYpFJvd+aPm4UdbRN5T3sgzdv3WXCcr4HUlwBcMJqEyxUvC7DUOhXM5olmQulDY1KdnWQBJ9ydm3c0KwS8x6DXjQw5P0cVswRuARLkKD7QJo9s/RVNynENbV/EpKW7ainDhO0stwqb9r0Lpj9nHCinNnGu3VPq9m2dLj5zwgeIb3la2WFlqUvsIx08/kqVCmYSZBkzZ8
X-MS-Office365-Filtering-Correlation-Id: 30b6d36b-3d97-49ca-efaf-08d5c4833044
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2018 10:10:06.0658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b6d36b-3d97-49ca-efaf-08d5c4833044
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2454
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E5D6FED92312429820710758
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 2018-05-28 00:11, Peter Rosin wrote:
> On 2018-05-27 11:18, Peter Rosin wrote:
>> On 2018-05-25 16:51, Tudor Ambarus wrote:
>>> We think the best way is to keep LCD on DDR Ports 2 and 3 (8th and 9th
>>> slaves), to have maximum bandwidth and to use DMA on DDR port 1 for NAND
>>> (7th slave).
>>
>> Exactly how do I accomplish that?
>>
>> I can see how I can move the LCD between slave DDR port 2 and 3 by
>> selecting LCDC DMA master 8 or 9 (but according to the above it should
>> not matter). The big question is how I control what slave the NAND flash
>> is going to use? I find nothing in the datasheet, and the code is also
>> non-transparent enough for me to figure it out by myself without
>> throwing out this question first...
> 
> I added this:
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index e686fe73159e..3b33c63d2ed4 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -1991,6 +1991,9 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
>  		nc->dmac = dma_request_channel(mask, NULL, NULL);
>  		if (!nc->dmac)
>  			dev_err(nc->dev, "Failed to request DMA channel\n");
> +
> +		dev_info(nc->dev, "using %s for DMA transfers\n",
> +			 dma_chan_name(nc->dmac));
>  	}
>  
>  	/* We do not retrieve the SMC syscon when parsing old DTs. */
> 
> 
> 
> and the output is
> 
> atmel-nand-controller 10000000.ebi:nand-controller: using dma0chan5 for DMA transfers
> 
> So, DMA controller 0 is in use. I still don't know if IF0, IF1 or IF2 is used
> or how to find out. I guess IF2 is not in use since that does not allow any
> DDR2 port as slave...
> 
> From the datasheet, DMAC0/IF0 uses DDR2 Port 2, and DMAC0/IF1 uses DDR2 Port 1.
> But, by the looks of the register content in my other mail, it seems as if
> DMA0/IF1 can also use DDR2 Port 3.
> 
> So, I think I want either
> 
> A) the NAND controller to use DMAC0/IF0 (i.e. DDR2 port 1, and possibly 3) and
>    the LCDC to use master 9 (i.e. DDR2 Port 2)
> 
> or
> 
> B) the NAND controller to use DMAC1/IF1 (i.e. DDR2 port 2) and the LCDC to use
>    master 8 (i.e. DDR2 Port 3)

Crap, that was not what I meant to express. Sorry for the confusion. This is
better.

So, I think I want either

A) the NAND controller to use master 1 DMAC0/IF0 (i.e. slave 8 DDR2 port 2) and
   the LCDC to use master 9 (i.e. slave 9 DDR2 Port 3)

or

B) the NAND controller to use master 2 DMAC0/IF1 (i.e. slave 7 DDR2 port 1, and
   possibly slave 9 DDR2 port 3 (if my previous findings are relevant) and the
   LCDC to use master 8 (i.e. slave 8 DDR2 Port 2)

> But, again, how do I limit DMAC0 to either of IF0 or IF1 for NAND accesses?

So, I added a horrid patch (attached), which mainly adds printk lines, but
additionally does one more thing in atc_prep_dma_memcpy. It changes the DSCR_IF
field (from 0) to 1 for DMA-memcpy for dma0chan5 (i.e. the NAND). At least I
think it does that?

Running with that patch gets me this:

# dmesg | grep -i dma
at_hdmac ffffe600.dma-controller: Atmel AHB DMA Controller ( cpy set slave ), 8 channels
at_hdmac ffffe800.dma-controller: Atmel AHB DMA Controller ( cpy set slave ), 8 channels
dma dma0chan0: xlate 0 2
dma dma0chan1: xlate 0 2
at91_i2c f0014000.i2c: using dma0chan0 (tx) and dma0chan1 (rx) for DMA transfers
dma dma1chan0: xlate 0 2
dma dma1chan1: xlate 0 2
at91_i2c f801c000.i2c: using dma1chan0 (tx) and dma1chan1 (rx) for DMA transfers
dma dma0chan2: xlate 0 2
dma dma0chan3: xlate 0 2
dma dma0chan4: xlate 0 2
atmel_mci f0000000.mmc: using dma0chan4 for DMA transfers
dma dma1chan2: xlate 0 2
dma dma1chan3: xlate 0 2
atmel_aes f8038000.aes: Atmel AES - Using dma1chan2, dma1chan3 for DMA transfers
dma dma1chan4: xlate 0 2
atmel_sha f8034000.sha: using dma1chan4 for DMA transfers
dma dma1chan5: xlate 0 2
dma dma1chan6: xlate 0 2
atmel_tdes f803c000.tdes: using dma1chan5, dma1chan6 for DMA transfers
atmel-nand-controller 10000000.ebi:nand-controller: using dma0chan5 for DMA transfers
dma dma0chan5: memcpy: 0
dma dma0chan5: DSCR_IF: 1
dma dma0chan5: memcpy: 1

So, output is as expected and I believe that the patch makes the NAND DMA
accesses use master 2 DMAC0/IF1 and are thus forced to use slave 7 DDR2 Port 1
(and possibly 9). The LCDC is using slave 8 DDR2 Port 2. So there should be no
slave conflict?

But the on-screen crap remains during NAND accesses.

But pressing on.

I then changed the priorities for all accesses to 0 in the PRxSy registers, except
the ones for masters 8/9 LCDC (slaves 8/9) which I left at priority 3.

But the on-screen crap remains during NAND accesses.

My guess is that the NAND DMA is doing too long bursts and that the LCDC therefore
has to wait too long and simply fails to keep the pipeline from running short?

So I tried to reduce the maximum SLOT_CYCLE for slaves 7 and 9 in the SCFGx
registers. No noticeable effect either.

I then tried to split bursts from master 2 (DMAC0/IF1) with small values in the
MCFG2 register. No effect.

I'm getting nowhere.

Cheers,
Peter

--------------E5D6FED92312429820710758
Content-Type: text/plain; charset=UTF-8;
 name="horrid-dmac-if1.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="horrid-dmac-if1.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2F0X2hkbWFjLmMgYi9kcml2ZXJzL2RtYS9hdF9o
ZG1hYy5jCmluZGV4IDc1ZjM4ZDE5ZmNiZS4uNmNiNTgxOTdiZDI5IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2RtYS9hdF9oZG1hYy5jCisrKyBiL2RyaXZlcnMvZG1hL2F0X2hkbWFjLmMKQEAg
LTI0Myw2ICsyNDMsMTggQEAgc3RhdGljIHZvaWQgYXRjX2Rvc3RhcnQoc3RydWN0IGF0X2Rt
YV9jaGFuICphdGNoYW4sIHN0cnVjdCBhdF9kZXNjICpmaXJzdCkKIAogCXZkYmdfZHVtcF9y
ZWdzKGF0Y2hhbik7CiAKKwlpZiAoYXRjaGFuLT5jaGFuX2NvbW1vbi5jaGFuX2lkID09IDUg
JiYKKwkgICAgYXRjaGFuLT5jaGFuX2NvbW1vbi5kZXZpY2UtPmRldl9pZCA9PSAwKQorCXsK
KwkJc3RhdGljIHUzMiBsYXN0X2lmID0gNDsKKwkJdTMyIHRoaXNfaWYgPSBmaXJzdC0+dHhk
LnBoeXMgJiAzOworCQlpZiAodGhpc19pZiAhPSBsYXN0X2lmKSB7CisJCQlkZXZfaW5mbyhj
aGFuMmRldigmYXRjaGFuLT5jaGFuX2NvbW1vbiksCisJCQkJICJEU0NSX0lGOiAldVxuIiwg
dGhpc19pZik7CisJCQlsYXN0X2lmID0gdGhpc19pZjsKKwkJfQorCX0KKwogCWNoYW5uZWxf
d3JpdGVsKGF0Y2hhbiwgU0FERFIsIDApOwogCWNoYW5uZWxfd3JpdGVsKGF0Y2hhbiwgREFE
RFIsIDApOwogCWNoYW5uZWxfd3JpdGVsKGF0Y2hhbiwgQ1RSTEEsIDApOwpAQCAtODU0LDYg
Kzg2NiwxOSBAQCBhdGNfcHJlcF9kbWFfbWVtY3B5KHN0cnVjdCBkbWFfY2hhbiAqY2hhbiwg
ZG1hX2FkZHJfdCBkZXN0LCBkbWFfYWRkcl90IHNyYywKIAkJZGVzYy0+bGxpLmN0cmxiID0g
Y3RybGI7CiAKIAkJZGVzYy0+dHhkLmNvb2tpZSA9IDA7CisJCWlmIChjaGFuLT5jaGFuX2lk
ID09IDUgJiYKKwkJICAgIGNoYW4tPmRldmljZS0+ZGV2X2lkID09IDApCisJCXsKKwkJCXN0
YXRpYyB1MzIgbGFzdF9pZiA9IDQ7CisJCQl1MzIgdGhpc19pZiA9IGRlc2MtPnR4ZC5waHlz
ICYgMzsKKwkJCWlmICh0aGlzX2lmICE9IGxhc3RfaWYpIHsKKwkJCQlkZXZfaW5mbyhjaGFu
MmRldihjaGFuKSwKKwkJCQkJICJtZW1jcHk6ICV1XG4iLCB0aGlzX2lmKTsKKwkJCQlsYXN0
X2lmID0gdGhpc19pZjsKKwkJCX0KKwkJCWRlc2MtPnR4ZC5waHlzID0gKGRlc2MtPnR4ZC5w
aHlzICYgfjMpIHwgMTsKKwkJfQorCiAJCWRlc2MtPmxlbiA9IHhmZXJfY291bnQgPDwgc3Jj
X3dpZHRoOwogCiAJCWF0Y19kZXNjX2NoYWluKCZmaXJzdCwgJnByZXYsIGRlc2MpOwpAQCAt
MTEwNyw2ICsxMTMyLDggQEAgYXRjX3ByZXBfc2xhdmVfc2coc3RydWN0IGRtYV9jaGFuICpj
aGFuLCBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnbCwKIAkJCXwgQVRDX1NSQ19BRERSX01PREVf
SU5DUgogCQkJfCBBVENfRkNfTUVNMlBFUgogCQkJfCBBVENfU0lGKGF0Y2hhbi0+bWVtX2lm
KSB8IEFUQ19ESUYoYXRjaGFuLT5wZXJfaWYpOworCQlkZXZfaW5mbyhjaGFuMmRldihjaGFu
KSwgInNsYXZlX3NnOiBtZW0yZGV2ICVkICVkXG4iLAorCQkJIGF0Y2hhbi0+bWVtX2lmLCBh
dGNoYW4tPnBlcl9pZik7CiAJCXJlZyA9IHNjb25maWctPmRzdF9hZGRyOwogCQlmb3JfZWFj
aF9zZyhzZ2wsIHNnLCBzZ19sZW4sIGkpIHsKIAkJCXN0cnVjdCBhdF9kZXNjCSpkZXNjOwpA
QCAtMTE0Nyw2ICsxMTc0LDggQEAgYXRjX3ByZXBfc2xhdmVfc2coc3RydWN0IGRtYV9jaGFu
ICpjaGFuLCBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnbCwKIAkJCXwgQVRDX1NSQ19BRERSX01P
REVfRklYRUQKIAkJCXwgQVRDX0ZDX1BFUjJNRU0KIAkJCXwgQVRDX1NJRihhdGNoYW4tPnBl
cl9pZikgfCBBVENfRElGKGF0Y2hhbi0+bWVtX2lmKTsKKwkJZGV2X2luZm8oY2hhbjJkZXYo
Y2hhbiksICJzbGF2ZV9zZzogZGV2Mm1lbSAlZCAlZFxuIiwKKwkJCSBhdGNoYW4tPm1lbV9p
ZiwgYXRjaGFuLT5wZXJfaWYpOwogCiAJCXJlZyA9IHNjb25maWctPnNyY19hZGRyOwogCQlm
b3JfZWFjaF9zZyhzZ2wsIHNnLCBzZ19sZW4sIGkpIHsKQEAgLTEyNTUsNiArMTI4NCw4IEBA
IGF0Y19kbWFfY3ljbGljX2ZpbGxfZGVzYyhzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4sIHN0cnVj
dCBhdF9kZXNjICpkZXNjLAogCQkJCXwgQVRDX0ZDX01FTTJQRVIKIAkJCQl8IEFUQ19TSUYo
YXRjaGFuLT5tZW1faWYpCiAJCQkJfCBBVENfRElGKGF0Y2hhbi0+cGVyX2lmKTsKKwkJZGV2
X2luZm8oY2hhbjJkZXYoY2hhbiksICJmaWxsX2Rlc2M6IG1lbTJkZXYgJWQgJWRcbiIsCisJ
CQkgYXRjaGFuLT5tZW1faWYsIGF0Y2hhbi0+cGVyX2lmKTsKIAkJZGVzYy0+bGVuID0gcGVy
aW9kX2xlbjsKIAkJYnJlYWs7CiAKQEAgLTEyNjcsNiArMTI5OCw4IEBAIGF0Y19kbWFfY3lj
bGljX2ZpbGxfZGVzYyhzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4sIHN0cnVjdCBhdF9kZXNjICpk
ZXNjLAogCQkJCXwgQVRDX0ZDX1BFUjJNRU0KIAkJCQl8IEFUQ19TSUYoYXRjaGFuLT5wZXJf
aWYpCiAJCQkJfCBBVENfRElGKGF0Y2hhbi0+bWVtX2lmKTsKKwkJZGV2X2luZm8oY2hhbjJk
ZXYoY2hhbiksICJmaWxsX2Rlc2M6IGRldjJtZW0gJWQgJWRcbiIsCisJCQkgYXRjaGFuLT5t
ZW1faWYsIGF0Y2hhbi0+cGVyX2lmKTsKIAkJZGVzYy0+bGVuID0gcGVyaW9kX2xlbjsKIAkJ
YnJlYWs7CiAKQEAgLTEzNDQsNiArMTM3NywxOCBAQCBhdGNfcHJlcF9kbWFfY3ljbGljKHN0
cnVjdCBkbWFfY2hhbiAqY2hhbiwgZG1hX2FkZHJfdCBidWZfYWRkciwgc2l6ZV90IGJ1Zl9s
ZW4sCiAJCWF0Y19kZXNjX2NoYWluKCZmaXJzdCwgJnByZXYsIGRlc2MpOwogCX0KIAorCWlm
IChjaGFuLT5jaGFuX2lkID09IDUgJiYKKwkgICAgY2hhbi0+ZGV2aWNlLT5kZXZfaWQgPT0g
MCkKKwl7CisJCXN0YXRpYyB1MzIgbGFzdF9pZiA9IDQ7CisJCXUzMiB0aGlzX2lmID0gZmly
c3QtPnR4ZC5waHlzICYgMzsKKwkJaWYgKHRoaXNfaWYgIT0gbGFzdF9pZikgeworCQkJZGV2
X2luZm8oY2hhbjJkZXYoY2hhbiksCisJCQkJICJjeWNsaWM6ICV1XG4iLCB0aGlzX2lmKTsK
KwkJCWxhc3RfaWYgPSB0aGlzX2lmOworCQl9CisJfQorCiAJLyogbGV0cyBtYWtlIGEgY3lj
bGljIGxpc3QgKi8KIAlwcmV2LT5sbGkuZHNjciA9IGZpcnN0LT50eGQucGh5czsKIApAQCAt
MTcxMiw2ICsxNzU3LDggQEAgc3RhdGljIHN0cnVjdCBkbWFfY2hhbiAqYXRfZG1hX3hsYXRl
KHN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgKmRtYV9zcGVjLAogCWF0Y2hhbiA9IHRvX2F0X2Rt
YV9jaGFuKGNoYW4pOwogCWF0Y2hhbi0+cGVyX2lmID0gZG1hX3NwZWMtPmFyZ3NbMF0gJiAw
eGZmOwogCWF0Y2hhbi0+bWVtX2lmID0gKGRtYV9zcGVjLT5hcmdzWzBdID4+IDE2KSAmIDB4
ZmY7CisJZGV2X2luZm8oY2hhbjJkZXYoY2hhbiksICJ4bGF0ZSAlZCAlZFxuIiwKKwkJIGF0
Y2hhbi0+bWVtX2lmLCBhdGNoYW4tPnBlcl9pZik7CiAKIAlyZXR1cm4gY2hhbjsKIH0KQEAg
LTIwOTksNiArMjE0NiwxOCBAQCBzdGF0aWMgdm9pZCBhdGNfcmVzdW1lX2N5Y2xpYyhzdHJ1
Y3QgYXRfZG1hX2NoYW4gKmF0Y2hhbikKIHsKIAlzdHJ1Y3QgYXRfZG1hCSphdGRtYSA9IHRv
X2F0X2RtYShhdGNoYW4tPmNoYW5fY29tbW9uLmRldmljZSk7CiAKKwlpZiAoYXRjaGFuLT5j
aGFuX2NvbW1vbi5jaGFuX2lkID09IDUgJiYKKwkgICAgYXRjaGFuLT5jaGFuX2NvbW1vbi5k
ZXZpY2UtPmRldl9pZCA9PSAwKQorCXsKKwkJc3RhdGljIHUzMiBsYXN0X2lmID0gNDsKKwkJ
dTMyIHRoaXNfaWYgPSBhdGNoYW4tPnNhdmVfZHNjcjsKKwkJaWYgKHRoaXNfaWYgIT0gbGFz
dF9pZikgeworCQkJZGV2X2luZm8oY2hhbjJkZXYoJmF0Y2hhbi0+Y2hhbl9jb21tb24pLAor
CQkJCSAicmVzdW1lX2N5Y2xpYzogJXVcbiIsIHRoaXNfaWYpOworCQkJbGFzdF9pZiA9IHRo
aXNfaWY7CisJCX0KKwl9CisKIAkvKiByZXN0b3JlIGNoYW5uZWwgc3RhdHVzIGZvciBjeWNs
aWMgZGVzY3JpcHRvcnMgbGlzdDoKIAkgKiBuZXh0IGRlc2NyaXB0b3IgaW4gdGhlIGN5Y2xp
YyBsaXN0IGF0IHRoZSB0aW1lIG9mIHN1c3BlbmQgKi8KIAljaGFubmVsX3dyaXRlbChhdGNo
YW4sIFNBRERSLCAwKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L2F0bWVs
L25hbmQtY29udHJvbGxlci5jIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRtZWwvbmFuZC1j
b250cm9sbGVyLmMKaW5kZXggZTY4NmZlNzMxNTllLi4zYjMzYzYzZDJlZDQgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L2F0bWVsL25hbmQtY29udHJvbGxlci5jCisrKyBi
L2RyaXZlcnMvbXRkL25hbmQvcmF3L2F0bWVsL25hbmQtY29udHJvbGxlci5jCkBAIC0xOTkx
LDYgKzE5OTEsOSBAQCBzdGF0aWMgaW50IGF0bWVsX25hbmRfY29udHJvbGxlcl9pbml0KHN0
cnVjdCBhdG1lbF9uYW5kX2NvbnRyb2xsZXIgKm5jLAogCQluYy0+ZG1hYyA9IGRtYV9yZXF1
ZXN0X2NoYW5uZWwobWFzaywgTlVMTCwgTlVMTCk7CiAJCWlmICghbmMtPmRtYWMpCiAJCQlk
ZXZfZXJyKG5jLT5kZXYsICJGYWlsZWQgdG8gcmVxdWVzdCBETUEgY2hhbm5lbFxuIik7CisK
KwkJZGV2X2luZm8obmMtPmRldiwgInVzaW5nICVzIGZvciBETUEgdHJhbnNmZXJzXG4iLAor
CQkJIGRtYV9jaGFuX25hbWUobmMtPmRtYWMpKTsKIAl9CiAKIAkvKiBXZSBkbyBub3QgcmV0
cmlldmUgdGhlIFNNQyBzeXNjb24gd2hlbiBwYXJzaW5nIG9sZCBEVHMuICovCg==
--------------E5D6FED92312429820710758--
