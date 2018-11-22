Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBE5C04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3189720820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI+joUyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3189720820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405706AbeKWBls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:41:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42517 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731038AbeKWBls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:41:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so9548539wrx.9;
        Thu, 22 Nov 2018 07:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kVZ4aa1WWSiBf0BScwmwCPIOPM1Z1WJtDKh3NCGY4Uc=;
        b=AI+joUykO7Y/1xau52rOO/p1Q88lH7Ac4dymFzop7bXXa7yvcn4R4r2IZBEai19Ffz
         ClNLsxHQu3cUtkmihQBMrHKJlCV4KpV2cr+VRygj5VNGdaHKYzQKd0ztwVXftH5czuQg
         uRG8C2bIzB+mZEedPRizbK+5RVF/6me2xdDSvJxCW0y4naCTmFBm4CGUN0eESlJORr3y
         tBIZt5HHMstQU+j9wmQ7amyJOVTxYm/4WQnM9vAVDvYJvmSIiedrMPy0qwO3XQKn8jfv
         OyAtQijzOqZLBj7BIE99wjyPoFBCbFaVbAJ6YADk1Q9PQdlUqpwW10Hvb4NO2+KVyLxW
         l6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kVZ4aa1WWSiBf0BScwmwCPIOPM1Z1WJtDKh3NCGY4Uc=;
        b=BpWTM+1sShIxlrqxticvvIrtcMMH8gYEfBUHAOBZvpAdhAhp9yX3DcLzF3sCnIjRaA
         N4I9vnArpQF8hL/Cwz6AnoSPEXTmgyeV77Gl4cUHvSbmRdNsPEWbJJDGlo8bSbgyJKDZ
         UfNogwG5WB4dbZ/iAdsKWv52VCxhJnR9CI+i02e0qMYGesRiGGW9oa4aDKUvIUbis+UQ
         rJ6d2T3IvapXziAXnxrzjG0AZWPgOsNgrprQWadt/HLSrR8QIm+WNhnx03yFoni7QnGl
         3SQ8kUcurLz/NcoUBVJ9EPEOjoSoLoy73Ac/yfh9lImcnwuLnVtTedzixSrXfmwUzzlo
         Gnlw==
X-Gm-Message-State: AA+aEWauUEUKMupCSrc5VQ9BKL7XqU7fgKPVeT5oNpXjE3TER+LtSMoN
        3pDY562F6IoTJim5v4NNVvU=
X-Google-Smtp-Source: AFSGD/XWQc8NjPngr3F51dZoRDupiyT7Ez4njC8iWauzmT+nCboEgp++2nd/YhyOtp6Fem/XwSCI/g==
X-Received: by 2002:adf:f28d:: with SMTP id k13mr10480127wro.78.1542898922518;
        Thu, 22 Nov 2018 07:02:02 -0800 (PST)
Received: from localhost ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id j6sm13795500wrw.30.2018.11.22.07.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 07:02:01 -0800 (PST)
Date:   Thu, 22 Nov 2018 18:02:00 +0300
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [RFC PATCH v3 05/17] irqchip/sun4i: add support for suniv
 interrupt controller
Message-ID: <20181122150200.p6e22sp3v4npb42w@ThinkPad>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <08b40429e46626f4caf8e4d2287b5c4d354e3b7f.1542824904.git.mesihkilinc@gmail.com>
 <20181122083547.srnopylueqx6p2qj@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122083547.srnopylueqx6p2qj@flea>
User-Agent: NeoMutt/20180716-631-34bcda
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/22 09:35, Maxime Ripard wrote:
> Hi Mesih,
> 
Hi!
> On Wed, Nov 21, 2018 at 09:30:38PM +0300, Mesih Kilinc wrote:
> > The new F-series SoCs (suniv) from Allwinner use an stripped version of
> > the interrupt controller in A10/A13
> > 
> > Add support for it in irq-sun4i driver.
> > 
> > Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> > ---
> >  drivers/irqchip/irq-sun4i.c | 104 +++++++++++++++++++++++++++++++-------------
> >  1 file changed, 74 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
> > index e3e5b91..7ca4a4d 100644
> > --- a/drivers/irqchip/irq-sun4i.c
> > +++ b/drivers/irqchip/irq-sun4i.c
> > @@ -28,11 +28,21 @@
> >  #define SUN4I_IRQ_NMI_CTRL_REG		0x0c
> >  #define SUN4I_IRQ_PENDING_REG(x)	(0x10 + 0x4 * x)
> >  #define SUN4I_IRQ_FIQ_PENDING_REG(x)	(0x20 + 0x4 * x)
> > -#define SUN4I_IRQ_ENABLE_REG(x)		(0x40 + 0x4 * x)
> > -#define SUN4I_IRQ_MASK_REG(x)		(0x50 + 0x4 * x)
> > +#define SUN4I_IRQ_ENABLE_REG(x)		(irq_ic_data->enable_req_offset + 0x4 * x)
> > +#define SUN4I_IRQ_MASK_REG(x)		(irq_ic_data->mask_req_offset + 0x4 * x)
> 
> You shouldn't have all the values you use passed as argument, so
> irq_ic_data should be one of them here.
> 
Could you elaborate it a little bit?
> > +#define SUN4I_IRQ_ENABLE_REG_OFFSET	0x40
> > +#define SUN4I_IRQ_MASK_REG_OFFSET	0x50
> > +#define SUNIV_IRQ_ENABLE_REG_OFFSET	0x20
> > +#define SUNIV_IRQ_MASK_REG_OFFSET	0x30
> > +
> > +struct sunxi_irq_chip_data{
>                              ^ a space here
> 
> > +	void __iomem *irq_base;
> > +	struct irq_domain *irq_domain;
> > +	u32 enable_req_offset;
> > +	u32 mask_req_offset;
> 
> s/req/reg/ ?
> 
Oops sorry

...
> > +
> > +static int __init suniv_ic_of_init(struct device_node *node,
> > +				   struct device_node *parent)
> > +{
> > +	irq_ic_data = kzalloc(sizeof(struct sunxi_irq_chip_data), GFP_KERNEL);
> > +	if (!irq_ic_data) {
> > +		pr_err("kzalloc failed!\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	irq_ic_data->enable_req_offset = SUNIV_IRQ_ENABLE_REG_OFFSET;
> > +	irq_ic_data->mask_req_offset = SUNIV_IRQ_MASK_REG_OFFSET;
> > +
> > +	return sun4i_of_init(node, parent);
> > +}
> > +
> > +IRQCHIP_DECLARE(allwinner_sunvi_ic, "allwinner,suniv-f1c100s-ic", suniv_ic_of_init);
> 
> You can even split that addition to a new patch as well.

OK. I will do 3 patches. First one will add a struct that holds only
base and domain. Second one will add register offsets to that struct. 
Third one will add f1c100s support. Is that ok?

Mesih
