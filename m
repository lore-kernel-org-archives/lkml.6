Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BD9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E838320837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zv0SwOSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E838320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeHaNEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:04:55 -0400
Received: from mail-ve1eur01on0042.outbound.protection.outlook.com ([104.47.1.42]:65440
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727222AbeHaNEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoM/W/pnDrDICSM03ZPdfkhcJ/XaOury2+BzaFD0U2Q=;
 b=Zv0SwOSdj308we5uB3hGqcvkkE/pYkoiuyNZapPFOaE/EDU8q9b/AWZtSsmXpvWQzgP6lVyUDZaYcGUxpCjVGYavjxof2hK23/PsXfFhG2rj4Sue8hiHqhQBdVx9ldb5gkw7AUxBzrFr82RFBWWKqX+LvDX+2vUgHEE+dioe+O8=
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1035.eurprd04.prod.outlook.com (2a01:111:e400:581a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Fri, 31 Aug
 2018 08:58:08 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com
Cc:     computersforpeace@gmail.com, frieder.schrempf@exceet.de,
        linux-kernel@vger.kernel.org, david.wolfe@nxp.com,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 2/2] mtd: spi-nor: add entry for mt35xu512aba flash
Date:   Fri, 31 Aug 2018 14:26:03 +0530
Message-Id: <1535705763-26369-3-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535705763-26369-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1535705763-26369-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:3:2::28) To HE1PR04MB1035.eurprd04.prod.outlook.com
 (2a01:111:e400:581a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3522eed4-8500-4309-c27f-08d60f1fe16b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1035;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1035;3:MP4OjZXM65e6xbAueRYgjiR6wlL++uNAH+hPIo3Q0YMeXOxvIUohjeBdtyGXH6palvsOzux5i8AYf7AhU7z/eJK5UMzaVPRFPFwx+iihP8jObh7DEfnmqo34eGtyt5ysq0EvFb+VJTfotBJseXxV4eyjshKxghRNn7UbmHmFgHX8w4Qu2k+oZB1VO964tuPO3yQ1TVgNLc9+uN3u4k0Ru2sUJyofZEgOIVVAzz3/7TGfNnyH4kkmTTD/jBqcqy5v;25:yxi+aw98Wpp4gEuqXyZt/8wusn5zzwBJ0MHHhwV/jmVFGOiqel3Ye7xwhRQs6OO9yJOKFfKmm4g6sBmDlAc7ExE8PnUxLunV29YC10YECrjXQ16Q5w+fmDWFjQMuVQCM7maNK7D2N0s1JT4VkRP/fxHDYeN8tbf9FLJ4FD6EVFo/4vWjEQ82GJiPDhRSR1NRkhQc9NOGI+vuPINnlh0e2lIB3kWYIcV8sdm6d5iAhPEryo1YWH61jIRxzx1fccWcy8xqJyWN4L8Ukubjkol7pjgfN1y0aOp4RrCycwPuaVRAWJ9JUqTAtstfZQpTLIp92oci2Huc2dEpdC88iQMDDA==;31:k2wUqufSdHCeTkr6q928auKHFulF4aGMqlQqbCJOtUzUtNJccW2YyiFV7qH4Zuoc05Rcu7BmPxzYTXur+KcUDE9w2HiT8V9FOF0ujNMoO5df0aeyP2z+RjFhP5jR4p80gXXg+yVnVCM0w2+/8yBMlB3zeAC/bok9OqBJlESY6CpeIHp/LncRjt80ZpDYePQai4Dv2+Hnhp5SXmLWN0PxqFsec2dGMBuMMI9bHQ0eFlY=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1035:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1035;20:PouOBArss6EW67C3t6/7BjzpBnw5RS3BtEp/nTN/y0xZXNcZvDuIrrurFTGoXndxGtIwHP2Q7WCiieDucfrCzh8ynEv/Q6zmNSdMeQz1MTayXIB+6NCjBWeoxk91Cn4YOi3Ipn/7KQqm5Ify0oQ0OmE4idE+jRhDwgNHMGCJftv4pxEzisUqOdUgvleNeuD+7Lrliii/Erw7bp/yCYbcijBfct4zOyvZAEl4/B8spX34JTc9xRdHn4WB+PnhP8iNf2beiHr4X9FfkyADV6j2R5dPh0HoinA9iJd3bACbq0gzQh+2aQ7hKvChQs0srTjuVuD66LHQgTYw19dbn7A0FsoKCnXmBeYM863s9tNk74ETbFaCfdjEppGPbEflvA+pwOQ+yajeGo1aBZTQPSgq3dPIWOAN0PbbrQsD9gEAJieTZAar/IuVoIrJop3O3faa4F8Cl9xzryfY+8V9O5Enyz1IYUhd7IMV/YbrvDC7kqLQFOZa4bAxgqJGCodlz2b+;4:QqAgOOk9GbA2OhVB9aaHs/05KP7dpDjYt/ZJb38CntARgQITbOU8filM7A9ZWeTYyyR9sjhKjHg8Jp7vMpv2BMceyxYUJyb9ivM17XAUn+BPhme+8QOlXrS5DYcrzTl4FySg0ojRWp1WklTKk/0EFO2H2AWgeSksUCE87VuJ2ZQu8LoClrWYimkYB1ytfaqhxIkTAx83jON//Gw/lgUPqIc59jO8KoD/MKXbV/tjollO2grNKQ9RNuI7535fulMGQuwg4Shmi+bslxN2pcZHG790zQc1v+DTf6DFoJDD7Ci1fQck5jZapnqZ2Rlr1Ray
X-Microsoft-Antispam-PRVS: <HE1PR04MB10350CC75161ED2C714235EF990F0@HE1PR04MB1035.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:HE1PR04MB1035;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1035;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(55236004)(8936002)(16526019)(186003)(26005)(97736004)(8676002)(81166006)(5660300001)(6512007)(39060400002)(4326008)(86362001)(50226002)(6486002)(52116002)(48376002)(51416003)(76176011)(5009440100003)(6666003)(305945005)(7736002)(386003)(6506007)(14444005)(956004)(2616005)(476003)(11346002)(446003)(68736007)(478600001)(66066001)(47776003)(486006)(16586007)(316002)(36756003)(53936002)(81156014)(25786009)(3846002)(50466002)(6116002)(2906002)(106356001)(105586002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1035;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1035;23:0M/Cp4uZ9PmW8ufIUzmPU5gR4k1NhKzRMs4Lgpz6z?=
 =?us-ascii?Q?rYyQGTUaS+QTcNVhRz65v9EY9tpXnWAWaWqz8Hm3wBgsumJi35TCeS4sCs4q?=
 =?us-ascii?Q?ImQzj8w8bYGyIhPrQZDs8J+9wIQiEioj9XehEyhpGK5eYi65d6qmvr9cJFwC?=
 =?us-ascii?Q?M8Ssg8cW8KyT1DCEN1vw5NeUhR079zahnb3t2Vo/poYyc9oDl74glYZMYJV/?=
 =?us-ascii?Q?GABCTyi18B4AYiWdrmOEw3XLHvK70qyPtJuuazKetPxeroxeo5bhyuXEn73S?=
 =?us-ascii?Q?2IHUn0gVAf8enokyMZUNzCmZf69all+y2g0brv8Xbu6R0EfzVDSHl6L43yCf?=
 =?us-ascii?Q?ykqAc1GBreaqRLQC/vwA2RxyxqJOH9hZ0FslGitvYz7xPZvzjx7zLPP2H+9b?=
 =?us-ascii?Q?l73Ytf+B/Ax8/q6buUnpEbQd+C38ZfJZCci0XsoYeXpXVddYH61XN7mIRGMp?=
 =?us-ascii?Q?NqYfyE+xnoy6utLDJAqVQW568e6lV12E1CF+LifIFx/gVNqSOhT0TcCG0YTX?=
 =?us-ascii?Q?iR5EW6jCS/J8att8eVIki7dMRRy99NJQVDY+3Nh26TV72OOMqTKyYIIS9ZDi?=
 =?us-ascii?Q?sXstBf0+xcVEGtdca/DJAbdaboylMqMDAAoGjnnTnskkoEg7wpVnFMUJHJbC?=
 =?us-ascii?Q?/1pQAbr4f88qMJur3/t3HmZGxiVzmIJxy9q94d7hoaQ90l18T6ztz9n307I6?=
 =?us-ascii?Q?P8/9xQq+bzbtKkIhRsdRZin5dPnhbCbTUIMoCXrdvoVVjafbmLho3wLCUn95?=
 =?us-ascii?Q?9WfkspbGGqSKQ1YRc/dbHP9+Ddo9skHrIm7PC4RgmXQxSgk6Ur1dyivZlN4k?=
 =?us-ascii?Q?3PKaIVVngopnciAyjA0Jx1bM477GBsJ6JQXSECN1VNgwkA1Cu+xKbkbL+7Nn?=
 =?us-ascii?Q?1WiMSAYA29AE8wMJMTR4+DboEXZ8RKW/XHcXOis6MaitkzBllmAHyeH0v4qo?=
 =?us-ascii?Q?qSP7O1iB4dyYg/lqIzJNFurY0PXeCb8dsexi+76rqoy6JQSp/FG34MH/q/9h?=
 =?us-ascii?Q?q4jlS96nPU44NUcXYAnKKdbIvIwo6Zab0VhZaBUmerFIGo7P5wlKmRqxlFa4?=
 =?us-ascii?Q?KnxseCyLiVVa7TZlw44g8+04aO4gieQcMcG7vlA/oyfUE+2JCscx1pRLhY6O?=
 =?us-ascii?Q?z2ZMzitLNMs1cDShQvejQXMFcyRbtxdBvfUziguGzf55IDyo2lPNIsy/xPsL?=
 =?us-ascii?Q?255izsHKzS95Whmq/IxUNN8a1kmWuUhydYy/TaaJ7Q741i06CvLYHJFdOqhA?=
 =?us-ascii?Q?9GcqDj+r46KUhhjnKPMI7xgpXUNQmv97cTbyOov?=
X-Microsoft-Antispam-Message-Info: 7+b28mLoyA895VVOPJLf+HQUALSexwbNb1B0f3+NHHiUveXaYAmjdJ4B4yFV9/NcGnJdpMpk0as1PElBK2FeXu0kUSw8Pa2m7mdnFBmg6HWjtk1GGSJqfiVT2TA8pnEQGLgw1UTAAWRA6gyK1mWChJgrVT4S5M00heLBNLPirzdfHyIqoFCukxK5fyYFXvCn9jJDbB+karjLFXekh2zsZ2Z809+Ndg6r5cIT4/hj6m/YGFSKDfCpFvv5sKON3mU0VKW9tRsOSw1c27WsUksM/1//Ka6KOvIDOHXcLZ2U678wa9E8eW/my7lbbLuvsafveicoDptJpFsOuqTz5DXyhEBp2pV6xrNuEACF0Ghp7js=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1035;6:hbUdsHg1SM61afAhBwwp5HwZ43tHMtrhX96NX9JGVc3TV9gUtCTgJpGQeSuOKxUMounInpErrGvJGMtuQ2aLOJ2KkQtyJ9X1AKCVa69GMMqjhjOjpSygyUQKjrhGKHsz6YH/FgfVjfnjlVRufimuZjoC6G0B8KvH0Gccf5vY28rOHVaX+VtR/c2WtdUXgo8nLqZ0U2Icfv50NuomWTWypKMgQfwrV23FGWjJ+YfTV91b0oHa5xgcBALSeNdbQD1CUBj3QivHSs6afDxXpui5hIJFJnYh3qM6r/LrpO7UpHOnU3KeTA+UyclS/2kzEQ3xnLrgp9uCuMwGC6FKxrrJQVW0XDFTOszb/ylfb3CONcmldSvMmXLQVW/xz2DjCkTGPkkn5Tg5UQ6l2Jm8cAH1/JxIlvC3vB0CMAGWD5eFQhy2BF1eRh5KpFpog9Pn9ipsQRkDg5terzTzUAAZmgSxvg==;5:2v8vyuqD8YzgVbXm0sI9s/+0tS7AQGwhyjAQm047Ta66z3j03HLMlyNugPi42Pavhc7jf9SfUlminNzzqD4s293DY6K1bCQcWL4DpNrO6Z7cnCU2pfGnNtpSdSxWIMtvTgshru4psXpcM7l2Onr1MyQ4NU/3qlkOepCVQDDSEP8=;7:aWgk/wZ0ZlxRcL9J2PnWcgWBcrIGVtQtnOJOc2Isw35caPu6VuMbUrG7HZ/TMocDXlpaitaMvdjV3+KikegrRmkkOIceYwXoTsHooHgNVxtNZMk0bcTUevkfac3hZ7nbi2eU3r8faXcysh43tZNnQTr0JFnFDs1WNaaCrlOT7lZoOJNBXDFf6Ttoq5yqUTMw9fA92J8EGq30+Q5mJ83YUq0DUD3VEc7NIXSz0kXtQMxrI7RizmvZfD/matJAJWZL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 08:58:08.6561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3522eed4-8500-4309-c27f-08d60f1fe16b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for mt35xu512aba Micron NOR flash.
This flash is having uniform sector erase size of 128KB, have
support of FSR(flag status register), flash size is 64MB and
supports 4-byte commands.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 33a55bc..6042df8 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1113,6 +1113,9 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 
+	/* Micron */
+	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512, SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES) },
+
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
 	{ "pm25lv010",   INFO(0,        0, 32 * 1024,    4, SECT_4K_PMC) },
-- 
1.9.1

