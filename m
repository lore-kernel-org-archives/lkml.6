Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbeEUKK1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:10:27 -0400
Received: from mail-ve1eur01on0079.outbound.protection.outlook.com ([104.47.1.79]:8160
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751111AbeEUKKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:10:22 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: linus.walleij@linaro.org
Cc: Linux-imx@nxp.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: mxc: add clock operation
Date: Mon, 21 May 2018 18:06:30 +0800
Message-Id: <1526897190-28714-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0197.apcprd02.prod.outlook.com
 (2603:1096:201:21::33) To HE1PR04MB1324.eurprd04.prod.outlook.com
 (2a01:111:e400:588a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1324;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;3:sMyF3+3iH4Z8pZi6+JG7jCvtZC5Xk7Q4chksK37B2KPwJnoL7zUx2+/n3LQoQvkpg84I7x153tpiw8PFcHLJ7IcFA6otEy1B812i6WK/OyROVHxNJeQs12dzWHFG0VWZiAfpldjZN5sRddkqBeo57W3LVBoRlC88aPhIn7Fy01YVauRPDy1f2PKz0pl6kEnXnMXjxj5Fk3+X7Yjjhkf0JrbETIIJH2d9YDKJXNnHE8P6avuxfXcLIyje/Jlh0k9Q;25:hvKvyAvuRI5jMekIBU8bnJzB1RmtAR4KDyPky0oERZvP5zbPx3lIFrU3Rjpq97LWJUGa5KmEsGIzXrFmJyUuNqUk64IYuNTtVX1OsLch1n+jxzV6w7xcajxxZ5caC1fkvK2nr9AZg2ddiwP+3qhEH4jqxgJ8BelYbZR7lauzasjNpfEW+sMvp3rkLgfZzuLMl7KAkuYeIkiMdS+RB9gJA4iOny+eUWfVgNkyFzUqUG9m0s3M3yMVCzNhiO16c3R5ZihImD1oRjb93wKOvNMWM5VmQU0mQJfBrE4Yv315thqc6c8ku2qqdnr7W4grUTF8kiM0UrSv0sLnpl2EK2qRdYQq5Ge52AR/AIcO3VknVsM=;31:atDUaqjrVGY4x2C5aQmv+Yj72MhivEHKccpCHqNG/VHFKPsfN6EZ+IH/7uEADwI5boCQS+4EIYqsyYvsy/7nYEetX9Fcl6jqBf2nYeazcVUX2Qy9ROzgt2iEf0u3GP95nwL6ZsOnSvtTyotDBaVXcyLhHqjWrls3fHV5KfxQTuvyxEo825XGDotOfrcDyVwDfFj2wKk9iiX/uhX78GIFmHrutL5gaKWdiJgix6ock+U=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1324:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;20:/qYimyHWeZ9JhAQjceJHEcHoA7y7II/6NdHWJk+WB+NmDHMsTpsdD0nOiT9mxkLeWxZ4OlvWm9Ho9WSukG3DAiQGmOaa4DHhZv915Sia9w6YC0AZEXT4jt88q0AnSi9LoWXvo+9APw9PgEmcfctWiwUD2DRFuWM5und6iqZ+NIdaP7LdBeiIFvNtEM0FjpXajjLqRmMMa99qPLg7G6GzpFHsY9otQLVEEjtYGcfTxFXgIcCKW9udEIT3JejmE96OfF0R/kbQjVF8uk9gXp+H0woyC5CZMrrLty9/U2yBqdYhaOAi3wLo67+NIiBt2y+26OgOBzTak51w4cyrg3z//7918nuraggPeaI/HHInEbJDhw5u8lBk5UFSkb8wXmaROSbaOP68kXCLDdgGV1tpiZRlhNPwS/sH/WwutF0yvuIy63aNGVmu+AA9PxPeZiygXnW0WhWiLhtIF+KVh65x6P8CYdM06hXzt4mtQfQuFYQoHHAqqkjmhMiAQhqRg1bW;4:czROYiFOyN3jeLBiU0xDdmw7ZXMpFcALPJY4Hl49O9XWfBg7E0O1UQ4GLXjejCj+LYZ5iwPme2cZEI60FL9qFrqEDsuy3Ii/XTP5zDiUc21lGbnEY4aN8IwmfzBkdTgUuiXtkYzLHyPvniDB7QIjd90YPuTAqOqt9IXVlzCxciYolCaJEDJKXWC7Kz9a04ytFy1iWsoUam0v/NGKuwQduExvMYy5jWBxyzg+Vv6m/i5gxe/TbfGDlOGV5qgKFikVtWN3b3xXbGtBCHoJwRoTLzAFGaRMnPPfcOxSLwA97dL4UDOEuY3PzMHd8akOhtcM
X-Microsoft-Antispam-PRVS: <HE1PR04MB132495193395F8843C439D04F5950@HE1PR04MB1324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1324;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1324;
X-Forefront-PRVS: 06793E740F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(39380400002)(396003)(199004)(189003)(6666003)(50226002)(6916009)(316002)(106356001)(16586007)(305945005)(2361001)(7736002)(105586002)(2351001)(478600001)(6512007)(4326008)(52116002)(8936002)(51416003)(81166006)(53936002)(81156014)(8676002)(47776003)(5660300001)(2906002)(66066001)(36756003)(50466002)(6486002)(1857600001)(86362001)(6506007)(386003)(2616005)(956004)(3846002)(16526019)(186003)(6116002)(486006)(48376002)(68736007)(97736004)(476003)(25786009)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1324;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1324;23:JiqMvC/iAQSCRNXlEudx4nlKlsPNSVVXUgLrDjGPF?=
 =?us-ascii?Q?bFjD7hP/tWFBEmieFkGo7vW7sKR+bRvwPaewpkIa4f+TN92VIR3trzhN5Ug5?=
 =?us-ascii?Q?klcid2Qi9rQJAH4oPW1qtvdCEsJgjBTXKRiztZT3+/91r5HhsUJlJjY7O88q?=
 =?us-ascii?Q?QhmPl0Puxbwi9FJ9zZgHZOribXx2yu3kv182rCGNMx5MagCmD3o9FrmTC+Gp?=
 =?us-ascii?Q?tG7POcSFC7LSBN5stDzPHXcb25O5NoSrlW8J2BWhH7qIB994I3CrBYRqd/vO?=
 =?us-ascii?Q?Im/wkEjb0sio4f6iQS4yADlAKZpQpwudxRpm40PCzArmTk67ec3i23O4ScJ1?=
 =?us-ascii?Q?5Ka/qYssMRuLOxO7d5X2jTP5gBlfdll9Djt6kR0wsjNxxsXMjz1qVx3bHK4l?=
 =?us-ascii?Q?8ciw/G4vccRmUmCzAF9CoxrAsuBx9l94TI5mcuQakJHIUcuYLh3cw4qRf7Sg?=
 =?us-ascii?Q?T9P4an6SxIR7D8aU76R6n59t+knECVffQOeRqCeQWaVheXMnAZZhVdDuYKaN?=
 =?us-ascii?Q?Is89UaRWl4tWy1o+h9OvKmMVOu9iZ2ySpBNhF5z27+nf81+1ABeQIVZfj0Ks?=
 =?us-ascii?Q?D6W3ve12PshhqnaWiAt/B0RjXmzYgKJ9eM91Q0qC/tyeEPcFpCsFuc3ai3gn?=
 =?us-ascii?Q?rLCPb2j94/D/BvvPbkyx8Cs3bkEOZrpeochASrsAzbt3UoguNPfjv46zmdbd?=
 =?us-ascii?Q?lMORj064PElyDIt2Jg6XeAGoX7piztQbDpSpZ31q27HNafqxnwA8EdBSnEfE?=
 =?us-ascii?Q?TPLkDaUkxeQdd4Xp+2zM+lpJ/Om9N2noi8/TT/t/Knw8iKjpi4xc3lZrHl5X?=
 =?us-ascii?Q?+rIEmKPD7surQNObCqAemxM9Ho5tZAr/gzuwrdn/f57bCRZDqNuIJaAnvzwo?=
 =?us-ascii?Q?VpGCAk1yObWcJj3+rzR/FWnA04/FuO1pRtYByYQgBmE8OGxW4mldHTx3vj7+?=
 =?us-ascii?Q?9RE/gWbZadVjK0GuA8wA5t9DSEJt+RtsB8+y0w2xhcLAmpCHCMKn5ltySr0M?=
 =?us-ascii?Q?q1/PVWmW0i2xUYkmkXt3pTK64UgpRTI4ueokdfu5AKk161ZT9gmB72naZJeM?=
 =?us-ascii?Q?FtDvb5aG8BSNaXrDnPFfUicCRFfmfb+H8pQOqNEUIDGj5Gd5fp8v51D0Kzr1?=
 =?us-ascii?Q?0DCHdZgoSpn+NA6Y/O7vIQB0UGQLbIMBvF/a2UDUwdIyBcN1l2lCIz/hTx3i?=
 =?us-ascii?Q?JjMGwiTgXgyks8=3D?=
X-Microsoft-Antispam-Message-Info: SufFW0+CUdHuPPWoQUhUboEx6htYaetV/U9UHo7poGOTwkOhN4nnjJu1DKVSU4ERNQ9o09Ke0dZK+fKnnMayeWNS6jhj2SCu9crwsKaQOuu2x9HD3adh+4P3UP5LK3kCeoavexsyPnC/ktx3eewKdoSesz9UhiNJLA6QHtcbIqc/os/I1DfMXRFKi+jMl5oX
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;6:xxE8ae+ecNIeBlmQ6mx5NfLZRHrqf/jQeG69wV6sVU6I67KRCrl9fYcSsRLBBaHH0xA1JGcrTk0IbLrDZPsEDNpLA3DL92WURNyhhEvfsvmGUjaWhmHAqU7ZRLLvmXvi76QIOGaewybGmthTTRQRw4wzpSTgOw52cwn13MONvCfInC2tvxZT/vfiNuNHBb3TW2vVFfEykOy4RXbHTBjtuFkCv2cfDtjADCOfg29lxRgJ5lDUWYhe/bTNXlOOhA+RVIrg9mMxGkalcdgeKKAaziQ92EWh5xBMlnRnv7RR8PsRUkvTQ0vCAeBiNn61AttNbN5g4LbBNHpCaCUiJ21B8jTOwKAlxXE9wdyfZ9Jg2F6/XZJyFRVWGUxf5Vd8t0o9WYIiBa4R4eAlybPaJHk723ER21lSZ87hbLgXz3483xJu1odglpqZzfIY19gsUE8oY1Q1iGLrg28Z4LCoirM03w==;5:apeB8nCYz/i6AKvLulmhVOJ326sYVAEHNe08JotXJIhJjXcUSoZUGrd1UsoZIn+28WeNUK3kaW2wjPadYBZet3fd0sbCcElqhSmAfPAhjYXodGDr3oKe5OTavj4r2tUUIuit5VYTc1FF8MBq997QHYG7w9XH159acF2rOOqSaik=;24:skTUbY2Xh+8Bg0X3LFOgw/IpFpbl8tIUQO+K7V9THXUQfeZegY6Q+C/6B+0JYXK9Trq1FbdVC8rQuVKreV3SyKKIf74ayGpocZxT84AeANo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;7:HrWtRaUwQ29weAKgEC6CXkTez+6R3BMrooweaduqdirryiL4TMRMZZng4GTahSCuJT03gkgsrjtPtPLm4Q2sOWWCqneTKZ5DckqicDrjVCRpQbOVtsei+E++5dQJZENGXZZjeJJhw84AFAwoyLiPzhFfNzo6yF0Zl0YVPm3uYgSTjKK7FgMXLddqT+oI1Vex/bS6RF6bMPDAMVELT6KOB3KqPbH9StQg4Nno/xwNp8J/TjxzdrDACxGj36FvQhA3
X-MS-Office365-Filtering-Correlation-Id: 0df6057e-4fc3-4612-d197-08d5bf030a7d
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2018 10:10:10.6023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df6057e-4fc3-4612-d197-08d5bf030a7d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1324
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SLL has GPIO clock gates in CCM CCGR, need
to enable them before accessing registers, add
optional clock operation for GPIO driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/gpio/gpio-mxc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 11ec722..8fc37c4 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -60,6 +60,7 @@ struct mxc_gpio_hwdata {
 struct mxc_gpio_port {
 	struct list_head node;
 	void __iomem *base;
+	struct clk *clk;
 	int irq;
 	int irq_high;
 	struct irq_domain *domain;
@@ -434,6 +435,17 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 	if (port->irq < 0)
 		return port->irq;
 
+	/* the controller clock is optional */
+	port->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(port->clk))
+		port->clk = NULL;
+
+	err = clk_prepare_enable(port->clk);
+	if (err) {
+		dev_err(&pdev->dev, "Unable to enable clock.\n");
+		return err;
+	}
+
 	/* disable the interrupt and clear the status */
 	writel(0, port->base + GPIO_IMR);
 	writel(~0, port->base + GPIO_ISR);
@@ -502,6 +514,7 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 out_irqdomain_remove:
 	irq_domain_remove(port->domain);
 out_bgio:
+	clk_disable_unprepare(port->clk);
 	dev_info(&pdev->dev, "%s failed with errno %d\n", __func__, err);
 	return err;
 }
-- 
2.7.4
