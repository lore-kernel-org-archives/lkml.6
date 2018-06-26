Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80DEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67505263AE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eXHsHSCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67505263AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934588AbeFZBF7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:05:59 -0400
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:33312
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933294AbeFZBF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWCAeQA9qqf7CeIWahiMH/cS98pDfHEfK+yXgfwxzto=;
 b=eXHsHSCwCMsjyTQYR0fMmaP2zEYgkmp1XoIbb8EDzy18TBuWG5kYeZqlrBpnd8P1yyiQ5FO6268lOGrzVB9+WAfKViPPbPc6FCnYPEv3eWNTEH4iM0qIZqbEm86u737Q/Ywi3lx9JsQOdq+b2ztPGqBlBm7GzpGhtxywJn9L2Lg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB5PR04MB1318.eurprd04.prod.outlook.com (2a01:111:e400:51cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.21; Tue, 26 Jun
 2018 01:05:50 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
Date:   Tue, 26 Jun 2018 09:01:40 +0800
Message-Id: <1529974900-28865-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::31) To DB5PR04MB1318.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e4a1b2b-b47a-4205-c05b-08d5db00f743
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1318;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;3:9rRkcDQoTzCnA4bylv59RQ4SqKUUV5bvAvv2A8ZOZRnFZ6Jikgz7GxRkJeGHtxvc0cq2m+y8onUsK25DCudIxtxc6RmhQ4d1NbvmBr/4X+S3lJBX514lWOatabssSYYugx5cg0Zr1zDW2khQFVBcN3eMMYeoihzoA7iP7RWcdr2MN62tkWEZaWNslYDOw1h56iCkmxO9B81sL1ndzijT1C886rzEi6+LaAYG2sFNCo3iT6YF+iTGAVrjOAhFmhg1;25:ajj8t5MWyw0JrCSXH4qiAqK5dyxO87IvzvoTiQoTq6Dbcfl4ybORxWq2l8FmDR1kyQZX0OOkHwWv1jTIiKQPk/kyj5zNagIwTCLkexY9ZJX2nI36hGf6JzPMKxvDFO5QHFP8qYNALHkmjLkn5qUgfUnzBwC5iJd4j47WgkArPh8yfu8zJPCoOLqNHNTLhDYSlPqMmu1dmF3upoq2G+DKGw3X7uK8uM5LsEFnN+0bQ8weTZfyOeNxpHyFmQ2vV9DHFaL1xWOJYhVm6AYxdC3zsUCXto7Sxm7iiTyhIVX3WVmqwz8nYAYspeXlWLHfIlAoAg7ZJemzO8dpXuO0WfJwng==;31:l/qv+ITGGKTwYZTao6KyUx+Su09QqdvMmdNGNnISKmggSz/tPuxWFytANgBkNfaZTbNNftH75GA2JYO7CwXiU/X1GCrHg3/Gn9BtqtHwSiYL5Rt9Vf1k8/zZDIHZQt7+1Vc7trq2qEbL4isLcf9v1iWj9kJJB03ohBS9EMp4JW+wmPOWK8C842Wmz43AJr+cZjyzkrd/zceTE8cuDaXF35WkFpzOxII/AsgskxVvDME=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1318:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;20:RxBOAUpCrlK9vqx8C+R/mK796/ZVpGRUGK1qLhBjcnc32xYEKbiOK0LlcVoWNRs1Eje6S4JLvYNh6l6qYeISLvMUrBLFADgekK00hvkctSZJ1KInfoC065wwAdOU8Eq0lFwIaDXIF4TCvS3f82rT/m3rtu8yUtrOHQbID/Qe7cNlopt8veQXCvPkGa/oFXErdxLwSyQtgzjQX02bZ02M8tHFKrVp2TbSIsJ7BUJ277z0QTyBJa/QD0UoG9ssyxt1CcLveaUOdRETdKH+qp4HNCXTY2OgxL1vkRoS0WR1jQnJlNt2/zxRaaQBExHYnJCbGVErtFOhH5ErGs9rUIpRd3AwJq/I6JY6evYEf6ay85nntQWM3rQF6mroFA1lA6p6mL2qQ8QmG4KjhuQthZsNIpAx6cjKpCNJ9lOKIS4Xg1hN8+j9fwLA3pCkqHpCR/xwLenrC/FupQRw3jwOEmYqOuPcyH6aBlIx3PhFuR5yrXMU6Df6EZmlVgNzUDmbfX+E;4:aYxNOtOCLMogajG3cKVoc9zpUSgQYF4TpdvlfHmQ8NYwK1qX7ck/T7NDJTYX/hEz2qxHUkZBxgmPWcQM7ivDYV9YKRhGwNXsSUh/nKvuiUbbt+S7Fr94kBHAl1jp0g8Ehhu5xNA67iOWsb1OFsD/jXclPvwvqAcmHSROZQLlI3w7422BQADPJtK4RKtmx9DBtobAnYzcRj5yUfwfjmjA3hdcDInG+4q/mlsCdh06csxf9y80nyZeTd70uuUKqdROLqsBVVPnPxaXXTI3dRXOWbIAMr8hnuCfEnjM+cRvp0FL3p0OmBJPyEH+DMfJ5aWb
X-Microsoft-Antispam-PRVS: <DB5PR04MB131861CAB5C678E3E7322705F5490@DB5PR04MB1318.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1318;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1318;
X-Forefront-PRVS: 071518EF63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(376002)(346002)(199004)(189003)(6486002)(86362001)(97736004)(16586007)(6116002)(3846002)(53936002)(36756003)(6506007)(386003)(305945005)(7736002)(6512007)(186003)(16526019)(26005)(316002)(51416003)(476003)(52116002)(2616005)(4326008)(47776003)(486006)(956004)(66066001)(50226002)(5660300001)(478600001)(50466002)(48376002)(68736007)(25786009)(14444005)(6666003)(81156014)(106356001)(81166006)(105586002)(8936002)(2906002)(8676002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1318;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1318;23:dttbJ78r+dzru3aAct7CiI1WHd/JaYbsIi2gNwLMX?=
 =?us-ascii?Q?igruleFCYKX2Z4VUvVIar+NM4M1JFOHN574GEzHgZOiWP+ZfK8FcG8omRtC7?=
 =?us-ascii?Q?6u9IFlmynS9RRfjZGaTK8YidsqMmVhP2HfdOIHR+woUAi6nm8A706OR+cSFq?=
 =?us-ascii?Q?VOvXcRU3Nkx0+jOgALBoH32ekgjYITt8RbdPriymJRkrFhwxRlX9bNP6n6HV?=
 =?us-ascii?Q?hLzm4Ma2Ghj9NOd06KwwXYb2/eOPBvPinG/AMXPhQCuUlQgQaCgHlZxoFa+g?=
 =?us-ascii?Q?/iKQBf6bDmVUWEebeG9AXo5CFbsueSGXa36RHX1sc5zOLXgTD79DX8Jv65a0?=
 =?us-ascii?Q?8DSWAGJcDpjb+GOdKM1NMWIvCKIVVFmaPd7HKf8EBoDqDqbWadcoB/uKUxSo?=
 =?us-ascii?Q?m3UuoHoC3f4q51QzJX15hBdFFQzWXWmz3XcKcZWSebLjabgNjlP6ANZpG/QU?=
 =?us-ascii?Q?DJLuca8kWIvmyTv7hJpaAC5XCrywl0Ni7JBy/RG3uFWFG3v9n9IPo8XIbwKw?=
 =?us-ascii?Q?F7XR9TtQhLn8JZ9Z7LSfKBxFextiNGOJbZp3LekGh9htxi6RjOu66WXBtSEg?=
 =?us-ascii?Q?0+TsIn2junnuptP//kMrljUA0HhCF6Yf4zMA18xck7ps5NUmgp0v2QPAbgbx?=
 =?us-ascii?Q?SKVHqzVjt3UU9HTfxi0RRc8arO4uqMkHA88C9CLuVTGfcA72BAcLWA4qfGp4?=
 =?us-ascii?Q?K9JobQXP/2BAZFg6DrmygBE+1e1/QMsa67ChlMpuqOsxC30c1IlG9SjlbR+m?=
 =?us-ascii?Q?2CT8ed5rmCt8wZJclK8cjmh48Uout4XazqeDbEaWXQ4pPFn1dokujJDVYyVn?=
 =?us-ascii?Q?lcxDyCeZJfp5T9dEYf/b2kYaLQNxj7hdSX6d849bML7050T2FAewbmq1xFiX?=
 =?us-ascii?Q?wzNMcGm/Nrz5ahrgpzYDhZWBbLaTOW3pEJMHbSFD1IwQ4gHo8KywUCIPmWse?=
 =?us-ascii?Q?ZI560lnBR9wu4tlH2twuYRdMUaxVwg2sL/INn/DC42QPsytVBmb/JzS7URQ7?=
 =?us-ascii?Q?BwMqK1i/MOx0KB9SBuqX9chOcmRZgLGcB1YwBBFzlxCDvyMDQFXodpiWihBg?=
 =?us-ascii?Q?G/kiiDKovkTxq5Ukr/cbVeGg2owzIpiiHQLUgG3m73p4my7qbZTtp3bfhntk?=
 =?us-ascii?Q?6sMh6bQIlmlCZrU1GYAHKMJty0CQ5DC?=
X-Microsoft-Antispam-Message-Info: DZsF1nJE7XtTs7jxjKjuZ9koHjXFA3cWipCQrVLKR8O7lfCS7/FtpSDZCvhviQbVmNv2wA/uwhC9i+y476kv/XjpaNbquPVToHFjL8Rxh8A74FGolGL4K17UIJgVXvG+VFUj19ab61kXMdlyA1CLtTgZwviwJpPnCbn7cxnbEePQpaBFvHrrDMCjXahap89P5ZHsCRnBUSJNtKeaTAp2FWoZTHgssBPI+w89C4u+NqcUM4nu85pi9Wf7ZvD1TS4nvid98BaB5m+M5J9zRiCB0Bcd249cBRHKfmBmDsawklAQuzRWky3jUQM8MFtT601IivWLBeQkxtnnqzxtCPbzgenHpR+AXsTdXsCyJwlZw60=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;6:CxqtR1/a6vC5KYDrwVvEuTsUWHxQGkITi+UsGjshxGrlH6jTRrTh7KuUHjC13OM3ifGFOyCupc9svDPBip/Io2vGcqe5rB351mRP8XyaLMFG3d2nK7XZI9Izo1XO7TLuv3LcuW9lIhuiw0GfVa9nHSeQqWaGfK8OyRPSrgmNyaF/dc0cfML5kdkKowQGlwRcO7YQwB89gRHSQ4xOrfwGzVjwx3eZ2h7d09ufc5pldh0iVEBG1/wNNA8LIHpxGZB/vWZWA2RQOxPZCQp8MaDYhod0LUmI7GDPAQZuYjdr9YIOQ1lGoub17lAxVALZMyuP11F1jLhlH+4flUyJjXNN9zrzHFKHqAF/sd1EL6SjfDssXMudFW1UQ+psaagpOy51Ysb5hT257KrN63oQ9Pg7EoZlJFkxUkWWFLR4cD2yHlwCIHB6sVc1ObqUZ/AFciVM/BomJxjSVS3bL2awgY6GgA==;5:nJDwOM9A0rE3Sy6JNLnaxkK5+QMgEHOPOccaEnkAaINkcQaJRD+zhuzTKjnhMjHX11Gtn2LwliSolrZVb1LZ+JtuCeQOsiyDnoITfCsW90hALBTOPh84lAFgyqcePdmrQFaaSdiqSelwKBr6AG05K2vXaAMYCiXZwe8sYKk5mZA=;24:KxhRkFUG/KZH1/bexHIxWvaLcmAC+U8LrkCWOPME1m5gYn9PbtWl7eaoAL1oxEYxoRLDM6PyqXhkZPpuo8VOz/lhh8R40qY0aukNHefezFM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;7:Hcc24o6t+JUgWvFck4SbswsuYqK8BXAOXFEycPisPqHKYy0Z3pG+mPpWpNQoS6/pVgc15ivKncISMCxtl0fQyoDlMnt3Z7USncYN6Ep9GJHKs4MIBnrLq791yg3QxulDWAhnGQTfhRSpvAK5tbBnt0O6z0Q41iekSBzunT5xK90d2QUOIxV9koNndpRMczpx3oLIvu90eyVVvrd615x0KzuD3sMNlOHShtQLpGqGnxx12YkbEb2bsoQdPnik3TrM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2018 01:05:50.6905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4a1b2b-b47a-4205-c05b-08d5db00f743
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1318
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6SLL EVK board, PFuze100's SW4 is supplying
LPDDR3, it needs to be always on. This patch fixes
Linux kernel boot up hang caused by commit
(5fe156f regulator: pfuze100: add enable/disable for switch),
because SW4 is turned off unexpectedly:

[    1.693613] cfg80211: failed to load regulatory.db
[    1.700063] SW4: disabling
[    1.703973] SWBST: disabling

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	improve commit message by adding info of which commit introduces this issue.
 arch/arm/boot/dts/imx6sll-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 4684ac4..2217c40 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -142,6 +142,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
-- 
2.7.4

