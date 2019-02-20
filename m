Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCCBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3319B208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="BAWXUS5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfBTJHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:07:11 -0500
Received: from mail-eopbgr1410124.outbound.protection.outlook.com ([40.107.141.124]:21745
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbfBTJHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gB2JUFhIwEtVYzV5m+CLdcxgrnO5NLg1lRcNfU+GQU=;
 b=BAWXUS5aFTxzQ6/0/SKlJ+fEg70u75nNxIuFbKzuTF3vHThnfmpAOdWuVhI4OEny4DzmO3t13Lo1wAiHiNqwPXJN/BxgDy8GQser05uBN07sjRJ6Z9QbaOkn6LWpaFKR2wKKt3TRxyI8QMiIeYCKEtDndVZBRS0mliPWO6tLBxQ=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1531.jpnprd01.prod.outlook.com (52.133.162.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.20; Wed, 20 Feb 2019 09:07:02 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::4cc6:14ba:d8cd:4107]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::4cc6:14ba:d8cd:4107%2]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 09:07:02 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: RE: [PATCH v4 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
 interrupt multiplexer
Thread-Topic: [PATCH v4 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
 interrupt multiplexer
Thread-Index: AQHUyGuWxb9ZURok+kaTr7Tx2RFLP6XnkpEAgADP5VA=
Date:   Wed, 20 Feb 2019 09:07:02 +0000
Message-ID: <TY1PR01MB17696D6C85CE6294B8C75F11F57D0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20190219155511.28507-1-phil.edworthy@renesas.com>
        <20190219155511.28507-3-phil.edworthy@renesas.com>
 <20190219202842.59bc7719@why.wild-wind.fr.eu.org>
In-Reply-To: <20190219202842.59bc7719@why.wild-wind.fr.eu.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c97385a2-71f3-4afa-5760-08d69712c731
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1531;
x-ms-traffictypediagnostic: TY1PR01MB1531:
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1531;20:2G6D4wX0g3ljYxiUZSfOjO6wo1EfCTefi5ZY9api4v88zJgpxgm7KrPJCn50RmQvVT7d0GR/PDfBxQLXvWtscG+4s9u2B74JIg+MIzqocZbFLE7eV9kQZAkQBIR3Nww6hN+7gVUyju1iJru2f28jdYPTwk1+fR94hGBPFH7eqjI=
x-microsoft-antispam-prvs: <TY1PR01MB153196350B0646F8CD9CCA78F57D0@TY1PR01MB1531.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(7696005)(105586002)(26005)(30864003)(186003)(97736004)(25786009)(6916009)(229853002)(106356001)(66066001)(486006)(33656002)(6116002)(3846002)(53936002)(44832011)(102836004)(6246003)(256004)(14444005)(71190400001)(99286004)(446003)(11346002)(6506007)(53546011)(68736007)(76176011)(478600001)(4326008)(55016002)(8676002)(54906003)(6436002)(71200400001)(476003)(81166006)(2906002)(14454004)(305945005)(86362001)(5660300002)(8936002)(74316002)(81156014)(316002)(7736002)(9686003)(202454002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1531;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: //mMLJYeEkMIphzO58deIgVdgHwgdIWP6876RinLKwxUuWxnTbVaK5jL+vUpTiNgr1XV9n9UL4T2RWV+kywXCWcicKvyGsyLro8jYKxdktpgsyp0YHb5ZX3iAaJhYnEzZOV51qIrNhydn7xUaJWEYjWuRvEhn6wAu4MV5boRq/Tl3qdSnxJZOs7C4/p3fSyyRPETySfWRrHMTA3fKKKRwgcJ7quxoWjp7tLq2BcB3V18aplupVDSVWo5cz9ZwckgZv9bDGD33ZUTf9ixYAMtKNec4tkAiTjvmM1k2xGbijXQnDOy+R7sVOwV69GmOSjKGUbb6UQZ/eiyY1o5H954FQhJ3mGPa2qALjAhYcCN7tZ9GfRAzgpiBwUSEVW3U12DrcyGEIRC/a/hv2S7ZqpW0EhR5WXyq0GSNLUKBvNrdnc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97385a2-71f3-4afa-5760-08d69712c731
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 09:07:02.4527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1531
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc

On 19 February 2019 20:29 Marc Zyngier wrote:
> On Tue, 19 Feb 2019 15:55:11 +0000 Phil Edworthy wrote:
>=20
> + LinusW, who seem to have taken an interest in irqchip hierarchies...
>=20
> > On RZ/N1 devices, there are 3 Synopsys DesignWare GPIO blocks each
> > configured to have 32 interrupt outputs, so we have a total of 96 GPIO
> > interrupts. All of these are passed to the GPIO IRQ Muxer, which
> > selects
> > 8 of the GPIO interrupts to pass onto the GIC. The interrupt signals
> > aren't latched, so there is nothing to do in this driver when an
> > interrupt is received, other than tell the corresponding GPIO block.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> > v4:
> >  - No change.
> > v3:
> >  - Use 'interrupt-map' DT property to map the interrupts, this is very =
similar
> >    to PCIe MSI. The only difference is that we need to get hold of the
> interrupt
> >    specifier for the interupts coming into the irqmux.
> >  - Do not use a chained interrupt controller.
> > v2:
> >  - Use interrupt-map to allow the GPIO controller info to be specified
> >    as part of the irq.
> >  - Renamed struct and funcs from 'girq' to a more comprehenisble 'irqmu=
x'.
> > ---
> >  drivers/irqchip/Kconfig        |   9 ++
> >  drivers/irqchip/Makefile       |   1 +
> >  drivers/irqchip/rzn1-irq-mux.c | 205
> > +++++++++++++++++++++++++++++++++
> >  3 files changed, 215 insertions(+)
> >  create mode 100644 drivers/irqchip/rzn1-irq-mux.c
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig index
> > 5dcb5456cd14..369f78d6b521 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -211,6 +211,15 @@ config RENESAS_IRQC
> >  	select GENERIC_IRQ_CHIP
> >  	select IRQ_DOMAIN
> >
> > +config RENESAS_RZN1_IRQ_MUX
> > +	bool "Renesas RZ/N1 GPIO IRQ multiplexer support"
> > +	depends on ARCH_RZN1
> > +	select IRQ_DOMAIN
> > +	help
> > +	  Say yes here to add support for the GPIO IRQ multiplexer
> embedded
> > +	  in Renesas RZ/N1 SoC devices. The GPIO IRQ Muxer selects which of
> > +	  the interrupts coming from the GPIO controllers are used.
> > +
> >  config ST_IRQCHIP
> >  	bool
> >  	select REGMAP
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile index
> > 7acd0e36d0b4..2edd42ef2182 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -46,6 +46,7 @@ obj-$(CONFIG_JCORE_AIC)			+=3D
> irq-jcore-aic.o
> >  obj-$(CONFIG_RDA_INTC)			+=3D irq-rda-intc.o
> >  obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+=3D irq-renesas-intc-irqpin.o
> >  obj-$(CONFIG_RENESAS_IRQC)		+=3D irq-renesas-irqc.o
> > +obj-$(CONFIG_RENESAS_RZN1_IRQ_MUX)	+=3D rzn1-irq-mux.o
> >  obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+=3D irq-versatile-fpga.o
> >  obj-$(CONFIG_ARCH_NSPIRE)		+=3D irq-zevio.o
> >  obj-$(CONFIG_ARCH_VT8500)		+=3D irq-vt8500.o
> > diff --git a/drivers/irqchip/rzn1-irq-mux.c
> > b/drivers/irqchip/rzn1-irq-mux.c new file mode 100644 index
> > 000000000000..ee7810b9b3f3
> > --- /dev/null
> > +++ b/drivers/irqchip/rzn1-irq-mux.c
> > @@ -0,0 +1,205 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * RZ/N1 GPIO Interrupt Multiplexer
> > + *
> > + * Copyright (C) 2018 Renesas Electronics Europe Limited
> > + *
> > + * On RZ/N1 devices, there are 3 Synopsys DesignWare GPIO blocks each
> > +configured
> > + * to have 32 interrupt outputs, so we have a total of 96 GPIO interru=
pts.
> > + * All of these are passed to the GPIO IRQ Muxer, which selects 8 of
> > +the GPIO
> > + * interrupts to pass onto the GIC.
>=20
> So that I get it right:
>=20
> - 96 inputs
> - 8 outputs
>=20
> This driver picks 8 of the inputs (and at most 8), and pass then down to =
the
> GIC. Do I understand that correctly?
Correct.

> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +
> > +#define MAX_NR_INPUT_IRQS	96
> > +#define MAX_NR_OUTPUT_IRQS	8
> > +
> > +/*
> > + * "interrupt-map" consists of 1 interrupt cell, 0 address cells,
> > +phandle to
> > + * interrupt parent, and parent interrupt specifier (3 cells for
> > +GIC), giving
> > + * a total of 5 cells.
> > + */
> > +#define IMAP_LENGTH		5
>=20
> Although the maths do check out, I find it rather dangerous. The versatil=
e
> nature of DT makes me say that sooner or later, someone is going to punt
> this in front of something that will need more than 3 interrupt cells for=
 the
> parent irqchip, and things will be...
> interesting. Even GICv3 in some configuration requires 4 cells.
>=20
> You've been warned! ;-)
Warning noted! I would like to think that no one does this in HW again,
though history suggests otherwise.

> > +
> > +struct irqmux_priv;
> > +struct irqmux_one {
> > +	unsigned int irq;
> > +	unsigned int src_hwirq;
> > +	struct irqmux_priv *priv;
> > +};
> > +
> > +struct irqmux_priv {
> > +	struct device *dev;
> > +	struct irq_domain *irq_domain;
> > +	unsigned int nr_irqs;
> > +	struct irqmux_one mux[MAX_NR_OUTPUT_IRQS]; };
> > +
> > +static irqreturn_t irqmux_handler(int irq, void *data) {
> > +	struct irqmux_one *mux =3D data;
> > +	struct irqmux_priv *priv =3D mux->priv;
> > +	unsigned int virq;
> > +
> > +	virq =3D irq_find_mapping(priv->irq_domain, mux->src_hwirq);
> > +
> > +	generic_handle_irq(virq);
> > +
> > +	return IRQ_HANDLED;
> > +}
>=20
> Oh $DEITY. No, really not. I don't know where to start.
Oh dear... not a good opening.

> - This type of handler should almost never appear in an interrupt
>   controller driver. Under the right circumstances, it will deadlock.
>=20
> - If I understood the above correctly, this should be modelled as a
>   hierarchy sitting on top of the GIC, and not as a mux. A good way to
>   notice that this is not a mux is that there is no register to read
>   and find out what fired.
>=20
> - The fact that you have to invent src_hwirq instead of directly using
>   data->hwirq is a clear sign that something is amiss.
>=20
> > +
> > +static int irqmux_domain_map(struct irq_domain *h, unsigned int irq,
> > +			     irq_hw_number_t hwirq)
> > +{
> > +	irq_set_chip_data(irq, h->host_data);
> > +	irq_set_chip_and_handler(irq, &dummy_irq_chip,
> handle_simple_irq);
>=20
> Another sure sign that this is wrong, the flow handler. In 99% of the cas=
e,
> using handle_simple_irq is wrong. I'd expect something that matches the
> underlying interrupt controller (a fasteoi handler).
>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops irqmux_domain_ops =3D {
> > +	.map =3D irqmux_domain_map,
> > +};
> > +
> > +static int irqmux_probe(struct platform_device *pdev) {
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	struct resource *res;
> > +	u32 __iomem *regs;
> > +	struct irqmux_priv *priv;
> > +	unsigned int i;
> > +	int nr_irqs;
> > +	int ret;
> > +	const __be32 *imap;
> > +	int imaplen;
> > +
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->dev =3D dev;
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	regs =3D devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(regs))
> > +		return PTR_ERR(regs);
> > +
> > +	nr_irqs =3D of_irq_count(np);
> > +	if (nr_irqs < 0)
> > +		return nr_irqs;
> > +
> > +	if (nr_irqs > MAX_NR_OUTPUT_IRQS) {
> > +		dev_err(dev, "too many output interrupts\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	priv->nr_irqs =3D nr_irqs;
> > +
> > +	/* Look for the interrupt-map */
> > +	imap =3D of_get_property(np, "interrupt-map", &imaplen);
> > +	if (!imap)
> > +		return -ENOENT;
> > +	imaplen /=3D IMAP_LENGTH * sizeof(__be32);
> > +
> > +	/* Sometimes not all muxs are used */
> > +	if (imaplen < priv->nr_irqs)
> > +		priv->nr_irqs =3D imaplen;
> > +
> > +	/* Create IRQ domain for the interrupts coming from the GPIO blocks
> */
> > +	priv->irq_domain =3D irq_domain_add_linear(np,
> MAX_NR_INPUT_IRQS,
> > +						 &irqmux_domain_ops, priv);
> > +	if (!priv->irq_domain)
> > +		return -ENOMEM;
> > +
> > +	for (i =3D 0; i < MAX_NR_INPUT_IRQS; i++)
> > +		irq_create_mapping(priv->irq_domain, i);
>=20
> This should never happen. Mappings should be created from discovering the
> interrupt specifiers for devices in the DT, and not eagerly at probe time=
.
The key issue here is that the mappings should not be dynamically allocated=
.
On the device that has this hardware, there is a Cortex M3 that is likely t=
o use
some of these GPIO interrupts.
Maybe it would be better to limit the number of GPIO irqs that Linux can
configure dynamically.

> > +
> > +	for (i =3D 0; i < priv->nr_irqs; i++) {
> > +		struct irqmux_one *mux =3D &priv->mux[i];
> > +
> > +		ret =3D irq_of_parse_and_map(np, i);
> > +		if (ret < 0) {
> > +			ret =3D -ENOENT;
> > +			goto err;
> > +		}
> > +
> > +		mux->irq =3D ret;
> > +		mux->priv =3D priv;
> > +
> > +		/*
> > +		 * We need the first cell of the interrupt-map to configure
> > +		 * the hardware.
> > +		 */
> > +		mux->src_hwirq =3D be32_to_cpu(*imap);
> > +		imap +=3D IMAP_LENGTH;
> > +
> > +		dev_info(dev, "%u: %u mapped irq %u\n", i,  mux-
> >src_hwirq,
> > +			 mux->irq);
> > +
> > +		ret =3D devm_request_irq(dev, mux->irq, irqmux_handler,
> > +				       IRQF_SHARED | IRQF_NO_THREAD,
> > +				       "irqmux", mux);
>=20
> And this is a result of using an interrupt handler in the driver. Bad.
>=20
> > +		if (ret < 0) {
> > +			dev_err(dev, "failed to request IRQ: %d\n", ret);
> > +			goto err;
> > +		}
> > +
> > +		/* Set up the hardware to pass the interrupt through */
> > +		writel(mux->src_hwirq, &regs[i]);
>=20
> It feels very odd that you configure the routing at probe time, and not a=
t
> runtime. This should really happen when the client devices are probed...
>=20
> > +	}
> > +
> > +	dev_info(dev, "probed, %d gpio interrupts\n", priv->nr_irqs);
> > +
> > +	return 0;
> > +
> > +err:
> > +	while (i--)
> > +		irq_dispose_mapping(priv->mux[i].irq);
> > +	irq_domain_remove(priv->irq_domain);
> > +
> > +	return ret;
> > +}
> > +
> > +static int irqmux_remove(struct platform_device *pdev) {
> > +	struct irqmux_priv *priv =3D platform_get_drvdata(pdev);
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < priv->nr_irqs; i++)
> > +		irq_dispose_mapping(priv->mux[i].irq);
> > +	irq_domain_remove(priv->irq_domain);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id irqmux_match[] =3D {
> > +	{ .compatible =3D "renesas,rzn1-gpioirqmux", },
> > +	{ /* sentinel */ },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, irqmux_match);
> > +
> > +static struct platform_driver irqmux_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "gpio_irq_mux",
> > +		.owner =3D THIS_MODULE,
> > +		.of_match_table =3D irqmux_match,
> > +	},
> > +	.probe =3D irqmux_probe,
> > +	.remove =3D irqmux_remove,
> > +};
> > +
> > +module_platform_driver(irqmux_driver);
> > +
> > +MODULE_DESCRIPTION("Renesas RZ/N1 GPIO IRQ Multiplexer Driver");
> > +MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
> > +MODULE_LICENSE("GPL v2");
>=20
> Can you please confirm that my understanding of how the HW works is
> correct? If so, we can help you turning this around.
Looks like I've gone off in the wrong direction yet again.

Thanks for your comments,
Phil
