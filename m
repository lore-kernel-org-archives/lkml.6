Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753444AbeE1GQ7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:16:59 -0400
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:35774
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753293AbeE1GQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:16:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: Linux-imx@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH V2] irqchip: gpcv2: remove unnecessary functions
Date: Mon, 28 May 2018 14:13:19 +0800
Message-Id: <1527487999-29768-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To DB5PR04MB1318.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1318;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;3:pdUk0atbPNZ+kidVcfUhbTMul767vZtZpF2UwSa1ZYNpSENU0I+0zzTncFSFr43Y62x9RaCnf1fjGJSgu1II0qW00qfX+QT58/zcrmTjYilU894oWBUE3Vajr87FvwP/z0knd9NfkDTZquFjGmFurvTubOjT8lxo9SRL9++T5T8XvVSncJrvNJhKO7nns6QccbEfzqhM9+irnRBTxGR1Kc4U0cYdj2A99im57m3R0JgC6ybqNZAsBwvQYLQoPyFg;25:8rIvOdrRsCc57jo4quEepAfU1d/9N2mv+4Xt8vJHEOaXmwfuwUZfcT99aZgGfalx/QpUtwg0oqgVh/xpg38kvpv1C3RCpRoZ0Ah7fcC3ZYeaLvK0mrFJXbDKs1Go5KM8d/EF8II69ZytoTTMY6Dx0nugIeNjUWOvB1ITLPJyxxGrTKz5lVWF9dfzQr9b5/hxsAnGI3Zy1e7+sWXWipWJObxzVYpplvOxxUC+DtrvkAYAGzPcUsV0H+UlCKu4J2I5mYjAHDDjPwzByjeJhHKXkTvd9Fw3FlKeXWm0fVbj4oworjHyUT28jGEXXa6ww7wEGGu+GW1brCog5h0sXpu67Q==;31:M+AJLwDmhwXRAEhMNoYxYbis6/b0u/jGiUOmEOTVDDNt260YYk5H33XS/B0ynthDt/Ul2t8E8EOR7BxvbeqktzxO2gCZk0pGnyZSG8SOLgZKX/5Of5BJ/xriA7BHBsVBzeAOjMwDcTErLA0/xjalfDOqMEIeBSKcpvo1wKwMvwG+tKrUCQ/mtbF4r1VTGQuB3SMJEE9ACUGow5/omHHsykydHri/D1GTHDsNs5MRXuM=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1318:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;20:iSuoKKfA1DVYm3iQl4EkGmr9FnYvvanVoPaLYjZMyC7dS48CSgkva9tmT3fuqz+kv6TmZ8794h7LbmbTv4mLXvDJYeejXmqw9k7QCkiY1G5MyhHwX48iMY3ooFIF6zBhhdyAJ13xXuJCOVNkG2Q6VZdd8hyz6AnQewyqb9cv/l2gpa9fNiunBqp/AAFBcdhnW33wL3rmPHGlyaxNWt39x/CAKwqCCwhLjPyuUMb8OhBiHbEAtJQZitVbDXSuJB/dHKvDynNQKXG3aRGXojHfyy3opaO6URgzz48wwPACYF61bkkc8/2qpc48pll4fw5FQ9DdXocj07kYPOK1V3J43svh9JSjI9CW746KePeiJL5Y7drBctpFOdisc/xnpru+2a4WQhrLHEDig9gMDtfAQoxMKkhsEKcqsVKNwXDN2JaXeFG8Tsgk4KCRbRsKh8REJ1tHgJmTo6bI6avuUty1w63lhuLsCmwaI2Es02+qfNEXkZ1azfRNLWUqXGahzs7n;4:IBX8Aqp9F04FXncvFmDAT2j2ny5WID6KlbTuup95ZgZ9BDqI/i8sZPBBErwzRJwEr7/+mKVxN+JiV4MokDR52/VHQGoA4Ad0rFerw32UeHxqG6qHirZuIljUbSl+BHMwN+UuARABm6qZMmySlqtCV+NCd8RovpC5OzzZ4aeBZD1n0oliZQGREuyGahQ0chzgRtzr4vhftJNh4Sgl29ICutnXq9ALpJq1C6muJW60MSHvCs1R2FokzQGHoZKDgacyaXW2oGUIS4y+AQ4WvoDc8vzSiedLbwAYBQgwF0TRDjgZAT6wfOj1fgPqyzKoLEVF
X-Microsoft-Antispam-PRVS: <DB5PR04MB131819B74881D91106B35DD2F56E0@DB5PR04MB1318.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1318;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1318;
X-Forefront-PRVS: 06860EDC7B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(346002)(396003)(39380400002)(189003)(199004)(4326008)(106356001)(8936002)(105586002)(47776003)(25786009)(50226002)(52116002)(51416003)(68736007)(305945005)(81166006)(81156014)(3846002)(6116002)(66066001)(186003)(16526019)(48376002)(50466002)(316002)(478600001)(486006)(6506007)(97736004)(6486002)(2906002)(7736002)(8676002)(16586007)(36756003)(956004)(386003)(26005)(2616005)(86362001)(5660300001)(59450400001)(476003)(6512007)(53936002)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1318;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1318;23:qdHBES4ek/upOBW9WBOWvIVSPJJLXK88q3mFW3s6W?=
 =?us-ascii?Q?CEoGcnaa+PSuCxb9tGvmYzoiVDjgFHP+gp0WaQQyvZYDXDif7PK8Ui2XvFfX?=
 =?us-ascii?Q?QxJjyxOAz5x9uaPMDiWzfia+dDtMzuBULDCyr2oEg0a8btkiH8cki1gzOXMZ?=
 =?us-ascii?Q?awVea4Dg32VrgVGm4BBM/cAvdTQejl/jr9lirNKShk/WoHkcBphzY7256C8x?=
 =?us-ascii?Q?+m2iaiCA7B/ZX7Hmrb6qJ3VJL4mK6zlPb6RC3AmY771/0jAHqVbkpYYEVJL4?=
 =?us-ascii?Q?GdRlBjqA9FjBWuSKHwljNt7DNG5ne3D4ZZtZT1Ak7kItq3Msvfyhr1zvKslt?=
 =?us-ascii?Q?suiFKo6hkoZmb/kbBwR7ufMgy++dPejZncfHfLbyOyW9iZ6h4k093CiebTN/?=
 =?us-ascii?Q?82cSndV5Wigvhw2V4jwfhg8oU50ThxrRVbFYJP1Bzs3lxlBb3i7AAg1OFQ2v?=
 =?us-ascii?Q?wjpuFb7ZCs0jHi4PQUw+vs1N8S6Y9qy+ctJvb7xwTZLdQ3Ls5g2Yvcpu1Vsg?=
 =?us-ascii?Q?mA1+HJIeYSrtIeTVUrel07lvb+gygXDIe/UEAfC/oT5zmi/Pi3mdX/6p00Ia?=
 =?us-ascii?Q?GdA2D7X/dCxuw/e46q296faxKWaUCBc09aB+dCbk85GssZdMVFx2GllNtbZU?=
 =?us-ascii?Q?vAW5DuCy3V8PcH+olcVBx7rhv4WpP0M1nD/0VEkfZY06WDoqJVJ+8BaQ6VTR?=
 =?us-ascii?Q?54xK7McbcV6xvC+WkjxPisFDJVca4/u3WurPOaTuIcNRc5323AXB1ElsZ3QX?=
 =?us-ascii?Q?s9jqH2Ia3xbmVzABT0OLyjuXyojjS6jFGFUeoa4i7M58TrP7crLmTFf12seb?=
 =?us-ascii?Q?Xc2HJDceYNY5/Qh5OXfRaOj2DkCcfAym/KOz3ZPutdE+YBURj4h+c8jiAsPi?=
 =?us-ascii?Q?RfW0U+SS4WjhiZNzTLMEUpzDnHFMulP67BnVa1OrMluTUQ8W5DO2vJVtofoS?=
 =?us-ascii?Q?7pEMjeIAsoW64yjvesIqoT+B4Hm9vK3AMEzlsPg/kVyu9kXTyqGqB6ibSmGS?=
 =?us-ascii?Q?Tnncu1HmrXV8r05HPjKmnTo5TYk+qM7ki32tjKv8ZNI+ldwRvQdCdb1iClq/?=
 =?us-ascii?Q?90Kzi/oEbRz+3JV6hVSXtXmFQnZzRj/SrVo7/57s7Q+s1DNNJMUj+ZtT0kE+?=
 =?us-ascii?Q?jaXnnlWKIA=3D?=
X-Microsoft-Antispam-Message-Info: j6pmn4QpdPZTzdY5JxgztXuqbv4FsN9ElxiJ7hlQSopAR1LeSPbkuxdb0kJOUaJKSTXezVC7Ccj09wJnra6sV9kUA2RmKyUytHdYAVkx1yFKNyxeS+JDwn/N+GaxiXNR1UohhuJeS6Rixv7gOlnYnJFGWanbw0I5XOMinzixTrFDoobMzqhTZNcUZsm322A1
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;6:3Dgh6FEFxuzKkzFHhKqWj//hVrPHv4os0tR0a+oZ4XChnWDHbn7EWZMTjvsMMIBpQeA7F8kAA+zehH6AnuPKu1AcW0G/WhWrD502ejLHuaWWEwL/VzHeIAeIhgTSWpYO0VNUHxAMmoQ+X+5Eu0irC5Adn/9ZxNlFbW3BF0qVx20dunIDBqTdGL+aNpcpQe19Eu49GN/l6skm+h2inh91mdGCpwuM7CRJlujz1EJWyabPKFJQ/TAumCExiPChv4sfmIKD7PDtGgUcahNOse18v03oyNMpR4DTz9fFY6VWev1BjUDht/rvCQ7+yn/WB4h6kBLK8jYQXRGxQi4VepxmNt/o+yr0zfayQO0eXKuQXUlVT9RB4SZBcco8OXikEU9fqnRTw4piagxz2l2NtKjtH9osFTXYSBOQmqzQ9DRt67Sap5S95O+5NikFFGKMbB5/mpiXY6u26bgmZVB6g6lJyQ==;5:+Uiz+exxBqQ2iAuGf21csaOAJEjmLFjzJW2Dja3eSxRAH4nGO3Z3tSX+lhD5Pnoc6yZkQ6PWF3Z/oc+tTMPSbqJLV8BmKsfsecCB1ZcuYg+Kli3xP/PXwdHeB1Z5OUdBtvu56luwBprU+Ygs96DgBbpWFyRly7gUTVGs7DhGzw8=;24:082UsORS05vdlEd5nrIgEPi89Isv4WzEBJKlDjwo8ljLH4x+vhPLv7KjuULIg97o2WpOHUnfY4V7y2qNHyttVRVxhEGlK+kVuV3Uj8kWxg4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;7:67jX+UZP6pEt0q27IMT2wDiYFzoSrPXbLQJH16fEJIXGZfDUJtKSnbM5GG3wlp7UxN741tYBTb5S+OUs2VQcjdNT8JvvFzu5XqPgltpokAUjBLttGYQJoFA8LKyL7WKvHFwD9wmYAwiD8S3vGaB7E/Jt493fwAV9DY8KAZlnnQe22MRQEG59st3tp9d/sQV6B2ueaISCzQ/wzhZpOucwq5t/6KB8pjuPZ3QlCrkdNtsVNW6ofCe+lRM/Wib/G9qB
X-MS-Office365-Filtering-Correlation-Id: e99efd42-4e61-4e71-7bf3-08d5c462981f
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2018 06:16:45.9425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e99efd42-4e61-4e71-7bf3-08d5c462981f
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
changes since V1:
	Add missing wakeup source write into GPC IMR register;
	remove all necessary arrays;
	suspend/resume tested passed with u-boot I develop for suspend/resume support.
 drivers/irqchip/irq-imx-gpcv2.c | 50 +++--------------------------------------
 1 file changed, 3 insertions(+), 47 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 4760307..6bb6ba0 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -21,53 +21,11 @@
 struct gpcv2_irqchip_data {
 	struct raw_spinlock	rlock;
 	void __iomem		*gpc_base;
-	u32			wakeup_sources[IMR_NUM];
-	u32			saved_irq_mask[IMR_NUM];
 	u32			cpu2wakeup;
 };
 
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
@@ -79,9 +37,9 @@ static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)
 	raw_spin_lock_irqsave(&cd->rlock, flags);
 	reg = cd->gpc_base + cd->cpu2wakeup + idx * 4;
 	mask = 1 << d->hwirq % 32;
-	val = cd->wakeup_sources[idx];
-
-	cd->wakeup_sources[idx] = on ? (val & ~mask) : (val | mask);
+	val = readl_relaxed(reg);
+	val = on ? (val & ~mask) : (val | mask);
+	writel_relaxed(val, reg);
 	raw_spin_unlock_irqrestore(&cd->rlock, flags);
 
 	/*
@@ -238,7 +196,6 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 	for (i = 0; i < IMR_NUM; i++) {
 		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE0 + i * 4);
 		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE1 + i * 4);
-		cd->wakeup_sources[i] = ~0;
 	}
 
 	/* Let CORE0 as the default CPU to wake up by GPC */
@@ -252,7 +209,6 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 	writel_relaxed(~0x1, cd->gpc_base + cd->cpu2wakeup);
 
 	imx_gpcv2_instance = cd;
-	register_syscore_ops(&imx_gpcv2_syscore_ops);
 
 	/*
 	 * Clear the OF_POPULATED flag set in of_irq_init so that
-- 
2.7.4
