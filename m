Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02C8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92AB921905
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1TVCUHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbfBLTPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:15:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36611 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfBLTPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:15:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id o17so4006934wrw.3;
        Tue, 12 Feb 2019 11:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pj79uPz3GMKl1ZChwzqRlGjlNQzcr4MgHkvoWErP+W0=;
        b=t1TVCUHxt0FEbkmzEoLr1ofg3t4zk91xbPjo4QUh24sfgS2dKCsyA/BVLB1mngGv3q
         WcjF2Vm8o7+VccNyfXsEJZ9yCSgIuz1ZFQEg3cTcPVCYaWq7+CQikpT7jUzzb50a37Z3
         dnGwMmV8dTcPAxyTXdOB42mSvzkBARG3t+QAOpXGy+IvqMHVLmPMcKfUDTwFfTh/HJBO
         eXZDkLtB9YbFfGgdlkisg7pagrJFAQCe3CQlUTki6e8rwv87MU4bsM5+7Y7rhWw2lzQD
         i9vA1n3Q7dftOx4kRB3BHFnjRSg1HXAuweU8Mw+E1jLbyxR7gSeTw1/oWc0tO+JLAD4g
         dBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pj79uPz3GMKl1ZChwzqRlGjlNQzcr4MgHkvoWErP+W0=;
        b=h1/AWUCw+LCMzZeQn2JFrquDj1v5Zv/AJ/ict00jSfpUFYi7DXP46KiydsASSREUXY
         CUDv0kTLZ9kZiXg6YOnLRJ5tPt6teybWNsbQqLkkNFETvXM5w6gXzyh6i4cjCHd1xDuA
         qLydZzFkhSQLNhmJdMbbCoxQwvY/RDtSwN5FmV4Z468ZjBmHTNluKBuMTMXLxorNr0LT
         ddSY9io6WJlctDcOROkDRAaXia2BwCW9FhNSgJLAhulszVifYo965x3gyc6ITS24BQy0
         HroJzid5OFByab94eerFz45J4DuBvrBi1EIvSouKUZvMAcpo9isVhWa7oFeAFwnpNuEA
         ldfQ==
X-Gm-Message-State: AHQUAuY/9Z1UOgvRQWMIRVUKmCNlL+2sjUQdl3Ldo8PSz1i+rh7suMGJ
        8LmgwO3HbCEeShZhqhyiRUc=
X-Google-Smtp-Source: AHgI3IafGn4ML6tAjwRwOCzcRp8aLsBfm7nyogZ1mBlheTQWMcCr6x3PdiUzMJHRs9CLcPUkasC+bg==
X-Received: by 2002:a5d:574e:: with SMTP id q14mr3992117wrw.200.1549998902904;
        Tue, 12 Feb 2019 11:15:02 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:788d:bad3:281d:6cd0? (p200300EA8BF1E200788DBAD3281D6CD0.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:788d:bad3:281d:6cd0])
        by smtp.googlemail.com with ESMTPSA id f17sm2009633wmh.40.2019.02.12.11.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 11:15:02 -0800 (PST)
Subject: Re: [PATCH net-next 4/4] net: phy: Add generic support for 2.5GBaseT
 and 5GBaseT
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
References: <20190211142529.22885-1-maxime.chevallier@bootlin.com>
 <20190211142529.22885-5-maxime.chevallier@bootlin.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <5f14bfd3-c9cc-79c5-bc7b-5f18397ba94e@gmail.com>
Date:   Tue, 12 Feb 2019 20:14:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211142529.22885-5-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.02.2019 15:25, Maxime Chevallier wrote:
> The 802.3bz specification, based on previous by the NBASET alliance,
> defines the 2.5GBaseT and 5GBaseT link modes for ethernet traffic on
> cat5e, cat6 and cat7 cables.
> 
> These mode integrate with the already defined C45 MDIO PMA/PMD registers
> set that added 10G support, by defining some previously reserved bits,
> and adding a new register (2.5G/5G Extended abilities).
> 
> This commit adds the required definitions in include/uapi/linux/mdio.h
> to support these modes, and detect when a link-partner advertises them.
> 
> It also adds support for these mode in the generic C45 PHY
> infrastructure.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/phy-c45.c | 37 +++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/mdio.h | 16 ++++++++++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
> index 6f028de4dae1..7af5fa81daf6 100644
> --- a/drivers/net/phy/phy-c45.c
> +++ b/drivers/net/phy/phy-c45.c
> @@ -47,6 +47,16 @@ int genphy_c45_pma_setup_forced(struct phy_device *phydev)
>  		/* Assume 1000base-T */
>  		ctrl2 |= MDIO_PMA_CTRL2_1000BT;
>  		break;
> +	case SPEED_2500:
> +		ctrl1 |= MDIO_CTRL1_SPEED2_5G;
> +		/* Assume 2.5Gbase-T */
> +		ctrl2 |= MDIO_PMA_CTRL2_2_5GBT;
> +		break;
> +	case SPEED_5000:
> +		ctrl1 |= MDIO_CTRL1_SPEED5G;
> +		/* Assume 5Gbase-T */
> +		ctrl2 |= MDIO_PMA_CTRL2_5GBT;
> +		break;
>  	case SPEED_10000:
>  		ctrl1 |= MDIO_CTRL1_SPEED10G;
>  		/* Assume 10Gbase-T */
> @@ -194,6 +204,12 @@ int genphy_c45_read_lpa(struct phy_device *phydev)
>  	if (val < 0)
>  		return val;
>  
> +	if (val & MDIO_AN_10GBT_STAT_LP2_5G)
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +				 phydev->lp_advertising);
> +	if (val & MDIO_AN_10GBT_STAT_LP5G)
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +				 phydev->lp_advertising);
>  	if (val & MDIO_AN_10GBT_STAT_LP10G)
>  		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
>  				 phydev->lp_advertising);
> @@ -224,6 +240,12 @@ int genphy_c45_read_pma(struct phy_device *phydev)
>  	case MDIO_PMA_CTRL1_SPEED1000:
>  		phydev->speed = SPEED_1000;
>  		break;
> +	case MDIO_CTRL1_SPEED2_5G:
> +		phydev->speed = SPEED_2500;
> +		break;
> +	case MDIO_CTRL1_SPEED5G:
> +		phydev->speed = SPEED_5000;
> +		break;
>  	case MDIO_CTRL1_SPEED10G:
>  		phydev->speed = SPEED_10000;
>  		break;
> @@ -339,6 +361,21 @@ int genphy_c45_pma_read_abilities(struct phy_device *phydev)
>  		linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
>  				 phydev->supported,
>  				 val & MDIO_PMA_EXTABLE_10BT);
> +
> +		if (val & MDIO_PMA_EXTABLE_NBT) {
> +			val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
> +					   MDIO_PMA_NG_EXTABLE);
> +			if (val < 0)
> +				return val;
> +
> +			linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +					 phydev->supported,
> +					 val & MDIO_PMA_NG_EXTABLE_2_5GBT);
> +
> +			linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +					 phydev->supported,
> +					 val & MDIO_PMA_NG_EXTABLE_5GBT);
> +		}
>  	}
>  
>  	return 0;
> diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
> index 0e012b168e4d..0a552061ff1c 100644
> --- a/include/uapi/linux/mdio.h
> +++ b/include/uapi/linux/mdio.h
> @@ -45,6 +45,7 @@
>  #define MDIO_AN_ADVERTISE	16	/* AN advertising (base page) */
>  #define MDIO_AN_LPA		19	/* AN LP abilities (base page) */
>  #define MDIO_PCS_EEE_ABLE	20	/* EEE Capability register */
> +#define MDIO_PMA_NG_EXTABLE	21	/* 2.5G/5G PMA/PMD extended ability */
>  #define MDIO_PCS_EEE_WK_ERR	22	/* EEE wake error counter */
>  #define MDIO_PHYXS_LNSTAT	24	/* PHY XGXS lane state */
>  #define MDIO_AN_EEE_ADV		60	/* EEE advertisement */
> @@ -92,6 +93,10 @@
>  #define MDIO_CTRL1_SPEED10G		(MDIO_CTRL1_SPEEDSELEXT | 0x00)
>  /* 10PASS-TS/2BASE-TL */
>  #define MDIO_CTRL1_SPEED10P2B		(MDIO_CTRL1_SPEEDSELEXT | 0x04)
> +/* 2.5 Gb/s */
> +#define MDIO_CTRL1_SPEED2_5G		(MDIO_CTRL1_SPEEDSELEXT | 0x18)
> +/* 5 Gb/s */
> +#define MDIO_CTRL1_SPEED5G		(MDIO_CTRL1_SPEEDSELEXT | 0x1c)
>  
>  /* Status register 1. */
>  #define MDIO_STAT1_LPOWERABLE		0x0002	/* Low-power ability */
> @@ -145,6 +150,8 @@
>  #define MDIO_PMA_CTRL2_1000BKX		0x000d	/* 1000BASE-KX type */
>  #define MDIO_PMA_CTRL2_100BTX		0x000e	/* 100BASE-TX type */
>  #define MDIO_PMA_CTRL2_10BT		0x000f	/* 10BASE-T type */
> +#define MDIO_PMA_CTRL2_2_5GBT		0x0030  /* 2.5GBaseT type */
> +#define MDIO_PMA_CTRL2_5GBT		0x0031  /* 5GBaseT type */
>  #define MDIO_PCS_CTRL2_TYPE		0x0003	/* PCS type selection */
>  #define MDIO_PCS_CTRL2_10GBR		0x0000	/* 10GBASE-R type */
>  #define MDIO_PCS_CTRL2_10GBX		0x0001	/* 10GBASE-X type */
> @@ -198,6 +205,7 @@
>  #define MDIO_PMA_EXTABLE_1000BKX	0x0040	/* 1000BASE-KX ability */
>  #define MDIO_PMA_EXTABLE_100BTX		0x0080	/* 100BASE-TX ability */
>  #define MDIO_PMA_EXTABLE_10BT		0x0100	/* 10BASE-T ability */
> +#define MDIO_PMA_EXTABLE_NBT		0x4000  /* 2.5/5GBASE-T ability */
>  
>  /* PHY XGXS lane state register. */
>  #define MDIO_PHYXS_LNSTAT_SYNC0		0x0001
> @@ -234,9 +242,13 @@
>  #define MDIO_PCS_10GBRT_STAT2_BER	0x3f00
>  
>  /* AN 10GBASE-T control register. */
> +#define MDIO_AN_10GBT_CTRL_ADV2_5G	0x0080	/* Advertise 2.5GBASE-T */
> +#define MDIO_AN_10GBT_CTRL_ADV5G	0x0100	/* Advertise 5GBASE-T */
>  #define MDIO_AN_10GBT_CTRL_ADV10G	0x1000	/* Advertise 10GBASE-T */
>  
>  /* AN 10GBASE-T status register. */
> +#define MDIO_AN_10GBT_STAT_LP2_5G	0x0020  /* LP is 2.5GBT capable */
> +#define MDIO_AN_10GBT_STAT_LP5G		0x0040  /* LP is 5GBT capable */
>  #define MDIO_AN_10GBT_STAT_LPTRR	0x0200	/* LP training reset req. */
>  #define MDIO_AN_10GBT_STAT_LPLTABLE	0x0400	/* LP loop timing ability */
>  #define MDIO_AN_10GBT_STAT_LP10G	0x0800	/* LP is 10GBT capable */
> @@ -265,6 +277,10 @@
>  #define MDIO_EEE_10GKX4		0x0020	/* 10G KX4 EEE cap */
>  #define MDIO_EEE_10GKR		0x0040	/* 10G KR EEE cap */
>  
> +/* 2.5G/5G Extended abilities register. */
> +#define MDIO_PMA_NG_EXTABLE_2_5GBT	0x0001	/* 2.5GBASET ability */
> +#define MDIO_PMA_NG_EXTABLE_5GBT	0x0002	/* 5GBASET ability */
> +
>  /* LASI RX_ALARM control/status registers. */
>  #define MDIO_PMA_LASI_RX_PHYXSLFLT	0x0001	/* PHY XS RX local fault */
>  #define MDIO_PMA_LASI_RX_PCSLFLT	0x0008	/* PCS RX local fault */
> 
Looks good to me.

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

Heiner
