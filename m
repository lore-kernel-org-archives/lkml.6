Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84787ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228F920874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ciSI/ULY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228F920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbeGXP2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:28:53 -0400
Received: from mail-he1eur01on0046.outbound.protection.outlook.com ([104.47.0.46]:13408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388540AbeGXP2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xe4bTCOnz+rR7Mysxu8fEOPpliQmrKVSBXiujyPOj8=;
 b=ciSI/ULYR7l2U3cKaULk110KbbyCrmOtqKAdJdIAzABz5tsqjaeuMoeuqxxFEQyRE1xoku6gFUCIbVn1oaZlLQIRqEitYrgyjLIaOlpeD0JBnjRDMt28KbJxA8gvY+6hm3YKcIIRU9KNMnlSnez4RVMMF6YjscYNmWzdP//3qwA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 DB7PR04MB4490.eurprd04.prod.outlook.com (2603:10a6:5:35::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 14:21:57 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, leoyang.li@nxp.com
Cc:     laurentiu.tudor@nxp.com, ruxandra.radulescu@nxp.com,
        horia.geanta@nxp.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, robin.murphy@arm.com,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v3 3/4] drivers/staging: Remove fsl-mc driver from staging
Date:   Tue, 24 Jul 2018 09:21:30 -0500
Message-Id: <20180724142131.28970-4-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180724142131.28970-1-roy.pledge@nxp.com>
References: <20180724142131.28970-1-roy.pledge@nxp.com>
Reply-to: roy.pledge@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR0102CA0006.prod.exchangelabs.com (2603:10b6:805:1::19)
 To DB7PR04MB4490.eurprd04.prod.outlook.com (2603:10a6:5:35::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e26a36e-febd-4a7a-aa1f-08d5f170d163
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4490;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4490;3:Wt/xGzOQp6HN6q0xfnjkTIftjAfv4S7blEIgJ6geRCiSmok49SWjCANb7MsPlCx0VgosCioTwe527EmicJUci3rho+0zWl+MNC4Np+yGpnAdQGc3xQ/s2VnF0M2t7+vKdkWi/wFU9A5YgtftWcjMJCoKAeBVIhywVbXS2yhRKm9wznFke7JFhkcza8SJ8cdN2zjYQ9QcEOXhW02o38UMxFAuL46Lz8rW4xSA2vU5BhEi2XRuU9VznarqDoJDRgIq;25:QrD1PpgTKRfzlVawr/1URG5WRy5K/Wk/m9V2xQ5i4jDnFArzKP/8gFCmxitmi/kfYrYlx8NY2WauWepFUCnWj00+WHj1jvIFKG+XJttWCTdr6jNh4E1yUft7ijXhO19ud4vzMnz5yDeyHOFiP4YaFyOPcL/qDnH+RjbyrzhaEG48hdLhaHkgbtMA/TfG00AFPw7M43nYPHUIjwKoZCYem7YCjQQP/VTczNENyFIc9lidHGxj7O4QlHY1WnWRNu2C6vHks2R5gGDMKz8vxD2cproGdvnysId2nr2YaQcZ6IGJc+YdQ+VeFEvJvQdXFM/Y8QjAPTAhfl2joYHNi8tMDg==;31:3gHMXkyvUJkYrTZj4SKUVvaZaB/ugzUfnZGZChK/LkMns9+W2+1++H8cIYbhZoIIhFLEFItgqD5sRWPJhBkTGDyq7z8WvglhyRhl0hPxZeu8KzPCUaiejD4io4w/rcRX2MSzdi9MQILKUGJfg/lhOCwB+Z7rrrjSiLiOkadbqGfdLceLaTvd/iZz2pWYVxACnrEIm0yU2Se5Y1eJkmgh0VS2mgM6KynSIyOV3TKtkDc=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4490:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4490;20:QwX1lhtSl0vRCqmqGGrTzfBtbdegc9+MR5O3QHLpx+IOpB8rOm2JLpBjkwoPSf8GhcWrmuei2Ov7Punwyl5Im3c5IkVmphrFuSvNExaq6snyVfBrXbFhxicTeQ5g+CnUp8OiKEzayeSftyY3z/5Dp2IySvrWrkdacqh55OO/lhVu1BPN7ZUeVtQErFvyI16/g/dsQE0O9owyjgKRiUZ0bqsy5is2InShv7Tnt0ER+iWSJcWBYHzJ8lyxKxIxqv/oT8Nh1ByBgzx6iiVI+q2fuFwA7rn/eFgaX4bQgsiLaGiwyY4jQi+6CWfFNao12ZJpxaenXpHIpUteq5yFPxQNdGLkoYhTDYD09AwoWNvceukZVa/z1G86SXn/Q6y34k+nRYZzQ5JfmFz7hIlSrHn6V3k62JYP9DDWNvEssJ/YZ0cx19eJGPddMEkM10lBy4voMM8klDg+bFatSmx5pBXkOX18Jbtjg7kgyBRTb66pFb21PmWDQH8nTFgbThfrSGYp;4:WnwA3VdhZI5mc4DE3ri9De9Rz6FTiP4uSdzCGh0k4/RRu8NEa4owuUoOeimmpI3bWZdQ/xst3167h9ZMGcATIz7PUWXCxBP62srQXv3sJXSjQyc+ytGzX4cK/kGS8SZyiyf8UUrSdiW9ppyD+xL0xQRmtrYPB02DvoDyxy5gr1kFQVZ7t6L0Rit47AvRTZbcGCn27OaYEyoiyjqg5H8V+EqCkrfYXd1ykeUU1evw0Jmx0aMlmYEb7EH3HD9ruSnalgwwbVXH6PEUiiOcbktZ7BlxtrmXKvG40pF+H+l5SbkoWkdS73dhWW0wxz9nsViD
X-Microsoft-Antispam-PRVS: <DB7PR04MB4490AFF4629910F632D5307586550@DB7PR04MB4490.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4490;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4490;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(366004)(199004)(189003)(1076002)(2616005)(105586002)(44832011)(66066001)(446003)(11346002)(486006)(2906002)(3450700001)(47776003)(478600001)(6486002)(36756003)(53936002)(106356001)(956004)(86362001)(6512007)(476003)(386003)(81156014)(5660300001)(6506007)(16526019)(68736007)(6636002)(97736004)(8936002)(6666003)(305945005)(76176011)(52116002)(186003)(50226002)(26005)(81166006)(7736002)(316002)(48376002)(14444005)(3846002)(6116002)(16586007)(25786009)(4326008)(43066004)(51416003)(8676002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4490;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4490;23:YS6gpikVTNwe3u+dfxhHkkkBIl/vmFka14WtfZn2+?=
 =?us-ascii?Q?gUAnujRxFdMMxRQBbtgIKm44c44RPAQMXOc+JPwrKh0z/YQ5x3oAAOn6RkLZ?=
 =?us-ascii?Q?A5qKGZwNpJdVvLArctheeVz1QUwec2TKM8dzi9am27Nq5Wo0THxTF9xOUzyB?=
 =?us-ascii?Q?0hValivSPo9xOzCgWAUEVyBEdRMW4z9Ysi39/PVHCxPSfurSCN/BsudezscB?=
 =?us-ascii?Q?ceg552L6xbN/Zu2LjPFYDCFi8CMaixMb5bVt2dOAj4MtUom80HjoDyxdrUA3?=
 =?us-ascii?Q?E+S1aq310ZCIZIq5/2mGtOvuG7N7GuCre39xtVK8Y9L7HUJObtKZmhdVU+F5?=
 =?us-ascii?Q?UmJkJb9N1K3xM8s2n30RxWYfq6pHhRjBHRRqzCrirlmlcxpVABHmr1Oc3FoP?=
 =?us-ascii?Q?czoiRDBdmNSOzcORE1dHuXafObececRvZwRMtwd9K/CrREIlrC+kV/XRdHAe?=
 =?us-ascii?Q?/u7P0xCx+dJIhNUygm4cYP5Auk6czCsEkmpYf1PyVA0UN08YWrmo8WpAygSv?=
 =?us-ascii?Q?dAopS+l1quO5FOBC1GC1/ElYkT8uwPXlUBFWsLfSMJQ0GtSNuNS34/hJueX0?=
 =?us-ascii?Q?5KcOOlJPdxF5C1gfdft+czWrBS5pxcbEqaim1BKLVU5WjlosMn4ocAdoOjoK?=
 =?us-ascii?Q?951v18MA7qPP/CWoSw+mxSUKvmBXTDWCcV3lJGHasaMgEiyqWvnkSXHMQdtw?=
 =?us-ascii?Q?oh1IG5OE41tEw/qpDS2IOXRxLvL7BmG62sSF9ZbUJAY9XKO4onQpciu2GAu0?=
 =?us-ascii?Q?zwtYXMHhpl3RfO3vMULY2203yviHNeXxJlYk47fP+csMJFpO9PPCDK3OajSf?=
 =?us-ascii?Q?LWVVbaf73QtYVP/oEQxYx9KDoODCabPRGGX//zKRSSNLhX1YTZKIkArpHXXh?=
 =?us-ascii?Q?ZjlegA5FgX6RZFfq+RSidGpt2viRq2rW1+RVw5SjR76qJpfSQ250mpyjcCFj?=
 =?us-ascii?Q?ZbN38Q+bzoLRO/cE4qC4lj4X1vUlloBTFtk159t6FeCcglCWiewmbp/xlAaf?=
 =?us-ascii?Q?h3JUpdCgfP4ZYvDxv5x51pHVP23MBFlNHDGy9Nk9vxYcGXPWHov/tP9+LmMr?=
 =?us-ascii?Q?88DddwD04sAV0vGOFcLqCMTuBqjXMgmte/NA6nSBA1uqvMYmeyjY02A6eMGz?=
 =?us-ascii?Q?1V4QqBAzlkavLzCbncBAtrCOnvUl9frHQS7Li56lECyLUyQ/eaIk+5YTIzhA?=
 =?us-ascii?Q?H3KxhnBos6JoNxCIBQqjv3iVDFyyG8vSkoJizc0w0BHhty94/OTJwi+Gx5R4?=
 =?us-ascii?Q?z96u2zImVpc8pU4vfs2IlV61BW6DiZBXS54riNX?=
X-Microsoft-Antispam-Message-Info: rB1CUgavYG8LDqW02dpPPiZkAgmGXxCEanlep6S9Ndhfnx1LJ1TKr65WIfsBIfi2WE4rtKdfdPWXPM6WGBWL1V5m/qx3PyhZGfzWqRnYt+wd8eraEWyw1KJjPfk9gJjGrARoKvmgUBZEFUEEH1t273joVW2YTB8j7VBWbsfxM1MwWm/kkFY0CwhMDNUoCfCKjV0PQGJL+AJcNYp1l9FHVtp/KgUZbK0+rx4e3fCJLUzpyxqJ97HbokRUaVtOQwugIbTAPGNYsXhxbaQrWD0eI21TNGLrqa06mCHGluiSEpZ9cXJ1JZbMp1IjPfBSGFtDB0IVCqAzJl8o7EOXIx3jjCy9/K+9IpSaxIzh0ihhZrw=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4490;6:g3JgmaqwYefpGQIZ4oLJlaVY0u/M2CPlos4U5yLINp/FZj3W2IKtUjLSG4T3PwedtCom1u1zBTwENFYWgZqhnIT8rWr8kfe4q8nzwKdL4apkliGnLjA80+rIALbNt5+7uAncyOf3ZZNpgxiZtwXKILbs0dsHRLYaQw8EbCtqtsv1nd9UCjmlMfi0dsz3WMek20tDoYanejdjlSuhs7z1dr051L3DwRk+A4itLmx2eIf0lQsc7o0QKPPUqdH7A3PWqNGYMiY/aNI8J6Sgf0PV5B0FnHCcIh+DNPng1PDyvNoPiRBL/c9Ca9o3tBwdfPV8iNq910e3AjEludNAV4jT+oaTmA+iDUIl2DdO9thkZkG8smqWyBdiSYtLdWfyNrO2ApHyZJlho+OAZfVEVtGlktP37d+Fvdgwrx9/+HhvrRaBojwiNsreA2ur19d++KX+LYeQVrDT9Nnbr2OENNNWrg==;5:znuMPiTa5rfCJpASvfYCOQAKXhxVeo//K2uouqhNnzdiclW5LXcopA2KGQXihvk1Cnf8nm85QG+rr/M4wIuVrCmBV52RsNfMZwS+0EsSxHoJUBgEv8oTYog4f1tZv1Xp3ge71HBteknUXhbVGgctK7EfjSLt7WvHsbWnvXjuqzo=;7:r2I1BcjArj6iN6y5CgqaihtO0VRk0wCPZTeJ65+euCE/1jEpIhc9srSx7SEXbHXROvypzauPJYhj8buWK6TfwDbsSUfYrZax7esHYXp1n0GChVylZmYhZ8UZFnz8M6YLEDgYYWu7SWImiJy1tl+AB4FYIxnrXapMUqSLCLy5qRuH6KCBIoCBiuFbJPT0zGxGM8kqhkCI9uvWhxvduFYlLZY0dhwnN6S0kDE72QVeeo8zGvxA5t6OuXaev7jMlgdL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 14:21:57.5050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e26a36e-febd-4a7a-aa1f-08d5f170d163
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4490
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the staging/drivers/fsl-mc directory from the staging
area now that all the components have been moved to the main
kernel areas.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/staging/Kconfig             | 2 --
 drivers/staging/Makefile            | 1 -
 drivers/staging/fsl-mc/Kconfig      | 2 --
 drivers/staging/fsl-mc/Makefile     | 3 ---
 drivers/staging/fsl-mc/bus/Kconfig  | 7 -------
 drivers/staging/fsl-mc/bus/Makefile | 7 -------
 6 files changed, 22 deletions(-)
 delete mode 100644 drivers/staging/fsl-mc/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/Makefile
 delete mode 100644 drivers/staging/fsl-mc/bus/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/bus/Makefile

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 75a4804..47b61c3 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -92,8 +92,6 @@ source "drivers/staging/clocking-wizard/Kconfig"
 
 source "drivers/staging/fbtft/Kconfig"
 
-source "drivers/staging/fsl-mc/Kconfig"
-
 source "drivers/staging/fsl-dpaa2/Kconfig"
 
 source "drivers/staging/wilc1000/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index e84959a..bfef8f2 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -37,7 +37,6 @@ obj-$(CONFIG_CRYPTO_SKEIN)	+= skein/
 obj-$(CONFIG_UNISYSSPAR)	+= unisys/
 obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+= clocking-wizard/
 obj-$(CONFIG_FB_TFT)		+= fbtft/
-obj-$(CONFIG_FSL_MC_BUS)	+= fsl-mc/
 obj-$(CONFIG_FSL_DPAA2)		+= fsl-dpaa2/
 obj-$(CONFIG_WILC1000)		+= wilc1000/
 obj-$(CONFIG_MOST)		+= most/
diff --git a/drivers/staging/fsl-mc/Kconfig b/drivers/staging/fsl-mc/Kconfig
deleted file mode 100644
index 3002229..0000000
--- a/drivers/staging/fsl-mc/Kconfig
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-source "drivers/staging/fsl-mc/bus/Kconfig"
diff --git a/drivers/staging/fsl-mc/Makefile b/drivers/staging/fsl-mc/Makefile
deleted file mode 100644
index 1468388..0000000
--- a/drivers/staging/fsl-mc/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Freescale Management Complex (MC) bus drivers
-obj-$(CONFIG_FSL_MC_BUS)	+= bus/
diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
deleted file mode 100644
index 90f234d..0000000
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# DPAA2 fsl-mc bus
-#
-# Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
-#
-
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
deleted file mode 100644
index 2141e4b..0000000
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Freescale Management Complex (MC) bus drivers
-#
-# Copyright (C) 2014 Freescale Semiconductor, Inc.
-#
-
-- 
2.7.4

