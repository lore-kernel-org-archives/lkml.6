Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C9CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9B620C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hVUUxusI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfBTLky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:40:54 -0500
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:56108
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727136AbfBTLkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d05lR3NTuVTq3uNuMBJwqYC0/xFoppKgvi3jTd3/L0=;
 b=hVUUxusIGebqnZOo/AyvEStah1tDaKe1fPxaI0br38a+btX6zJ5SLIuDQ8E+5RnraZ3nVwlMz064b7/2WZ3NpsJkYHxB92iSok3sBGxoiCrpF5poqJJnQ5EMH/qdZ1c+m8t2HGFbpgxg3XoOSOuY9DOjvRq2LHGoOQndU7Yz1l4=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB6152.eurprd04.prod.outlook.com (20.179.6.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 11:40:47 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 11:40:47 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH V4 3/4] irq: imx-irqsteer: change to use reg_num instead of
 irq_group
Thread-Topic: [PATCH V4 3/4] irq: imx-irqsteer: change to use reg_num instead
 of irq_group
Thread-Index: AQHUyREf2RnhG/en0kyiwRnjFIZLUw==
Date:   Wed, 20 Feb 2019 11:40:47 +0000
Message-ID: <1550662447-8565-4-git-send-email-aisheng.dong@nxp.com>
References: <1550662447-8565-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1550662447-8565-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To AM6PR04MB4215.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e46c687f-f95a-45bd-3802-08d69728418b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6152;
x-ms-traffictypediagnostic: AM6PR04MB6152:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6152;23:uDR+Rp+O3xDv47zkj8RsX+D4wbBvokZU0VlItwo?=
 =?iso-8859-1?Q?iK8LHSkS71nTIjF8/XdyIFxVdom6F0p+qbnqghZG31NOCeChl4eWnZ1EGs?=
 =?iso-8859-1?Q?HseiEyg6w1q6vqrgIoj6U0qzFeY02BXNVbvoKARK+0xppn7HZ3CSRFsmEv?=
 =?iso-8859-1?Q?Ptt9+9eFNQi5txqAzOHTaIVyLvgohaGcEewLtuby9uFDFedp2cZwiEHF24?=
 =?iso-8859-1?Q?NHMDHMZQx0OArjQ5z1r8iDUBs+0jLyzZiO5JxFmrvbToRhQ0AdGwxGm6OL?=
 =?iso-8859-1?Q?VwEw5XUFz/7baOcoV4nWJMnVfQ6FYw0KouAoickZ35LgwAmzUndbhIGxUU?=
 =?iso-8859-1?Q?WnrNBuoSSyVHwbjdrobv/HvkkuGSDUuH92FiqqXjlWlWjkf6veiAIQ+zmY?=
 =?iso-8859-1?Q?ypMDIjcXGg0Mu0/KfCdaBpDWBmJiZ2ySA4O/qUKq64XTwKCKN/sLxSU429?=
 =?iso-8859-1?Q?YzZFD2qpiy64XrrkeoE1RNOpkbCr0fB1kHzOoBYZ+Z7wKE+VsjZRzUTn3n?=
 =?iso-8859-1?Q?W67kPU4B1F0fLeeBNaMFG7CCVEXtyZeC3g4veEN7SpLtBLZoIJ6vhzZDmS?=
 =?iso-8859-1?Q?jP5HhMXDnVeg0+hwqfmbgM7PWLsFzUIOmw8OopOJtqxBeJaCP01mN6ouEu?=
 =?iso-8859-1?Q?D5N0Zky9Y3sfkTFObjC8jIvTnr7ezFLu6tI0f/7SA2aVd8OF4Ay8Ra0vmZ?=
 =?iso-8859-1?Q?Ipsg7DYFkCE2aIKwT7/oXw18lkccEFDFhUMNSo1MXhL+BQnzhe9Ktxk587?=
 =?iso-8859-1?Q?9qWeZxFzHhv6qJQbXL7PkOf+brkIiUh2iFWQYDJF1FCH/Nav8mXUwYptIu?=
 =?iso-8859-1?Q?kcHAZdJUoAN8CyoIi9SfhOut7j/IJkybdhEbZMG6maHfv82k+9fKMNNFcl?=
 =?iso-8859-1?Q?4SjBDK1g9BHW2c4jsunDntQ5PmcRkSlCfVIhg5PlFF7gTVGKXPjAG+TQ5t?=
 =?iso-8859-1?Q?HJvDXy7JSKHKiYju3q/mT5paNRJsSXL4KD/bgVTPxNBqs4ICX1a68ZZrg/?=
 =?iso-8859-1?Q?NurOG/UqN44kl+NaYTsbh7Vums2ZaamV/xeg87AMT+/tmG0bh0us3H4LEn?=
 =?iso-8859-1?Q?hFKTzgp6gXmwEKYj99UqoYgmus9ySs7XepqMposQh77b9m/SMp5orx9yhK?=
 =?iso-8859-1?Q?wCGCeM2wbSKTxDfpF5BR7XGv+hB+gX33I7HDCBTZ0HktLzl6Rd+sWeZJAF?=
 =?iso-8859-1?Q?IAtez0p1OQYrLrm4EbBqylFpW//F7r5FuFlqYeI6lkvmmHkhISl1+huDMk?=
 =?iso-8859-1?Q?leRaoDlzghVSSxc89S0OC3o2OHgKNRLL2KVMGnjujrdupT1df30pnx8Qn0?=
 =?iso-8859-1?Q?myzBSQ+4akH0UutwTies/I80xMgjGNPdXvGoZO88OLrXA=3D=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB6152852A1759FA2E02C5E7E8807D0@AM6PR04MB6152.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(486006)(8676002)(97736004)(81156014)(11346002)(2616005)(446003)(36756003)(478600001)(81166006)(476003)(53936002)(316002)(4326008)(5640700003)(25786009)(50226002)(44832011)(52116002)(7736002)(305945005)(76176011)(186003)(26005)(2351001)(99286004)(106356001)(8936002)(105586002)(6512007)(14444005)(386003)(256004)(6506007)(2906002)(86362001)(6486002)(71200400001)(54906003)(102836004)(6916009)(6116002)(68736007)(66066001)(71190400001)(14454004)(6436002)(2501003)(3846002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6152;H:AM6PR04MB4215.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eEW13h8ND/RsCouhE9Eyq7PNCeC1jxvoWjoiBqCwfVHcXd8oPKqe0swRmV2KvJIemaJrEcvj4FfYTm11Sroj8gRyqPctmN9iX0A/U7ZHj0WzWSpo9BN/bTIcIaC45cOVGmey+8DjuQ+GnAOYksQHiqG2UVSeBowSzQol+kF66Y0HlH9BmpKbAQSduPCBmmzeD+sdJNCRoV0Z6zWTp5x911pzTaLL5ZSwGpdFJHNolnH9WTEe14bDFON3JEoS7J7/J1fO4f2ovTsEZCUylwJNtjsVd5WEw16U90JqMy+XXxNZrE7P0MbpXyPrWeD5NSorqmh63cu6YU6kDdXVE/vA9KNHqE4cgoX9OYc3S6eNuhZAwUOovYUmpybsUGKCXwi3E7EsZ1QPZWS7Wh+pa99VhHEXSmnSc/5/gy4XL5agpLg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46c687f-f95a-45bd-3802-08d69728418b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:40:44.1009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One group can manage 64 interrupts by using two registers (e.g. STATUS/SET)=
.
However, the integrated irqsteer may support only 32 interrupts which
needs only one register in a group. But the current driver assume there's
a mininum of two registers in a group which result in a wrong register map
for 32 interrupts per channel irqsteer. Let's use the reg_num caculated by
interrupts per channel instead of irq_group to cover this case.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v2->v4:
 * no changes
v1->v2:
 * The using of property name updated accordingly
---
 drivers/irqchip/irq-imx-irqsteer.c | 35 +++++++++++++++++++---------------=
-
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-i=
rqsteer.c
index 5b3f1d7..67ed862 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -13,7 +13,7 @@
 #include <linux/of_platform.h>
 #include <linux/spinlock.h>
=20
-#define CTRL_STRIDE_OFF(_t, _r)	(_t * 8 * _r)
+#define CTRL_STRIDE_OFF(_t, _r)	(_t * 4 * _r)
 #define CHANCTRL		0x0
 #define CHANMASK(n, t)		(CTRL_STRIDE_OFF(t, 0) + 0x4 * (n) + 0x4)
 #define CHANSET(n, t)		(CTRL_STRIDE_OFF(t, 1) + 0x4 * (n) + 0x4)
@@ -26,7 +26,7 @@ struct irqsteer_data {
 	struct clk		*ipg_clk;
 	int			irq;
 	raw_spinlock_t		lock;
-	int			irq_groups;
+	int			reg_num;
 	int			channel;
 	struct irq_domain	*domain;
 	u32			*saved_reg;
@@ -35,7 +35,7 @@ struct irqsteer_data {
 static int imx_irqsteer_get_reg_index(struct irqsteer_data *data,
 				      unsigned long irqnum)
 {
-	return (data->irq_groups * 2 - irqnum / 32 - 1);
+	return (data->reg_num - irqnum / 32 - 1);
 }
=20
 static void imx_irqsteer_irq_unmask(struct irq_data *d)
@@ -46,9 +46,9 @@ static void imx_irqsteer_irq_unmask(struct irq_data *d)
 	u32 val;
=20
 	raw_spin_lock_irqsave(&data->lock, flags);
-	val =3D readl_relaxed(data->regs + CHANMASK(idx, data->irq_groups));
+	val =3D readl_relaxed(data->regs + CHANMASK(idx, data->reg_num));
 	val |=3D BIT(d->hwirq % 32);
-	writel_relaxed(val, data->regs + CHANMASK(idx, data->irq_groups));
+	writel_relaxed(val, data->regs + CHANMASK(idx, data->reg_num));
 	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
=20
@@ -60,9 +60,9 @@ static void imx_irqsteer_irq_mask(struct irq_data *d)
 	u32 val;
=20
 	raw_spin_lock_irqsave(&data->lock, flags);
-	val =3D readl_relaxed(data->regs + CHANMASK(idx, data->irq_groups));
+	val =3D readl_relaxed(data->regs + CHANMASK(idx, data->reg_num));
 	val &=3D ~BIT(d->hwirq % 32);
-	writel_relaxed(val, data->regs + CHANMASK(idx, data->irq_groups));
+	writel_relaxed(val, data->regs + CHANMASK(idx, data->reg_num));
 	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
=20
@@ -94,13 +94,13 @@ static void imx_irqsteer_irq_handler(struct irq_desc *d=
esc)
=20
 	chained_irq_enter(irq_desc_get_chip(desc), desc);
=20
-	for (i =3D 0; i < data->irq_groups * 64; i +=3D 32) {
+	for (i =3D 0; i < data->reg_num * 32; i +=3D 32) {
 		int idx =3D imx_irqsteer_get_reg_index(data, i);
 		unsigned long irqmap;
 		int pos, virq;
=20
 		irqmap =3D readl_relaxed(data->regs +
-				       CHANSTATUS(idx, data->irq_groups));
+				       CHANSTATUS(idx, data->reg_num));
=20
 		for_each_set_bit(pos, &irqmap, 32) {
 			virq =3D irq_find_mapping(data->domain, pos + i);
@@ -146,12 +146,15 @@ static int imx_irqsteer_probe(struct platform_device =
*pdev)
=20
 	raw_spin_lock_init(&data->lock);
=20
-	of_property_read_u32(np, "fsl,irq-groups", &data->irq_groups);
+	of_property_read_u32(np, "fsl,num-irqs", &data->reg_num);
 	of_property_read_u32(np, "fsl,channel", &data->channel);
=20
+	/* one register bit map represents 32 input interrupts */
+	data->reg_num /=3D 32;
+
 	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
 		data->saved_reg =3D devm_kzalloc(&pdev->dev,
-					sizeof(u32) * data->irq_groups * 2,
+					sizeof(u32) * data->reg_num,
 					GFP_KERNEL);
 		if (!data->saved_reg)
 			return -ENOMEM;
@@ -166,7 +169,7 @@ static int imx_irqsteer_probe(struct platform_device *p=
dev)
 	/* steer all IRQs into configured channel */
 	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
=20
-	data->domain =3D irq_domain_add_linear(np, data->irq_groups * 64,
+	data->domain =3D irq_domain_add_linear(np, data->reg_num * 32,
 					     &imx_irqsteer_domain_ops, data);
 	if (!data->domain) {
 		dev_err(&pdev->dev, "failed to create IRQ domain\n");
@@ -199,9 +202,9 @@ static void imx_irqsteer_save_regs(struct irqsteer_data=
 *data)
 {
 	int i;
=20
-	for (i =3D 0; i < data->irq_groups * 2; i++)
+	for (i =3D 0; i < data->reg_num; i++)
 		data->saved_reg[i] =3D readl_relaxed(data->regs +
-						CHANMASK(i, data->irq_groups));
+						CHANMASK(i, data->reg_num));
 }
=20
 static void imx_irqsteer_restore_regs(struct irqsteer_data *data)
@@ -209,9 +212,9 @@ static void imx_irqsteer_restore_regs(struct irqsteer_d=
ata *data)
 	int i;
=20
 	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
-	for (i =3D 0; i < data->irq_groups * 2; i++)
+	for (i =3D 0; i < data->reg_num; i++)
 		writel_relaxed(data->saved_reg[i],
-			       data->regs + CHANMASK(i, data->irq_groups));
+			       data->regs + CHANMASK(i, data->reg_num));
 }
=20
 static int imx_irqsteer_suspend(struct device *dev)
--=20
2.7.4

