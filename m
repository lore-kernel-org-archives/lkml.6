Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD202C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D6320645
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBhQR4aE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfBYCbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 21:31:06 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43103 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfBYCbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 21:31:05 -0500
Received: by mail-oi1-f194.google.com with SMTP id i8so6060658oib.10;
        Sun, 24 Feb 2019 18:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tk70JKHkKH4RuTLo3ofETusPkXwTSKlS1nzM85K/z9o=;
        b=KBhQR4aEyqjoy2d20aMMMSOfOU0g/TBWrmBd9n00GbxEvHJ/+w/U7xq1Y5oN0yQhoH
         GfnDU/A10vWCsTdM8ohkSrHMbWyaVbenT+qW3U5BV56hNX4jh+mriP1ihWi+jLW6DJmr
         Q4RLFTlUWF0vfFuJ9i/j0nmoQdfQfX0VfgouYrDR4S5rCru1iYTIg5KS6H7MLsc4UQ6u
         Dy2l9lJHL75arQ1IYHlz0JyLf+/RZjrrFCP1rjqBGTq30gg67AE6RVnaCpCXH+rwm8/v
         1EJcr2TpqLUMHcAVlCEDSto0EdCaYcsNMCrIMVbMAwtBX6DIVNPnx9tAZ+PhnmjGU7ft
         LPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Tk70JKHkKH4RuTLo3ofETusPkXwTSKlS1nzM85K/z9o=;
        b=fj7hrM7f99GCSQVDr9aZzQNvBbEuDjuH1pEiFjSJZ/jmND/bDZPUcvlAngq79BxVlS
         Uc6peymjXAKgvB0ShO8ehMHKliMWd0GOwOigdbqZjMGhsV1ZL9dJ+ZIlgvTF9r+kJT74
         ouMysN7s3CykvrUwdmkSY7LHORWs3aBl4M/PW9SAxvSOdRkwuIFB2lP2WCAGuwEGiD8R
         Wy+L49vozssan+FzWiIEuUqzj90moo/AKSC2LzQH10rvymDi1P79AaImmA7vjU3ImJXY
         kqlKAC6phDWTGyOdrwqyLQwDBm6vmP5HyFqS2cpqaXzRUlHXHiugAL8grl92xMn2GoI7
         ZhIw==
X-Gm-Message-State: AHQUAuYooPXPifPUR2qVBTwd3bmeicgSEozgusJIRHaYJFn2S0JullTI
        sH4VaKl6bJN9XUdUWUrjf7/uRPT2
X-Google-Smtp-Source: AHgI3IZtXKk6YOCU4WAfDo/w9NI01RFEDJH4oF9whcuNlZdEQwyMU6eDXRdcprXRG8tsutRzKc/Sxw==
X-Received: by 2002:aca:cd13:: with SMTP id d19mr9858364oig.5.1551061864110;
        Sun, 24 Feb 2019 18:31:04 -0800 (PST)
Received: from [192.168.1.2] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.googlemail.com with ESMTPSA id z5sm3514708otm.14.2019.02.24.18.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 18:31:03 -0800 (PST)
To:     Parshuram Thombare <pthombar@cadence.com>,
        nicolas.ferre@microchip.com, davem@davemloft.net,
        netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, rafalc@cadence.com,
        piotrs@cadence.com, jank@cadence.com
References: <20190222201225.GA15633@lvlogina.cadence.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 a9BQwACgnzGuH1BVeT2J0Ra+ZYgkx7DaPR0=
Subject: Re: [PATCH 1/3] net: ethernet: add support for PCS and 2.5G speed
Message-ID: <673edcd1-9ea5-9efe-1f66-3f8ea8d3f092@gmail.com>
Date:   Sun, 24 Feb 2019 18:31:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222201225.GA15633@lvlogina.cadence.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 2/22/19 à 12:12 PM, Parshuram Thombare a écrit :
> This patch add support for PCS (for SGMII interface) and 2.5Gbps MAC
> in Cadence ethernet controller driver.

At a high level you don't seem to be making use of PHYLINK so which
2.5Gbps interfaces do you actually support?

> 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---

[snip]

> @@ -361,26 +361,50 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
>   * macb_set_tx_clk() - Set a clock to a new frequency
>   * @clk		Pointer to the clock to change
>   * @rate	New frequency in Hz
> + * @interafce	Phy interface

Typo: @interface and this is an unrelated change.

>   * @dev		Pointer to the struct net_device
>   */
> -static void macb_set_tx_clk(struct clk *clk, int speed, struct net_device *dev)
> +static void macb_set_tx_clk(struct clk *clk, int speed,
> +			    phy_interface_t interface, struct net_device *dev)
>  {
>  	long ferr, rate, rate_rounded;
>  
>  	if (!clk)
>  		return;
>  
> -	switch (speed) {
> -	case SPEED_10:
> +	if (interface == PHY_INTERFACE_MODE_GMII ||
> +	    interface == PHY_INTERFACE_MODE_MII) {
> +		switch (speed) {
> +		case SPEED_10:>  		rate = 2500000;

You need to add one tab to align rate and break.

>  		break;
> -	case SPEED_100:
> +		case SPEED_100:
>  		rate = 25000000;
>  		break;
> -	case SPEED_1000:
> +		case SPEED_1000:
>  		rate = 125000000;
>  		break;
> -	default:
> +		default:
> +		return;
> +		}
> +	} else if (interface == PHY_INTERFACE_MODE_SGMII) {
> +		switch (speed) {
> +		case SPEED_10:
> +		rate = 1250000;
> +		break;
> +		case SPEED_100:
> +		rate = 12500000;
> +		break;
> +		case SPEED_1000:
> +		rate = 125000000;
> +		break;
> +		case SPEED_2500:
> +		rate = 312500000;
> +		break;
> +		default:
> +		return;

The indentation is broken here and you can greatly simplify this with a
simple function that returns speed * 1250 and does an initial check for
unsupported speeds.

> +		}
> +	} else {
>  		return;
>  	}
>  
> @@ -410,30 +434,49 @@ static void macb_handle_link_change(struct net_device *dev)
>  
>  	spin_lock_irqsave(&bp->lock, flags);
>  
> -	if (phydev->link) {
> -		if ((bp->speed != phydev->speed) ||
> -		    (bp->duplex != phydev->duplex)) {
> -			u32 reg;
> -
> -			reg = macb_readl(bp, NCFGR);
> -			reg &= ~(MACB_BIT(SPD) | MACB_BIT(FD));
> -			if (macb_is_gem(bp))
> -				reg &= ~GEM_BIT(GBE);
> +	if (phydev->link && (bp->speed != phydev->speed ||
> +			     bp->duplex != phydev->duplex)) {
> +		u32 reg;
>  
> -			if (phydev->duplex)
> -				reg |= MACB_BIT(FD);
> +		reg = macb_readl(bp, NCFGR);
> +		reg &= ~(MACB_BIT(SPD) | MACB_BIT(FD));
> +		if (macb_is_gem(bp))
> +			reg &= ~GEM_BIT(GBE);
> +		if (phydev->duplex)
> +			reg |= MACB_BIT(FD);
> +		macb_or_gem_writel(bp, NCFGR, reg);
> +
> +		if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII &&
> +		    (phydev->speed == SPEED_1000 ||
> +		     phydev->speed == SPEED_2500)) {
> +			if (bp->caps & MACB_CAPS_TWO_PT_FIVE_GIG_SPEED) {
> +				reg = gem_readl(bp, NCR) &
> +					~GEM_BIT(TWO_PT_FIVE_GIG);
> +				gem_writel(bp, NCR, reg);
> +			}

If you are making correct use of the capabilities then there is no point
in re-checking them here. If you allowed the MAC to advertise 2.5Gbps
then it is de-facto SGMII capable.

> +			gem_writel(bp, NCFGR, GEM_BIT(GBE) |
> +					gem_readl(bp, NCFGR));
> +			if (bp->caps & MACB_CAPS_TWO_PT_FIVE_GIG_SPEED &&
> +			    phydev->speed == SPEED_2500)
> +				gem_writel(bp, NCR, gem_readl(bp, NCR) |
> +						GEM_BIT(TWO_PT_FIVE_GIG));
> +		} else if (phydev->speed == SPEED_1000) {
> +			gem_writel(bp, NCFGR, GEM_BIT(GBE) |
> +					gem_readl(bp, NCFGR));
> +		} else {
> +			if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
> +				reg = gem_readl(bp, NCFGR);
> +				reg &= ~(GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL));
> +				gem_writel(bp, NCFGR, reg);
> +			}
>  			if (phydev->speed == SPEED_100)
> -				reg |= MACB_BIT(SPD);
> -			if (phydev->speed == SPEED_1000 &&
> -			    bp->caps & MACB_CAPS_GIGABIT_MODE_AVAILABLE)
> -				reg |= GEM_BIT(GBE);
> -
> -			macb_or_gem_writel(bp, NCFGR, reg);
> -
> -			bp->speed = phydev->speed;
> -			bp->duplex = phydev->duplex;
> -			status_change = 1;
> +				macb_writel(bp, NCFGR, MACB_BIT(SPD) |
> +					macb_readl(bp, NCFGR));
>  		}

There is a lot of repetition while setting the GBE bit which always set
based on speed == 1000 irrespective of the mode, so take that part out
of the if () else if () else () clauses.

> +
> +		bp->speed = phydev->speed;
> +		bp->duplex = phydev->duplex;
> +		status_change = 1;
>  	}
>  
>  	if (phydev->link != bp->link) {
> @@ -453,7 +496,8 @@ static void macb_handle_link_change(struct net_device *dev)
>  			/* Update the TX clock rate if and only if the link is
>  			 * up and there has been a link change.
>  			 */
> -			macb_set_tx_clk(bp->tx_clk, phydev->speed, dev);
> +			macb_set_tx_clk(bp->tx_clk, phydev->speed,
> +					bp->phy_interface, dev);
>  
>  			netif_carrier_on(dev);
>  			netdev_info(dev, "link up (%d/%s)\n",
> @@ -543,10 +587,16 @@ static int macb_mii_probe(struct net_device *dev)
>  	}
>  
>  	/* mask with MAC supported features */
> -	if (macb_is_gem(bp) && bp->caps & MACB_CAPS_GIGABIT_MODE_AVAILABLE)
> -		phy_set_max_speed(phydev, SPEED_1000);
> -	else
> -		phy_set_max_speed(phydev, SPEED_100);
> +	if (macb_is_gem(bp)) {

You have changed the previous logic that also checked for
MACB_CAPS_GIGABIT_MODE_AVAILABLE, why?

> +		linkmode_copy(phydev->supported, PHY_GBIT_FEATURES);
> +		if (bp->caps & MACB_CAPS_TWO_PT_FIVE_GIG_SPEED)
> +			linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +					 phydev->supported);
> +	} else {
> +		linkmode_copy(phydev->supported, PHY_BASIC_FEATURES);
> +	}
> +
> +	linkmode_copy(phydev->advertising, phydev->supported);
>  
>  	if (bp->caps & MACB_CAPS_NO_GIGABIT_HALF)
>  		phy_remove_link_mode(phydev,
> @@ -2217,8 +2267,6 @@ static void macb_init_hw(struct macb *bp)
>  	macb_set_hwaddr(bp);
>  
>  	config = macb_mdc_clk_div(bp);
> -	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII)
> -		config |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
>  	config |= MACB_BF(RBOF, NET_IP_ALIGN);	/* Make eth data aligned */
>  	config |= MACB_BIT(PAE);		/* PAuse Enable */
>  	config |= MACB_BIT(DRFCS);		/* Discard Rx FCS */
> @@ -3255,6 +3303,23 @@ static void macb_configure_caps(struct macb *bp,
>  		dcfg = gem_readl(bp, DCFG1);
>  		if (GEM_BFEXT(IRQCOR, dcfg) == 0)
>  			bp->caps |= MACB_CAPS_ISR_CLEAR_ON_WRITE;
> +		if (GEM_BFEXT(NO_PCS, dcfg) == 0)
> +			bp->caps |= MACB_CAPS_PCS;
> +		switch (MACB_BFEXT(IDNUM, macb_readl(bp, MID))) {
> +		case MACB_GEM7016_IDNUM:
> +		case MACB_GEM7017_IDNUM:
> +		case MACB_GEM7017A_IDNUM:
> +		case MACB_GEM7020_IDNUM:
> +		case MACB_GEM7021_IDNUM:
> +		case MACB_GEM7021A_IDNUM:
> +		case MACB_GEM7022_IDNUM:
> +		if (bp->caps & MACB_CAPS_PCS)
> +			bp->caps |= MACB_CAPS_TWO_PT_FIVE_GIG_SPEED;
> +		break;
> +
> +		default:
> +		break;
> +		}
>  		dcfg = gem_readl(bp, DCFG2);
>  		if ((dcfg & (GEM_BIT(RX_PKT_BUFF) | GEM_BIT(TX_PKT_BUFF))) == 0)
>  			bp->caps |= MACB_CAPS_FIFO_MODE;
> @@ -4110,7 +4175,28 @@ static int macb_probe(struct platform_device *pdev)
>  		else
>  			bp->phy_interface = PHY_INTERFACE_MODE_MII;
>  	} else {
> +		switch (err) {
> +		case PHY_INTERFACE_MODE_SGMII:
> +		if (bp->caps & MACB_CAPS_PCS) {
> +			bp->phy_interface = PHY_INTERFACE_MODE_SGMII;
> +			break;
> +		}

If SGMII was selected on a version of the IP that does not support it,
then falling back to GMII or MII does not sound correct, this is a hard
error that must be handled as such.
-- 
Florian
