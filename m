Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbeFCChe (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 22:37:34 -0400
Received: from mail-he1eur01on0074.outbound.protection.outlook.com ([104.47.0.74]:52960
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750913AbeFCChb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 22:37:31 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] ARM: imx: add L2 page power control for GPC
Date: Sun,  3 Jun 2018 10:33:44 +0800
Message-Id: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::23) To HE1PR04MB1323.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1323;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:HjADlaft2vobHaWzUBtPAUfRt3j2cvq7CmQarQtxUAEkCTmIgJmf4eK0oW5SP6WbRTQ4i3S9rwZuJgdzrXhQH1T/9qJ9Tnc60r+GsgrUyGIjJG/4n9PGYEXjKjtrQ0mqY6FKJJ4jBuNXfkkzd1rmTEmf8+0A3TW9WHHRhKA2xzqUSJCAkPsxZi3xL/qa/aMYRg+YXwBGWsznYtbNR7dFlYcxLUY1eb4thcTYoe9yr0wa1vT2UonTSwIRZCuWezAV;25:mYJyzea5lkoz9sMNp1sfX0RuNHWmxNRKWc/RQqK21EO1WFl0EwejAMZurkNuRyxuGwxibXNGCAJpraKUnvt4oxB/Kd8yBuCb1OYGfd4vET7OP0Yykmf343ia+tvDBZ9N/xYG/Yfvs4v6ER0m+h3qGbM/119JifXq4NvdXABRUsAmJhzE4tn9yBp1CWFZTlU/N6T/4ir3FBgHfahKmAEQwXMUmul3jKaUkJ2NzIEkPQmHo3WMKMztKIBXCmStpPJ8hV5gZpRm6FsGm8rYk3TpE5FNCX8gzP8xFWdk21EugPeGVqKrwv4Cv+NMtZcA4wUYxufzxi1Q3FBT+MD2a26D+A==;31:hzD/5rK7/X3qBHnwnsqXYg2UGGe5nzsrCWtWMSQYd1JRgt+l6x4Q9FoLIv0B2Aod15qkldGCIeyJQh1Jmtoph3llhYfate3FhJbcPxwYLydLPSfiDm+JJ5DmyY6LmjK27TI1OiPgSP7pSSQc54/5GOVWXI2jCXvH43aLcF4l5cqgTjfNXfSP43dE5V2ztfjfyq/QlzQmLTaf24+MyNqHwj9HNdSTEJpV0tpHxnkieko=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:grsUKOfmgVT70uD2Z5ByRIkoUDSBQn/79RERYAGRCEF0OB68E/RLuvsV3AJVWK10tbk150JyHNDzbzl5uXxA5rWjyCHaxUG8n5S5TYQd5mhM0cSK/iR48ZT4VSqtq9Uyb3vn1bde1NscQ5heWf0slma4VI9yXRWhQh0lQM50nyAbthVPrpYdTCg7PdTWzJZiIq3CrTRAO59NekO9IZgxiafSsioW4W2iEWtSgqmdcPGiDwXFoDhzs/UFlNYmtxf/H4CrLIkY/zqoOeh5BLn7Hqv3fdwbzCrPRFJ0geFE36cIsrqKGFqZ7k9aAXRMln3o79yJaAFbTtcOCtXFt8t2uk4ls7q7/e6IhqyREj9ih/pimMxAqWO9L7imX66vyY6XM4W+cbEaZgfhcKwRYFdrx0bpFbb6l/6cRcks+f9SGnv56Bv62icgQSq7PU9taumkBQnPgFN4bJXiWhc2Q5xmRI8Sl+ubQd+fMM0utwQT05TbgTjYWtoI0gNBVaR4Hh9l;4:VAPvR4SpIC+s1MJ5skxpnadMhCXgPS0IuJ7OfuLo/e8AVv0QIV+HyoArComYW8pBtSbRm+5iHMQOfLsXcfJX9s4JcyhMreGp5Ym5YsIUmjSsfVqwJ5Ktvwi0cRJpbd9HDnNoYrla5G//225EIASvu9GkjoptCmm9b4o7Nria6TRK1OB3I3WC8tYlb2V85oFR+qSyhFhVu4kiKp7dmZA+9whjMIul6yLV7aae72TembriSBX9I4dGcZlGO+D4Kql0XbM9JFvd9VNsm1JFjt/TfzKxgov5/VXFztanXaJ163h+LQSIDb2fZ/vn5T90ulSE
X-Microsoft-Antispam-PRVS: <HE1PR04MB1323582CD08298A51DDAF659F5600@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 069255B8B8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(39380400002)(396003)(199004)(189003)(105586002)(305945005)(97736004)(86362001)(2906002)(106356001)(478600001)(66066001)(81156014)(8676002)(7736002)(51416003)(48376002)(8936002)(81166006)(50466002)(486006)(186003)(956004)(47776003)(2616005)(476003)(52116002)(16526019)(16586007)(6486002)(36756003)(3846002)(6666003)(6116002)(316002)(386003)(6506007)(25786009)(6512007)(5660300001)(4326008)(50226002)(53936002)(59450400001)(26005)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:QM5wTemA4LyourxVRCoYMAXM5dNNTUP8YfCEkxid9?=
 =?us-ascii?Q?Q1TqB6+n31xLLoVaYnZ7zuVb4cVts5rv/+WkKdmbZ/CGu5OKvDRop3lQNrpx?=
 =?us-ascii?Q?QDqMd6nTmQlTtyfl3Yprmk9wXi5LSN7RZp5d+lii1Rixe/em4vl0oUrONfhA?=
 =?us-ascii?Q?WEdwqDLxj6BX3UVTkaA6F2HZAmwbRyX6QIUsrXekDAWBhN6iE686ZXTGwWHc?=
 =?us-ascii?Q?m8rxwJjcI94PmcLIFCnTk42KM1fTVx2icrXlIBHhb1bpK+MqpXQQsyN2OtL8?=
 =?us-ascii?Q?y4WrQv8c0LvzuvUUf8hCWJonFh0rCBm7DgaUBqbkeWuzuReFMuEBFzu7gQ/T?=
 =?us-ascii?Q?qh3c021igNeh+jusX8jx2QX6kvx3YE8KPL1fqVJ4aI1ZdtFk4qLYZckVEMk+?=
 =?us-ascii?Q?5Lz3wG8NZAnNCkz6JZnaRvibPcBblv2Nw+hQgCGAwrEO2zvKQajgET7gBAvE?=
 =?us-ascii?Q?Tl5fcNxiinb7SUwmrHTxnN9RBWAsTbEjBuzjhQs9PAg7qQKnFnHCEp7s6ogy?=
 =?us-ascii?Q?2DzejftgzGJQOEidWQZNhXCgsq6NCtzUKRNZhbulwQRT/ZpcEKOqxFZvgG6t?=
 =?us-ascii?Q?gCt8e/Ds4pgOgizUOmxCS/gtmNUOTpc/p6o+maoVMJEi8Q2xE83cfUQc6cQk?=
 =?us-ascii?Q?CiaRBLXo5Z2bCrwctmOx3y7MH+kd9hP9UfgGnx679QW1AQMiX1KHVKLx2fG4?=
 =?us-ascii?Q?onPtmfEufYbIv3zI2CjB2HG730CwEcovxK3Un9f0/tCm15ZoKculhjP1LJ5D?=
 =?us-ascii?Q?Uk2bhuJ4xIxwZio1zIhzh+1nmPxedkOX+5VUA0T8LwVk4Hn0gAHd1IwWlW+g?=
 =?us-ascii?Q?wPaAvbAq4lVMdtil9+NFzjJT/esVuVSiX1eY45mB6KBE5ILZEcRjiV8po+mq?=
 =?us-ascii?Q?iYwkLP4jexNqM0O84uvczxi1FNk2E4AMZpUMfQGbEyYx2RKzMu4MXfYw41Z6?=
 =?us-ascii?Q?bN5ooNMK5U81V1o81tJ9J92KXt+3S4anqFi7aID+AvlHiFPyEsftub6UUeTe?=
 =?us-ascii?Q?FrcRjUWeD3m9sEFtumnTPz4QyqRAUKcDPB006HYtT3/cILDNYh4wg/Ns/n3Z?=
 =?us-ascii?Q?Mb8JU7Ea3+IWsR3En3hpCnA7eCYztOAG/PlcpI3w7rwClfbNGGCDRw5XOhLt?=
 =?us-ascii?Q?c4x+tPmXpU=3D?=
X-Microsoft-Antispam-Message-Info: vIRy6zDRQaLMjFzBkLkIjS3XnbEi+2sTKOTEhLLyrCyp4MnKlhY0iRsjrwvi2JHX5lT9mo9tIlWV0xPzOuman8r7d104Hh1wlt28yH0NK3shhF5rAsZNV9PGFf4+CW5vYP+j5BuexXw1lP8J0aO2V7FAVN4K/gRust05v6IrL5VLfzzUjd+NYJ3xABKybRxt
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:QO8oR91tj3EA70FuJWKnl9DAm90N4i9jY0Ixt/Fe3Loo25Rjx9DO22p4EjgyyGymWDnRXnotiRrrHP9QeApQ2XyP4LnleUCmSe98BbwvG1djNVOuPk8TxaeVI3onhbdpYSZZRIRzCpN93+tDHureX8cMVToke5jtV/LpcmFMDAlKavFAYyNFq18tEHl5jPbaYHplZjcYjjo0ase0RJjEWcrZmyyacKrIlfyPG1iIYuFqc/ELcnrBalXYR3inPHbN9p9lvGN3jUBSz0tjv4stYFPD05cOme0eVx+jZ1FjYnUEDd7Od1BnPMiCtqIEXoByky58FxP+C/E+U4wpL4mKUE5Ypbttmr10Ljl5PNeH76/Bk5dKb2CKNDnJRAiILn6nqrG389ouiUHQKkc86Bh32/QFZvCjBt+8BjL2ECqBTQfp6VYuvtPDTdrkIr4ZDsqiHPc8tcckHnimSEj5l6l2Ew==;5:Jkpn1BKIrBUq/thuIa87uZQtNiaWlpUMB1BSZ0Pq5RWnkEhfK3+AdI1Pid1aWnuJzGGvJYJ7/F1IPO7v+7qZNh6NY35OWg991tsz1d8aFYfY32esIvpY8tXeS0JcPI1qTvb8AIno6EZfo6i8OzwKuK40sQnJbV9a6LCGFHBcGnU=;24:5QsCw/PgK2Yf+wV2s7hH6O0FdH9XQc2CLDyCWa7jRYDh3DG6Ffv4hYpebGkUiLdD/p9pFV5rQ+FDVAuFS91ztBvzNF3jKcuZ+LIR1ujC950=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:+KG53gUxfCT48Iw47XrreSKYvIyITLg6XgTkIaEN9jh0Z9JSULABrsVePFZlOu0Du77pZ+KTvGRUw07c45Ji66EIE5zXJZ6LnER8TNEC6bSz0RmOB/6YXJ3APKza9V6npklKTqsnozV+zvdpe9pq/Z8FnphcN6OJcblGAPcDKKcg2V87imUuXApOduhmRneD+OAp/aLqXWn3Z2RMJ7TxtErPXTAWX3Ml76xcmMnDurjH5EXtAy+DlI/5qFRI984M
X-MS-Office365-Filtering-Correlation-Id: dea1434c-9fbd-4719-ade3-08d5c8faf079
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2018 02:37:22.0458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dea1434c-9fbd-4719-ade3-08d5c8faf079
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms like i.MX6UL/i.MX6SLL have L2
page power control in GPC, it needs to be
disabled if ARM is power gated and L2 is NOT
flushed, add GPC interface to control it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no change since V1.
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
