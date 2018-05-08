Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbeEHMeb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:34:31 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52306 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbeEHMea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:34:30 -0400
Date: Tue, 8 May 2018 13:34:08 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: davem@davemloft.net, kishon@ti.com, gregory.clement@bootlin.com,
        andrew@lunn.ch, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 06/13] phy: add 2.5G SGMII mode to the
 phy_mode enum
Message-ID: <20180508123408.GK16141@n2100.armlinux.org.uk>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
 <20180504135643.23466-7-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504135643.23466-7-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 03:56:36PM +0200, Antoine Tenart wrote:
> This patch adds one more generic PHY mode to the phy_mode enum, to allow
> configuring generic PHYs to the 2.5G SGMII mode by using the set_mode
> callback.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Hi,

Would it be possible to get the 2.5G SGMII comphy support merged
ahead of the rest of this series please - I don't think there's been
any objections to it, and having it in mainline would then mean I can
drop the Marvell Comphy code from my tree and transition to the bootlin
Comphy code instead.

Of course, the perfect solution would be to get the whole series merged,
but I'm just thinking about the situation where we're still discussing
points when the next merge window opens.

Thanks.

> ---
>  include/linux/phy/phy.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index c9d14eeee7f5..9713aebdd348 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -36,6 +36,7 @@ enum phy_mode {
>  	PHY_MODE_USB_DEVICE_SS,
>  	PHY_MODE_USB_OTG,
>  	PHY_MODE_SGMII,
> +	PHY_MODE_2500SGMII,
>  	PHY_MODE_10GKR,
>  	PHY_MODE_UFS_HS_A,
>  	PHY_MODE_UFS_HS_B,
> -- 
> 2.17.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
