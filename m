Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeDEQAT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:00:19 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45460 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeDEQAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:00:17 -0400
X-Google-Smtp-Source: AIpwx4+MYJUQtA3P1ym6JmeZo3flXZF22vdDHp9CYu73mBd2i3lPDJDZ3cEPY6IENxbEEpO0n3LR3A==
Subject: Re: [PATCH 1/2] net: phy: Helper function for reading strapped
 configuration values
To: esben.haabendal@gmail.com, Andrew Lunn <andrew@lunn.ch>,
        "open list:ETHERNET PHY LIBRARY" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc: Esben Haabendal <eha@deif.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
References: <20180405114424.8519-1-esben.haabendal@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <49448b00-e3fd-25df-580e-c02428f1bfe6@gmail.com>
Date: Thu, 5 Apr 2018 09:00:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180405114424.8519-1-esben.haabendal@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/05/2018 04:44 AM, esben.haabendal@gmail.com wrote:
> From: Esben Haabendal <eha@deif.com>
> 
> Add a function for use in PHY driver probe functions, reading current
> autoneg, speed and duplex configuration from BMCR register.
> 
> Useful for PHY that supports hardware strapped configuration, enabling
> Linux to respect that configuration (i.e. strapped non-autoneg
> configuration).
> 
> Signed-off-by: Esben Haabendal <eha@deif.com>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  drivers/net/phy/phy_device.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/phy.h          |  1 +
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 74664a6c0cdc..cc52ff2a2344 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1673,6 +1673,47 @@ int genphy_config_init(struct phy_device *phydev)
>  }
>  EXPORT_SYMBOL(genphy_config_init);
>  
> +/**
> + * genphy_read_config - read configuration from PHY
> + * @phydev: target phy_device struct
> + *
> + * Description: Reads MII_BMCR and sets phydev autoneg, speed and duplex
> + * accordingly.  For use in driver probe functions, to respect strapped
> + * configuration settings.
> + */
> +int genphy_read_config(struct phy_device *phydev)

This duplicates what already exists, in part at least within
genphy_read_status() can you find a way to use that?

I really wonder how this is going to work though because an user can
decide to force the PHY to have auto-negotiation disabled just like a
MAC could actually attempt to do that while connecting to the PHY...
more comments in patch 2.
-- 
Florian
