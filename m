Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED45C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545312073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N03kP+UE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545312073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeIEMUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:20:03 -0400
Received: from mail-eopbgr00043.outbound.protection.outlook.com ([40.107.0.43]:9824
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbeIEMUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgOTjIsmrT5TvzY6SnWtGFF8ZS2I53EfZdboyrVazhc=;
 b=N03kP+UED+ZA7jkK1GNZsm3/fSH1VDvaI+bSqvoYvmjCYB4jow97vFsPimQ5Id2HYRCa0h4U6YwiBaXTuxLQXn2J/6VQSnCuG+1sJooWzhQXNH3lMXfwksl3655ih4J9YjTkkV2SqXylHZckLNpJWJAYONX7XVyK3uNi/f1ngLY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB3PR0402MB3914.eurprd04.prod.outlook.com (2603:10a6:8:f::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Wed, 5 Sep 2018 07:50:58 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx6qdl-sabreauto: add gpio keys support
Date:   Wed,  5 Sep 2018 15:46:12 +0800
Message-Id: <1536133572-2138-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0095.apcprd03.prod.outlook.com
 (2603:1096:203:72::35) To DB3PR0402MB3914.eurprd04.prod.outlook.com
 (2603:10a6:8:f::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39713aa6-3593-4cef-8e34-08d6130453d2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3914;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3914;3:FW0XAzbY50Zq6Gp2gvHFN44i+eR3US03ayfogylM4vr8HQ1T2VhmQJXdgbCU7UNb0y6QTHCv+sk1SHfo3s6faDINks5NZPVkHys9cOrOey3shlN+w/IjmrgitxnB70dI/l7Ma5NUQy0JXC2ZKiMzokP40bZu55K5/fhfMy87uCbzFk+UrwaSQBT9YjlCY3LBeXj5HCE33a7wta7FqyfXLuqnWQqVA707QHhBqretW38FbUHJSyfeH3uXhs/kU7xj;25:0KmCZjtzJpZtNO9Of106DeqYl8LMgrDxjNGbSpNXZx7HLMpzjpnKDhWW0+hMMWSMuY8ZOS4Dm3TytqroK8U0Zc0PHXQ8cLN+So+YgToTG3WkzmZQhPGDHHTo/MbtMu6VPEgF22eqWLXmHbbuU1j46Rhgg/6z2kByKVrYVyxLJNS1y5ezlMFEO8Hi1nO3KUn+3jEB57cH2eo/+h0NtqX0oQx6LpAuHm5ByxlgULGMhyQ10MMIHR+FYjtQqgzWnRCwovaep16/GGpr6EMd9iVv5Yw/gFzxMw0WvMOSQu//B7h6T/ob3vS3DdN7PkfONzo4utxsaBq4ItaViIUn43cOpg==;31:bazl5zGoWGVMq4OWWm8VYdCg8j6hsNYdG7dY86S5KsXyg6DnvQcGch+qufIFrkPwTSDfxZgB7MHDKU8Bz4F3QOjR5cVJmwk7INwpGT7QBcEMcW/13pEyClBc61kUHoBRcGFXzPV8vJiiFEykTABzlVYPLNkjpkdOvn3xNAeeMGsm+TqFDqbZU4AUUVfZIghexsQokFtUcoRa3uTJRPmEI/dZyYmW00Gx99lnbLS2q2Y=
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3914:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3914;20:YNTJrhgaoUWxLXZFRdvnallXpg1mwL6EFiJuwksJ4EJxyykNmCLiUAc0fsIYiPNdcitsM8Ss4lX786wYi7wj1zlbXj8r1bnSN+jb0s7y6LkSbgpiwtOaElfbJep1t4iPPH1AIJQ3LNNS/xHjq9+TZR0836LXZa6H2HJuBlOfEAsEBxuhOfgXuQblmk1Qx9kHeSWMHwOFMRFstKTNbOafy6ywn9LX3sitS1Fghq2WSXpRTG5wC5Eu5JULtDx1ooLD6Zr23cpdxDoJsfYUjUkEUkD2awYEH7FOAGWSKXNJNq+4xHl9ZLaVwOUBCIj+amVZaO7wZYF2/IGYrX2z0Y67OUlhpXNmYeWhMjQYJDQTZHBCxDo1h//QpGLHw4ISfBDzXNfs3tjjqH8FlIpcVBLZaV+tNIqAVlpjZS6cq9tSOHrad8pSGC+X3KrJvkecnxlYYZmTZNFTA91YWazuXDNXLLKhadzNvqZlo/EXhQEXsQ866pkULxwcw9k2mHgt8nFM;4:lzPIYTGb5hA/SNbFqDhspfgAJM1cTBfY6tfzFM/8a/JPC4Dt0I+qK3Ce+mnuIqQqx6IaMmBDJFLz5MnakuiS8+Zh3NsdrxJVJ9764HUMeZSmPmsIXaJisNxlB5qWqBmEMBoO5w39POkp6JuiR1QHtku1usYRvSazOb0H4hGaFoqfZAWa3Doi4+lB2TstEWeobbCl8erQtyjLGrCet/vjIzY5CF36n2aEzFFUYiQybkocQXOe0ZwOezJN3pD44dfoGNcVSk+qt6QGaZgzxFRIXAOCfc0kDhojAYBu4A+HSTV6NGpgh3mru5lJWU0Rd8en
X-Microsoft-Antispam-PRVS: <DB3PR0402MB39145B5781A2155DD4286C32F5020@DB3PR0402MB3914.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:DB3PR0402MB3914;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3914;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(136003)(346002)(39860400002)(199004)(189003)(6486002)(478600001)(53936002)(97736004)(50466002)(8936002)(25786009)(66066001)(4326008)(50226002)(6512007)(51416003)(47776003)(52116002)(1857600001)(5660300001)(81166006)(26005)(106356001)(7736002)(6116002)(476003)(2616005)(956004)(16526019)(186003)(6506007)(386003)(486006)(8676002)(2906002)(36756003)(305945005)(316002)(86362001)(575784001)(68736007)(105586002)(3846002)(81156014)(6666003)(16586007)(48376002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3914;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB3PR0402MB3914;23:D2IHaFY3P+5fJk+sWAkmLG+HmNYCKxhuZhRATpA?=
 =?us-ascii?Q?zzqIhAZWOTVaZeBSiu/nUsrVUuiwXvoDhfjY88ICcg6ud2Sv5NQ7ZqyUXADr?=
 =?us-ascii?Q?oRjMpdiK6wF8Ia0Wd/3yfUDgeoxwYZJCCAJWvMKO0pUxfEUcc5K1jI1m9bIT?=
 =?us-ascii?Q?I3Kz7AOw8WxNGgzTKKuYcJEgAnsspBhc9vmfFxNnjXAR/wj0J6n0Ddie3QBa?=
 =?us-ascii?Q?e9anARy82JZ7ve71KxRo8jTTjnNhYo5dAvlPReLKEeZzj76gVQBbvo1jnJvM?=
 =?us-ascii?Q?86GPrDCdVMaW1252f+acPklbu+Cn7sPy9ofsCJeWRRFijsZnOXJx6U8bufPx?=
 =?us-ascii?Q?LHB8jdOCkhE0dF9NoW9zd7Sqg8HzJK5konK93ewoQ3swbmGo2LVRP8T0ZgQC?=
 =?us-ascii?Q?3wn7amBq2JalFyL3CGVa1B4a2RejlXmSCcxAJcKgDyG1hMMVlW1o5I5X1RuN?=
 =?us-ascii?Q?v0J0vKmM6/lldN5WmTIGHPLd2yWGy//wxMUXqlF0JoY3A3Y5DVVhRs1xUhZI?=
 =?us-ascii?Q?o08a+wwSCvwTGDvMNaccRghRJJJigAw126fVEWH8lvgvbeE7CdJ6JAvTl065?=
 =?us-ascii?Q?fvF0fe7tZTfxW4fykpkz6dKEiToFnO1srf0VNuqBHtG0J9a9U4gWBPiVKXr7?=
 =?us-ascii?Q?pyYF5B9oHuChOtpLM3hgso03b13XtdW+qoIB1o6KxsKeAX2rYVfHJZJOj4jd?=
 =?us-ascii?Q?1Sm0Pd2WkuHqcEiOukh/h2nucL3i95PgEtD/eupgZVTFbqT74Hw8Rh4zsnSX?=
 =?us-ascii?Q?AY4Pi0WgPO5rEj5mY0z2Zmm6I1POgJeYKEiJP4UZeszUE971CXLRcNxgtVOb?=
 =?us-ascii?Q?ex3tB/9Ovwl0ETLQxo15+VzaqR7Vw/77FhszYiLxBvYp+RLz6c+kVEZ92mNw?=
 =?us-ascii?Q?mZx9QrKK85Gji93mthKDVWXHYVBGCp6b3pcCt/AySi+WNUSLD/sCl6UUZJ+j?=
 =?us-ascii?Q?3GDzuDpREu33GVLoOpNEiwOkOCddEplHrxBREckzwOVfkfNhJOezDNNmF5PB?=
 =?us-ascii?Q?JiLDQoqN5XNKv6A3w38pklUDCUlINc4/XWLgfuo4NlJz9wrR9tYmzb7/QrX0?=
 =?us-ascii?Q?9fn1v2PIvAmv9tgZBQfOHddi6olGeUDoWHSSTe16iskgw3RI9tXMoIQVlAVx?=
 =?us-ascii?Q?x6kyT9uUMd17H779HqgZXnwDiwv1Vo99DudBVE2fuGcsyR+cLqda3MQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: x/Wf59/+VrJQuQFEkeb88ERBT+MiLahwC5HNzBglvnrUM3x+CzCOkEw999Ssv83m2l0riqqkRHHKUBYfDT29LoQ1lt3TNFyK6hVhU9Dd6B3TP8H1IcOS/ZgHOT+9orqFN/wfcuGJXyIhiaw89AW7c+nbeY3xQbGB9hbt/jq5k9sur2Z918/ZZecHhg6qi1dvxXWf9VxQlmmIB15p9Sc6ddXCDUcT4dZoBfgTV/4F6KthMVaKC+MmlYq1Oe+JYaNpZHRKhvpEtnYOqRF+fcFpBSR3DKZUuLIpdFt9V/2DneQNsq63t9Os6Lll1/utKz3EqC0ptlcXIog4aLmS/7zAyB/oNlEWMur3YZ5R9LBaAxc=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3914;6:XlW+UMc70h3s9PB+g5ZWED714vrOyLn04JZYKRV1LduKGxn02s+Jx564ruQp8cH/l5/rlVN1cyLf5b1qt6xccsXgmny2sePr3NQ6XItkJqLE9shtFxadphXup8VG3hBtHweLNN5FBWhhOQKsBjJw590nq4YFMLrtxjr5xaem9QF5rYxrB7fhFwkmNtH+6896ilRgGuHGNywFatIxiGf1DQWAWnzMwPBOAGp2u5PV/d9K9A6Y0oL3y5bZZJsUmGjKtotrT5ynJN6hXr2RPQswiUrlNp4z5SgA29ADtOknNUgucGa24PCOQ3v5ZgR++wddOxn0GCvjE9g9mRY+/+B9BQIvzEnBTcH3x03zM+3jhTIhcgJFOnJv+wT6TopUGNnz6ha5rRWprC5HPif8w0JJowlDNrj2MfnFBmI7mA/+A++CD4SEMkuikEBBxA/fh8kbuz41Db/KoHrpHMRrE7G8ig==;5:d1Sq4VrxgSfqtWfhsFsYKx3G/08EqRGNMTLwU11ZhhCiBc1yZttqm+smD8BgM0pHTFTIRV/sP/nftlXcqXaToj60Fc8RQ0+Lcjt9e09FK6La64rLXMljnkcl5RdKQtFM4MM02agGSIV2iUWcmlrLAnoOqcuzwn3pdVsugY8Tpbs=;7:LhAumlWlA6A87/yybYqcOyoe1hX8fj2wyD0NrdtMaMb+d9o/fpxj1R8LPxLNgK3jw+vhNtwgloTU9SMnLcfxrcnXkXlDz9BIThdtsVbgUqlq/U7oYES+QoxHprXlsWqgdXe3J2suAMcSJXgDbsM+Mde8yahMf7S5OnzwE7Dt2tSQuZk1AbuHUQkBPB/fJlbdEggVKSJGTWHyE7ZYilcm715c3C0ens6CakxBZc0I1VO3cJ+/1NAL/ehOLzRClSFo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 07:50:58.9733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39713aa6-3593-4cef-8e34-08d6130453d2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3914
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX6QDL SabreAuto board's gpio keys support, there
are 5 gpio keys on base board:

SW3: KEY_HOME;
SW4: KEY_BACK;
SW5: KEY_PROGRAM;
SW6: KEY_VOLUMEUP;
SW7: KEY_VOLUMEDOWN;

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 9f11f1f..246af86 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -4,6 +4,7 @@
 // Copyright 2011 Linaro Ltd.
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	chosen {
@@ -25,6 +26,47 @@
 		};
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		home {
+			label = "Home";
+			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOME>;
+			wakeup-source;
+		};
+
+		back {
+			label = "Back";
+			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+			wakeup-source;
+		};
+
+		program {
+			label = "Program";
+			gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_PROGRAM>;
+			wakeup-source;
+		};
+
+		volume-up {
+			label = "Volume Up";
+			gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
+		};
+
+		volume-down {
+			label = "Volume Down";
+			gpios = <&gpio5 14 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			wakeup-source;
+		};
+	};
+
 	clocks {
 		codec_osc: anaclk2 {
 			compatible = "fixed-clock";
@@ -446,6 +488,16 @@
 			>;
 		};
 
+		pinctrl_gpio_keys: gpiokeysgrp {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__GPIO1_IO11		0x1b0b0
+				MX6QDL_PAD_SD2_DAT3__GPIO1_IO12		0x1b0b0
+				MX6QDL_PAD_SD4_DAT4__GPIO2_IO12		0x1b0b0
+				MX6QDL_PAD_SD4_DAT7__GPIO2_IO15		0x1b0b0
+				MX6QDL_PAD_DISP0_DAT20__GPIO5_IO14	0x1b0b0
+			>;
+		};
+
 		pinctrl_gpio_leds: gpioledsgrp {
 			fsl,pins = <
 				MX6QDL_PAD_DISP0_DAT21__GPIO5_IO15	0x80000000
-- 
2.7.4

