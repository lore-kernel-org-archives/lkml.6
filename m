Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F072AC65C1D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 13:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5CF2075C
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 13:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jbDW7GSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5CF2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbeJGUqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 16:46:53 -0400
Received: from mail-ve1eur01on0069.outbound.protection.outlook.com ([104.47.1.69]:24230
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbeJGUqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 16:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQ1bQiMdV1pSvSqpsvn74phrP0GrHCV1YZ6v4dusyJE=;
 b=jbDW7GSfS523RrEyzUoX1dtfYtgdCe70KeBLvx6BFiX2LOl/6ppjUn7juquCIBSwAAUqhOubKgyD8PO0bg+Z6UkGVy9qH+oHDm1J2tkHdPJN3nElNnN0dFZIb7HbwJuHYS1/4xFWV9STIwuPo4b9NyQmO/KDHYUkRTXJQ6Si+FA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from shlinux2.ap.freescale.net (119.31.174.66) by
 AM0PR04MB4210.eurprd04.prod.outlook.com (2603:10a6:208:66::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.22; Sun, 7 Oct 2018 13:39:31 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/1] MAINTAINERS: imx: include drivers/firmware/imx path
Date:   Sun,  7 Oct 2018 21:24:17 +0800
Message-Id: <1538918657-2032-1-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:36::27) To AM0PR04MB4210.eurprd04.prod.outlook.com
 (2603:10a6:208:66::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dc8932f-4a50-42d4-3939-08d62c5a50e6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4210;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;3:U4AGVPBT8Wr2frVwAcAPKEfCkhqxUcXYjLPz0KVb/LDSDtIXI/NTf4HnpJEHQ8rl/W84IoQSpZ0yypsnhn9MehJvIbnYbEZ+wEZ0T592Sa0/z+PZSiZ0/ivPcUtlh6bq2XpEcXkCApls5CV4pr/o/u3Naes/hcylVapjag0vgKFeMTUF+N0/fnhnlZkr8FP8O3hbyoSpQSz0qdw8ty3mVdw56csGBJM94us1DMNocNh4avUTnrJGuEYPzd6QgQ93;25:aEgnE6KWZQmXcZWo2f1f2xkuzkZxyJRgjstSdW4kExyaMFJb1JdDuogkDgU610GvspMIG7McLlDajQqbMxDn86DRmyiq/pLbv0HO+tkPEFA2HNJ9x2lJ1HkbyfxQ2WdK3qEESUemN7TGOJkJ56m+5E6KFo5fUH5Ph+TZLKFgpEHbH1pkTBi4tBk9TCX6smOlhhvKab4jL/uMXpeEgVQ78HBBr9gvBBturKDXEVOFWwbKWVbqvJfFMuRagtTIzbllXg9mxV8G6SJ8RDm54+iQPsmsckWLd2X8Me7JK3/6MorLu75tDiTaShDhIdVhT2OEfqxe97O4tNxqSD6XJ6NYKw==;31:lK2IW+1grCYi9RXFJ+KvaQ0KLpYou42Aoaz80cZesp914zgjKO1WPFtpHn/CfRsfbHMJ5D2D/P1PeRcTKqs+RFrhHVRp7juzbVlvhXeK6Sph1MrUl45iddaCS82HjGEk27XLX1J2+waqb2rwKNehb59ez5XGcnnA8rlpvG0LyjI5RBisx40S89E1TuhR+Q0f5RTLfSET9CNVJUpwFbRea9zC0pCJ7MDwYSxYwQ1CG10=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4210:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;20:rqdBK7L/uaQzaCUhtVXcYEodOFuMFuLJP5wd/UbbUdjs0zC8ohYfeVmtvlScRKOPAwjfE3qiSvicPKZwDtxa7yu8VYISpy3ioXF1fY8NfjOdkz4q9RlLcLbjqFD0Q2r4PxjnHqxmQhnUGQ5Ifg2M8Td8FBeBo536MF3JKDuHEPNiSOK/eNaz+9swLK4YdHPX276JM/AXem75ORiXG0oPtvvR0xLeFsWmSxhRXlQdwo8eDQrtv3U+XZpHkL0E2w68Lzd4+ylL1mXEzwb1TxEM0fKywk4CHgs1+8Sw6JWL6UifWIJhhJ6N3Hyu1lADu+gFq8UTp8XWHC0phtO/IfWNr/vX8LFZ+45xrw0Jyvc60WzygeMCfjeCpi/CFWkvEe2FaWfo9tiIkYxK+0vTqy8GzmWZXTNVXkFJE8oCUJVQgD6HHhTft35O/I19Zul1Fcg4R76K0Zqo5foh3BITTxnrrG6olIVn1NYUwgUCfh6iMh2HjvFAWkpb8JTA1E0skS9S;4:1wfsnIo1lU9DGh2WNBimSUQFCZnLTtRBjRMU5ZuqK/h6ORyld2NVDbz1VwUBo2TsolGv4KF3p5nU9bjFzblFVWCzNT4KySuRedChQegf6CmZGnF+XozxLmoiEWnRkCPeXAEg2Of5LRco5R7eMHxjEU25uTuOJf0kwKmfjQxbXM8edHUesNoEZRXTLi2eI9Bd9Dy4+kHQwGzvYDZkWm1P5WJqitfVFcR8FlnTAQLFD73bcenAA6KaggUPHA3h5CFRYX8I/vIPvelZw6UfAYIhOvEWaBhliiSKid7LqQQkmNrB/riI7iLZwVjRy09HwWichiQCQqPYps8bWHdD3njmFA==
X-Microsoft-Antispam-PRVS: <AM0PR04MB4210FBD90E236200D1DB408B80E50@AM0PR04MB4210.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991055);SRVR:AM0PR04MB4210;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4210;
X-Forefront-PRVS: 0818724663
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39850400004)(376002)(136003)(189003)(199004)(2906002)(5660300001)(68736007)(305945005)(186003)(16526019)(86362001)(4326008)(6116002)(50226002)(476003)(81156014)(386003)(6506007)(8676002)(3846002)(26005)(6666003)(6916009)(8936002)(25786009)(81166006)(7736002)(53936002)(2351001)(316002)(52116002)(105586002)(97736004)(36756003)(16586007)(106356001)(486006)(39060400002)(54906003)(478600001)(6512007)(2361001)(956004)(66066001)(47776003)(51416003)(6486002)(2616005)(50466002)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4210;H:shlinux2.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4210;23:dXvCiKZumFLxTuuOV+iP6kU1IQX8ajJ5vfYtMNTMZ?=
 =?us-ascii?Q?fxcfEQUyZ2S2qyYUf804F7JxrSaKsrTX0EgC/5W0RTdx+iAM5Tgel6nRvXKt?=
 =?us-ascii?Q?/hasNNcS8k7LDHxhTwYMR1PEvTda7RW/K0i109rHQwYGotrwGX/UMQZFAHP3?=
 =?us-ascii?Q?rxfrYshad/X7R/pb33krUpnuaCmhVPyfx0QuMhb/v8AI9/ZbvinkbxXMwLRE?=
 =?us-ascii?Q?ePXB6hGOWIbiYEpYQfIrUmCLJuuaKJ7o7Wkwrf36ZAWl80/gPhZV+YPZTcZM?=
 =?us-ascii?Q?GD50L5E7iveKhXsbdWKbEkCaxvQLu683lq3bTl/0W1MqgOnXoGpLRIC1NVf1?=
 =?us-ascii?Q?YM/BTfElF6GBD2ZiYP1p9d25b4lQh2427F/kZ8pTRWjwRy0FjewIFfsHZhqJ?=
 =?us-ascii?Q?n2sAkgJN2CjKWcio9qKd1oCQ8lkc+N6FK+SKcx4AC778nx38DrX3f2fviLN2?=
 =?us-ascii?Q?N9X7Rc5bJOgMLl9g9Zcw0Y/40/jh51X56FlEwzeS9EtKVVjzrpbZ4de9YjTk?=
 =?us-ascii?Q?vtyBv46X3bp2CyPawZq2cehByMSqTJ/0QQ8V6NkGlzN1UjkjViyZ1kFtjcCy?=
 =?us-ascii?Q?HKM9nu1d5C3w+4ZpjTrU77N6RYemooSbzUsltaYh3IeoXRFhB0uCpOzHqTMK?=
 =?us-ascii?Q?+3mYbPZ1GMh81UX1oJn1bmHNdRG/sQDuE2srLptjBA4EfmY4KZUA05j3lips?=
 =?us-ascii?Q?KI2O3K0JNak87rd8Hkz3Ztj/hHKjEekbZ8s7WGKd6cmiXWDPikuy/QxAEPOJ?=
 =?us-ascii?Q?h8/DYaiIGkqQKCMzaBTo3P9qBZ8v7mXbz/aSHLqcOV39MFn8O/muOjNI1CxO?=
 =?us-ascii?Q?eMURcFgWkcDRMxDNwTJpGo6L2U2rgrm3OjzGjUUFQx3PesewUj8qvcb9X0NY?=
 =?us-ascii?Q?sgeHDdnXY39mCfPFYIKrc1/Lu3rnfAEeafZNYjqQknZW+HCLwqCgsJo4eT0S?=
 =?us-ascii?Q?tGRxUbyLm96o8+xCNguwoPCQDzTbgD6v2bh5hSA7/sVCpB93pQHUdRoFbY2A?=
 =?us-ascii?Q?RWIClz72/AtxadHHjcH2vDxYzspGFKeBrHprHZCGTauY1/qylW4GXw9MN4qP?=
 =?us-ascii?Q?o6z7CrJqigiwzRASZrIHCYVT5bC5M1bRqAOZg6QPIYi8iK7xZ5qlRg8HSUFH?=
 =?us-ascii?Q?ofUMlG+xEpBLAJFKosalBK/QOJBX3EeEaOBx4nTUdoX68NP77axqIKrNlEYy?=
 =?us-ascii?Q?q1OLAMv4iUEh7hQcybRZKmxGZtM87wJLVFs?=
X-Microsoft-Antispam-Message-Info: htEdEXO5MVHviPmc56u0JE6A0V3DbfoZ0RL/TC0JlIsyZgxC4+DYHus5PwNEg9dxmuRf+O2YRKf89cxC0+zXm607ZpB1vw7Y+30yxi455yFRc9hM6ixW7CwSR5j9c0EpcvJTE2bxM+B0TM/PiFN+dpAQNQcBbf+QUuk/JqsIP5b0noIkOKR0aEjkiK2JZqc3p+kF0LScfp9h4aDbeJeBZhfsromEvd1GlAISxo2Dp3J5YY6kuYk5edKFDguT9rr/v5b3PvvLuI9pPyRgJb4LiEdgYrDffYv72iaKKQsXpoiyZQDmcnWfX8xhnENvUNIm7EqhnyXizvdf63SBE95cBlfMFijl/sFutRK71dOXkuA=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;6:DMohJY7DHCJhjRkCdzxHzTlb6zXMLhhuC7emiW5Jw4AepI0hiNsRUz6i86IGt8apEJ00/LzZ94Qc9DPxjEmUiccU/yqyWhRsJmhYNfu2hCvCz02l9+3Y9GwgYOSzoMhJWbZFvJKJ2JiG5/cgZpQ4itwCKu7aARZsfKR2ZJNbQMnKKf7fSFLAsIZZxr2jPySKePERuwfMcoeH9B4qMzoPZyzs/F53vgoDnxxgtmGqCj7GeLlq/rYPTKUEPd7zU9d+WcnkfJYHM2fxXz9sf8Wpph3igiSpvV/4wuKtHu9+N59TFuf2dTgEf9rFp4QGcPdwiVobl3SEpDusFX4PjBrBJH/fkxiF9VkOkAnDCcTai01N3tFj2UsRyPJGr+7Grdyxlk9jrFTFZDBnoqxw49m+ZUUAPBFbi0xTe6C+2hV6A2H2XdH8kQNTo5i8gvVLFQ9Bz9qBnYNbKZXSNN4bZgY+/g==;5:ROzI3Zq9S1ATkoSafLcLHI1txUkE77ZvRXX6aY7VR3tzYi3r5itLJX/hBID5rBY37s1QrCOz9Ns2J8IXIoyh2vd0d/PmAPpEgK12KLZj0Oe9oNQkUR8ibGOKiuGViejz3f9hOfY3VrkTJ7quUJIQ1KC5pZ3p+8/HIHU4Ikei1GA=;7:10ZHX7krMyIENM7fxX4mSMX5NdGsPFkd18XY5Ff6SPS+uJ5toBx2deKR34SrxSUIJu922Eb6B/u/HTNi7KHn+BLZdWmx5WDqB5fwg1QsxYxhZrTFZnls5iJGq1j8p+04plx4khCqysYutjHMREZvLaypJT1psQyoFMOnWHKXVWdCAP7IQmBfC5cjOvqshuq5VuILkQyKz7Y1clLw4mtA8cOMxV2c7hBZVkeAsr3REnEqBJB4jDUhP7fbCTYBYTVa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2018 13:39:31.0259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc8932f-4a50-42d4-3939-08d62c5a50e6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to newly added IMX SCU firmware support, let's add
drivers/firmware/imx into maintainership.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052a..d1fb824 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1462,6 +1462,7 @@ F:	arch/arm/mach-mxs/
 F:	arch/arm/boot/dts/imx*
 F:	arch/arm/configs/imx*_defconfig
 F:	drivers/clk/imx/
+F:	drivers/firmware/imx/
 F:	drivers/soc/imx/
 F:	include/soc/imx/
 
-- 
2.7.4

