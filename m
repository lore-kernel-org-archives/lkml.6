Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4013241-1526453420-2-18123446682454193269
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526453419; b=O5N7a9y6Ld7QZCNSAQopt0Llx3tm8Zorz5C1Sw4BBtTFr8Rzbg
    UdC98N2s3X4k1HKlyPPOlZDRRAlQwZ/7A55omD5dCwFafZ0J62E0cILOXtB3wdN4
    97rS95GshCtY1wqcjowEWtpXdVf6olrM0UMXLkZi8msgFtnrjKGO9DXokvSHcC3C
    SF93rhvIl/EVuL0btuNILjW3GS3M/k0rbq91P/+krpwRB64O6iTG6IvuDOEy2tz+
    W4x9X6tgoeMJyhwwvwCfeRmvTwdLU6PUGrVNV9KZ+KGR0cNBN8F1qlcSmzQ+y1sy
    rXI7fQghueqgF5AJcNWe/2LJMCTQU4DVIMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526453419; bh=gZl2WPEfdhQ
    pKd3yskGeXWCnE3HJFYFc+fJzGOcXR/o=; b=VYAl4HZH9tLQMxVSNEVLbfd0gUi
    8cf8wLlKHrgwL6SgC2/6n3m3vojAj3HacC+CbcN6eosohA+UpcDLq+ElFuS4zkTR
    7+IgorCTcMHx76zEssdHvgMrznwf/ZlD124izT8LMxfdBfdA9j9Vak4qlo4tOvvG
    BYaCBQ31b8/9hUW4U1ESKTwbCU5sV+mtfn0dLLYgF61xu8NLhFzRxKoJT3JX6zgp
    oGxNKQYayesxKmZih2IHCfaUVN7nqH3Dy7Qbnl+t5OrJbAnHfrCucN0IbkUhfHaA
    v0TmACFy4u+4lRw9gp03fVEVm96M9DucZ4IeICg5bO5cgsUVB63jY2sjteg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFxrT2P614c0F/e9qdIBzHCVxfHNFH531NI9igVgCdCTQN2uIhktaRcf6frWJoj5y4vOTFtyddR6PnU7SmfI9kR57rwLhlNViFvybXCAKDFVpSXJ9sD7
    IpO6DScpBVzINAasb8sg87bhA/EJtqbaaBN/TtgKIb91K1nicY/YYu7FnaEebS3Kw5JZMe5U7NE17h3L6lF+9I42+UFXP4JahpWg/z6p+NPtCr9yHxFBLYhf
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=j4e_FN_Bv2zboy8PRJwA:9
    a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10 a=d3PnA9EDa4IxuAV0gXij:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeEPGtu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 02:49:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55929 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752407AbeEPGts (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 16 May 2018 02:49:48 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
        URIBL_BLOCKED shortcircuit=ham autolearn=disabled version=3.4.0
Date: Wed, 16 May 2018 08:49:45 +0200
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>,
        Simon Horman <horms+renesas@verge.net.au>,
        Maxim Uvarov <muvarov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RENESAS ETHERNET DRIVERS"
        <linux-renesas-soc@vger.kernel.org>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)"
        <linux-omap@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] drivers: net: Remove device_node checks
 with of_mdiobus_register()
Message-ID: <20180516064945.GB32746@kwain>
References: <20180515235619.27773-1-f.fainelli@gmail.com>
 <20180515235619.27773-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180515235619.27773-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Florian,

On Tue, May 15, 2018 at 04:56:19PM -0700, Florian Fainelli wrote:
> A number of drivers have the following pattern:
> 
> if (np)
> 	of_mdiobus_register()
> else
> 	mdiobus_register()
> 
> which the implementation of of_mdiobus_register() now takes care of.
> Remove that pattern in drivers that strictly adhere to it.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/net/dsa/bcm_sf2.c                         |  8 ++------
>  drivers/net/dsa/mv88e6xxx/chip.c                  |  5 +----
>  drivers/net/ethernet/cadence/macb_main.c          | 12 +++---------
>  drivers/net/ethernet/freescale/fec_main.c         |  8 ++------
>  drivers/net/ethernet/marvell/mvmdio.c             |  5 +----

For mvmdio,
Reviewed-by: Antoine Tenart <antoine.tenart@bootlin.com>

Thanks!
Antoine

>  drivers/net/ethernet/renesas/sh_eth.c             | 11 +++--------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  5 +----
>  drivers/net/ethernet/ti/davinci_mdio.c            |  8 +++-----
>  drivers/net/phy/mdio-gpio.c                       |  6 +-----
>  drivers/net/phy/mdio-mscc-miim.c                  |  6 +-----
>  drivers/net/usb/lan78xx.c                         |  7 ++-----
>  11 files changed, 20 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
> index ac621f44237a..02e8982519ce 100644
> --- a/drivers/net/dsa/bcm_sf2.c
> +++ b/drivers/net/dsa/bcm_sf2.c
> @@ -450,12 +450,8 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
>  	priv->slave_mii_bus->parent = ds->dev->parent;
>  	priv->slave_mii_bus->phy_mask = ~priv->indir_phy_mask;
>  
> -	if (dn)
> -		err = of_mdiobus_register(priv->slave_mii_bus, dn);
> -	else
> -		err = mdiobus_register(priv->slave_mii_bus);
> -
> -	if (err)
> +	err = of_mdiobus_register(priv->slave_mii_bus, dn);
> +	if (err && dn)
>  		of_node_put(dn);
>  
>  	return err;
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index b23c11d9f4b2..2bb3f03ee1cb 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -2454,10 +2454,7 @@ static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
>  			return err;
>  	}
>  
> -	if (np)
> -		err = of_mdiobus_register(bus, np);
> -	else
> -		err = mdiobus_register(bus);
> +	err = of_mdiobus_register(bus, np);
>  	if (err) {
>  		dev_err(chip->dev, "Cannot register MDIO bus (%d)\n", err);
>  		mv88e6xxx_g2_irq_mdio_free(chip, bus);
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index b4c9268100bb..3e93df5d4e3b 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -591,16 +591,10 @@ static int macb_mii_init(struct macb *bp)
>  	dev_set_drvdata(&bp->dev->dev, bp->mii_bus);
>  
>  	np = bp->pdev->dev.of_node;
> +	if (pdata)
> +		bp->mii_bus->phy_mask = pdata->phy_mask;
>  
> -	if (np) {
> -		err = of_mdiobus_register(bp->mii_bus, np);
> -	} else {
> -		if (pdata)
> -			bp->mii_bus->phy_mask = pdata->phy_mask;
> -
> -		err = mdiobus_register(bp->mii_bus);
> -	}
> -
> +	err = of_mdiobus_register(bp->mii_bus, np);
>  	if (err)
>  		goto err_out_free_mdiobus;
>  
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index d4604bc8eb5b..f3e43db0d6cb 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -2052,13 +2052,9 @@ static int fec_enet_mii_init(struct platform_device *pdev)
>  	fep->mii_bus->parent = &pdev->dev;
>  
>  	node = of_get_child_by_name(pdev->dev.of_node, "mdio");
> -	if (node) {
> -		err = of_mdiobus_register(fep->mii_bus, node);
> +	err = of_mdiobus_register(fep->mii_bus, node);
> +	if (node)
>  		of_node_put(node);
> -	} else {
> -		err = mdiobus_register(fep->mii_bus);
> -	}
> -
>  	if (err)
>  		goto err_out_free_mdiobus;
>  
> diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
> index 0495487f7b42..c5dac6bd2be4 100644
> --- a/drivers/net/ethernet/marvell/mvmdio.c
> +++ b/drivers/net/ethernet/marvell/mvmdio.c
> @@ -348,10 +348,7 @@ static int orion_mdio_probe(struct platform_device *pdev)
>  		goto out_mdio;
>  	}
>  
> -	if (pdev->dev.of_node)
> -		ret = of_mdiobus_register(bus, pdev->dev.of_node);
> -	else
> -		ret = mdiobus_register(bus);
> +	ret = of_mdiobus_register(bus, pdev->dev.of_node);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Cannot register MDIO bus (%d)\n", ret);
>  		goto out_mdio;
> diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
> index 5970d9e5ddf1..8dd41e08a6c6 100644
> --- a/drivers/net/ethernet/renesas/sh_eth.c
> +++ b/drivers/net/ethernet/renesas/sh_eth.c
> @@ -3025,15 +3025,10 @@ static int sh_mdio_init(struct sh_eth_private *mdp,
>  		 pdev->name, pdev->id);
>  
>  	/* register MDIO bus */
> -	if (dev->of_node) {
> -		ret = of_mdiobus_register(mdp->mii_bus, dev->of_node);
> -	} else {
> -		if (pd->phy_irq > 0)
> -			mdp->mii_bus->irq[pd->phy] = pd->phy_irq;
> -
> -		ret = mdiobus_register(mdp->mii_bus);
> -	}
> +	if (pd->phy_irq > 0)
> +		mdp->mii_bus->irq[pd->phy] = pd->phy_irq;
>  
> +	ret = of_mdiobus_register(mdp->mii_bus, dev->of_node);
>  	if (ret)
>  		goto out_free_bus;
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index f5f37bfa1d58..5df1a608e566 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -233,10 +233,7 @@ int stmmac_mdio_register(struct net_device *ndev)
>  	new_bus->phy_mask = mdio_bus_data->phy_mask;
>  	new_bus->parent = priv->device;
>  
> -	if (mdio_node)
> -		err = of_mdiobus_register(new_bus, mdio_node);
> -	else
> -		err = mdiobus_register(new_bus);
> +	err = of_mdiobus_register(new_bus, mdio_node);
>  	if (err != 0) {
>  		dev_err(dev, "Cannot register the MDIO bus\n");
>  		goto bus_register_fail;
> diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
> index 98a1c97fb95e..8ac72831af05 100644
> --- a/drivers/net/ethernet/ti/davinci_mdio.c
> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
> @@ -429,12 +429,10 @@ static int davinci_mdio_probe(struct platform_device *pdev)
>  	 * defined to support backward compatibility with DTs which assume that
>  	 * Davinci MDIO will always scan the bus for PHYs detection.
>  	 */
> -	if (dev->of_node && of_get_child_count(dev->of_node)) {
> +	if (dev->of_node && of_get_child_count(dev->of_node))
>  		data->skip_scan = true;
> -		ret = of_mdiobus_register(data->bus, dev->of_node);
> -	} else {
> -		ret = mdiobus_register(data->bus);
> -	}
> +
> +	ret = of_mdiobus_register(data->bus, dev->of_node);
>  	if (ret)
>  		goto bail_out;
>  
> diff --git a/drivers/net/phy/mdio-gpio.c b/drivers/net/phy/mdio-gpio.c
> index b501221819e1..4e4c8daf44c3 100644
> --- a/drivers/net/phy/mdio-gpio.c
> +++ b/drivers/net/phy/mdio-gpio.c
> @@ -179,11 +179,7 @@ static int mdio_gpio_probe(struct platform_device *pdev)
>  	if (!new_bus)
>  		return -ENODEV;
>  
> -	if (pdev->dev.of_node)
> -		ret = of_mdiobus_register(new_bus, pdev->dev.of_node);
> -	else
> -		ret = mdiobus_register(new_bus);
> -
> +	ret = of_mdiobus_register(new_bus, pdev->dev.of_node);
>  	if (ret)
>  		mdio_gpio_bus_deinit(&pdev->dev);
>  
> diff --git a/drivers/net/phy/mdio-mscc-miim.c b/drivers/net/phy/mdio-mscc-miim.c
> index 8c689ccfdbca..badbc99bedd3 100644
> --- a/drivers/net/phy/mdio-mscc-miim.c
> +++ b/drivers/net/phy/mdio-mscc-miim.c
> @@ -151,11 +151,7 @@ static int mscc_miim_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	if (pdev->dev.of_node)
> -		ret = of_mdiobus_register(bus, pdev->dev.of_node);
> -	else
> -		ret = mdiobus_register(bus);
> -
> +	ret = of_mdiobus_register(bus, pdev->dev.of_node);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Cannot register MDIO bus (%d)\n", ret);
>  		return ret;
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 91761436709a..8dff87ec6d99 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -1843,12 +1843,9 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
>  	}
>  
>  	node = of_get_child_by_name(dev->udev->dev.of_node, "mdio");
> -	if (node) {
> -		ret = of_mdiobus_register(dev->mdiobus, node);
> +	ret = of_mdiobus_register(dev->mdiobus, node);
> +	if (node)
>  		of_node_put(node);
> -	} else {
> -		ret = mdiobus_register(dev->mdiobus);
> -	}
>  	if (ret) {
>  		netdev_err(dev->net, "can't register MDIO bus\n");
>  		goto exit1;
> -- 
> 2.14.1
> 

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
