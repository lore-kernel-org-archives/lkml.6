Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE7BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB2D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uOGnDSoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB2D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934392AbeFRNLl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:11:41 -0400
Received: from mail-he1eur01on0057.outbound.protection.outlook.com ([104.47.0.57]:38112
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933189AbeFRNLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSwqmBh+vB4mzkR0P8EJikdh3wvuIwy/DxJTHgB0c0E=;
 b=uOGnDSoBWjen0c1aoCJT+DskdsPgQyH05ZGyhOdDHS3wBUp7oNMtjAvqbrrxswGCY+vCOxfoU4oS0zfc7du0K0f+wsulelLdocUxXx5YPCGf+HO5G/VXVvtSlKiNLRoa3Z+jtW3M9cP2k/fXQ7rLZDe9PO8wiD4DgDHDebe+o3A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 VI1PR04MB4304.eurprd04.prod.outlook.com (2603:10a6:803:3f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Mon, 18 Jun 2018 13:11:33 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     Robby Cai <robby.cai@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx7d-sdb: Remove duplicate regulator-can2-3v3
Date:   Mon, 18 Jun 2018 16:11:09 +0300
Message-Id: <abacbb7485b0c9b908eae8ae87be9d8e0eab87b3.1529327283.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR0201CA0017.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::27) To VI1PR04MB4304.eurprd04.prod.outlook.com
 (2603:10a6:803:3f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e38d753e-7b85-4e9d-571b-08d5d51d03dd
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4304;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4304;3:YRaPSeKDy0wQD9Gxajx9t1n/EGcfC5S5ctUd8JzXFVegtqHZHwCs4I6J0J4qmy7ImPCcU47F1YtvNH3rOxwDHJ8ci+wgkirEQrIoRLzEMMAwmq0Wa3tfpTMrdizpJZ4iXV5RDelDDDx0wOd0VNSKq7ma4pc0sIETSCmgVy/aNcfWUKnv14kTfCrsmbyVHGtvBUJzLGFN5XFSszZxGJXiGYOYEN1QchLQII8fKahxCs/BXfU9dHvCkBm9YN4Yzusi;25:w+cxqs9ZCIHULTVi3tWcqAYXVFiP+5McH/0u5k4dp0MLAKA4Oaib6AD+8TyXiViWM4nVBrWIw+oVd07Z23FMQOxk5Ru6cFm05Pi67PxshZH0TyjmK5QyhEnuCA5nI5KPpfU5fHzrXbunPOY2+kDEpfR/oLZ9vdobeo8d7TRoodkmIsDqYUwnguQQTNB+1TwYErAmo1D2cSjqmIHqiUoHYf9jFsKFgK2+95kzwKiAUamFkwvx09j9X08MKdFYeSH2/P9L0R36pCCu1GoGUnJoaPdvvLfYyWMzgwB+8BDhrMgvX1glybv1rHRnBqwdc+y+Y6WR/LZ13u/CsPvb4aVnzg==;31:dn0q9IyXYo7gOzKVPpqCRuLtQbbq1DYSshVIJEXOtNkKYeZJUtozpF6OlYoR3L0WtFgb5/ywieLprjckpalSOC3y0Keh/l9ubwT5pJUJ1kwCqbJdLIX4IVNEOzVUxNur+OZck8umkqCKi8GqCbNcZ3Y4sMfsoX7yyhrM6GDAJdWZLJ2e7bzYiV0P6az1i5ilEGjhMHKe9IAcj08I7Mu942gx8f4aYAEpxtVJkCNHJWY=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4304:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4304;20:MRc7uKsW2N5jzytYn0H46llzRn7+3SlG5bmivGosGg/FE74cXjiIilZHdIKH0EUImYdzOZ5/JM9eYM/iC3pgrjHcDh9wbiW6MKHamFfGECkTnLgNlciMkZaiN4EtfVRaN5He3fLneQK+IU3kYIWshkVBqJz91f/0S+QC6WqNSFQ0Aq0eUoiCTn8n0YhbWdp78lf2L5dCgEJD6ZvmD5a+Thl1nAy7KzjRUBad9XYeYeGSXAfsTo+GQtxTDXDmCMIvy5hD3Uqu4/rZPZX9bHdTs8blqqz1vuT7+t8lngmpmoF1PIgnBuCyDr3626vOC8a66oCH3A+ztK5zllsvgoao48ME+AM+lGs/B6tAIRkBeoFkC3ST1oeNq7sgK9gkSgQLihG4QggPjXkX+LBG5g3UEs4vVL8XJiqeRQk2N5xg6caK4/k720eVMSUT04blMdkmFK2bQLoFEFvh2Xuy+SmxeRg5bFwIi+lg+DB2XmtGVi9qvDnp57QKFYaWiROOKcvI;4:8M9gilimUNVLAK57g9Xv7+MTwOL2tj8UPviTG6jRJChG2GCvLULYTWJAMN8MU5QLnxOlR7d8xO4XnmJHxgM3hWEZCOkYxdtMavL797k9LwGAQQXR+O3vVsgoldxEAKExqJT8GPH6g3tkurluKjAJK3W+Pktxs4m+JXt3mMBRPqf5LvrjAD1oo485LPzcCTqcvBhk3u/7fOCBzwAVPKuUSAa/u9c0ZaIYtdO5FZdCWliCwLQRtmNuA7GdVBBFUtsG5iBEtBe/nQcX3HlGvCGDvx2V3M5UHgNgFAsadoNTpQRjvEjrZgEL1jAFUUlVWklp
X-Microsoft-Antispam-PRVS: <VI1PR04MB4304DFFBC42D365A0C4F2D91EE710@VI1PR04MB4304.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4304;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4304;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(376002)(39860400002)(39380400002)(346002)(396003)(199004)(189003)(36756003)(2616005)(956004)(486006)(476003)(50226002)(51416003)(44832011)(52116002)(6486002)(25786009)(6512007)(478600001)(4326008)(110136005)(16586007)(316002)(47776003)(66066001)(8676002)(6636002)(5660300001)(48376002)(6666003)(186003)(26005)(118296001)(2906002)(7736002)(305945005)(97736004)(106356001)(68736007)(105586002)(53936002)(16526019)(1857600001)(86362001)(6506007)(386003)(6116002)(8936002)(50466002)(3846002)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4304;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4304;23:DgO4fD42DrjJ7DAf3m07d5GlprCfI6xQzRWTeIkif?=
 =?us-ascii?Q?OnIDkxfCSj9jAGSducY+VBR55OZ+aRNszNHIGaycd2sCkzLzftWCkEHIvi9e?=
 =?us-ascii?Q?BMwWWMTBIoC/pKiNxh9nYNJbtH9fTlqzyxx4mhmk/dosYQJvi9L6cqkKDDmj?=
 =?us-ascii?Q?Zhq/0IFNBrhYR6dXoZe+k26YOxahtm0nPD8RmD8a1rFGKaN91T1ehE+YbzTk?=
 =?us-ascii?Q?X3bm27vz6VtCOpZWZvbMfmQL7UCX8LJlOzcW5GcqPlJ8sbyMN4AuYKhnJe4I?=
 =?us-ascii?Q?su0kSIrsrr7u1xBLGUB3szCJOyNFUY8C4fhpxdSdx4RQFrD/o2YatnuUwVgV?=
 =?us-ascii?Q?RxMWQXuHSmfqqCILtFpqDlErjBP7uzX0I2nr2D+bxoPm8w4DFv7PAhqH+DTb?=
 =?us-ascii?Q?dQuneHMFEYb1ZdKcHTuk+47qp1kiw6dMSNW5fhXynIVTtIarqExAhid08wi0?=
 =?us-ascii?Q?pOpwCgs1Qp9y5VK+o91ShhU/Hv/JVJmV5fvR1cS1CuhbUhwaD0VwnNX46Rd1?=
 =?us-ascii?Q?YzP4z47SR2+JWQuVjFbgtj7z4/0BmE6H+UtWZcrEBRlja59yUKoUSYKUI4GL?=
 =?us-ascii?Q?S8daUJe8O6Q9HT6tj3Cj15quXr82mtKsx5oBAYxG+4f2VD3+x1rfPwRnPW66?=
 =?us-ascii?Q?u8cXarUOpzZjLVyPSQC4cOCG74Sbo/ceAxNvhR5q/IDerI/DgcPYJp0pXsdg?=
 =?us-ascii?Q?ZGofmZF67L4ZPxhIgzGktuIbY35JONw9ozsni2p3hlbWxq8IngNhgsBOgVp7?=
 =?us-ascii?Q?hBwIRM3hARDvXbm7FbjPnk0N9NIh4qsknZ67qXsVfPWUUcnd5piuRHAQ54vJ?=
 =?us-ascii?Q?5A8iGzl9w61xD5ScS3Ohs//nxvOeTN8R1bcR+goaFcj50bl+WG1Ca077pqx8?=
 =?us-ascii?Q?6547+Q5TDgAAX2JqSXcqs/cHROdrvyq0UFfB+yJzIp4bNyg3tGHHBR5IP/zG?=
 =?us-ascii?Q?wbfKepbaeBI0EcSoBkC6bRnkjpSuVi3L8/x4EzMeo6FrLg1R2y/Buo1bgxxd?=
 =?us-ascii?Q?xKGJ+kuHQEXZPuVkwni5bQZI9JhYQ81VHRWBFsl5GVrA1beT73FzO2UOhUPG?=
 =?us-ascii?Q?JJcenlHRAb5hu22GxKBk5rLzc4r0d8qChRpu/ErI1/DPb715ybyxwNivvYqU?=
 =?us-ascii?Q?6jBvhJN4ikTBriXt7dsqI2GlRz6xbygb9sNL1jFME/XLCcgH8acHhGvEVOR2?=
 =?us-ascii?Q?I6QvF+35mn4sz95sEJcwkBVqLNgaMGNiLP5K3SV3KuWwPeEn965bt0X8A=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: CWA6+0Pj2v/D6aiaRWiz2XbCiZlX6dlcbMQJ7Vgi/XpaXwBGfYsPdNA7SkyWB54P8d57ECjr3PCW4dg4hGNI/3vlVVoJHJ3tXuReaHCerf3713+TAyIQzCilJgW7K780eFBPwppEKLxE8+3e9DR2NYYePRTSDp68LfFBvvJkT2fiHwA9zFeTXIKopMVBXqujsA862hoBoM2/MsL4YUqTQIMTBPPJRerw45DFMIPB5dAc/yV1mLUy1+iq27fiEw+f/cwcmk/Y+oKFOD/N2JHxBxn8ID85viEgetB+FHlPfUxNJgyAp9BjurLzER/OwQA8rOknhtKtaHlf2DYeOrk9Wg==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4304;6:HOFOhECHxLXfaUWg8nLTxAO/e1EHAYrTlM7mM0MIIPM/365YXWV9T8YSJ/MiMBhMiy5jBQX0soMla/3nQw3Dq6kT8HWvty/c9x5Y6qLSsMmwCZtLXtcT1hygJJgUORFbgKxkUn3bC2pgkS3iE/nKEiPxJ0l0s8fcALtZKyM60EKIiKhHn9JGwoCOwbVrX7nw2TtLiVVsCy6/wON6uEpjpqNzSw7kqLKzwrGTJ1od4e0pyFdK49jpEaDfT2y2QcJXqJWF1e/pVNgsY07FkY+qnJtMNPotxWJE+QIN3irKHW+ut4+zGnSQUu9kw5RarwC23nIlM0Whh9FRnl6eJ1A814f9gLlzuhaKRgWpCPxdek81x5nQ6uG0Ysai2BfcOJsCZk01+vjcCvno2e8U+BzFeqVkOFjelqznvc4BOwSY0gZg++qOQLPSonnoxgli6/ZYauenQZWheU7c3IRiC5VESg==;5:9EItWCx7RuE+83Z2mMsxyl17iX/QIG79Hf/+dgc+4rlstxVfjMABD9atv2KZ/8OMlzw6I4rdwJnYLxA2bHaUmGEBKnQLEEQGSUcirJ/stW4KaERMPCAScH01uZ7ONBl9RCsi6w4nb2D8+uMhfe85pNcAYVwlkE4BrXClbstMaQQ=;24:lqDZq2lKUFPVElCt8kN6tP8uZzennNVvdso15kASBxL4Z2Hs7yM49oX7OwvDxhN5YA/t4iHCioEHcOv3pJG+cOugZ5K+Mvl9/bm1mM2GfAI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4304;7:SJTparCGQnDExv45BhzaTPQeQlbYSbJPPSb2HGV7ecftfeXT7cVv3zkzgq1ZsD3iO4q4AUUjmIoRtlRgD6JHaTt1zA/+3dolZja+pT9VfLk6Uz6kF9wqlqY0fo9NuszYjkGPTHDWMzoGMlypDhX3wfmGp/NwqzOTWLEjV6m41nPe891eeyCzVhxZBA94XVZRX3Hwxgse7Wj3mIQPlbkRrE3SMfd53FXUPCqzjY6i7czRAUymg54ADKO5tXsT8fLo
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 13:11:33.1823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e38d753e-7b85-4e9d-571b-08d5d51d03dd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4304
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two different regulators are defined with the same name and label but
distinct properties.

The first definition was added with the first board dts and the second
was added when upstream added flexcan support.

Looking at schematics it is indeed gpio2 14 connected to the STB pin of
the CAN transceiver so remove the first definition.

The second definition entirely overrides the first so this already
worked and this patch results in no DTB change, just a cleanup.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 arch/arm/boot/dts/imx7d-sdb.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 940849163104..9f9e6a1e3b72 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -69,18 +69,10 @@
 		regulator-max-microvolt = <5000000>;
 		gpio = <&gpio4 7 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 
-	reg_can2_3v3: regulator-can2-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "can2-3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio1 7 GPIO_ACTIVE_LOW>;
-	};
-
 	reg_vref_1v8: regulator-vref-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vref-1v8";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
-- 
2.17.1

