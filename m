Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbeEWG1D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:27:03 -0400
Received: from mail-ve1eur01on0051.outbound.protection.outlook.com ([104.47.1.51]:38617
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753989AbeEWG0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:26:55 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: Linux-imx@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip: gpcv2: remove unnecessary functions
Date: Wed, 23 May 2018 14:23:00 +0800
Message-Id: <1527056580-8791-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To DB5PR04MB1318.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1318;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;3:7qI2/a45GDf//MSWRDzZX3Ck7fDDlyBR/GX89pmQGgOenXmlXmwk8fMzPi5tx22z0m9Wla8o8Qwbycil7bmDef1rnahfkb4mNMqLfYHoGs3rjSXDB5DnIEt/jcon5mWR49RumoHO2RZObkE5zlOYY/NK7uP8ZmPdXxdtdaFGsWXPgrpWY+5KwMStN2cbwBJZ/baIM+SALV5rRxhkM1GTFEL23FUHvrb1gZojl5Huq2fP0eLmoUC9b//sTN41Ac3j;25:dgp8WYOJsKpqr9GtGrZr+5r8Xzr2C4bqIzKhaEVj4dVYwwdScBfcuXqLbo08PhksrVcKfxF/HoBN2SomFY3KyN+DJ77wVAzekXL/S9KbMpff3320EJq38rl8673oTLX+eE9gelCc1yYXm9qGbxhe/oGClutL0fnEA27EVdqe9fmYkAEVOidA/hMui3HA5G9vLDa2zH7BTHhtBdJnvsYr8rjR5Qc3yss/gE1TiKQyC+iNTP1PL2TPWMBA8b4j2TbUvtg7yi5pRWoX8+iETcJHvYgD1jZCokT6gAF+71Eny0xBqKNq5OtsVFmSr23EnfuvKVUsQfkN6CoHWnz3XSjOZQ==;31:OjHh1tC5DBNDOna1owNEQkLauysfHWf1pVM3+agWEQ9vucRIXebxhCPAV8FEYqVjo40EgPK20YwSivv4ILEfkdFdI7Q1QBeZSWTrffXYA7qriuARLbkHeOU4zQJaVz1YUSxZFmS+XeCqfRQ0vtSb/BLA31acLAOmR812plh22II5Egx2YgJFDnY4szL8SsU3GJjX3dNyKYKGPam8O4X11MKtBCVmCVW/3IWsE5A8yRg=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1318:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;20:7amrYOf6doV03bkLDsy0ZWhtby86s5SugwF+POrdRcjnQhM89Rp7HVmQvrS547XhePI4wgHVQl3NdHD6ajGbCgFYEKKMUoX4EgjSr2ZUWJVcuKBDnGRIS2LkIeLQVCXwTjdA/90Pb0nLqgcia+RG42iinGfzpRiDd7OXRVf5D38+D0jrNFRa8pldafvpPRxn/iAqPSWrGzljRnNXoy7gqy3lJZsg9IxJ2RBcc8ycdPUHujo4sR8ZhDC+W+ObKoHUlTM5s8Ezdp3ehMeqCZej56NlOp+iFl10NA1qOWRCEGVDmoM4CputeqDfvST37GoQ+qolopJUyl/aFJmMn3gFfy7Y5oVy0qTVzGvyBTUCTj9t4ZWijOJ+JXnG0oHDkXxg/SY9gk52gon2SxF+kRuu1BTpNxnJA1KPBq4ML7S+a5Ti9yPoe4M/zWAAgHwMHKcn5m0ALCcrlOfD2N36YhAHGQLfsBO5wCFP96uur0pUUuLumuHCdLxIk7H5W0xVpAF9;4:6042lJY5rV9+NW7YQPZqnwBgMZOqncLOlan2o07NxNwbNjG5pOzHqqtyqgLuHztwxeunEnnayOJACIKIaCpucIX4DUN4aEwhg+hsIeV9nlc7qbqxznHtUiU/ROZ+Jl3HKes4TiZxZkySn0Sj341WLojfT4LfdqUH56RiAhVIfAX6WLsRp9zRFjMOt5a1vgnxtvqP1Myo6/GAPqsh1d+/826nS1ZCzEbypBHSlaBzmfJY/4YoByTJaOVrFL36isiUlulHrGrOxsH8bLQiHdWhoygUGtzCbWCTzL8FQCb7prupiRY56uKqtuaLpGPYX/CZ
X-Microsoft-Antispam-PRVS: <DB5PR04MB1318E37F2D12E6BF1D1ABC86F56B0@DB5PR04MB1318.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1318;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1318;
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(39380400002)(189003)(199004)(97736004)(86362001)(478600001)(52116002)(26005)(8676002)(4326008)(81166006)(486006)(316002)(81156014)(2906002)(8936002)(476003)(3846002)(1857600001)(50226002)(50466002)(25786009)(7736002)(36756003)(305945005)(47776003)(956004)(5660300001)(6486002)(59450400001)(6116002)(105586002)(106356001)(2616005)(6512007)(6666003)(16586007)(68736007)(386003)(6506007)(16526019)(53936002)(66066001)(186003)(48376002)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1318;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1318;23:M/k1PTi+xuV/y4+YECXFanksxhyUAe2gz4sL+fh3M?=
 =?us-ascii?Q?gCjRmggZ7j17Wm7NNTjeMofPrK9l7iEhOFItV+nsbwZVlCw6jLYeB07vQov4?=
 =?us-ascii?Q?TmV4PzVcjZHKQQW21P5f27VirKxEUpMJXs6JhdiwlUsQseb184DQ5cB7Vy+1?=
 =?us-ascii?Q?4corakhXpE0149tiqFUrnnXc39rktSe+AsdaS9EiWHROEYpJ/OrtoMJA11Uw?=
 =?us-ascii?Q?ulnfyocATnvfictCGVTt1Wq1BqnsUss6BKo9+AOMo45dnjjVrHQWvgYSjYkI?=
 =?us-ascii?Q?XCtZJ4a3k1RwRv9fDmHctLSLn9nRRyjKtGJmF5LJ1+uS4+GZRPUieFyWYljM?=
 =?us-ascii?Q?4yWwYPjhqZXyD8jvx5hiQ67XeTknxrydqlkmaWXaciTdangdD8JzxUO13ee9?=
 =?us-ascii?Q?LsqBCnsPk1NBZHFNZ8AjVNZffoW1slyjr/T/15OUR0KI6MKgCx5AGWwtxFmz?=
 =?us-ascii?Q?VPXhQ30jgEnVaGZZ1JRmGIAAE6985SFT562i1uYfXHs2mRLmQN7QvM84YhOJ?=
 =?us-ascii?Q?wpiovHd8hnPM2Hzxc+v41fbpMihzkSeLzCLEwqSfDhcutMkfgu5PAKXxVE2o?=
 =?us-ascii?Q?bVCP7BZf5bL4vETpM8JYFrFdEujOVS49zI5/2+ON0hGqUYyAOyx1Gku4R0kh?=
 =?us-ascii?Q?z2nupIDLpwfEIZjmmYW9zjsAePwODwBXRyg4t3bsBkxXA/Wz3BI2oA12VEMw?=
 =?us-ascii?Q?GszzXhNPHwXWy7j2d5bg0MUiWF3NB8jTyg/9FGHdg82hSZWQoFgjpUdNgXQk?=
 =?us-ascii?Q?OJXe9SCfUNmg7Pt4Fvuuwn164ngYNpmE28NeeYFvuB5+gM5MVF77z8Ha/G4z?=
 =?us-ascii?Q?ThILFwieIs+Li45IKza4TCdsVJ5MBoCU85jymGKKUgWNci0krd0YhXXrWlbh?=
 =?us-ascii?Q?s4Txbo9N5SIrLVhX5RR14FyH+Ly0L/5V61fm1sdsdkY+1Y+glybefiKU9mvL?=
 =?us-ascii?Q?AwlRrAS63Tx4SSoUVjemgRU+GBN1MvLPIf72CM9baqkS9K04XkiBqOehoxd/?=
 =?us-ascii?Q?zx2gmuQuz7H9fZllYrDvQcfdH8/zbJ+IrjTnWXpDkdbFKEPnofYI87v26S7H?=
 =?us-ascii?Q?s8i+WGiEL7gbF6iCFLNQpAIbA5b05VQhrQz4iBkw8WemsPofg9sRcWMsFSe5?=
 =?us-ascii?Q?dEvlAEh6oAC6pB0+ZtO+eKduKajqU5+p9ch6d2aX677692/7mxevQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5lypHsOpJtA9wCeXEwUXuIUfCwSFyidiOMTHTL2OZCCYRKnbf5oDKvReEIH5iiiDOeOUmeCOMLJ8mfqvsn0F1BHe82lmTbmPjbtQMT8JkeYZPQR6iIvaxAYVmZ68pKix/3I4rjWo4EukTnyk2c6CLRYdwLgz8rNJKumY2LrCb3y/sH4lH8C5Eyca9scEibRK
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;6:bgz9wxlurSrYX6EjFwXbvCqVObW1vvsJ3rs9L3L7cMO9OfhYsKLULDBbtmmsbntIGg4TDSUfTfFHZXVW3BW9udGe2+czuXMwKLJDoXgeqTE4FOFnKb8B7N2PmvwJeh5ZZgVfyXQIuSmnocUhQfkmwqqVwfOwlmOK9+MIIokvdZJIapZBJQnz+N5InK2k6Zemwkl/x+KDrMe4/A4miRPgkISuquTnsp1H/D5vaqgH9fRRfZuZe5GwppuXb1V2H5zAsomBgGK4ae1rQUVi0oJpRRxWMXbU+YVLlxbh/j+DT7Kvt8r1F6AiS/geZTqQYIG8Z0ZpUFRvqh85IJV8ij3bkGywSWEKN9SxpdbMKOhhybhNtEZ8zbcZC8KqQZ3o3DEwAZnjNZxn+1qC8mwS7P+UXdAXnjZZS1WqDao2xoQs+NMQL+RYq6eKp0m2VjOgBin8dXNNYf5/qtSk6Amz8XcE0Q==;5:xPAN6FZ5tcstraTe0FTEHvsc4CaM0IpznUPp43QpQOd4mapRCeU29Gn5yfSuNi2mYlAS3uNsa8tnfq+KvgD/gJMd/KYrZ2np3sAAXIRuSjI8lHWZOajmyw35NqKvp3ObPXnj1b1VGmqQfhtbvyb6faLIY8s0P2G+bw+0ANkIHe0=;24:6vNmgSLFsWMY5o47OrchydCuynQkS0B2rzzbhSdElP9zRy3MuqCUajULQqc5qk9CGC8ENA2liFeyX9KQ9GUQhVqUpTTZ7udrqZe+0Wsv2bI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;7:uqE2aD3E8LrBTm/VHDDUdAIJ7zwiIw8sCspc4r9klpyHxfqtTOiwHlVUU6RS+OmjfUwaLK729+QLalSREPaQgL+uq/JW5EwsG+Lpl/wmXh9D80x2zxMhXLbT6Y7ymErmUVzNX4Ny373BVT4WEZbBHzGsGFsTsCZ6mfTgy+tQ2Xeumxj+c6uMadHC9mQy03Y5Dd4J2OxZkX1bo3XkOjwup/HEDa/uI/DZ+JzQFN338KiOr2a7Ee0iznykN/kl0YB/
X-MS-Office365-Filtering-Correlation-Id: 1eb8c31f-93b9-4e07-bd7f-08d5c0762b68
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 06:26:48.7407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb8c31f-93b9-4e07-bd7f-08d5c0762b68
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1318
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPC is in always-on domain, it never lost its
content during suspend/resume, so no need to
do save/restore for it during suspend/resume.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 41 -----------------------------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 4760307..e6025d9 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -28,46 +28,6 @@ struct gpcv2_irqchip_data {
 
 static struct gpcv2_irqchip_data *imx_gpcv2_instance;
 
-static int gpcv2_wakeup_source_save(void)
-{
-	struct gpcv2_irqchip_data *cd;
-	void __iomem *reg;
-	int i;
-
-	cd = imx_gpcv2_instance;
-	if (!cd)
-		return 0;
-
-	for (i = 0; i < IMR_NUM; i++) {
-		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
-		cd->saved_irq_mask[i] = readl_relaxed(reg);
-		writel_relaxed(cd->wakeup_sources[i], reg);
-	}
-
-	return 0;
-}
-
-static void gpcv2_wakeup_source_restore(void)
-{
-	struct gpcv2_irqchip_data *cd;
-	void __iomem *reg;
-	int i;
-
-	cd = imx_gpcv2_instance;
-	if (!cd)
-		return;
-
-	for (i = 0; i < IMR_NUM; i++) {
-		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
-		writel_relaxed(cd->saved_irq_mask[i], reg);
-	}
-}
-
-static struct syscore_ops imx_gpcv2_syscore_ops = {
-	.suspend	= gpcv2_wakeup_source_save,
-	.resume		= gpcv2_wakeup_source_restore,
-};
-
 static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct gpcv2_irqchip_data *cd = d->chip_data;
@@ -252,7 +212,6 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 	writel_relaxed(~0x1, cd->gpc_base + cd->cpu2wakeup);
 
 	imx_gpcv2_instance = cd;
-	register_syscore_ops(&imx_gpcv2_syscore_ops);
 
 	/*
 	 * Clear the OF_POPULATED flag set in of_irq_init so that
-- 
2.7.4
