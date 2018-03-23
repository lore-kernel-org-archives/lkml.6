Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeCWU3v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 16:29:51 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40602 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbeCWU3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 16:29:49 -0400
Date: Fri, 23 Mar 2018 21:29:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
Subject: Re: [PATCH net-next 1/8] net: phy: Add initial support for Microsemi
 Ocelot internal PHYs.
Message-ID: <20180323202942.GR24361@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323201117.8416-2-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 09:11:10PM +0100, Alexandre Belloni wrote:
> Add Microsemi Ocelot internal PHY ids. For now, simply use the genphy
> functions but more features are available.
> 
> Cc: Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/net/phy/mscc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> index 650c2667d523..e1ab3acd1cdb 100644
> --- a/drivers/net/phy/mscc.c
> +++ b/drivers/net/phy/mscc.c
> @@ -91,6 +91,7 @@ enum rgmii_rx_clock_delay {
>  #define SECURE_ON_PASSWD_LEN_4		  0x4000
>  
>  /* Microsemi PHY ID's */
> +#define PHY_ID_OCELOT			  0x00070540
>  #define PHY_ID_VSC8530			  0x00070560
>  #define PHY_ID_VSC8531			  0x00070570
>  #define PHY_ID_VSC8540			  0x00070760
> @@ -658,6 +659,19 @@ static int vsc85xx_probe(struct phy_device *phydev)
>  
>  /* Microsemi VSC85xx PHYs */
>  static struct phy_driver vsc85xx_driver[] = {
> +{
> +	.phy_id		= PHY_ID_OCELOT,
> +	.name		= "Microsemi OCELOT",
> +	.phy_id_mask    = 0xfffffff0,
> +	.features	= PHY_GBIT_FEATURES,

No interrupt support? In fact, the only advantage i see this brings
over the generic driver is that the name Microsemi OCELOT is printed.

     Andrew

> +	.soft_reset	= &genphy_soft_reset,
> +	.config_init	= &genphy_config_init,
> +	.config_aneg	= &genphy_config_aneg,
> +	.aneg_done	= &genphy_aneg_done,
> +	.read_status	= &genphy_read_status,
> +	.suspend	= &genphy_suspend,
> +	.resume		= &genphy_resume,
> +},
