Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbeFCChx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 22:37:53 -0400
Received: from mail-he1eur01on0074.outbound.protection.outlook.com ([104.47.0.74]:52960
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750952AbeFCChd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 22:37:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/3] ARM: imx: add cpu idle support for i.MX6SLL
Date: Sun,  3 Jun 2018 10:33:45 +0800
Message-Id: <1527993226-19587-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
References: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::23) To HE1PR04MB1323.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1323;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:WRcLroVVr6+UTDasadrA7q99pQlQPGCN3n2F+0/BI3H2Iijh8So+bAzB1iIl7gh3jVWHkd+oP46EVo2o4gHN9fLuoXWu72+2+folTzOdPLgl9tffmd6bAOPjL/sw/WgnKmiiMaKddyjyUAYhyn1b0LPkLoKjY3WAmxVbq2Q5iJrT5bCZtZInqwExC2kZfOsS0uS5Jca9s0MFalqiATCLLqyTo9cFy0ekoovVwRgo5+UDsyBC2unjBlqbQ2UR3ysd;25:mKhJE752AIeJY4gcUpcQBbv3um/dE5jhLkEvpInZUdi73A0qFgCE8fu/vxiFTSwUutUxHPGA0FUMBJpstt+WVtDMlYjiatKUQ3PV7ofO3s09A0ArtDx2V4Ba2/TYb0CIhRmUiSGp7aeg9wAd9W3rO3n7V7saBtfVNbP5LX8mRi4w/z+bFfhTFDsuA8NbiX/k4KO0oysPjGn8q5MgQuyfngtNxsruXGb+gd/0wGs091urNML0bGG/0hMDh/34g3VHcyGCszUmiwAlcRcantp3Vd51h8ySuJqsRTdunyIng/R4Vjq+pcVxLYWF6+tjYVh5Sqs46PNe145aVVZZlpOEDQ==;31:kGfjbz65BnX0HoOHew1ySV0lQT0Wvpfc0Dj+PyHTZvKTDSx5o4ROTGS9htezAX7u6dYUek7w+VDpqCPzVeNt512gn+FKz7ImcBeLxx3advmsnLLt8sYn35GJs3349cBgN+I58GbK1FkBf5LmMkr1KJtm5hS261d8sPPs+LHQB1+ZE+G/9eXm1ZRDPfuLgHzx7NGu8IokJijlNC3AMSizXOXDJMSATZHh7DWHSiXjtIo=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:huhbLMsmLbYJjhpJWbQk1D5OFrmlkKgq21ln6MFAD+jck+cztRS+J5tTkqt0gkmd1m8V2yNdcH8/TFOLp7CtLz8dSJKz6oG2RnRd7FYRzwuPcjQ0tMd1NSh/tDCLEWR4m2c2wAG7RZA9Q4oOkxzPYBq44CTJjuxRVMnITLdO8mz7xDaq6Opkvq32GZa9LExSqUlAMVxsCFp6V84A3Ww4Bt/6K2QBA69oK7M/OlT2ZXq43DNlq4GTJdqZK1PWJi6lP602DppPirPrX9AkQ0RNnnvYtm5oinQ0imZDuOwacDUlpu1wUABtwQkcBtJLoPl5N88nO3H2zlK9Ri/ZXo4OmzKTRjraNJ0YfeW60EuG/hvCnPhXz8uaGbgqCQHzNtDgGHl7+7+tODoBPBRUIa7Ly77zgUqeQVCycxHzElqjvObcGZfefahgYMdTERE4zUnkh5ofSQkqJed44LHqztg3+9lBBamq9xQbmuucoCQGENSP4tXI6Ac+CiErse2hAULr;4:BZ4zP4SzlDpgAcBLI3w9R7ujJKpriZfVjiZ31uke8PXXS+N7j6Z3Jc8FZH6qeb3MAYvllacY36slMjV2vfitRLQ4psj2NXhwo56wbo80JfImnjgq3TU/ulvUWnZs6y4MaaXllwLD5JEIrXIDRWEbJmUa5W5WEM0jkwY4BM0UZVJhGsbeEGtlA27bB/9I/weV1YtcRjnksZ5w+9aNhlH5oA/ttP3QBa5dMcguxsgvEaAPsksRaY7nedLpWyd/Xbmz/4bkaTj6axBMU7+OAAiPKYDV/IpcgTu4/yB2DdBJlrd6TCa1A0poW2UzTreDE2KP
X-Microsoft-Antispam-PRVS: <HE1PR04MB1323C614A5215146DB969D0EF5600@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 069255B8B8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(39380400002)(396003)(199004)(189003)(105586002)(305945005)(97736004)(86362001)(2906002)(106356001)(575784001)(478600001)(66066001)(81156014)(8676002)(7736002)(51416003)(48376002)(8936002)(81166006)(50466002)(486006)(186003)(956004)(47776003)(2616005)(476003)(52116002)(16526019)(11346002)(446003)(16586007)(76176011)(6486002)(36756003)(3846002)(6666003)(6116002)(316002)(386003)(6506007)(25786009)(6512007)(5660300001)(4326008)(50226002)(53936002)(26005)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:sYcwreG6zcMfkVVrUas7N8o43OB5lvmXKifRcFLtg?=
 =?us-ascii?Q?f+ojW6k4XBcRqCC+13RW+1Npkbon/gWYyFs4BDgf+XwYdudNaXK+pOXvds7m?=
 =?us-ascii?Q?pmmSMeti77/VDu5QT+TxYXHjQ29JoWNbMrm+tMlAior/qex6EvC39l3ljepP?=
 =?us-ascii?Q?+ByDVMkdpLbtCD7T0UphmjdV3vyzkb4lR27j5J5QEXpPHnlX16tC31cdKOVT?=
 =?us-ascii?Q?TsMnRgzlKRorhbJ5V6vLZdrMjqqG4n6L19iJmXGLFK5Fy2FXQVFDBZZ7eC1z?=
 =?us-ascii?Q?dBBa9G3Ggzl1JEThW2H8YLCUIcSzDRLKnlhqEDg2cM2Rh1Up4Jx9mzpiaZ+y?=
 =?us-ascii?Q?pI0EkNtZGjlbTwOeKWEI66Ys0IkmoijKvBkY4vSSF2b9eDRldnLuQiYDIbuh?=
 =?us-ascii?Q?SHscYROldHIcK/FfCr4VR8q8bUVNWLG3qR2qsyb6EeIY+tZF69mRy0d1u0qe?=
 =?us-ascii?Q?PHXNPkJpSi8fc7p4LEB0R8x63+b2XazbHKd8WjzQWRrz75mljc4soC3WZxNZ?=
 =?us-ascii?Q?gxVDEUEnS6DW1GPUmhjSS+6im9bZti3eiZW58JRMnVi0bx5F2nhLNIKmgHvl?=
 =?us-ascii?Q?kuaqV39EgeaqyjvomXrsEYrX03mj96ETyAd2rAPXNBabfr6oEz/RNMSWKPp1?=
 =?us-ascii?Q?vZ2Hj8v8FDmJ+gdY3KuAzUyWaWzeA4VRsKIYkFxveS7QUXKzcQGFqhWli4eM?=
 =?us-ascii?Q?ERoExonJAA8YtcTCJ6ugzBgs7EMEpsvdVLwBB2y7V2GzXx/SgjBTDZdMnl0R?=
 =?us-ascii?Q?XObcHUlO06QgNa5nO94sBB99LHJSwXDQ/5Mnxx9xLpfGhRlo+gi+oU3gruxA?=
 =?us-ascii?Q?kT2us47NrrcLEVYtk8uWnu3UK9oSpUDfBVNqLWqCcoRlGVLdulfu6TBkvZe0?=
 =?us-ascii?Q?DQc3O5nRi6CSK0yrQ1gvqzthDxNJbgkjFTdzoV5SjDn5lGHuhN6sJRmZXgLJ?=
 =?us-ascii?Q?FRJsj8N1BYsaLcO6kSOLt/6seWxoQCgf9RYrZzajEdAPz7WoG6WkUJeC1XOF?=
 =?us-ascii?Q?arQHlSn+e6Vko2xvbJDgUw1TXuYd5GJEiBw343yD8wWU5Xw/QjERb5TI4+MU?=
 =?us-ascii?Q?cG09Pk8AkE7BdV/WfX+TPjVnzr0iXzD365+W0tNKb6s46ElzYmxI5hRzy/UA?=
 =?us-ascii?Q?Umgr3ZENlpV3BWVoHpXnG895UhlrW08acZRWhQbBx2UrTjU+sw3pgLJ2f1eY?=
 =?us-ascii?Q?UJtx9zkpjmfLOg=3D?=
X-Microsoft-Antispam-Message-Info: 7VaAlLp9k/PFoGj5AtCj4iQ7WF3JuehJzSOvwA8umXZHi7zAUhbGCMdtIgxkxQfQgZmueoX0wsgAii+8ADmg1LT9Ae+V4COsArQVXYPrY/kQdbJVXzE80kpWHdi0tOkORheGM7IgmgoTnTBnrMXAao2lJEBTLHbC3oKqqV0koU1ndQew72MrS36Nyyfz6vtz
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:72FEjQygC1lcrO6r4jka/05Rwt3z5aqfuQ6XWKkd7OG8sxP380ZvTTcU3IhxwxnpQzkVparY1L2gwz2xwHJ8z8zW1zWfCtUYcRVJbSixuoDUnDU8EZzTtEx0w2KLulB0XNmhhN0OFLKxm8kAc5Pd3Ojq86NCdKncUoE8gVA2cVk45x8EVqO7Bydb4PUSAp6RooajIWQGkVAUmkZb4I9qsLO8g9vGXofF7U3FK/P9qg69cTaqxSvFCrOSQ4UPMadaozhgWorOT3p2IiNwv0a5PdNGgJKtXFnfQDaS2Y8r4xHx+SjrIsZ+KKyYUsPXYlKaXxyRLo/XesGH2R0ZuoZbMQB27pd5iFA6SMBxzyEPkNb47VKicsNveiuI1A0HS5rjE+VHCxH2qPbA21F9ZAmyJv3CriGBhW4L0F9sIhKugNxp9ItbV6GnpjEtYEvOUS2+Z94LBBDfNJT/um6E9TYUog==;5:rfSyD4jLR9JLfGlDYJ2PjjIuo54jOZPerkUk6LTlgtW0DG1A994HosGYKGYduJqQ/PG34LGy89X+GeujewwnWU/8yAs/TtdISZ7GGSJL88F3EMVgU0fCCytmfgO/+nYQhLMnp31q8zvRZWIfnBQsauTmMPKlFwUKWNe16b/kUiE=;24:rZ0JdBK+ktV2W51rt7nsRaZuOhj4uBd6v+3ZLxRKngEbFBhYptbIOSEPOf/2FDEkEKrRA22DLhYqt74h1ZH0vuH3c9SVH4jtTbC8bOYisvU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:k3ltDZY2tk/NXooe1f6uz8no0Zy1DYphblgrXx2XaaUtt8TPQ3loRvKzQINCPZ5AJqTYfI55MO2YfsjpY6/H1UIOyZ8f2suVhx4NMP+LIJf3HOfKnEQEtbHizKLdPYMpD948r2W1ZmYq2J7dqUv4xymctD98zWao/AE0ZQjiNJjWC9C6JpLm/Nz/TxcGaNRM29R1O2xbNmmoLC23nWpfFWYJLGIKNcKAg2Ur4kl0u6zu6Ys2+Hbn2q2HMXt2kkBx
X-MS-Office365-Filtering-Correlation-Id: 19a4ad82-da1b-4dc6-76e5-08d5c8faf243
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2018 02:37:25.0460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a4ad82-da1b-4dc6-76e5-08d5c8faf243
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SLL supports cpu idle with ARM power gated,
it can reuse i.MX6SX's cpu idle driver to support
below 3 states of cpu idle:

state0: WFI;
state1: WAIT mode with ARM power on;
state2: WAIT mode with ARM power off.

L2_PGE in GPC_CNTR needs to be cleared to support
state2 cpu idle.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	Fix build error when cpuidle-imx6sx.c is NOT included in Makefile by different SoC configuration.
 arch/arm/mach-imx/Makefile         | 4 ++--
 arch/arm/mach-imx/cpuidle-imx6sx.c | 1 +
 arch/arm/mach-imx/mach-imx6sl.c    | 5 ++++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 2327e3e..127fdf3 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -25,8 +25,8 @@ obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
 obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
-obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
-obj-$(CONFIG_SOC_IMX6SLL) += cpuidle-imx6sl.o
+obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o cpuidle-imx6sx.o
+obj-$(CONFIG_SOC_IMX6SLL) += cpuidle-imx6sl.o cpuidle-imx6sx.o
 obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += cpuidle-imx6sx.o
 endif
diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
index d0f14b7..243a108 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sx.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
@@ -103,6 +103,7 @@ int __init imx6sx_cpuidle_init(void)
 {
 	imx6_set_int_mem_clk_lpm(true);
 	imx6_enable_rbc(false);
+	imx_gpc_set_l2_mem_power_in_lpm(false);
 	/*
 	 * set ARM power up/down timing to the fastest,
 	 * sw2iso and sw can be set to one 32K cycle = 31us
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index c7a1ef1..183540e 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -42,7 +42,10 @@ static void __init imx6sl_init_late(void)
 	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
 		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
 
-	imx6sl_cpuidle_init();
+	if (cpu_is_imx6sl())
+		imx6sl_cpuidle_init();
+	else
+		imx6sx_cpuidle_init();
 }
 
 static void __init imx6sl_init_machine(void)
-- 
2.7.4
