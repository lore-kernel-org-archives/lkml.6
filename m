Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E47AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F36224076
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mo8WagY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F36224076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754121AbeGETlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 15:41:55 -0400
Received: from mail-he1eur01on0063.outbound.protection.outlook.com ([104.47.0.63]:17248
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753752AbeGETli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 15:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TYpKTxxUmrvogxaiTPY8J0uWynrc3Q4STDQlsjms5Q=;
 b=mo8WagY7/k3c9SuZ67Rvz2RzfjH43dqtI/sCzCVaOGBF9HqZkR9hR25XopXFRUOzL2cBWUyJIoymosZXKEpV0eC5BBoQyJ4xulN6GtAktGSCzoGSVcHTydkLq+5NJWhBI475JzhLie8AEIaqOJ6xWGjLncBdp4dilEIT/rboNNI=
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM0PR04MB4482.eurprd04.prod.outlook.com (2603:10a6:208:73::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Thu, 5 Jul 2018 19:41:33 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, leoyang.li@nxp.com
Cc:     laurentiu.tudor@nxp.com, ruxandra.radulescu@nxp.com,
        horia.geanta@nxp.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, robin.murphy@arm.com,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH 2/2] drivers/staging: Remove fsl-mc driver from staging
Date:   Thu,  5 Jul 2018 14:41:13 -0500
Message-Id: <20180705194113.16256-3-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180705194113.16256-1-roy.pledge@nxp.com>
References: <20180705194113.16256-1-roy.pledge@nxp.com>
Reply-to: roy.pledge@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN4PR0501CA0057.namprd05.prod.outlook.com
 (2603:10b6:803:41::34) To AM0PR04MB4482.eurprd04.prod.outlook.com
 (2603:10a6:208:73::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6efad057-d73f-47bc-2659-08d5e2af5184
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4482;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4482;3:nJNFHe7l27QsesmZgOBF5QQ1vJ7PWrPE+pKWXfNv7dD+jIl0jJGObVGlO0LkAZRF5WQ9szSGgP7SZGARjz4wQZANd8vh9IN/scwdoFsKqbx1HjpWmhibTquZxGYgRqRq3udPIucidxgD3JySIb69UtIi6NYHF03SpTLxaV0BZumwhneQqrPGK1omb7Q4+q4LL2RWmjkdmutoDkyMN3POxyJ7Isr41Vft5E3Rb3v0f2dZSFeWpaEPu+BhM+63O5+E;25:cUb89NSWehkoL9jF8I9YE1R/Jh5Uju44nwyf9CYe9MZZcAmOGl0D8JXY6eJDjS69jTHXLZu92L1dy5otIQfQ4FMkdkVdPgPpydl3wdqFJh93yRjxRz37y2SoQa+KmYOz6n7mOBLRB0HjinQqwIis4SjEz0rmbtiVylGPVLla3Og3vHhTi75ai5Atu7DPwaeRj/qgNpzKG6B4xJBBAzOXZy6E+hB1WayUlvQYrR6jm7gCamFDpoq7bDHJ9IVx2fAqlBsF6XKZ+VU35P+M/GezD7+4EWt9WkcaL/IRQr2DRM/cQWlkJtZA9H/zg8dF774i0t/OK1Ic0uTcK2PKxZVrkg==;31:BPJEAdrOXuQ0fUOTAGIwNdT86nk9sjh8fONwJ0HT7VF9lDUHkebhsdoq1G/H3J7B5Hl3YL1qCQSnTthoApk3Uuum80ZLkVMbDvLqmssxQvJKgtQPHS/V+oYUP5kuSUoM05HwoqsXu38JXKXlDjgUAc1L6vPuXjLedeX3JyvQy469sl3PsTaDueL/7Sv/RRR2tsIOs+G14aeBllB61jgbbqSeoG0otW775vg/K7zD9Xk=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4482:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4482;20:uiNNOdNre67pJMuQzVwXgO+/QZyq6YJvpgD2gSmEFFT/V0jOluiRsOeFifwAllMjlcfZZ1Gq+bd+oXHILIssiLlNS1GZBm/dDwhgAQWaTvmq1cbZyrmGXOf9E3OXX2VxWq1GBoC3z40oBATKMouWo5bzOqYGeny+UV5ur47jsZSl5u6albzkcn/o5RIsx+g6dtLyRBBNgEKz+2EQ/Jr2ObrB82P9Qva94H/5Uff//TTS7kVGSsju2ydQiRZB8MmpmxmQdWSuxXAsnoa3e4Zaozbp00HQGvPpAVgzk9HGGnMMKhNUA+5+LPXFmyBLQ6w82wl1HVHrb8uwglStYf3VjyJp79c7wc3b+0mnH3DHwuwAmvPi7Cx5ekVqDo4Qp9wRoc3oMy8jVuU+UAMfSnE3bp9ucNC6edPtNMnuqFgRbswBjoieWjrnnW76m5LWnNT0IelokUCB2vb+jczAOTFKuWam/zwDrjPuKaaUNoqy+VWDFhtMnmwMDZC4U6AMZUHi;4:oqbWnjvCXODt04bKjtPW10Q3A125/KBwKIOisMVuNo1GYPu2UlnxcmqAgFGJ1inYhdBW1Y6/QNlwhmSicHClzE9M5VHYLTppHGlMyDY7l11yx0+N9OCGXw0oxtAT7pe1i1lPNs7yZJKA13Ktzm3JeNRJxNi0pnoxwSzb3no9ZIPmvCr0fzjqROJF3IzGXXLiX6w9rOCtqIeQvdT4bnH2HGLfXOHyOfmUnjnlYqV3lzsEytIaIf1oPBqnhaYwmPvHU3Gt9h5Y+DaEA7I82zAVlnpPvcXYYuY3LU7Nq53n8qjk9tJ09x/yWqsMM2avh2yc
X-Microsoft-Antispam-PRVS: <AM0PR04MB4482AE4A4CA9432160B4279786400@AM0PR04MB4482.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4482;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4482;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(189003)(199004)(76176011)(51416003)(52116002)(3450700001)(6512007)(386003)(6506007)(48376002)(1076002)(66066001)(2906002)(47776003)(5660300001)(26005)(97736004)(36756003)(68736007)(316002)(86362001)(16586007)(50226002)(6666003)(3846002)(6636002)(6116002)(106356001)(105586002)(4326008)(486006)(53936002)(14444005)(305945005)(43066004)(6486002)(50466002)(7736002)(16526019)(186003)(44832011)(476003)(11346002)(81156014)(478600001)(8936002)(81166006)(446003)(8676002)(956004)(2616005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4482;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4482;23:Y/MC0tj3fQHPQgQU1c8JdfrgslNj50Vz0y+MZFxqG?=
 =?us-ascii?Q?jq+mS7RbGli0MI+KmunpoZrZqUeV1Q3DjsC4OK7sbsDZgcobnDZ8+Z/WhBGh?=
 =?us-ascii?Q?biCKJj0a7mu5MP7ykx7I5jdCNVFQFzqFPbXVWNER4bkFRDo5EraQa3odaS6Z?=
 =?us-ascii?Q?WiSsmyuODKXHOeS0z3D02m1SwluMbjT0g/W5Ie4g033MHmjg/qcAkgToI4Pi?=
 =?us-ascii?Q?0VtXbapJUskZVoMEOw9VJuv/0onbxlRVKExfxRmaniPM1FM6dwHigk4bhA6z?=
 =?us-ascii?Q?mIomDGGt3oW3Gv3eBxklhMtuy7GTmmO/RNYy9vrncnlypNy2NsVSywcr3Vz2?=
 =?us-ascii?Q?LIbIY3yrk9mMkN20vbB89nBjCWQgU0YjND/UzZiNqIM8ctxRo89FnXo6RPvT?=
 =?us-ascii?Q?lRiV84QlMN3hzpBmPF2JaSIhnsLuzU2UThdeSnGaCniwabm9pJlrpfldZoLp?=
 =?us-ascii?Q?OZyBOQlizj0vHYPfS93TmcXcUkqKzZrQcQhrMWnnTooA6sjwAjhu332k18Rk?=
 =?us-ascii?Q?vshv2GLuvJsuqlSfoxbRkU8v04QLu87mFQO0Ozh5tXJgpVHkt8c+5SjGEl73?=
 =?us-ascii?Q?mLVYsXCm1cIpiVOQQukg8OSqWJ0jUJgd4StqI4Kt/kOlQP8TzXUHcojR0Wl2?=
 =?us-ascii?Q?psLvfJ2La5beIGbKmO2aWT770pqdF/WXzumpf6HlurV1LsppUzRtRK+oX/jI?=
 =?us-ascii?Q?PGL3/FZ4G1DUW7PYmZZLRpMEqgThBGNOlvRTpwrOpFMiXMwEyskCea77dfgA?=
 =?us-ascii?Q?9mjbGT4jOojgUXCaHf3FP2mk5WYJYmSa3nZDBgmfpUgErP0NbEKO5+qWm/Ux?=
 =?us-ascii?Q?3L8MkvzTJbWIugT6oU/2Ox+/5VevHpYCEuEDw2lX9+UBtrjcPabAU/unThF7?=
 =?us-ascii?Q?16Oh+1lZyHa5IrdmjUp7JYHMSDgM/1h5svyM49YJR0mmUse2KSJBrPP5A5Iq?=
 =?us-ascii?Q?C2GKNhUX5k6Cjz8Ep2JwFNwaPmMz/PVb1OsJ5Hcs223EKvDcx0bO2BkNrGUV?=
 =?us-ascii?Q?q89DqpBl0u11/RqM8uM/DJadW2tH9hywlBO1qotBDqRZxLg22t1yrP89er9h?=
 =?us-ascii?Q?NWHqS4FX7Swa9ittVQ08z1gRQ++7dRS+xcliPQAQJMi0nHAnMDebbSWw8KGb?=
 =?us-ascii?Q?EEWn0uyZCrChHTc8kgLyRg0n7+MU4sDM7d1BnHqySDGXUlUfUCi63C9M6NeM?=
 =?us-ascii?Q?ls3ylhtLdE2SdwaiNHhHeQvCalW8fQpKgDX5rErdG1Ba9rQ89NjLFJlXGU+e?=
 =?us-ascii?Q?c8v3lbqRde0KhhUorr49VDQMpLXJEOKLuxuvLIN?=
X-Microsoft-Antispam-Message-Info: kEGsrQzAZ8FVz2WQofVEtEdKv2vvJ83u7yZvRCZCh1fyACJ0mpacmeeZgePEZvQOLuB78JPicb/+A/5Y02yq5tZhBFrrCzCipXNxVHFnyF3yqBGfTyrIWz148DNRoCXUBcd7G9L71zjz8cazTZ1I8s93zzEddMuJLKGbPut4t3YNA8WYWUFs5iryyQtyWUAN8QLuHd3vQFiuY6DNmm2QXjCGcAIiubTOybmhMZWOW9DEbXBz+LyhwLJDzkvNYswH1tdBZcSaOYQxo2cmH8zAfB29/tzoOPRbM/MGzHKYNCCZF5iWo6h6lbcjxw4RkH1LWEgSnf7BhsXN5uqf/5jcZHZvvB8B5bdDsHvPCrbUQLk=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4482;6:hjaaiMgjOrqfLzjcwapkbDulKdAHHwz2Ml77I0Rh+Adhh08z21EsdVqG0OiHLj4ZA+fYPjmcs8j8/QQpThkxlP76amrd2RidUCHUSKSfJOy76dZSMERITAKmiJfH02wpMEbL/L+Pj5yXo8Depu816gkjmf1FaYofPeUH6AKEpcUpAkb5WOSV+iHEbdMxpNuYGyegGEdv3HLgtcB4iVVUinmB8Y7zYInK70tAwD6tLCRKdc44vDGFWRTPK7F2LYqSjCF56adMvChWa10NgoMOtDO5uaHwpaH2qsH6HmvFMUdudavM4dRyiqKRucbEQpBh0IlEPVof1sP7qNgkdoLeSVwYsFs6Ci+w4sHbRPgcW80ldUMyEcW+hVMHwrVTg9dM/BPL9szOv4beAZRZAeP4BBo3rM0DCcGRDaHIrwr/x8zP7h9zMS8D9LLSWx9jngxAQnSPswdSzVhBV1LhTPmbNQ==;5:/wNf2oB7DEohkJBwhBqS1SVxcgij8ozV4WrR+YL4qZGUYsugFL6owzFqQQGnxh5Z/5YgxGaQyfoC/6I21vL7XdmIenxQz9XY7PTjP+el/lEc5ddigCu0wG1T4G4dyM8aAeRraJZiRZ+MMeNr3fQ22MSl7noIIcAmjKfU6RVjMQo=;24:8OeKtDU3GEOJ0s7rHItb22pet9DWZB0VF6pvNxf2qkMJewIAk+PhX1alJIgj9KhVK8X0VJnA3J7zG0kv8djhFJwqVaIAuCJudzIrNqeJWuc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4482;7:irI14w/TSmMPj4RRZCasHk8RspkF/KNebvdeO2SK0fUZkWdce+xMOYROf9D9WhlAdPYymm6Kh3aVdZBH/iZhzPhATmX4uzR3q2HJmm98/GeHKNVcX3EbNpV/XsmiUf+ZrPSmpAj+9I24oqEaiE43pwF81pxJIZH/hABaNVmTTfZUnuzGhVMqX3FpHh7Cp3A8rcedZahSMBtwAKQtS2PIawKS882S02JBD6wrm5sgbwHI8AxuH+eyALwAF2y126pb
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 19:41:33.8438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efad057-d73f-47bc-2659-08d5e2af5184
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4482
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
index 9339af2..344fcf1 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -90,8 +90,6 @@ source "drivers/staging/clocking-wizard/Kconfig"
 
 source "drivers/staging/fbtft/Kconfig"
 
-source "drivers/staging/fsl-mc/Kconfig"
-
 source "drivers/staging/fsl-dpaa2/Kconfig"
 
 source "drivers/staging/wilc1000/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index aa40b1f..2a84679 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -35,7 +35,6 @@ obj-$(CONFIG_GS_FPGABOOT)	+= gs_fpgaboot/
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

