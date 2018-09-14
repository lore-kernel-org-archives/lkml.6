Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF713C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459B62147D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qy+aZjO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459B62147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeINIQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 04:16:33 -0400
Received: from mail-eopbgr00085.outbound.protection.outlook.com ([40.107.0.85]:50144
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725953AbeINIQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 04:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNOZ16vBNMsljN/uF/C0F0bpj6lB5J6S1Esja74Hp+Y=;
 b=Qy+aZjO8Cqdx/CGi6UZHZNGXUxAMG8z5QSsfrzarbSxwyW1T/UiDbHqLd7ooDGNVSynSBHCo2wxlIWQufdN7k5i3w2o5hz95r4oznKLmKf8+ySiKmbwz5CPzuyDkJgOTzX2FobGXXYxanto537IbmThZrmVxDKVV2sjBrOAqTfM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM6PR0402MB3911.eurprd04.prod.outlook.com (2603:10a6:209:1c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Fri, 14 Sep
 2018 03:04:02 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] ARM: dts: imx6ul: use nvmem-cells for cpu speed grading
Date:   Fri, 14 Sep 2018 10:59:21 +0800
Message-Id: <1536893962-11200-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:203:52::28) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e8cdd8d-27c5-4547-b065-08d619eebbef
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3911;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3911;3:zyJBIUcdvxHnESmSSeruVB6sLcuLFnTsZz+zAAQxF6D8cpjSYc0WT/AIA2qk8ufyXrs2z/VssCfC6pHFeoh6CzTin8A01erwEEr8oI8jlPyRTFYFX5kpt5yOCqpjNAZ1s8Ea57zSpLzjCzJJDz8BTmLKRTU6cnG432bc3Iqg9JNcB/MRXw4+XW19XJtAKPFYGWUsrPNjWB3P/r+PACO8HhNVydet4tE4Xpvf51YkSNmZ7FWK8dz56t912L4DTEO2;25:DGqSKl4IrX9hpncbLe8ScBnu8JRDtvhH4QJXhIFSEck2EybqjEL6g3EaX2TyVjt9ORngcpyAdt75I5zbUZK+2G8OqRiY2yKi/g6R2A735kcWCpOXH2JE0YJoP62e2lJWUITTcKwPNqiz215VnwusTFPlXrGNoKlASP1OtbFPu9mt6f0SFdc48szPHOACFlqq7uIl/cQCByLLnlNteatA+Jq04nAwBSWttlyA4zTQQgFkPaYC6M+jklKoPEaoMtk6Gh/bncpbCgRTsd5jtH3w6dXALjiopBcUF6UPhwvWrq6zKyr2mO3sNCilHF/Ew0nWlcG2Cy1rqnmZB8aihPY+nw==;31:J17OBrmZc4xRYJW3IVkDGAo1UQo7lHYNJpw6+KTXT1kNcMmW57x3EPHvOdw+51YLB0AbvwVvNOx+ig6gealw+fBtrze8LP1/BYstoTIHONSzHxT48sosv2/F/+tVL/pxurWjG9zWVZKHUcZAlBrPND8EakQdhH7N+mNDOze6JtFQ5mfCGHTcTtSiXZUaybqP+V7vJfDmaOGcGz9Z/OSlQIGHrRsvwJCsEtcJLcw3G2A=
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3911:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3911;20:XRS2rWOHFII0ycrXp8YuupfscwrVT/WaGseX6LbTi0lLfnAHOJyD/oZernAcptHvYQQ7S4IK4sHzWVpiuZy2ISlBOfZG020+etUq5Knso9i06QmSQ9HO5pZkbRX4UfVuLRa0u051Hj52M78AQDeG6kfE+vRwEUDP93HFs+4y1Jr6d2904UfELdMYMMLqNAdeY+5Aki/iE8FzegWhGiGhhbiQUz9FHI+d1lAwganEeqwYdjItQBNk6YmEqcsn2z8BKl5NP7Oxam5jdOPr6t/6E55cdO5ZrvJlBVnl8FMnE1XOFZojRlEKJ1BdpNFyUnVKl+sgcWVM0LQ5+jMgY1nGz2evNoO9oCrbiBaRqG8cgl6LEOIWKBkm3ox1OMjEPnpifLVeFwiDnlN9Hy3unsgL2ATIG1+NQMJ6KYDphxj7am6iC0t8YPflio/Vymck5OY8onKbHdIBmA9p7/+ztknpi2u+hNtQXH9oPmR59VRI1ndVE9qyQL8TQoVWwrnMiuIM;4:pohkgf8/sjtpXCG9Go2G9p/zXSrYdJ1TKKCqBGF230jaAyrlnVHkvL30mNz6f3UjEmwVsSBrc+RCVrE/6S+lAKMGlVShf08j8ngYmTAhV8dxyWY1LHnwach9iKtN98WbHvyVugOe5ShShAJ4cHtHKFEKkun98s9hcZQiXtb6iO4ZXQBQj+OEDtMCW+tTE7GHlzx9eIRcPlXSy6gEeew1PUh8/z9oycySSnBoO8+3L4buZ9IdxnnlREC8robrxojV2MW/xHe4gCbNTgC0UImreVa2cyH7Ee1bQ1AzG7p0S49f8AzDGyknaKLLnXdb8g8K
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3911FDF5A551F81EEBA9979DF5190@AM6PR0402MB3911.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:AM6PR0402MB3911;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3911;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(956004)(2616005)(81156014)(81166006)(6512007)(36756003)(47776003)(476003)(6506007)(386003)(5660300001)(7736002)(2906002)(305945005)(478600001)(26005)(3846002)(316002)(6486002)(66066001)(105586002)(16586007)(8936002)(97736004)(68736007)(4326008)(486006)(52116002)(53936002)(106356001)(51416003)(186003)(575784001)(86362001)(25786009)(16526019)(48376002)(8676002)(6666003)(6116002)(50466002)(50226002)(7416002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3911;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR0402MB3911;23:0/7D+b5ZSZ4/MU7XZV+3Uf8hUwzgzLtYlujWHy+?=
 =?us-ascii?Q?XP/fynmg0IqW0uF1zprzoZZhYS3WokjRKv5DdGoXnhTDRQNOB8DaF81uz4pQ?=
 =?us-ascii?Q?aqx5RGo0IpMLBzpOwqtnpyPBb/ZNJMmUw5PqpLE9tWmhfSf55rfUNCKswQT9?=
 =?us-ascii?Q?KHL8EcsHxXtRkneIAbgNcXcUSRv3l1EWUHdlDPuRaCgFBohBSVwhyyE+uWzA?=
 =?us-ascii?Q?2sJKgt93Z9WxjbgAFTlP/1U+qLB5yu8dGp8TR2xQsqbJj32gmcSkpZxBovTR?=
 =?us-ascii?Q?xn3XkjNVDffK1pXbW3StwN3GXwRSq/xEote5N4RQ6016SCFqLFH1nQrO/qVu?=
 =?us-ascii?Q?DElSfV5q8ib/a6eIYC+orfEs5jAgwcbgpveunOb4wCnHqRfI/d44y4T46AgA?=
 =?us-ascii?Q?dCvNYC8F0SnWvU7J0MwT34hsmIhe/2E5yzaj5uR+tqnazfMw8xZFFE29+5V9?=
 =?us-ascii?Q?3NcqZMHbBH1UvNKDSuPuNrfaPjJcqo35JReMmKTCy21KedUTKg5aZOXOIZug?=
 =?us-ascii?Q?fBh5j6MJKanJUqbjBeDG0UVWH8+Rlb5af9Y6GTrc+VDpZpVCHZVUSVNRhXax?=
 =?us-ascii?Q?TKhdB8HOUepzDSk71HXjJiF8Sg/+KouwxWkdTYAavorSacsUbykJ2DP0DNoL?=
 =?us-ascii?Q?ZLSUwlrfEp33xQDbDdPRYq1d1rNkd1HU7M+lgw5wlp4TsTRYe52xvxHMgVfT?=
 =?us-ascii?Q?RkUxudnr0E+aesfygKneF218BzFVsYl9VEINq2Rzk8DlWzbGPnLiorgoVWXG?=
 =?us-ascii?Q?MK7j6ydf3b3xT4VsYQR99MqUUctuX97TtZoS0EK2DWgx+1LG0Xc97hwBIdFv?=
 =?us-ascii?Q?W3X1U37A47Mk8cUGGvLCvH6mV1ZLldOOId46u+o36mPt5et1NTRKneGjhnND?=
 =?us-ascii?Q?XA3OEEJxGUIgONj0vz2dPXleZtTbMg1WruF39wIzvGHh1vs+mZcK6Jk8PL2Y?=
 =?us-ascii?Q?B09I9DhTLIsVgRzxKLeoC3pJL4jZ9z0sYqAcKpYl+ethHLAqZ1fXm25dwZk2?=
 =?us-ascii?Q?nz+iyYkrwTGlOKTDyJKYoYc5W5DFUtVlnVwQ8AnPgc6dEicgSZRnWwBU0G6T?=
 =?us-ascii?Q?IkEgneg9ayj92mE9o7YuhBIPod+PenKbIzYf9e/aBHL/RPzylsgEiHaCwhbP?=
 =?us-ascii?Q?0N9sIkqu8t5alLR7wKuA93z+4asFTd+e2wBS7VCRO0dNHp1K4wTIHaISyWjb?=
 =?us-ascii?Q?ZJYh3+i18U7H++qI=3D?=
X-Microsoft-Antispam-Message-Info: o4KMdA+890zYN4HE1xvuWj8P6GrYTrxMLcEpn2IaFV6u1+nfgOo5LEfG+4lzNTO1WYOTTKAGs1dp+KFoAIhpy05WpMSMsOLBOV6KMabDONseuxudFg4rEAr/ZHDCVDlBsTD2ksv+FeI+iC89nnnqf0wFVcwwIweyegQWI9iUOrXO3yGITVUCfVoAWPZoCULf0CinwMkS5XmyOLqag1+YzFxBmHlvzDhZH7bnZhKtO/mG8ZJJNszM7oXpfFrd+tPVX36YKpP7bcJjxokpWzrGRo9KsTVYRXiid+/GBM1zk4pSukkoi1dnir4+qcC0/Qu+eb7CDOjvL4I4cbNgRetGTJrHpLY2rYJaj4Zn7N8zRCM=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3911;6:+75JQBhsgBjHlLH2DmgVQyhtk47vcOVht2fn7C5Md41UVNt0EDLteIKfJFIre4aKQrZ5HnkvsqDP6DCzGdMMKAGK79J7VV+JxxMQ+TKSd31v2ds1I48amYbgP+D50R3ITcY/jsTzR/3EEDFdz/UHO+u2hUg4CznJThAZ0KwF5v2wbtNbjKgp4mUDqeCLVw/LIG7FHFb1pobYvkbbACYltZVxWAK6mQS8N5TIvZtH69ndz8RIiqTaWZecM977XwgiZWR5UtGvjUVddhxhcYXUsOLuW7vzZs7Gm1F4YZ13YWmUpFFdnGuwRZLfnuun2/JJDmNUFIYY5y4I9kZFKeis/+hYyLGuTjRpd4o1DmFxjaAWmyB6Z9wWH+XZUElCTq5RrkK50J05jDfTsj/+1B5P+t8cujodq6xUp/veDa9gc4o0SZKCQ32XYYx0ol8MHPhGQP7JmIbYu1zhxP5Ykkd1Bw==;5:2yt1DfvrNRHx/LBG34KmqDC0Ex0bUDeshVGFrAieo1L2Vkdxhxu4jhDOetTGGYsaqiq3sy6wOwo+ae7UwwvkI9TfvyKyCzD+iBKUtFYsakGItfnNJN6VR1Jzbn7Fx3BkeEtSyZgXxSpsjDsZJgsKshVlbtZGFUBYB0kH/suu/CM=;7:6pv9a8yzjp2QJmVE+Km5joXqCWWihjckdlUy0k8yntYurTZYUizEfkEhZ5plCm1VR5kFEdcfrEgxBII3mTMQ+O3t2xMlP2UB5RXOqwRq8T+uHV7Wv6V0NtAZ9e+1UZWEet4SpyG2Y208J4OJm/eDpgY6ZlT4cm3LZNsz1au/5JIjlCI/IhgwzIWtV5rhWkKMcC/QZ6W3SMfqg11gURwk7UpIhNym5Q0Jpe9DaK/YarKYL8mTi14QhHAaJl5feaar
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 03:04:02.6044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8cdd8d-27c5-4547-b065-08d619eebbef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3911
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6UL, accessing OCOTP directly is wrong because the ocotp clock
needs to be enabled first, so use the nvmem-cells binding instead.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 6dc0b56..c670d8e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -89,6 +89,8 @@
 				      "pll1_sys";
 			arm-supply = <&reg_arm>;
 			soc-supply = <&reg_soc>;
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 	};
 
@@ -932,6 +934,10 @@
 				tempmon_temp_grade: temp-grade@20 {
 					reg = <0x20 4>;
 				};
+
+				cpu_speed_grade: speed-grade@10 {
+					reg = <0x10 4>;
+				};
 			};
 
 			lcdif: lcdif@21c8000 {
-- 
2.7.4

