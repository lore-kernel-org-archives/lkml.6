Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057F2ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9724120882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q0REFQG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9724120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeINSQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:16:28 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34554 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeINSQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=76P+7sosZOjBwy10dZ05jlKGrqDPIegzOkR5vs0b7is=;
        b=q0REFQG0DqxGWsXEmsxFF/Kfa0NrVsPoJUv/ajgg2LXJs+S7ZLxm+aSW6GokGSdupw7WfUY+DhZqaKCXqLDG8lOQaA10fcKxKNQ4zQKEQhWZRNqGZl9DLyZfyJwPFulkngEJk6qvOYtaMp3eALwskm/XkXMR/XR8bntploTECzc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g0njQ-0004AK-2k; Fri, 14 Sep 2018 15:01:56 +0200
Date:   Fri, 14 Sep 2018 15:01:56 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
Subject: Re: [PATCH net-next 1/5] net: phy: mscc: add ethtool statistics
 counters
Message-ID: <20180914130156.GB14865@lunn.ch>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
 <e220fe75053e200f91554b752905d84b14b76eb6.1536913944.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e220fe75053e200f91554b752905d84b14b76eb6.1536913944.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin

> +static struct vsc85xx_hw_stat vsc85xx_hw_stats[] = {

You could add a const to that.

> +	{
> +		.string	= "phy_receive_errors",
> +		.reg	= MSCC_PHY_ERR_RX_CNT,
> +		.page	= MSCC_PHY_PAGE_STANDARD,
> +		.mask	= ERR_CNT_MASK,
> +	}, {
> +		.string	= "phy_false_carrier",
> +		.reg	= MSCC_PHY_ERR_FALSE_CARRIER_CNT,
> +		.page	= MSCC_PHY_PAGE_STANDARD,
> +		.mask	= ERR_CNT_MASK,
> +	}, {
> +		.string	= "phy_cu_media_link_disconnect",
> +		.reg	= MSCC_PHY_ERR_LINK_DISCONNECT_CNT,
> +		.page	= MSCC_PHY_PAGE_STANDARD,
> +		.mask	= ERR_CNT_MASK,
> +	}, {
> +		.string	= "phy_cu_media_crc_good_count",
> +		.reg	= MSCC_PHY_CU_MEDIA_CRC_VALID_CNT,
> +		.page	= MSCC_PHY_PAGE_EXTENDED,
> +		.mask	= VALID_CRC_CNT_CRC_MASK,
> +	}, {
> +		.string	= "phy_cu_media_crc_error_count",
> +		.reg	= MSCC_PHY_EXT_PHY_CNTL_4,
> +		.page	= MSCC_PHY_PAGE_EXTENDED,
> +		.mask	= ERR_CNT_MASK,
> +	},
> +};

> +static u64 vsc85xx_get_stat(struct phy_device *phydev, int i)
> +{
> +	struct vsc8531_private *priv = phydev->priv;
> +	int val;
> +	u64 ret;
> +
> +	vsc85xx_phy_page_set(phydev, priv->hw_stats[i].page);

I might of asked this before...

Does changing the page effect registers in the lower range? It is
possible for other operations to happen at the same time, and you
don't want for example a status read to happen from some other
extended page register because a statistics read is happening.

phy_read_page() and phy_write_page() will do the needed locking if
this is an issue.

> @@ -673,6 +782,13 @@ static int vsc85xx_probe(struct phy_device *phydev)
>  	vsc8531->rate_magic = rate_magic;
>  	vsc8531->nleds = 2;
>  	vsc8531->supp_led_modes = VSC85XX_SUPP_LED_MODES;
> +	vsc8531->hw_stats = vsc85xx_hw_stats;
> +	vsc8531->nstats = ARRAY_SIZE(vsc85xx_hw_stats);
> +	vsc8531->stats = devm_kzalloc(&phydev->mdio.dev,
> +				      sizeof(u64) * vsc8531->nstats,
> +				      GFP_KERNEL);

devm_kmalloc_array()? The security people prefer that.

> +	if (!vsc8531->stats)
> +		return -ENOMEM;
>  
>  	return vsc85xx_dt_led_modes_get(phydev, default_mode);
>  }

   Andrew
