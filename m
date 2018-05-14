Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbeENIPP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:15:15 -0400
Received: from mail-eopbgr20065.outbound.protection.outlook.com ([40.107.2.65]:15735
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752306AbeENINR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:13:17 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/3] cpufreq: imx6q: add cpufreq cooling device based on device tree
Date: Mon, 14 May 2018 16:09:18 +0800
Message-Id: <1526285359-17978-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
References: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TY2PR01CA0013.jpnprd01.prod.outlook.com
 (2603:1096:404:a::25) To HE1PR04MB1324.eurprd04.prod.outlook.com
 (2a01:111:e400:588a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1324;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;3:4WIMUqMUunOBXDy66okMIfR7rxAzAWSfHi9se2Ti+i7KFJ70yhEGpWdZVN1uQxn5k4jYoPYGB0mKi7rs2XFiztP/8ZvG6DGS8wzWyx6iC6IAIX2U0yVwXnMqW0YQQdqYzIc3MQy4zOOj8EJ4MM6+a6keMovcZF/vZaFyLhOlGGS+ss+bJyiaPsBqyrbLWg6UD3Qch+2qtnbUmXOoGgAlkcTxXuz/9o4FIoHQqVpYL6n3tCbcDMBX3Ps9WqbARUo8;25:YfZ6Eh84H+ybeIwef01AzwOhrIqGxKazCO8fI9NyhVtWmHb+0EN+JqQyaJGknht9sMNGjQW/OnjBs0XihDVSzAiA4ptha2gfAPRNpaVXGgyXvLJ2GfaxIj4o3La4iY0G6lLJ+IKa/TWbf9OuaayPJTWI6dXwKDQnJNISW6D3kwmCxVUm3G65So5xTq90P/CbroZ1vp4XxVyJzYifpouUaYOCLUjX1rFTpN5wgmAD9WBBtqUO9JzpI3T8vXxXAS0NYwOqPc6XCrfnUHqwgOBrJlmynjaTbqBDBY/w3t+DfsG6zByWlyjc0NVXVLc4D2KamgadI43L9O0+ieDT8odYhg==;31:KhUNnp4IDSScDLjlRiPwwgGYg7NeLzN3hpsSFid7qd9ZrBKTmYgN3h8Yv6roFpVmZeTGr1N59tmhzZjG7vqRJctjGf3sR0mjkrVRnCEq70ZBWLOmwI9fCaFU4loHqrK9nGTJnwok1sCwy1ZDDlT1b8ljrNgNO0kMG8k7oQ9++MTPQ2jZfVYrceAlkNxGBEKtqFV7hdJ79X6Cfc2eRxvdJnXoljIqql97SgSZ20A6X5M=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1324:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;20:kI6BcM4QLvo02C3+a1aj/pH+xc+R4H7aeeqhfy/JCHdo+BTPcDfr7I/xK1YmCedhH4x7BuniaFVs/yMFRqUf+Qj4ddlBnCnjrDV9qcnr31YNAihbCaELz8edcgy8CJbfSHBS1Nl1t7avVN7PULHQu70+N0Z6g7pdY8X2H2Y0yhSYAsxfRVKEepAyuwPq43uAVhmHv5HjC0P9g8Nw0sjt7khOBKBthTZSEXZz5eV849yJGasJON9dedFtb0bSNkzbPzeYvwYBIBvkXD261y4ZJmoXRropIM5yBF+lT94lJG08ITB45GXbs4ECqhvl/eU8/rLOVDPyYXtSLRs91tDpAYbe2g57eSWF/gCsYqaVY+QIQAfKe/wQ7tIcHrA7eH0iN/3f/DvIhrb6nwe0HhCF5jvqxSCaj6HtBpkDlVSKS7wx61gfSgPzFsV1/vVW/LYUqms33X0xIlJH4YMWx4SOpKb8XBYhaoey40s03eXoO3/gawYV9PIJjzMyQT5DcoM0;4:Zb3iOR8gOWpZ/uIS/UvKpnITB65W2lu75QNrRD7Y9nEXDX1120zRgDFm3anjyAcUzxoUJX/dfxQK1D3Jf9/ttrUtNLDSjDXUnMdAorkFpDGE7ShipVYAqdMs6aiezdpSzdD4vOyfKEe3F2MO67bNbjfDtjUicOZQZJrIJX/NYZIKugkQzSz53eVC7b74IsbFzvTTjP8DrCOx2sLtFJvJcQZx2ASLZ8baBccqtprSoHrolr5V4CwZpFg3uqlWAf0mSpFedXViPpjloGKOIW9YIY5zaKuiIxCJaYvbjPnSoRE1ZKd0YuCq1YWz6d5PKTT8
X-Microsoft-Antispam-PRVS: <HE1PR04MB1324D729769B848BF2AE8745F59C0@HE1PR04MB1324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR04MB1324;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1324;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(39380400002)(396003)(199004)(189003)(316002)(2906002)(52116002)(7416002)(51416003)(6666003)(16586007)(5660300001)(25786009)(39060400002)(68736007)(6512007)(53936002)(4326008)(36756003)(97736004)(478600001)(6116002)(3846002)(106356001)(305945005)(105586002)(7736002)(386003)(6486002)(50226002)(47776003)(8936002)(66066001)(81156014)(81166006)(6506007)(8676002)(59450400001)(48376002)(11346002)(76176011)(446003)(50466002)(956004)(486006)(2616005)(26005)(476003)(16526019)(186003)(86362001)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1324;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1324;23:UlwPum0B6F5rVwxgNtkUZlDipbvZu/+JwWkkzkx/W?=
 =?us-ascii?Q?DnOkI2DBO5Priz1aOtoOnyI3bzpYp96iG+GO76guXuhuflKyrAehoI8506wD?=
 =?us-ascii?Q?P3Ws32ui0oytGCIFEe+LGVrhzFOd3R6qpk36untE0m+8lY3luOY7M0/g8pWQ?=
 =?us-ascii?Q?87NfDw92z2Lq4xxC3JopaMkBYHJkl72dA8s53UZK21Y1yzb45Lg4fSBtgelY?=
 =?us-ascii?Q?gZCs+nRawQQGOkln0EugNBN1CiKOJx5UbF2EICohniSFrYKS93iCaNx8rRQB?=
 =?us-ascii?Q?QXRVDbR5DyZMcmz4t5Te1jDw/vOPMYRu0xTr+h/Rvj6VyGVd5kWX03NAwTNk?=
 =?us-ascii?Q?H3Nx/4SMCRxZIpnsNXQr63BvEqhKk8vxjnDNOfS711AAuGtlxZhYUYGPMqEU?=
 =?us-ascii?Q?6IstbttNRMeuVt70GdKK8IjS8ZP+PXVuHYQuMFNs3JStvS6oOTQo5JezVobZ?=
 =?us-ascii?Q?rsgCVImBJ+ebPjz8cbsIKLbBRt+2zcwztHb7UeRm6u+3kxvrckoyDuSiSfmy?=
 =?us-ascii?Q?RMqWIDoPb1mOGL7IEV9Pzi913tNbKQEgNr5n7PGZYZl7OIfxNepZELmvXG+S?=
 =?us-ascii?Q?0vQs0tZ/g3Ync0pjAPU/tipuq9s6A83ISmNWrBVgbbQaUG3HeTt8l7ERTy2o?=
 =?us-ascii?Q?dHxdWKjSh7voTp+OcP6CXz4y1biRynjhrNbuESYtx8YlFMXemoLAB3CZJPQC?=
 =?us-ascii?Q?W5mS+uyLUzrji2ru6VMh/J+LnXmyW5N/Lpu8sjIkYd8hm2ksFe0Qbv35/Wgu?=
 =?us-ascii?Q?i233OjFoQ0lBtSAYiqsB1EbcrTeWG7P0pyQ3UBrWm0/m1zdEnEXfC/DBdZb5?=
 =?us-ascii?Q?L16X0aa4tchr17HjOcuY/taojXVVW6pBIetZRscl73d0z6t8OsFrnDlB529H?=
 =?us-ascii?Q?EbxpnRRNbBaMMuH/qaBucUnT4xESNhfxSbZcKtiBgJyMLqgWhPPOwryURZpa?=
 =?us-ascii?Q?WcEHVwFLyV5hVw7tL7ULdA4rl56io1fUPwmYXYdh12/1cESSHCviMWJDn72r?=
 =?us-ascii?Q?rA6rPTaOB2hwQ8F/ffwO3x/4keB8QLan19FJECu+ypOy51ODSC/c168a3i32?=
 =?us-ascii?Q?DIaxo8xW1XP4lA1GyIyVNtEDxULITJQ1pkD9oiUf4zLprKjt2OfMPQ1WrVM1?=
 =?us-ascii?Q?Ywqn1xqQ2VnR5pfsHqxzPYwt88ooWnCNxqPJ1UognSFKHWQVDEmKea889G8X?=
 =?us-ascii?Q?q7ots9Hs11GY/+78+8zy7AtLQprE67Q6lgQLSdzvDuxrfyVWWt4hwCw+zCIS?=
 =?us-ascii?Q?Dfjbcbfsgy40ozfv+/q1hqooDla8GME7iEEdffn+TQzX0QXEkVE9ifE67VAZ?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: nTBmXCDRoe2HhemgHxJih+e9+MlBwksu6i3agWbkAspRIEwZ+mY08aKwdJ14WP1cn29druFAfRS2rYo5XrZHmQuT9kSMTl6DGC5k2Rh8yMPkU5XH9ntLvWXXoobeC6WjAmD7UdC051jJR/Fg+zTQg1ipSawpAm2hyYJWtsmIP/ny4uuLE9GLvhF1OpxIEffZ
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;6:qURBV9QZ3olgVCyNHHrvdz/Q52lyckyLSk+IX2B36MhYDEoz56RUyEHHGmrDstmwymS8opnRSajglcyuZ0FFHwhCkSfGKgBO7kW9+qWzONLWvpjzGfR2R0lFenmV7S17plCAIyvE2j4GtMFIA/0ElhXsAirQlk9zwRB/ArxTOvEnVGftny8VCPzWR59/TgvyukE/UoQn3+4In1bg4Baey/S1XsCKGdmOYsnR0MYV4MjbTLr2HUZM5s2SAT2gATgqgeutd3gqP9bDkxcmiehmYqC3k48zoUVLzJPS38H+z6X0D2OqanZxa4fp2gRvxavaTPKkRekbZ2neWP54RX55EVaCyv+/GbxzwuQNtKMOAvwigTzrPUMXUsXvkMsEBNAugIVBCEwrj8KjSpv3z2IpvEC3M4VF6lmOcpChRJnFfxVMJnBX3kBWWbmsheDVHRGH7+taDivTrGmwt5+zb3u+Xg==;5:FYFfMskwQHMRFGNlnvzfAGfgSnlviPddHLHpPPR1tzAV1ZjkStAHQq5BJQc3hMgoCseLgSclVlbH8RHY3JjW3Z9N093lJF8j9sv6gmHtXo/vZzAsblXUyj1MTecNIecBTnJzTGGaGGArP2T7d/WDslElSALfS6dDU9zijzjKDXw=;24:A45C8rIFSB4neLRKxje41D7+eV0i77ZyOcUE40VpVJW5UPulN4S/ijk/fJ/74tbDMnkDnY8jiyy5ZXvnqWf20stmnZG15v2jztFKt5k83kc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;7:Cj6jevYkywLSB1e30R7YiyX8q4G21guJOxiWkYQmAJKzzM9DKnTZWMMASLXBRYQY5gQeU7CSk9ydNb2vvx/QHjS5kkhs6Tek6Mg/GZJngtcn1jFeSbE4Ya078PcJ8n9Qma3UnoIvsH4OAT6D96oGXTIZ8fS7jfMYG6NNSUQj27Sni0PQdn5pOMgIyMgT/SJ/+nizB3Ljbkk484R4tWzn6PHii1onPgH2rejJoUaj4VoF406gPjtLXa+O58pw/lCz
X-MS-Office365-Filtering-Correlation-Id: 2eaea709-4577-4360-4805-08d5b97288cb
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 08:13:05.6475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eaea709-4577-4360-4805-08d5b97288cb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1324
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the imx6q cpufreq driver as a cooling device
based on the thermal device tree framework.

When temperature exceeds the passive trip point, cpufreq
driver will be used to throttle CPUs.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 83cf631..27ce84d 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpu_cooling.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -50,6 +51,7 @@ static struct clk_bulk_data clks[] = {
 };
 
 static struct device *cpu_dev;
+struct thermal_cooling_device *cdev;
 static bool free_opp;
 static struct cpufreq_frequency_table *freq_table;
 static unsigned int max_freq;
@@ -202,6 +204,11 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+static void imx6q_cpufreq_ready(struct cpufreq_policy *policy)
+{
+	cdev = of_cpufreq_cooling_register(policy);
+}
+
 static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify = cpufreq_generic_frequency_table_verify,
@@ -210,6 +217,7 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.init = imx6q_cpufreq_init,
 	.name = "imx6q-cpufreq",
 	.attr = cpufreq_generic_attr,
+	.ready = imx6q_cpufreq_ready,
 	.suspend = cpufreq_generic_suspend,
 };
 
@@ -482,6 +490,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 
 static int imx6q_cpufreq_remove(struct platform_device *pdev)
 {
+	cpufreq_cooling_unregister(cdev);
 	cpufreq_unregister_driver(&imx6q_cpufreq_driver);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 	if (free_opp)
-- 
2.7.4
