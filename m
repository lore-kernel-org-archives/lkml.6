Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81E3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE09218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549492730;
	bh=Y3uDLBjXA0Bs7TrZ/pCQV51xaf3LfGTiDfnCRwXHUf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RUJydfjbP+A0Oj//VilzdeCNlyT+AQJvTg38L/iOf8F9B42NsF/7T0nRsknZPtsbK
	 4WcY33NnQNZFH7vmURJw35fySZGanzuXU/JBfQ+Vx3cAsngHa7S2+m/zP3KD8GvvmF
	 oWDMr1juoTIo48GZK0mheyu6DJ9kf4BFOXrGdu/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfBFWit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:38:49 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38778 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfBFWit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:38:49 -0500
Received: by mail-ot1-f68.google.com with SMTP id e12so14967147otl.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 14:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KyhrdRvQwOtWPLNfIx/wwb2zcG6kJ+tUhgnWfDCG6d8=;
        b=D6Uiz7446P54R6zftoXWOh/qchohp6WFTKjrwnsFVp7qTVwRALA+2QtFhN3Otu1Lpe
         sOPbswUX+otbtM02HwWXSr3MOCxW6V6pBfmU6oOWwa7Y3sYKYrU9EAPBFcCzxCPszhPd
         Jnm9umvsHg0gVC1UJVjIO6GZzKNsDiG8tbiammtfz1Y8Do2h+DHECy5gAIAXcaz5RAk2
         8MxAsieNCnGN64dr6oyTQz8eVkSO5J/pOf+9sZTl49ZPLYrRd1pEOzo8RoLbfXqybFuC
         KNjIC0loUh89bP0jyJbc2TtP84I+udw1+REQVdoWnxxOqR3mLPceU1G8hipnR6UMhdFg
         uYNA==
X-Gm-Message-State: AHQUAuZxNN1L5201lTZPTTWWLqAH/Z/Cs/cw5288iUg5Rp3gsNDFxFsJ
        LHB/47bthsTay74eQ22urBUC4w==
X-Google-Smtp-Source: AHgI3IauJePI+rLbGDalYOh3Dl636ZOUdkoQ39h+8kbQeEF7A5be/izEwq3O0I4DlNb1cD3CX7j30w==
X-Received: by 2002:a9d:88d:: with SMTP id 13mr6503396otf.269.1549492727725;
        Wed, 06 Feb 2019 14:38:47 -0800 (PST)
Received: from localhost ([2601:647:4700:93d:6db5:e35d:dacd:7872])
        by smtp.gmail.com with ESMTPSA id g19sm9858195otl.26.2019.02.06.14.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 14:38:47 -0800 (PST)
Date:   Wed, 6 Feb 2019 14:38:46 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        colin.king@canonical.com, linus.walleij@linaro.org,
        yuehaibing@huawei.com, mcgrof@kernel.org, frowand.list@gmail.com,
        robh+dt@kernel.org, UNGLinuxDriver@microchip.com,
        woojung.huh@microchip.com, hkallweit1@gmail.com,
        davem@davemloft.net, f.fainelli@gmail.com,
        vivien.didelot@gmail.com, moritz@ettus.com, alex.williams@ni.com
Subject: Re: [RFC net-next] net: fixed_phy: Move the DT based link GPIO
 parsing to of_mdio.c
Message-ID: <20190206223846.GA22321@archbook>
References: <20190206205106.11517-1-mdf@kernel.org>
 <20190206215322.GC32483@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206215322.GC32483@lunn.ch>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

thanks for your feedback.

On Wed, Feb 06, 2019 at 10:53:22PM +0100, Andrew Lunn wrote:
> On Wed, Feb 06, 2019 at 12:51:06PM -0800, Moritz Fischer wrote:
> > Move the DT based link GPIO parsing to of_mdio and let the places
> > that register a fixed_phy pass in a GPIO descriptor or NULL.
> > 
> > This allows fixed_phy on non-DT platforms to have link GPIOs, too.
> > 
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  drivers/net/dsa/dsa_loop.c                   |  2 +-
> >  drivers/net/ethernet/broadcom/bgmac.c        |  2 +-
> >  drivers/net/ethernet/broadcom/genet/bcmmii.c |  2 +-
> >  drivers/net/phy/fixed_phy.c                  | 48 ++------------------
> >  drivers/net/usb/lan78xx.c                    |  2 +-
> >  drivers/of/of_mdio.c                         | 15 +++++-
> >  include/linux/phy_fixed.h                    |  3 +-
> >  7 files changed, 23 insertions(+), 51 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
> > index 17482ae09aa5..7f124c620092 100644
> > --- a/drivers/net/dsa/dsa_loop.c
> > +++ b/drivers/net/dsa/dsa_loop.c
> > @@ -343,7 +343,7 @@ static int __init dsa_loop_init(void)
> >  	unsigned int i;
> >  
> >  	for (i = 0; i < NUM_FIXED_PHYS; i++)
> > -		phydevs[i] = fixed_phy_register(PHY_POLL, &status, NULL);
> > +		phydevs[i] = fixed_phy_register(PHY_POLL, &status, NULL, NULL);
> >  
> >  	return mdio_driver_register(&dsa_loop_drv);
> >  }
> > diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> > index 4632dd5dbad1..bce644dec5c2 100644
> > --- a/drivers/net/ethernet/broadcom/bgmac.c
> > +++ b/drivers/net/ethernet/broadcom/bgmac.c
> > @@ -1446,7 +1446,7 @@ int bgmac_phy_connect_direct(struct bgmac *bgmac)
> >  	struct phy_device *phy_dev;
> >  	int err;
> >  
> > -	phy_dev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
> > +	phy_dev = fixed_phy_register(PHY_POLL, &fphy_status, NULL, NULL);
> >  	if (!phy_dev || IS_ERR(phy_dev)) {
> >  		dev_err(bgmac->dev, "Failed to register fixed PHY device\n");
> >  		return -ENODEV;
> > diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> > index 51880d83131a..7cbd737aba80 100644
> > --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
> > +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> > @@ -525,7 +525,7 @@ static int bcmgenet_mii_pd_init(struct bcmgenet_priv *priv)
> >  			.asym_pause = 0,
> >  		};
> >  
> > -		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
> > +		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL, NULL);
> >  		if (!phydev || IS_ERR(phydev)) {
> >  			dev_err(kdev, "failed to register fixed PHY device\n");
> >  			return -ENODEV;
> > diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
> > index d810f914aaa4..845bd7c2065a 100644
> > --- a/drivers/net/phy/fixed_phy.c
> > +++ b/drivers/net/phy/fixed_phy.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/err.h>
> >  #include <linux/slab.h>
> >  #include <linux/of.h>
> > +#include <linux/of_mdio.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/seqlock.h>
> >  #include <linux/idr.h>
> > @@ -191,50 +192,12 @@ static void fixed_phy_del(int phy_addr)
> >  	}
> >  }
> >  
> > -#ifdef CONFIG_OF_GPIO
> > -static struct gpio_desc *fixed_phy_get_gpiod(struct device_node *np)
> > -{
> > -	struct device_node *fixed_link_node;
> > -	struct gpio_desc *gpiod;
> > -
> > -	if (!np)
> > -		return NULL;
> > -
> > -	fixed_link_node = of_get_child_by_name(np, "fixed-link");
> > -	if (!fixed_link_node)
> > -		return NULL;
> > -
> > -	/*
> > -	 * As the fixed link is just a device tree node without any
> > -	 * Linux device associated with it, we simply have obtain
> > -	 * the GPIO descriptor from the device tree like this.
> > -	 */
> > -	gpiod = gpiod_get_from_of_node(fixed_link_node, "link-gpios", 0,
> > -				       GPIOD_IN, "mdio");
> > -	of_node_put(fixed_link_node);
> > -	if (IS_ERR(gpiod)) {
> > -		if (PTR_ERR(gpiod) == -EPROBE_DEFER)
> > -			return gpiod;
> > -		pr_err("error getting GPIO for fixed link %pOF, proceed without\n",
> > -		       fixed_link_node);
> > -		gpiod = NULL;
> > -	}
> > -
> > -	return gpiod;
> > -}
> > -#else
> > -static struct gpio_desc *fixed_phy_get_gpiod(struct device_node *np)
> > -{
> > -	return NULL;
> > -}
> > -#endif
> > -
> >  struct phy_device *fixed_phy_register(unsigned int irq,
> >  				      struct fixed_phy_status *status,
> > -				      struct device_node *np)
> > +				      struct device_node *np,
> > +				      struct gpio_desc *gpiod)
> >  {
> >  	struct fixed_mdio_bus *fmb = &platform_fmb;
> > -	struct gpio_desc *gpiod = NULL;
> >  	struct phy_device *phy;
> >  	int phy_addr;
> >  	int ret;
> > @@ -242,11 +205,6 @@ struct phy_device *fixed_phy_register(unsigned int irq,
> >  	if (!fmb->mii_bus || fmb->mii_bus->state != MDIOBUS_REGISTERED)
> >  		return ERR_PTR(-EPROBE_DEFER);
> >  
> > -	/* Check if we have a GPIO associated with this fixed phy */
> > -	gpiod = fixed_phy_get_gpiod(np);
> > -	if (IS_ERR(gpiod))
> > -		return ERR_CAST(gpiod);
> > -
> >  	/* Get the next available PHY address, up to PHY_MAX_ADDR */
> >  	phy_addr = ida_simple_get(&phy_fixed_ida, 0, PHY_MAX_ADDR, GFP_KERNEL);
> >  	if (phy_addr < 0)
> > diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> > index 3d92ea6fcc02..bd88f0aef2fa 100644
> > --- a/drivers/net/usb/lan78xx.c
> > +++ b/drivers/net/usb/lan78xx.c
> > @@ -2051,7 +2051,7 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
> >  	phydev = phy_find_first(dev->mdiobus);
> >  	if (!phydev) {
> >  		netdev_dbg(dev->net, "PHY Not Found!! Registering Fixed PHY\n");
> > -		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
> > +		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL, NULL);
> >  		if (IS_ERR(phydev)) {
> >  			netdev_err(dev->net, "No PHY/fixed_PHY found\n");
> >  			return NULL;
> > diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
> > index de6157357e26..6be2120b5f03 100644
> > --- a/drivers/of/of_mdio.c
> > +++ b/drivers/of/of_mdio.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/of_mdio.h>
> >  #include <linux/of_net.h>
> >  #include <linux/module.h>
> > +#include <linux/gpio/consumer.h>
> >  
> >  #define DEFAULT_GPIO_RESET_DELAY	10	/* in microseconds */
> >  
> > @@ -460,6 +461,7 @@ int of_phy_register_fixed_link(struct device_node *np)
> >  {
> >  	struct fixed_phy_status status = {};
> >  	struct device_node *fixed_link_node;
> > +	struct gpio_desc *gpiod = NULL;
> >  	u32 fixed_link_prop[5];
> >  	const char *managed;
> >  
> > @@ -483,7 +485,17 @@ int of_phy_register_fixed_link(struct device_node *np)
> >  		status.pause = of_property_read_bool(fixed_link_node, "pause");
> >  		status.asym_pause = of_property_read_bool(fixed_link_node,
> >  							  "asym-pause");
> > +
> > +		gpiod = gpiod_get_from_of_node(fixed_link_node, "link-gpios", 0,
> > +				       GPIOD_IN, "mdio");
> >  		of_node_put(fixed_link_node);
> > +		if (IS_ERR(gpiod)) {
> > +			if (PTR_ERR(gpiod) == -EPROBE_DEFER)
> > +				return PTR_ERR(gpiod);
> > +			pr_err("error getting GPIO for fixed link %pOF, proceed without\n",
> > +			       fixed_link_node);
> > +			gpiod = NULL;
> >  extern struct phy_device *fixed_phy_register(unsigned int irq,
> >  					     struct fixed_phy_status *status,
> > -					     struct device_node *np);
> > +					     struct device_node *np,
> > +					     struct gpio_desc *gpiod);
> 
> Hi Moritz
> 
> I think it would be better to add a 
> 
> extern struct phy_device *fixed_phy_register_gpiod(unsigned int irq,
>      					     struct fixed_phy_status *status,
> 					     struct gpio_desc *gpiod);
> 
> If you are not using DT, the np is pointless. So lets keep the API
> simple.

To clarify: Do you agree with moving the parsing to of_mdio, or do you
want to keep the parsing as it was and just add an additional function.

In the latter case you'd have a
static struct phy_device *__fixed_phy_register(unsigned int irq,
					       struct fixed_phy_status *status,
					       struct device_node *np,
					       struct gpio_desc *gpiod)
{
if (gpiod)
   use that
else
   old behavior / scan dt?
}

That we then call from fixed_phy_register_gpiod() with a np of NULL,
and from fixed_phy_register() with a gpiod of NULL?

Thanks,

Moritz
