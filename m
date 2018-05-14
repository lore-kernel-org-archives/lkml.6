Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbeENINT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:13:19 -0400
Received: from mail-eopbgr20081.outbound.protection.outlook.com ([40.107.2.81]:1447
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752416AbeENINN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:13:13 -0400
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
Subject: [PATCH 1/3] thermal: imx: remove cpufreq cooling registration
Date: Mon, 14 May 2018 16:09:17 +0800
Message-Id: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TY2PR01CA0013.jpnprd01.prod.outlook.com
 (2603:1096:404:a::25) To HE1PR04MB1324.eurprd04.prod.outlook.com
 (2a01:111:e400:588a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1324;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;3:Sf35Tv5GdE1xzoWtm2mQ5pCf7r5a8+56/gBEHnaQLnhH9AnNq92hwANzpDTAJ6/AxpioWdYoKZqY7pCDT1/hCsQR4w8hd3XozV7Onb0E+FaubI/Exj1ctfll7TwSQIrfvTXmWO228LgZGSA/SM0/Gqg+kbnv+pxYI6F903glKJs5JopSY5klCLA2srVyKyVta+Aksudxxgu7QK8rSkdbyq9znquBB+Qxa7xdvLRV8peJuhHsJBoFGbtQdwQq/mJh;25:bQ0G/B7wma7sF8F4lyFQ0vT6x6MgU4Rm8DyQJmjmPfs5Cok4MAavG8q06iP2LBgE4SNifs+sXbI68pnv8KqVgjFtORJ0uPtQT9n41+AyXH/yLSm4EM5+HPIEFa/JQS+V+SvbL1r5TDJazwAZhZ5pL/IRiAqS7hv3cDNCNrsfaXBQyp8XkD8xu4AavVVODrPa9uPCeBaEcL780GGO5dnTpqNQzSP/kY0oKZTwJmmEM41jVjiAnEoiRcHABptDouj8A/TB7YGzEp1KLPnRl6Xot7gebI13zEvi/uspyIB9HgpcR7Ztc6/a8liTp8gf1fXq3FWyvWD6PSinRmbw5OdKHA==;31:XrIpM21seFKIn0sGqYgLjugxm3AcE/iTcXAD369AVTxNraOJFbelLDHED48oCeSuSOohxbn+fQEizKkH7QipEeje5PxOhPIuQ/Y5PZ3atmoFfeA3FKKVk1PkOfs5UibiQLnf5uG+CrBXkYvYQ9H1TGuiQef7YF74b+6eGuEq79fDyWBOTWKd0RBWRJb8ibTZqsky4L+FS25RvH6Jc2ZyNJQf3qEvla4d3n84LOA0JRk=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1324:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;20:2ivXE2Oyey4tjFpYoeIgmsAZBkR0l6feFohK2WSHXbgt9gmePNaYqcGfrkkcl13xSEQ8uC34WrcNbZVcB504dVeMbIkzHCZbk4e4IV8uS+wqvW1Kt30EpHG5AKmCN9gj3gCli4jaQRoL3RlJa5GDSuMnhLNuHagnPnU/rKb8fTI7CK4eOm0C4cJUyYUEduvcESpoImOLiCebhbq15h7HRejYODckdmGHB9b/0CvzLzHOV602SkMEaeISUQRvXaLvTro6zTZLp+BuKZEjf/QjVIvV8fEhWV0ohJKBSD1pEBWhn5wy4OqF8PREmeUlUE0hBmKv/hzxrNczRe9UTTr4H6xhceo+PqC3UBSOzA3bOh1+zK27KiQvoy1kcIqRaRQ5Ky7+LjJZXwDy3MuVmka+kzD3EhCRTguavqbzqt7bKTQVT1qNgiXQr2fGnbLcp+dHxt1sKJ4YTX8FjYuBWpe1NrTncHHluMjrR9Vm5y0wZGYa6MOdLqVUX71nwj4T+2OT;4:+Ma+X4pW1yQ1HrT7JNfxsZNajWy1Iw5GuWZ4vQ6PJe15ju1uKflU6aQuBAgTx2uWRt2ecdub8GNJ238R67/vXs8ZIMqeTKqNPlx5yU6+vSHrCnmdR0WX5sSrPpmC1o67+NC3nrjhcjT1LYN3TygAoELzVfnkc1WDz1Bi7kCoZz3gBHiBcVMr0mZYliSWa2GCtHq0c+rRjd3TezNGXuIrB35Q3Xz6H0OyujXV8L+RipgxPEIin1DMAB+ynvrKdkfbwX+Hft2+ftKQzw5BopfSwrszvYxhfSqbh1FbdxVKIFn5JgJK/a6w0RtjVMY72hhL
X-Microsoft-Antispam-PRVS: <HE1PR04MB132491E8DA54EFB37FEAD45EF59C0@HE1PR04MB1324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR04MB1324;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1324;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(39380400002)(396003)(199004)(189003)(316002)(2906002)(52116002)(7416002)(51416003)(6666003)(16586007)(5660300001)(25786009)(39060400002)(68736007)(6512007)(53936002)(4326008)(36756003)(97736004)(478600001)(6116002)(3846002)(106356001)(305945005)(105586002)(7736002)(386003)(6486002)(50226002)(47776003)(8936002)(66066001)(81156014)(81166006)(6506007)(8676002)(59450400001)(48376002)(50466002)(956004)(486006)(2616005)(26005)(476003)(16526019)(186003)(86362001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1324;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1324;23:RLYNj3J0bQ0KSGvXg5Z0UiMgU/v3XpwP9Gr3hsbpY?=
 =?us-ascii?Q?/DUhg1MYjvEBkcmQthHEXcWmvjCXj1PqZeJL8jVu+Pp7ZAiOtRRfVgxFNhOy?=
 =?us-ascii?Q?cOCPzzenCjJduqT+DB733swS1DAwq+31PnsXx6iUCkYx2XA+MF1A4oLdmPw9?=
 =?us-ascii?Q?WOazbzi7rJOlAUTIllA4NMrUjuSuAXih+zrLeAJPXJww2HAxXUQPZ9LSzGi4?=
 =?us-ascii?Q?RYjC17tppQQ3nCpa5i/zL/hU423LKit1M3SIi48ji6w5HKIWaF6OpXFceosv?=
 =?us-ascii?Q?6I2g0QfEMhpJV5boBwIaK3EHlu/IVuyUcRNOTKMbOWlHapw2yzANPPl+NRkd?=
 =?us-ascii?Q?+7yRywgTsN10TfSenqEzNnGF0QGbKwDTp6HYvHzoKW54fcux3AibsZuaD2vo?=
 =?us-ascii?Q?IflOvbTIFG6viE8xU+TiAZeuVnCOSgzhp3iFtElCeLoWY+BerL0Z8lFi5Drx?=
 =?us-ascii?Q?puxzrLcbSi8PiG62xtxPZviq0ChYofnuyMW/NYiyY4lM38VkBHgzb36cYvr/?=
 =?us-ascii?Q?2debTbyEUtp9kZJtPkeLrKVswz4nqZK3hLvrkhnZiP9a0LITouVv4kuqXtUR?=
 =?us-ascii?Q?Zt/l9Ed9D3KvKDyBhjvAGAssAiIAkHR6Z5OpdkH5l5YWNeAslYHOUMx5q/ye?=
 =?us-ascii?Q?PMRjhAYzEL0gYTJekNudiD1D0hwC7HwgxCf4rYWY02E++eCpDaV6nkHjb6N+?=
 =?us-ascii?Q?AdjNAuRD4h6NJ3nhD3so6ysDjJRmAUol3uk8NQ8BgiqJKrVfnsTwruC9+7/i?=
 =?us-ascii?Q?RQAVeTzrCMav5FyLKIdmJUSg7so0ATcUIlkO1AbFkZzJYOaiZS/hIcsUsOP7?=
 =?us-ascii?Q?3zG/jorkO50djgcuokwQO/y29QgmRHiTSNxZzKbqQQBMbVQZfV6f9TU71mvh?=
 =?us-ascii?Q?hEGIy9aCYjanXgPmUd7hWh57jddbAeov0WHZFHWQfEWdkL0cOk+BxWYNh/LE?=
 =?us-ascii?Q?KcsXbbKFu6lYKsFJYr35fgSPlUArYpwoUFA+uIpdGEOSPq+eQexSKea1J+ab?=
 =?us-ascii?Q?CFq3V3ZGfF/3TdwJ/nVzvX5N1eQ6EKv/473IHO8XNAQE8HEKXQnwo1cL7CrN?=
 =?us-ascii?Q?fHWRGmrKkCCtpzObeczpk0yMskV2m3Wn869D4iB+yRlrGWB5l/NfzvLnn9R/?=
 =?us-ascii?Q?vkYocALstB+XdiqM4xdRfM3Y3yMIjNw8JyTfm4fkOq5az6pklXno6bDv4WcR?=
 =?us-ascii?Q?GW9oC0uNBSCR4CHzXQWSgHh1GVrvm3WZw65?=
X-Microsoft-Antispam-Message-Info: R05DykYJb2xHxNXUlJRwP2Nxxo9IQDbUWfMAXeK0uXoR+WYRIkA2rqEGkinCyn2qIUk/t5xjh0zYsPM/5oB7c0LTIlFvkMvIDdraG/waG6dzMXxxsMTyVfFf8q0mnIINscQkZkJvpan4NJ73qNXrDAQj0cuA6UepQ6LEYdoNZ0W5UztatwrTC/ikcB0wwZco
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;6:4cGQeFKo2HNuC5bZJsgIKI6t3EdBs86Xv4iQzP9I11c+ry5iPgetO+tHTzc3AQ060UeebaE/SpvELgIRyplgV7adXqD0zzsTyv3vXUKijfhRB6n1FbjboJZAMvQv9Vgih4VAaK9m/xYvnAB3dr/wHCllGSLxSN+zhUhX7ADS0CwPcpBXxUwZgRXvKK0/NcmdMZM2Zl14dUt+xp/oJnOoSFtCJru09xkn7NnMW63M4POVmO2pBX8rhlO00ntRjhIQNZh0INaRAWc6yMehVGctw8Bq16zYnlkFptqyXQ9sgKtFGU87N+MJR7VPxY+/MfjwAe+Ekukufqf+wEzFjRSPRXo/LYmmr4iqrTpSX9k8aDehsdZzGy7KnhVN+fXwJ6tEv2XfyHCzKEU1OEH8vqK3wVvhzckY0fzkDrkjouicmVrFCNTzGOn3ZtxkQ0AdXKNwY38zUEiSYEcARW1oIbpMHw==;5:REuHQ3RREWivSSbfjqIeJL9FzGTzwW98LJBkKZkCS4slpONKKAYbzCruCwVcLbciuw1LmHL7YU1KwD8N8EpAKddzFyXB9b6WoLh5BZgOIbANuE9ah2Hk2H5iL4ExxyFC2+IfPoZ0ruBNfRLm64dO8TdKNGJeHCaBR9XXE0nIen4=;24:nJ4Vemd3VdycIv1EM6utw1OTJsdekfmQxePShryWUMoVEcjRIkVGZVQKiHGILzOFsg6l4nLEf8y8NLC5omfBe3YuKErOjp4n0CZykcRdHaQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;7:AwmPZtR8shgoGhA7/SUzw5QMBaMOMoOoS/QlW+/VYmisXOGoG1RI08q0dnfNDhnqCP5tsxFhJUBSSxEW9PkZT7o6o1t0bPZb27KDr1abrIuS5m+E1C6ZATUUvZcdzKVeeFCL3VdwXfa/aNxFiLp+paXR5IDsfbpT17fQfaiLy28CQ7pJMPuJLlXklDdj8pp7VwMbtX7ofKJAN7ONq/kj/Yk8LbH5cyN9UHq1fYJLNaCyVf+ftEpqzvsCAraVUBrr
X-MS-Office365-Filtering-Correlation-Id: d96d6636-ecbf-4434-817a-08d5b97284df
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 08:12:59.0535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d96d6636-ecbf-4434-817a-08d5b97284df
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1324
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes cpufreq cooling registration in
thermal .probe function, cpufreq cooling should be
done in cpufreq driver when it is ready.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx_thermal.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index c30dc21..8eedb97 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -9,7 +9,6 @@
 
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
-#include <linux/cpu_cooling.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/init.h>
@@ -207,7 +206,6 @@ static struct thermal_soc_data thermal_imx7d_data = {
 struct imx_thermal_data {
 	struct cpufreq_policy *policy;
 	struct thermal_zone_device *tz;
-	struct thermal_cooling_device *cdev;
 	enum thermal_device_mode mode;
 	struct regmap *tempmon;
 	u32 c1, c2; /* See formula in imx_init_calib() */
@@ -729,22 +727,12 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 	}
 
-	data->cdev = cpufreq_cooling_register(data->policy);
-	if (IS_ERR(data->cdev)) {
-		ret = PTR_ERR(data->cdev);
-		dev_err(&pdev->dev,
-			"failed to register cpufreq cooling device: %d\n", ret);
-		cpufreq_cpu_put(data->policy);
-		return ret;
-	}
-
 	data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(data->thermal_clk)) {
 		ret = PTR_ERR(data->thermal_clk);
 		if (ret != -EPROBE_DEFER)
 			dev_err(&pdev->dev,
 				"failed to get thermal clk: %d\n", ret);
-		cpufreq_cooling_unregister(data->cdev);
 		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
@@ -759,7 +747,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(data->thermal_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
-		cpufreq_cooling_unregister(data->cdev);
 		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
@@ -775,7 +762,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"failed to register thermal zone device %d\n", ret);
 		clk_disable_unprepare(data->thermal_clk);
-		cpufreq_cooling_unregister(data->cdev);
 		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
@@ -811,7 +797,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
 		clk_disable_unprepare(data->thermal_clk);
 		thermal_zone_device_unregister(data->tz);
-		cpufreq_cooling_unregister(data->cdev);
 		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
@@ -831,7 +816,6 @@ static int imx_thermal_remove(struct platform_device *pdev)
 		clk_disable_unprepare(data->thermal_clk);
 
 	thermal_zone_device_unregister(data->tz);
-	cpufreq_cooling_unregister(data->cdev);
 	cpufreq_cpu_put(data->policy);
 
 	return 0;
-- 
2.7.4
