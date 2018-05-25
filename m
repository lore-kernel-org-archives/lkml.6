Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeEYEmS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 00:42:18 -0400
Received: from mail-bn3nam01on0134.outbound.protection.outlook.com ([104.47.33.134]:6016
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750913AbeEYEmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 00:42:13 -0400
Authentication-Results: spf=fail (sender IP is 64.157.242.222)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Yangbo Lu <yangbo.lu@nxp.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, <claudiu.manoil@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
CC: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 1/5] ptp: rework gianfar_ptp as QorIQ common PTP driver
Date: Fri, 25 May 2018 12:40:34 +0800
Message-ID: <20180525044038.37756-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39380400002)(39860400002)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(1076002)(51416003)(8936002)(39060400002)(486006)(336012)(86362001)(2616005)(476003)(85426001)(2201001)(110136005)(126002)(16586007)(44832011)(316002)(575784001)(36756003)(97736004)(8656006)(6666003)(81156014)(105606002)(305945005)(53936002)(48376002)(8676002)(81166006)(498600001)(50466002)(77096007)(26005)(4326008)(50226002)(2906002)(106466001)(5660300001)(47776003)(59450400001)(356003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR03MB2189;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:ErrorRetry;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC013;1:6Ofl2M+eOvKBWh0MVOb9umls5Qtbh/FjgT6DIhl/hqFqeI/GOCfxn/euxyfEKOWXPrIUgg9+LckcL18kD+hUQrvvS14dVySXos5vS6Ugkhq7p1pHeUJy36/ewUcAW8rc
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(2017052603328);SRVR:SN2PR03MB2189;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;3:9t5wmoVuG/2Ng6tL2gcVSyKHsz1VaHqRfdOhgHy/0DLfaTllD+XJq9dTiwluVbrjDSOKL7pzSr5zMDpb0/r2xdh9lEGXrCajQLH+iivVjB7VO5oxzdiVI2rtwvc8th9Fo7tEXprF6Obn91T2Y2n8Y0Uqyp36cawISxq6pB3a/+jX51m9jU66VtMCCRTz+6J+ECtlF1142AVJTnPpf9Q4x6ULyxa1gwSmsNNchRa770xnaTD14uBxi4JFa11ZM0+0KU1V3HqUmaxe/xVqdCzXoOuzhYDLtItJZOhfqRlIYTwimq4CMqsPnGTZgX+eFR3r9EuGL8ef2oQD2lcWD38ARzmMfcpuydCgXyeylWUcsrY=;25:HAGNsWvIoSk6KmvfoYLz+SGoJA85sk6LC1vxuL7FKxEoR18BKxvQCvhTh9u4AcxqD5dJtH5yp6EUtCOlraPJ3jcfrBZ+BRqMpWDavW7ZqXkTZ+1yo/RcHdZ5J7i9D9Odnki6Bz2nlyQmuXp/r36pnp6SdQ0CRKIJPYOXB7uqXSmGayi1k2Bh3MfKB1GIQgGBzk3wxi9ylw+wfllo7sdBNoPnU8iA6tirU2+E8JypnKOvKSxTRaDKRFsc/9NwFqPmY2F21CAQdc07nlpRwu48jVwS8uE+Nd/0+qH+mfVPZRCZvdlokhQ47+8ekjZ1Nnr8F3ORa5ndCQ2LJ11X6UVtHg==
X-MS-TrafficTypeDiagnostic: SN2PR03MB2189:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;31:JFMtNZQi0nbj4EjfDaugDMG6O4xXtgG/ektrNUH0DwPb0GZ/eohRsSUL9C8tVSHA0TpI9RsPShFDwUe0kzQR4KJe7zAYAvfHuO2sP4Hbkits6dWeLYCEURQN0fIca2kd3anpmX2DSrxF/h+mXmwzCenulH7CqE4AdH45PEZSKEW9mmUUkSAqtJFwX9lab2zgN2v8o3f+SNsot3W4/La87he/MiCrX04J48/joRZ699s=;20:qDnvnGI4dRyWAzawVT3t0QBWbs6AZ7/ONsgLHPs2SkHwWnBehRchfeL/11kaA/RfNxz8Zw+bcimlZKTuIBuhLpqahKXG0a1AdQJ1gJ75igsboSHVwR6PZi5SBD+olmzLPhWis6paDFI3nFZkLR0Sdt2d/tfZhRRokPvI/kEEbofg9dASBDJnjBhW3BGN9bgKk8665Q559mqrh0JcJImmJHRMFdvTbjSqHZx8I6xplrlFcmES60Z1ZsI45FeX3dpvVNyvbhfoY25ebdCx93iwnJJzrEKmb9/JdfVBgXsCe1y23baNouAnTjWnLhkZY44LLl355lCdCpDE6FduGDCaQw+Btd6BOgN0xstJP+r3YhYC7kFQYaUUVq9ziPX82RnGuG7jbCseHKYf9z6wCu9JOlcqu9Og09T0cqtFgbl0boX+Vuxo+gdVrLdiQHUZ5s2TEMBHLL3HTbIx4uxAy2VYTbEN9asvtRvntOyKMKSoFIPZpYM1ELleS5Z/jIBkYIh11aNKFG1V/7lB+A4uraMnpvcSOYyMBe/ZZp3cT7UC+Ve7iI1ZLDKF3BRvOuwgg9u2y0/TF6Q1WfCAYT1C5mS+YYCNUivF0ZLd2SzeBBcL9U4=
X-Microsoft-Antispam-PRVS: <SN2PR03MB2189DD9FEC529F0191CCCF88F8690@SN2PR03MB2189.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(185117386973197)(85827821059158);
X-MS-Exchange-SenderADCheck: 0
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93003095)(6055026)(149027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(6072148)(201708071742011)(7699016);SRVR:SN2PR03MB2189;BCL:0;PCL:0;RULEID:;SRVR:SN2PR03MB2189;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;4:J4XIZRbdMK92h+zJP+hE2rJoYjMvXyEt0DGBoah0/qEabuicUTOFIt0rLdPo4021CWPEsE56dmOiRJFqamJUHdJ7vkzGRCZmuYEmOhIeVkE6JvVtv5K0sFcJpAJbittnICbKkeqAgSebV2+uwSCGMnAEN3lVhGMjajSPUk7YgzAbqhzMVik7eAW9o31I1JT7232qx2qWSQCdYUf+e7cuKYVU00O1s8SfpE5kic1H9Zw8BLgxJzomXSw5TzE4337spMc0n9Hwwl6+o2dwJG7JQwYU2Zeazlf8ShV0LjMgEIWHFRvQqnufsm3PtksUU868ruKsO6gonfo7OksOQRU+0qqzKAUvHKlB0poOX4ASedJpJGdZ9EgcFXy4yNCV0Il2
X-Forefront-PRVS: 06833C6A67
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR03MB2189;23:4aYWYxqouvUymSe8Q6gzkciirGrmFIKpeGs43NRkT?=
 =?us-ascii?Q?B2UN+Z7X2R4883z/iWuajlIPO9Vl7K2iB5AJPiZu6md8dvUo5GnMuByN9IlB?=
 =?us-ascii?Q?R4/0oP3ExRH+S2EIcMteURxeNjRP0fQjedemdlFyjgSVOFSU37bUBVvD93R0?=
 =?us-ascii?Q?Jflka5EIJ53a2rU5VJVageV6WBzBDop2vXKA5yJ8JMHcG8eLC1XvuA0dHVKG?=
 =?us-ascii?Q?16q30KScIU4w6INvGJJ2gHiNgX9j47P2zG0RRoCGoOy6xm5CEZ95pzGN2MVI?=
 =?us-ascii?Q?kr+UZP4WuWTys7h5Yjdj/ByNgYnweUlN7iJ5W8ybLRgkyB0uY8nAkHCz34OQ?=
 =?us-ascii?Q?aqwUqn3i4JhldmcCWXR2mMYCOwpsqg6QYM0WOSJ/rNXBMArTuxFlvm1HGKNr?=
 =?us-ascii?Q?4+TiUc09qZsJm9Ah2dl3yc8JQAZk78BBV5fiKthHdnQM7rXAv1CGxwBFy09r?=
 =?us-ascii?Q?JD7EyTAcCOgcUglCIByXzGr4scb7ZB3VXduZLRwilvsfpT7GNRLToaRKFs7Z?=
 =?us-ascii?Q?yQ9RAhDJ9sHeOUeWHxtFPAytsSbnoxE0SpR0hvhkdo8T6ESJabtEif3+jH1/?=
 =?us-ascii?Q?o4oRUTezCH/nNGCexDvrSmW+JOZdlm8H0Gd6DUJHlXMSARafKz8967mnk4rB?=
 =?us-ascii?Q?u9LEZBbufZx1ACJeI4TruKQFWmjkqvgHsEcWbyxRi1j5DMoKdCEVyDONRBsJ?=
 =?us-ascii?Q?Tki2mwgRG99Nx6gqPBCT0UlIuTe5nQpArxCTzvJ11gZMkTqr1iGbCrCUwXbm?=
 =?us-ascii?Q?pKBt2i7hdRGF3DzaBWl1vFYfMGZd0NMeBt0uznkz5kpu/9StcAv9ULmavGmY?=
 =?us-ascii?Q?A2Nas0buEQw3eZJDAQAcW/mJSiEYkWXyBNoGjlsfLknOv76m5X+3VopgjW6y?=
 =?us-ascii?Q?6zwzoo8/2o8tQtNyN5SF8Ehv2ORrdSiYLIDyYlZqeGfoahXimvN6mJ40rHPt?=
 =?us-ascii?Q?iXAqXGX3++3H/ZJjIZg46y2/IJAz+Ko0lPy99WRDwjpcZhK9HXny5MGgJfsV?=
 =?us-ascii?Q?iwzmMONI+s3yTKwOFlh+CqTOVCvQiSt2idvyJfZ4jBoxsdPusw9f1p+LrB9X?=
 =?us-ascii?Q?ZaJQDNlJ1P4sN5qcIBgC3+HBhtUISOf45cbqrV2BowbrBg9ysF3IgUsNyRxy?=
 =?us-ascii?Q?Os9Yg5sfPZAG8ZhoUNQr0ofYW71p53rHu0nVzdG9OrdBX6blXrJNqRgm5371?=
 =?us-ascii?Q?mW/rPmfP3DbkkA=3D?=
X-Microsoft-Antispam-Message-Info: bJzcxXgHW4KXgJ7uY2zCLebcmtXJl/5WBHe7PiSjInV/SD3+hetmwUYceQeDHUHBs1CeUl0Vot3yL5ktcFJsdubsGXqcZelpWnq67p2kMAL8kYV+8zo1hXIqa9mlfRFfwwrtK10timIQEvhztqVJ0YfuBkHoBiNEmenwmaLSclmgT2papwz/+FGt20xi0Gfv
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;6:0nBZy/Qr7joYxMhtoG0xI4UhcDgt2sguw0trHFtAKcccWKlWjz39v7QkNX53lzzgtgi1Xzsq1RhwzCt1blgMfE17rFrYry8RRwltSOT26qRI8X2og/3lgcxTs0ZRlmKWoiRngRl1s48cnjjw8DbVae2voxqqKwSWoQO21FzuLVXmP4Yb0xZ/857DXJYuiyiK+LPF179bAoxzORi3bVJt3okZxwNYcfaRG+zhsd1rkJpSQcDkkHi3ZHS7MLxvJFUBh7IrjCUhWVE+yKEXqMP+Ksci0417YdKUAYIdemhZRIdlb3H/oA02eGeM5BhH5imriHTAh+QFgOKv0AypUcPX+Ns5hZ+jPUYwdVlNRjqdtSIstPP9yH7ib+Y7qQ8ywGgPLxXXtkm0iUv2/gVhj0ajAIEbM2UAoTSUKeCbR994+WwBQphhWYKCfBNfjnYfH5Hjb3qEhTrkQj44kJ6w/qpxkw==;5:IyF5Lel53UT+R8phVunt6B0jUqUk3lzxENzFx6CwB4DUg21YWkDvt2cChLC5SwDDlcrYXDnzc3OXvVrHJpEVWzh1y1ZW6R55p84FcX+qBEWaSgLytEhhVjanzaSUrQAKfftXT//Jg8vJr1eBkJSWkhnpJyVUJtFh0/zPg12BbuU=;24:xEOTdGLlIdAb38uKjuwKcTCX9R/o1Rw9YFM2y8R/nJ7bxDeVbCBFM92WUH2W2Em9QW7/D0EeLP8XE6D246UBSEzX+y4Y5S8iPcrZREz+9b4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2189;7:NOzv9xEKDDGCHVcfRAw5AzrUOq0bGQhrQl5Qah04Xynugblm725tNBxcW5La+tnZsZdPVZBU7AH7Xz+U4s+m82aXeobvZUHk2xEZngYLTHQFqb1M2nxczcIZCN6Mbqkl9jXoQ7elnZtF02y6ilbdExcId1H1as2ER3q1hBIcQtQxM2D8tn+MnccWrkxXK2riIOWEt0bgYDd/jtQGYsFRBaYWbxwHBTTJ+zkk7Db8vPlVG90SimFMUnJxrdrxgSFi
X-MS-Office365-Filtering-Correlation-Id: ea4c388b-5f2f-4d9c-b539-08d5c1f9df12
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 04:42:07.4795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4c388b-5f2f-4d9c-b539-08d5c1f9df12
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[64.157.242.222];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gianfar_ptp was the PTP clock driver for 1588 timer
module of Freescale QorIQ eTSEC (Enhanced Three-Speed
Ethernet Controllers) platforms. Actually QorIQ DPAA
(Data Path Acceleration Architecture) platforms is
also using the same 1588 timer module in hardware.

This patch is to rework gianfar_ptp as QorIQ common
PTP driver to support both DPAA and eTSEC. Moved
gianfar_ptp.c to drivers/ptp/, renamed it as
ptp_qoriq.c, and renamed many variables. There were
not any function changes.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/net/ethernet/freescale/Makefile            |    1 -
 drivers/ptp/Kconfig                                |   14 +-
 drivers/ptp/Makefile                               |    1 +
 .../freescale/gianfar_ptp.c => ptp/ptp_qoriq.c}    |  320 ++++++++++----------
 4 files changed, 174 insertions(+), 162 deletions(-)
 rename drivers/{net/ethernet/freescale/gianfar_ptp.c => ptp/ptp_qoriq.c} (58%)

diff --git a/drivers/net/ethernet/freescale/Makefile b/drivers/net/ethernet/freescale/Makefile
index ed8ad0f..0914a3e 100644
--- a/drivers/net/ethernet/freescale/Makefile
+++ b/drivers/net/ethernet/freescale/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_FS_ENET) += fs_enet/
 obj-$(CONFIG_FSL_PQ_MDIO) += fsl_pq_mdio.o
 obj-$(CONFIG_FSL_XGMAC_MDIO) += xgmac_mdio.o
 obj-$(CONFIG_GIANFAR) += gianfar_driver.o
-obj-$(CONFIG_PTP_1588_CLOCK_GIANFAR) += gianfar_ptp.o
 gianfar_driver-objs := gianfar.o \
 		gianfar_ethtool.o
 obj-$(CONFIG_UCC_GETH) += ucc_geth_driver.o
diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index a21ad10..474c988 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -41,19 +41,19 @@ config PTP_1588_CLOCK_DTE
 	  To compile this driver as a module, choose M here: the module
 	  will be called ptp_dte.
 
-config PTP_1588_CLOCK_GIANFAR
-	tristate "Freescale eTSEC as PTP clock"
+config PTP_1588_CLOCK_QORIQ
+	tristate "Freescale QorIQ 1588 timer as PTP clock"
 	depends on GIANFAR
 	depends on PTP_1588_CLOCK
 	default y
 	help
-	  This driver adds support for using the eTSEC as a PTP
-	  clock. This clock is only useful if your PTP programs are
-	  getting hardware time stamps on the PTP Ethernet packets
-	  using the SO_TIMESTAMPING API.
+	  This driver adds support for using the Freescale QorIQ 1588
+	  timer as a PTP clock. This clock is only useful if your PTP
+	  programs are getting hardware time stamps on the PTP Ethernet
+	  packets using the SO_TIMESTAMPING API.
 
 	  To compile this driver as a module, choose M here: the module
-	  will be called gianfar_ptp.
+	  will be called ptp_qoriq.
 
 config PTP_1588_CLOCK_IXP46X
 	tristate "Intel IXP46x as PTP clock"
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index fd28207..19efa9c 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_DTE)	+= ptp_dte.o
 obj-$(CONFIG_PTP_1588_CLOCK_IXP46X)	+= ptp_ixp46x.o
 obj-$(CONFIG_PTP_1588_CLOCK_PCH)	+= ptp_pch.o
 obj-$(CONFIG_PTP_1588_CLOCK_KVM)	+= ptp_kvm.o
+obj-$(CONFIG_PTP_1588_CLOCK_QORIQ)	+= ptp_qoriq.o
diff --git a/drivers/net/ethernet/freescale/gianfar_ptp.c b/drivers/ptp/ptp_qoriq.c
similarity index 58%
rename from drivers/net/ethernet/freescale/gianfar_ptp.c
rename to drivers/ptp/ptp_qoriq.c
index 9f8d4f8..5110cce 100644
--- a/drivers/net/ethernet/freescale/gianfar_ptp.c
+++ b/drivers/ptp/ptp_qoriq.c
@@ -1,5 +1,5 @@
 /*
- * PTP 1588 clock using the eTSEC
+ * PTP 1588 clock for Freescale QorIQ 1588 timer
  *
  * Copyright (C) 2010 OMICRON electronics GmbH
  *
@@ -29,16 +29,15 @@
 #include <linux/of_platform.h>
 #include <linux/timex.h>
 #include <linux/io.h>
+#include <linux/slab.h>
 
 #include <linux/ptp_clock_kernel.h>
 
-#include "gianfar.h"
-
 /*
- * gianfar ptp registers
+ * qoriq ptp registers
  * Generated by regen.tcl on Thu May 13 01:38:57 PM CEST 2010
  */
-struct gianfar_ptp_registers {
+struct qoriq_ptp_registers {
 	u32 tmr_ctrl;     /* Timer control register */
 	u32 tmr_tevent;   /* Timestamp event register */
 	u32 tmr_temask;   /* Timer event mask register */
@@ -127,18 +126,19 @@ struct gianfar_ptp_registers {
 #define PRSC_OCK_MASK         (0xffff)
 
 
-#define DRIVER		"gianfar_ptp"
+#define DRIVER		"ptp_qoriq"
 #define DEFAULT_CKSEL	1
 #define N_EXT_TS	2
-#define REG_SIZE	sizeof(struct gianfar_ptp_registers)
+#define REG_SIZE	sizeof(struct qoriq_ptp_registers)
 
-struct etsects {
-	struct gianfar_ptp_registers __iomem *regs;
+struct qoriq_ptp {
+	struct qoriq_ptp_registers __iomem *regs;
 	spinlock_t lock; /* protects regs */
 	struct ptp_clock *clock;
 	struct ptp_clock_info caps;
 	struct resource *rsrc;
 	int irq;
+	int phc_index;
 	u64 alarm_interval; /* for periodic alarm */
 	u64 alarm_value;
 	u32 tclk_period;  /* nanoseconds */
@@ -149,54 +149,67 @@ struct etsects {
 	u32 tmr_fiper2;
 };
 
+static inline u32 qoriq_read(unsigned __iomem *addr)
+{
+	u32 val;
+
+	val = ioread32be(addr);
+	return val;
+}
+
+static inline void qoriq_write(unsigned __iomem *addr, u32 val)
+{
+	iowrite32be(val, addr);
+}
+
 /*
  * Register access functions
  */
 
-/* Caller must hold etsects->lock. */
-static u64 tmr_cnt_read(struct etsects *etsects)
+/* Caller must hold qoriq_ptp->lock. */
+static u64 tmr_cnt_read(struct qoriq_ptp *qoriq_ptp)
 {
 	u64 ns;
 	u32 lo, hi;
 
-	lo = gfar_read(&etsects->regs->tmr_cnt_l);
-	hi = gfar_read(&etsects->regs->tmr_cnt_h);
+	lo = qoriq_read(&qoriq_ptp->regs->tmr_cnt_l);
+	hi = qoriq_read(&qoriq_ptp->regs->tmr_cnt_h);
 	ns = ((u64) hi) << 32;
 	ns |= lo;
 	return ns;
 }
 
-/* Caller must hold etsects->lock. */
-static void tmr_cnt_write(struct etsects *etsects, u64 ns)
+/* Caller must hold qoriq_ptp->lock. */
+static void tmr_cnt_write(struct qoriq_ptp *qoriq_ptp, u64 ns)
 {
 	u32 hi = ns >> 32;
 	u32 lo = ns & 0xffffffff;
 
-	gfar_write(&etsects->regs->tmr_cnt_l, lo);
-	gfar_write(&etsects->regs->tmr_cnt_h, hi);
+	qoriq_write(&qoriq_ptp->regs->tmr_cnt_l, lo);
+	qoriq_write(&qoriq_ptp->regs->tmr_cnt_h, hi);
 }
 
-/* Caller must hold etsects->lock. */
-static void set_alarm(struct etsects *etsects)
+/* Caller must hold qoriq_ptp->lock. */
+static void set_alarm(struct qoriq_ptp *qoriq_ptp)
 {
 	u64 ns;
 	u32 lo, hi;
 
-	ns = tmr_cnt_read(etsects) + 1500000000ULL;
+	ns = tmr_cnt_read(qoriq_ptp) + 1500000000ULL;
 	ns = div_u64(ns, 1000000000UL) * 1000000000ULL;
-	ns -= etsects->tclk_period;
+	ns -= qoriq_ptp->tclk_period;
 	hi = ns >> 32;
 	lo = ns & 0xffffffff;
-	gfar_write(&etsects->regs->tmr_alarm1_l, lo);
-	gfar_write(&etsects->regs->tmr_alarm1_h, hi);
+	qoriq_write(&qoriq_ptp->regs->tmr_alarm1_l, lo);
+	qoriq_write(&qoriq_ptp->regs->tmr_alarm1_h, hi);
 }
 
-/* Caller must hold etsects->lock. */
-static void set_fipers(struct etsects *etsects)
+/* Caller must hold qoriq_ptp->lock. */
+static void set_fipers(struct qoriq_ptp *qoriq_ptp)
 {
-	set_alarm(etsects);
-	gfar_write(&etsects->regs->tmr_fiper1, etsects->tmr_fiper1);
-	gfar_write(&etsects->regs->tmr_fiper2, etsects->tmr_fiper2);
+	set_alarm(qoriq_ptp);
+	qoriq_write(&qoriq_ptp->regs->tmr_fiper1, qoriq_ptp->tmr_fiper1);
+	qoriq_write(&qoriq_ptp->regs->tmr_fiper2, qoriq_ptp->tmr_fiper2);
 }
 
 /*
@@ -205,72 +218,72 @@ static void set_fipers(struct etsects *etsects)
 
 static irqreturn_t isr(int irq, void *priv)
 {
-	struct etsects *etsects = priv;
+	struct qoriq_ptp *qoriq_ptp = priv;
 	struct ptp_clock_event event;
 	u64 ns;
 	u32 ack = 0, lo, hi, mask, val;
 
-	val = gfar_read(&etsects->regs->tmr_tevent);
+	val = qoriq_read(&qoriq_ptp->regs->tmr_tevent);
 
 	if (val & ETS1) {
 		ack |= ETS1;
-		hi = gfar_read(&etsects->regs->tmr_etts1_h);
-		lo = gfar_read(&etsects->regs->tmr_etts1_l);
+		hi = qoriq_read(&qoriq_ptp->regs->tmr_etts1_h);
+		lo = qoriq_read(&qoriq_ptp->regs->tmr_etts1_l);
 		event.type = PTP_CLOCK_EXTTS;
 		event.index = 0;
 		event.timestamp = ((u64) hi) << 32;
 		event.timestamp |= lo;
-		ptp_clock_event(etsects->clock, &event);
+		ptp_clock_event(qoriq_ptp->clock, &event);
 	}
 
 	if (val & ETS2) {
 		ack |= ETS2;
-		hi = gfar_read(&etsects->regs->tmr_etts2_h);
-		lo = gfar_read(&etsects->regs->tmr_etts2_l);
+		hi = qoriq_read(&qoriq_ptp->regs->tmr_etts2_h);
+		lo = qoriq_read(&qoriq_ptp->regs->tmr_etts2_l);
 		event.type = PTP_CLOCK_EXTTS;
 		event.index = 1;
 		event.timestamp = ((u64) hi) << 32;
 		event.timestamp |= lo;
-		ptp_clock_event(etsects->clock, &event);
+		ptp_clock_event(qoriq_ptp->clock, &event);
 	}
 
 	if (val & ALM2) {
 		ack |= ALM2;
-		if (etsects->alarm_value) {
+		if (qoriq_ptp->alarm_value) {
 			event.type = PTP_CLOCK_ALARM;
 			event.index = 0;
-			event.timestamp = etsects->alarm_value;
-			ptp_clock_event(etsects->clock, &event);
+			event.timestamp = qoriq_ptp->alarm_value;
+			ptp_clock_event(qoriq_ptp->clock, &event);
 		}
-		if (etsects->alarm_interval) {
-			ns = etsects->alarm_value + etsects->alarm_interval;
+		if (qoriq_ptp->alarm_interval) {
+			ns = qoriq_ptp->alarm_value + qoriq_ptp->alarm_interval;
 			hi = ns >> 32;
 			lo = ns & 0xffffffff;
-			spin_lock(&etsects->lock);
-			gfar_write(&etsects->regs->tmr_alarm2_l, lo);
-			gfar_write(&etsects->regs->tmr_alarm2_h, hi);
-			spin_unlock(&etsects->lock);
-			etsects->alarm_value = ns;
+			spin_lock(&qoriq_ptp->lock);
+			qoriq_write(&qoriq_ptp->regs->tmr_alarm2_l, lo);
+			qoriq_write(&qoriq_ptp->regs->tmr_alarm2_h, hi);
+			spin_unlock(&qoriq_ptp->lock);
+			qoriq_ptp->alarm_value = ns;
 		} else {
-			gfar_write(&etsects->regs->tmr_tevent, ALM2);
-			spin_lock(&etsects->lock);
-			mask = gfar_read(&etsects->regs->tmr_temask);
+			qoriq_write(&qoriq_ptp->regs->tmr_tevent, ALM2);
+			spin_lock(&qoriq_ptp->lock);
+			mask = qoriq_read(&qoriq_ptp->regs->tmr_temask);
 			mask &= ~ALM2EN;
-			gfar_write(&etsects->regs->tmr_temask, mask);
-			spin_unlock(&etsects->lock);
-			etsects->alarm_value = 0;
-			etsects->alarm_interval = 0;
+			qoriq_write(&qoriq_ptp->regs->tmr_temask, mask);
+			spin_unlock(&qoriq_ptp->lock);
+			qoriq_ptp->alarm_value = 0;
+			qoriq_ptp->alarm_interval = 0;
 		}
 	}
 
 	if (val & PP1) {
 		ack |= PP1;
 		event.type = PTP_CLOCK_PPS;
-		ptp_clock_event(etsects->clock, &event);
+		ptp_clock_event(qoriq_ptp->clock, &event);
 	}
 
 	if (ack) {
-		gfar_write(&etsects->regs->tmr_tevent, ack);
+		qoriq_write(&qoriq_ptp->regs->tmr_tevent, ack);
 		return IRQ_HANDLED;
 	} else
 		return IRQ_NONE;
@@ -280,18 +293,18 @@ static irqreturn_t isr(int irq, void *priv)
  * PTP clock operations
  */
 
-static int ptp_gianfar_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+static int ptp_qoriq_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 {
 	u64 adj, diff;
 	u32 tmr_add;
 	int neg_adj = 0;
-	struct etsects *etsects = container_of(ptp, struct etsects, caps);
+	struct qoriq_ptp *qoriq_ptp = container_of(ptp, struct qoriq_ptp, caps);
 
 	if (scaled_ppm < 0) {
 		neg_adj = 1;
 		scaled_ppm = -scaled_ppm;
 	}
-	tmr_add = etsects->tmr_add;
+	tmr_add = qoriq_ptp->tmr_add;
 	adj = tmr_add;
 
 	/* calculate diff as adj*(scaled_ppm/65536)/1000000
@@ -303,70 +316,70 @@ static int ptp_gianfar_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 
 	tmr_add = neg_adj ? tmr_add - diff : tmr_add + diff;
 
-	gfar_write(&etsects->regs->tmr_add, tmr_add);
+	qoriq_write(&qoriq_ptp->regs->tmr_add, tmr_add);
 
 	return 0;
 }
 
-static int ptp_gianfar_adjtime(struct ptp_clock_info *ptp, s64 delta)
+static int ptp_qoriq_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
 	s64 now;
 	unsigned long flags;
-	struct etsects *etsects = container_of(ptp, struct etsects, caps);
+	struct qoriq_ptp *qoriq_ptp = container_of(ptp, struct qoriq_ptp, caps);
 
-	spin_lock_irqsave(&etsects->lock, flags);
+	spin_lock_irqsave(&qoriq_ptp->lock, flags);
 
-	now = tmr_cnt_read(etsects);
+	now = tmr_cnt_read(qoriq_ptp);
 	now += delta;
-	tmr_cnt_write(etsects, now);
-	set_fipers(etsects);
+	tmr_cnt_write(qoriq_ptp, now);
+	set_fipers(qoriq_ptp);
 
-	spin_unlock_irqrestore(&etsects->lock, flags);
+	spin_unlock_irqrestore(&qoriq_ptp->lock, flags);
 
 	return 0;
 }
 
-static int ptp_gianfar_gettime(struct ptp_clock_info *ptp,
+static int ptp_qoriq_gettime(struct ptp_clock_info *ptp,
 			       struct timespec64 *ts)
 {
 	u64 ns;
 	unsigned long flags;
-	struct etsects *etsects = container_of(ptp, struct etsects, caps);
+	struct qoriq_ptp *qoriq_ptp = container_of(ptp, struct qoriq_ptp, caps);
 
-	spin_lock_irqsave(&etsects->lock, flags);
+	spin_lock_irqsave(&qoriq_ptp->lock, flags);
 
-	ns = tmr_cnt_read(etsects);
+	ns = tmr_cnt_read(qoriq_ptp);
 
-	spin_unlock_irqrestore(&etsects->lock, flags);
+	spin_unlock_irqrestore(&qoriq_ptp->lock, flags);
 
 	*ts = ns_to_timespec64(ns);
 
 	return 0;
 }
 
-static int ptp_gianfar_settime(struct ptp_clock_info *ptp,
+static int ptp_qoriq_settime(struct ptp_clock_info *ptp,
 			       const struct timespec64 *ts)
 {
 	u64 ns;
 	unsigned long flags;
-	struct etsects *etsects = container_of(ptp, struct etsects, caps);
+	struct qoriq_ptp *qoriq_ptp = container_of(ptp, struct qoriq_ptp, caps);
 
 	ns = timespec64_to_ns(ts);
 
-	spin_lock_irqsave(&etsects->lock, flags);
+	spin_lock_irqsave(&qoriq_ptp->lock, flags);
 
-	tmr_cnt_write(etsects, ns);
-	set_fipers(etsects);
+	tmr_cnt_write(qoriq_ptp, ns);
+	set_fipers(qoriq_ptp);
 
-	spin_unlock_irqrestore(&etsects->lock, flags);
+	spin_unlock_irqrestore(&qoriq_ptp->lock, flags);
 
 	return 0;
 }
 
-static int ptp_gianfar_enable(struct ptp_clock_info *ptp,
+static int ptp_qoriq_enable(struct ptp_clock_info *ptp,
 			      struct ptp_clock_request *rq, int on)
 {
-	struct etsects *etsects = container_of(ptp, struct etsects, caps);
+	struct qoriq_ptp *qoriq_ptp = container_of(ptp, struct qoriq_ptp, caps);
 	unsigned long flags;
 	u32 bit, mask;
 
@@ -382,25 +395,25 @@ static int ptp_gianfar_enable(struct ptp_clock_info *ptp,
 		default:
 			return -EINVAL;
 		}
-		spin_lock_irqsave(&etsects->lock, flags);
-		mask = gfar_read(&etsects->regs->tmr_temask);
+		spin_lock_irqsave(&qoriq_ptp->lock, flags);
+		mask = qoriq_read(&qoriq_ptp->regs->tmr_temask);
 		if (on)
 			mask |= bit;
 		else
 			mask &= ~bit;
-		gfar_write(&etsects->regs->tmr_temask, mask);
-		spin_unlock_irqrestore(&etsects->lock, flags);
+		qoriq_write(&qoriq_ptp->regs->tmr_temask, mask);
+		spin_unlock_irqrestore(&qoriq_ptp->lock, flags);
 		return 0;
 
 	case PTP_CLK_REQ_PPS:
-		spin_lock_irqsave(&etsects->lock, flags);
-		mask = gfar_read(&etsects->regs->tmr_temask);
+		spin_lock_irqsave(&qoriq_ptp->lock, flags);
+		mask = qoriq_read(&qoriq_ptp->regs->tmr_temask);
 		if (on)
 			mask |= PP1EN;
 		else
 			mask &= ~PP1EN;
-		gfar_write(&etsects->regs->tmr_temask, mask);
-		spin_unlock_irqrestore(&etsects->lock, flags);
+		qoriq_write(&qoriq_ptp->regs->tmr_temask, mask);
+		spin_unlock_irqrestore(&qoriq_ptp->lock, flags);
 		return 0;
 
 	default:
@@ -410,142 +423,141 @@ static int ptp_gianfar_enable(struct ptp_clock_info *ptp,
 	return -EOPNOTSUPP;
 }
 
-static const struct ptp_clock_info ptp_gianfar_caps = {
+static const struct ptp_clock_info ptp_qoriq_caps = {
 	.owner		= THIS_MODULE,
-	.name		= "gianfar clock",
+	.name		= "qoriq ptp clock",
 	.max_adj	= 512000,
 	.n_alarm	= 0,
 	.n_ext_ts	= N_EXT_TS,
 	.n_per_out	= 0,
 	.n_pins		= 0,
 	.pps		= 1,
-	.adjfine	= ptp_gianfar_adjfine,
-	.adjtime	= ptp_gianfar_adjtime,
-	.gettime64	= ptp_gianfar_gettime,
-	.settime64	= ptp_gianfar_settime,
-	.enable		= ptp_gianfar_enable,
+	.adjfine	= ptp_qoriq_adjfine,
+	.adjtime	= ptp_qoriq_adjtime,
+	.gettime64	= ptp_qoriq_gettime,
+	.settime64	= ptp_qoriq_settime,
+	.enable		= ptp_qoriq_enable,
 };
 
-static int gianfar_ptp_probe(struct platform_device *dev)
+static int qoriq_ptp_probe(struct platform_device *dev)
 {
 	struct device_node *node = dev->dev.of_node;
-	struct etsects *etsects;
+	struct qoriq_ptp *qoriq_ptp;
 	struct timespec64 now;
 	int err = -ENOMEM;
 	u32 tmr_ctrl;
 	unsigned long flags;
 
-	etsects = kzalloc(sizeof(*etsects), GFP_KERNEL);
-	if (!etsects)
+	qoriq_ptp = kzalloc(sizeof(*qoriq_ptp), GFP_KERNEL);
+	if (!qoriq_ptp)
 		goto no_memory;
 
 	err = -ENODEV;
 
-	etsects->caps = ptp_gianfar_caps;
+	qoriq_ptp->caps = ptp_qoriq_caps;
 
-	if (of_property_read_u32(node, "fsl,cksel", &etsects->cksel))
-		etsects->cksel = DEFAULT_CKSEL;
+	if (of_property_read_u32(node, "fsl,cksel", &qoriq_ptp->cksel))
+		qoriq_ptp->cksel = DEFAULT_CKSEL;
 
 	if (of_property_read_u32(node,
-				 "fsl,tclk-period", &etsects->tclk_period) ||
+				 "fsl,tclk-period", &qoriq_ptp->tclk_period) ||
 	    of_property_read_u32(node,
-				 "fsl,tmr-prsc", &etsects->tmr_prsc) ||
+				 "fsl,tmr-prsc", &qoriq_ptp->tmr_prsc) ||
 	    of_property_read_u32(node,
-				 "fsl,tmr-add", &etsects->tmr_add) ||
+				 "fsl,tmr-add", &qoriq_ptp->tmr_add) ||
 	    of_property_read_u32(node,
-				 "fsl,tmr-fiper1", &etsects->tmr_fiper1) ||
+				 "fsl,tmr-fiper1", &qoriq_ptp->tmr_fiper1) ||
 	    of_property_read_u32(node,
-				 "fsl,tmr-fiper2", &etsects->tmr_fiper2) ||
+				 "fsl,tmr-fiper2", &qoriq_ptp->tmr_fiper2) ||
 	    of_property_read_u32(node,
-				 "fsl,max-adj", &etsects->caps.max_adj)) {
+				 "fsl,max-adj", &qoriq_ptp->caps.max_adj)) {
 		pr_err("device tree node missing required elements\n");
 		goto no_node;
 	}
 
-	etsects->irq = platform_get_irq(dev, 0);
+	qoriq_ptp->irq = platform_get_irq(dev, 0);
 
-	if (etsects->irq < 0) {
+	if (qoriq_ptp->irq < 0) {
 		pr_err("irq not in device tree\n");
 		goto no_node;
 	}
-	if (request_irq(etsects->irq, isr, 0, DRIVER, etsects)) {
+	if (request_irq(qoriq_ptp->irq, isr, 0, DRIVER, qoriq_ptp)) {
 		pr_err("request_irq failed\n");
 		goto no_node;
 	}
 
-	etsects->rsrc = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (!etsects->rsrc) {
+	qoriq_ptp->rsrc = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!qoriq_ptp->rsrc) {
 		pr_err("no resource\n");
 		goto no_resource;
 	}
-	if (request_resource(&iomem_resource, etsects->rsrc)) {
+	if (request_resource(&iomem_resource, qoriq_ptp->rsrc)) {
 		pr_err("resource busy\n");
 		goto no_resource;
 	}
 
-	spin_lock_init(&etsects->lock);
+	spin_lock_init(&qoriq_ptp->lock);
 
-	etsects->regs = ioremap(etsects->rsrc->start,
-				resource_size(etsects->rsrc));
-	if (!etsects->regs) {
+	qoriq_ptp->regs = ioremap(qoriq_ptp->rsrc->start,
+				resource_size(qoriq_ptp->rsrc));
+	if (!qoriq_ptp->regs) {
 		pr_err("ioremap ptp registers failed\n");
 		goto no_ioremap;
 	}
 	getnstimeofday64(&now);
-	ptp_gianfar_settime(&etsects->caps, &now);
+	ptp_qoriq_settime(&qoriq_ptp->caps, &now);
 
 	tmr_ctrl =
-	  (etsects->tclk_period & TCLK_PERIOD_MASK) << TCLK_PERIOD_SHIFT |
-	  (etsects->cksel & CKSEL_MASK) << CKSEL_SHIFT;
+	  (qoriq_ptp->tclk_period & TCLK_PERIOD_MASK) << TCLK_PERIOD_SHIFT |
+	  (qoriq_ptp->cksel & CKSEL_MASK) << CKSEL_SHIFT;
 
-	spin_lock_irqsave(&etsects->lock, flags);
+	spin_lock_irqsave(&qoriq_ptp->lock, flags);
 
-	gfar_write(&etsects->regs->tmr_ctrl,   tmr_ctrl);
-	gfar_write(&etsects->regs->tmr_add,    etsects->tmr_add);
-	gfar_write(&etsects->regs->tmr_prsc,   etsects->tmr_prsc);
-	gfar_write(&etsects->regs->tmr_fiper1, etsects->tmr_fiper1);
-	gfar_write(&etsects->regs->tmr_fiper2, etsects->tmr_fiper2);
-	set_alarm(etsects);
-	gfar_write(&etsects->regs->tmr_ctrl,   tmr_ctrl|FIPERST|RTPE|TE|FRD);
+	qoriq_write(&qoriq_ptp->regs->tmr_ctrl,   tmr_ctrl);
+	qoriq_write(&qoriq_ptp->regs->tmr_add,    qoriq_ptp->tmr_add);
+	qoriq_write(&qoriq_ptp->regs->tmr_prsc,   qoriq_ptp->tmr_prsc);
+	qoriq_write(&qoriq_ptp->regs->tmr_fiper1, qoriq_ptp->tmr_fiper1);
+	qoriq_write(&qoriq_ptp->regs->tmr_fiper2, qoriq_ptp->tmr_fiper2);
+	set_alarm(qoriq_ptp);
+	qoriq_write(&qoriq_ptp->regs->tmr_ctrl,   tmr_ctrl|FIPERST|RTPE|TE|FRD);
 
-	spin_unlock_irqrestore(&etsects->lock, flags);
+	spin_unlock_irqrestore(&qoriq_ptp->lock, flags);
 
-	etsects->clock = ptp_clock_register(&etsects->caps, &dev->dev);
-	if (IS_ERR(etsects->clock)) {
-		err = PTR_ERR(etsects->clock);
+	qoriq_ptp->clock = ptp_clock_register(&qoriq_ptp->caps, &dev->dev);
+	if (IS_ERR(qoriq_ptp->clock)) {
+		err = PTR_ERR(qoriq_ptp->clock);
 		goto no_clock;
 	}
-	gfar_phc_index = ptp_clock_index(etsects->clock);
+	qoriq_ptp->phc_index = ptp_clock_index(qoriq_ptp->clock);
 
-	platform_set_drvdata(dev, etsects);
+	platform_set_drvdata(dev, qoriq_ptp);
 
 	return 0;
 
 no_clock:
-	iounmap(etsects->regs);
+	iounmap(qoriq_ptp->regs);
 no_ioremap:
-	release_resource(etsects->rsrc);
+	release_resource(qoriq_ptp->rsrc);
 no_resource:
-	free_irq(etsects->irq, etsects);
+	free_irq(qoriq_ptp->irq, qoriq_ptp);
 no_node:
-	kfree(etsects);
+	kfree(qoriq_ptp);
 no_memory:
 	return err;
 }
 
-static int gianfar_ptp_remove(struct platform_device *dev)
+static int qoriq_ptp_remove(struct platform_device *dev)
 {
-	struct etsects *etsects = platform_get_drvdata(dev);
+	struct qoriq_ptp *qoriq_ptp = platform_get_drvdata(dev);
 
-	gfar_write(&etsects->regs->tmr_temask, 0);
-	gfar_write(&etsects->regs->tmr_ctrl,   0);
+	qoriq_write(&qoriq_ptp->regs->tmr_temask, 0);
+	qoriq_write(&qoriq_ptp->regs->tmr_ctrl,   0);
 
-	gfar_phc_index = -1;
-	ptp_clock_unregister(etsects->clock);
-	iounmap(etsects->regs);
-	release_resource(etsects->rsrc);
-	free_irq(etsects->irq, etsects);
-	kfree(etsects);
+	ptp_clock_unregister(qoriq_ptp->clock);
+	iounmap(qoriq_ptp->regs);
+	release_resource(qoriq_ptp->rsrc);
+	free_irq(qoriq_ptp->irq, qoriq_ptp);
+	kfree(qoriq_ptp);
 
 	return 0;
 }
@@ -556,17 +568,17 @@ static int gianfar_ptp_remove(struct platform_device *dev)
 };
 MODULE_DEVICE_TABLE(of, match_table);
 
-static struct platform_driver gianfar_ptp_driver = {
+static struct platform_driver qoriq_ptp_driver = {
 	.driver = {
-		.name		= "gianfar_ptp",
+		.name		= "ptp_qoriq",
 		.of_match_table	= match_table,
 	},
-	.probe       = gianfar_ptp_probe,
-	.remove      = gianfar_ptp_remove,
+	.probe       = qoriq_ptp_probe,
+	.remove      = qoriq_ptp_remove,
 };
 
-module_platform_driver(gianfar_ptp_driver);
+module_platform_driver(qoriq_ptp_driver);
 
 MODULE_AUTHOR("Richard Cochran <richardcochran@gmail.com>");
-MODULE_DESCRIPTION("PTP clock using the eTSEC");
+MODULE_DESCRIPTION("PTP clock for Freescale QorIQ 1588 timer");
 MODULE_LICENSE("GPL");
-- 
1.7.1
