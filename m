Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeE3HQU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:16:20 -0400
Received: from mail-he1eur01on0043.outbound.protection.outlook.com ([104.47.0.43]:24753
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932377AbeE3HQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:16:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: imx: add L2 page power control for GPC
Date: Wed, 30 May 2018 15:12:36 +0800
Message-Id: <1527664358-17844-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0071.apcprd03.prod.outlook.com
 (2603:1096:203:52::35) To VI1PR04MB1326.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1326;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;3:9IY6AWieP7hefX+729SHknnVMrMYh/Su/at9DkHzNTdNoec34mcUzV8JJmfwNtOIBfe5Qjqo3LVGM02Hc2PdPmGAnQ2EGzQzMGjzwMXaMxAPGTNnNRh1/daveo736No1scJWoIcxRsqDYZxTvZngQn4HomAj4MgvYh/Z93WDzPDKBunkliDU0XbvRrKkNAl6O+Ut90yC54cRY9+GhhwtHM+9TWlv6hg5q/5uIVT4rFyEIH4i2Cyuzo/ECzFfKhCU;25:rt83Oh5mJsVxgRzWKiHyeVbed2AvdD17bCHI5Dgh0b3yd55KXeVeMhs3Lsed62UaaeESDGC0QSX+6HAEBenhy564MPvahHRRXFM3CtNmOd64cwddvPgv4l/ALlLQ4lRRMHMzE/OnUFZpituQ2luXsvcHfX8gZvESvYM+FKsuXAXYnCELS+yLOcrE44vCIXbcNmGz8g2Z2p30qAhDWKoJQKRGhXuS08UB/fVeINCroE3+57aR9vNbVuyuM9FqkhLWUTPvgkrDs4NwhlS0ea8TFkJsM0ABEQJ7CjAyJ5S2hHU/JHS3FCGc8q+eJl/mV6LTZ0WUK+J8ZzkY9dn/7YQw4g==;31:KLWN3ZfMyk2R146GVSMnGI+RuwgDqcw0T416lseT3UfEn8/eUgwlk+/N34RaoAnz1DNuv16jtYd8hMBJB2SP7NArQ+XxpGh0SC7/3Qwj6/WQa7Zq9WwOQwmyS6HzsAsto0BUjJBHQMFZ8Jx2+7/+ankzXUzy7fJAtyIP8c4dYcPf0EXaiuU7MPRWlPOp6fniKfW1SfRvyHaqR+rxNNOe7s9+kzSFAXYWW7F49RfRdOE=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1326:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;20:+sT7OzW31ao82zErj2VVpFs1X8cnSgBu8yF7rl3y3eEqb15nQjBIF3axtdUjb6LpOUlsZ0MNgiC2w7Fr2j2O2vd1DBRzimV9FI5MiF+snQv09FJv7kHEhO0EtzuS3UbtqAyEhmOomTM2PPmwluZnHNDRHFMlUIopJ1SU29AdCTbHMddlfTixesPkae31RxcCkYygOL3DI2Sl8IE3n/LsiJeVuU+Auq+p1s6apMQ90P7B76AmVPwJt6Tv1C6GCIyKX4l88JR2oXoSrKlC1JHdMg8pgXLAFJ43TraTm3uyRh70mBcRsmZYVFnQxVggGD22O1j0rBa7SUmdPLDlImgN2IO+AacUXwopYBKZnTzp4tsRCAIt+BOSISLNbh/GDGH7/FNi2FyC6dSX7BfTZApCJXu+zmwW3F6/xH9hv9zHqPQkRKRTHAlVnKjl+/E7+mVxECZL6MQFOq+Ghn4BF0Z6IidZVw+J0lyNx8vaId53DTFoXYPzVNSzZt2JwwifSnXq;4:lIT1/Dzx/8IpgvvpPBYo2gMqP1Gd454AEaXSBishv6Jh7prs9/Rzxd4tgYW0RxNTtkSNRx0xOXKavwdxuquVAlst6iCE6nROyijfUfz8nTAXP7qwaDkylWCrUrMtb/DBXIY+3FrPwVzcCR+AppaI1ej4DqyElXcY0inCG6ytqyHdeJWO/zeU5lE9jQ4kmLSlIcs58jYdY+ecmEJ8y7qJr6XO0RCvKQTHP12kJoQ+8qNMNYmP2FxgBH1XcxECqhAVT/nqnAJesi1eDz4eNAyD5lx5yoxbuQ+VlZpGRcHG3r88+6euGMxQdxsTE6mDZFPu
X-Microsoft-Antispam-PRVS: <VI1PR04MB132654079F3361DF66CCE50EF56C0@VI1PR04MB1326.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1326;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1326;
X-Forefront-PRVS: 0688BF9B46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(2906002)(6666003)(81156014)(81166006)(59450400001)(486006)(106356001)(7736002)(305945005)(6116002)(8676002)(3846002)(50466002)(48376002)(68736007)(16526019)(478600001)(476003)(105586002)(5660300001)(6486002)(86362001)(26005)(47776003)(316002)(16586007)(186003)(36756003)(97736004)(386003)(6506007)(52116002)(25786009)(6512007)(53936002)(2616005)(51416003)(66066001)(50226002)(8936002)(4326008)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1326;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1326;23:gXPBbxYq6l/61k5lDhb6lfAx/OTnrkfaS48D4BO86?=
 =?us-ascii?Q?xYJ4VA93lin1r8s8tCowDvQlS3wtODCEafBms/EL4UZEpQ+RbG6ylrPQv1Ar?=
 =?us-ascii?Q?zzLjHvVaDiTRXH7heTeaQoyGx93tgyCmSu0+CmBSdfahI9ta8X2D7eGRXpgK?=
 =?us-ascii?Q?UMzvujXUssOXybdFOorSh+Gsze1ZPIvWcduthOFO2ITO1fZCbkYrLxB9K12b?=
 =?us-ascii?Q?O2nmUFni+MUVNmyzfU8fWQ0QgyUKizU2aoCRiJZ3SY2SANOl+HDZ2e5ZRUrd?=
 =?us-ascii?Q?fHnHWpJeeBP4emY3PCXCPANMt8Xz2y6un1paielKIDFTsZB16cIuvtx7iVF9?=
 =?us-ascii?Q?EJJG2ClcDMOgy/tpl8h+v8FS+fAcaGItdMc5IhgjURnMjI2QhSf4zWxT/+i7?=
 =?us-ascii?Q?dlxzhFbq0NMkCoyBTJcDRhWrVTozdkyvqGfS6YXKmGZhnxgm+09sXCwEi1+/?=
 =?us-ascii?Q?zhSIKAAXwYTYO1kPWGw8lVIfFUUoZxcYZxsDyZ04cwQFE/yiigDWLZTh8+wJ?=
 =?us-ascii?Q?L+KIdRToZAPx/RJG+aN0U9yguTXXMKZF2KWUTG6Ya/ppjUhZEa8uz8RH3vYc?=
 =?us-ascii?Q?rDNCiTnuNJcMaar1PTc1M8F9+C/XOsgx/qYtWdseOxbFslu1eT/4Zm4Jov57?=
 =?us-ascii?Q?OHrbe9LE18yHNvLoKcIkPoJVz5a5+NUJqbatGjcIrTpS8JC00gv29kCF484w?=
 =?us-ascii?Q?vpC4xngyH7H0suHv73du2ATcx0cvbSvanbsg2S+lZVwucZE34zqKZQKjS28Y?=
 =?us-ascii?Q?BJDdQJ+TnrFsVZiGQvIdgl4LKU59oQ84xXl/yg4AuZ2r8bYyTavsFz8mM+ms?=
 =?us-ascii?Q?hiKuG9YkKL2vAzvQcKo6xr87pwhY7EoRDM4iJj4BXbjxjOciG0aEzArw6XMk?=
 =?us-ascii?Q?IOw8seTv/F4bA7FlH5XAqJSaiUNr994tb2JbMbkKu+yAcu+bULIMpWNg87zY?=
 =?us-ascii?Q?tJWMQeoKnfk+qsbPvjvXX88Sc+kMjQKfC/ol6qu0svA8tSnpQV+1tuiUluO2?=
 =?us-ascii?Q?15HLsXlW2B1CQ7wKxqKWkwdKO6eYuvCl64UD1RfbW7Ba6VjiygD0mkjCjd0G?=
 =?us-ascii?Q?vypCfkLRx9RN1jMW2xuRiak1ouRZwpsfOLXJgP1GZEAzT9j/XtWYJpewaeXH?=
 =?us-ascii?Q?EP15HSyoxM=3D?=
X-Microsoft-Antispam-Message-Info: LWWZ/NC/6VIl5/w4yo8HEXPWLcYMRvFS+ulrO+g/3656Bc2D+iXi/ladQXoY7km6/NOAZ57O08ETBERy2wQBPiTy48+astXkEEYyw0L+0mLwvK9xfUqqTDCrF4gMY30XyhULpSZt4Kly4iqwijE1xFNRBvtxTRRK1jy7m9vIp6q/l8Lw2cbaW9aoiQh43XU4
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;6:F4pyZmJ1TtPmt6Z5U8smpOBPoFfrXPAObRz4L0RJ3zd0X7m9M3VrSetlxFB0ZSZCVsn+fn+I8t7Lp3Fr1zOLWZlH26CEftlSV0muKJew/V4jHedkyiYmmDEndnpCCOAPy/MG96V/1jH7nes77hI+80OOk5fKKu0G6Lf30YUVQqX9lQ+7Z1+fI1b4SxpP+5qL7AruF6/i1w8h92Lto7b8BHS1vDJK7DAjCzIYnm2uMnxj8zDxockp7KqELvQktoOsbzZch2p82Rm8TKGelXOOop41L5rVs6tOe012cCrpc3Ffjtsi5uW2B8mLLYzR50y+sBXn10X4S+MkFOnLZB855VeQVr8fN/u1UM2wPJwDuzd9TfHPmLPuaf+bcycE92bdmMlhnZj+jZSo8OMotxGuGZISZMH6wqM3fyatEBiS4MQROKfzvepK0tWbJ4aOBUZP2lPd+QInUHwPZPaaHt5xSw==;5:FGS0VXf4l0COyW05ff/RLd8rAw3b7r1wd+eeR3c61eT8twfqob1SVCn355YQRsTERzZlnZmGfITxw0Ykez8/DjqpyH5nCBrx4yNMGi2NXfREWtRK+pqr/WSBt/Elj1QkAoe/a8qHNYkFqBE9oUS018g3Gx36mc/IHPnYr7pWeBE=;24:3D2+G7nytx4ynvLm90enx2Y4BU7ila8gR5YiZZ5zSjELvZiMxeKp1JvB5dcYagug83Z2B5Ef8VNKaY37ilQtYLwblc5hMI5DTdy9H1Gdjn0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;7:57BPZBczWdVZGKYn5HGZxtnrDYqeQJua3zaz3FqitxiE8zB+/hRAUgj5XsOoKvBCybhqpknGBuNMdOkOnRt0YL9A8+rXqrOtgA3+cY6CdZ78I4Kya99jQn+rjhAgzUjmkSkNRo6frxxCeCEydZNuvbTxNSI5K2xor3qadc9Rpbv19Wt4O1vTl/roitblFXtl1TA+PGr9ta33BjCZHYjBORrUV7Uiwm9zTYUr62NGHqBgFxhTdiXr21sta4MMGJlA
X-MS-Office365-Filtering-Correlation-Id: 6adaa44c-682f-486c-ced1-08d5c5fd3914
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 07:16:08.2229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adaa44c-682f-486c-ced1-08d5c5fd3914
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1326
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms like i.MX6UL/i.MX6SLL have L2
page power control in GPC, it needs to be
disabled if ARM is power gated and L2 is NOT
flushed, add GPC interface to control it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/common.h |  1 +
 arch/arm/mach-imx/gpc.c    | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index c8d68e9..a2716ec 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -58,6 +58,7 @@ struct device *imx_soc_device_init(void);
 void imx6_enable_rbc(bool enable);
 void imx_gpc_check_dt(void);
 void imx_gpc_set_arm_power_in_lpm(bool power_off);
+void imx_gpc_set_l2_mem_power_in_lpm(bool power_off);
 void imx_gpc_set_arm_power_up_timing(u32 sw2iso, u32 sw);
 void imx_gpc_set_arm_power_down_timing(u32 sw2iso, u32 sw);
 void imx25_pm_init(void);
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index de535cb..e11159d 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -20,6 +20,7 @@
 #include "common.h"
 #include "hardware.h"
 
+#define GPC_CNTR		0x0
 #define GPC_IMR1		0x008
 #define GPC_PGC_CPU_PDN		0x2a0
 #define GPC_PGC_CPU_PUPSCR	0x2a4
@@ -27,6 +28,8 @@
 #define GPC_PGC_SW2ISO_SHIFT	0x8
 #define GPC_PGC_SW_SHIFT	0x0
 
+#define GPC_CNTR_L2_PGE_SHIFT	22
+
 #define IMR_NUM			4
 #define GPC_MAX_IRQS		(IMR_NUM * 32)
 
@@ -51,6 +54,17 @@ void imx_gpc_set_arm_power_in_lpm(bool power_off)
 	writel_relaxed(power_off, gpc_base + GPC_PGC_CPU_PDN);
 }
 
+void imx_gpc_set_l2_mem_power_in_lpm(bool power_off)
+{
+	u32 val;
+
+	val = readl_relaxed(gpc_base + GPC_CNTR);
+	val &= ~(1 << GPC_CNTR_L2_PGE_SHIFT);
+	if (power_off)
+		val |= 1 << GPC_CNTR_L2_PGE_SHIFT;
+	writel_relaxed(val, gpc_base + GPC_CNTR);
+}
+
 void imx_gpc_pre_suspend(bool arm_power_off)
 {
 	void __iomem *reg_imr1 = gpc_base + GPC_IMR1;
-- 
2.7.4
