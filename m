Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbeC1QTL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 12:19:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39282 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbeC1QTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 12:19:07 -0400
Date: Wed, 28 Mar 2018 18:18:55 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
Subject: Re: [PATCH net-next 1/8] net: phy: Add initial support for Microsemi
 Ocelot internal PHYs.
Message-ID: <20180328161855.GJ13942@piout.net>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-2-alexandre.belloni@bootlin.com>
 <1caa7359-9ca3-be22-fae0-475daf8b220f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1caa7359-9ca3-be22-fae0-475daf8b220f@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2018 at 14:08:10 -0700, Florian Fainelli wrote:
> On 03/23/2018 01:11 PM, Alexandre Belloni wrote:
> > Add Microsemi Ocelot internal PHY ids. For now, simply use the genphy
> > functions but more features are available.
> > 
> > Cc: Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  drivers/net/phy/mscc.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> > index 650c2667d523..e1ab3acd1cdb 100644
> > --- a/drivers/net/phy/mscc.c
> > +++ b/drivers/net/phy/mscc.c
> > @@ -91,6 +91,7 @@ enum rgmii_rx_clock_delay {
> >  #define SECURE_ON_PASSWD_LEN_4		  0x4000
> >  
> >  /* Microsemi PHY ID's */
> > +#define PHY_ID_OCELOT			  0x00070540
> >  #define PHY_ID_VSC8530			  0x00070560
> >  #define PHY_ID_VSC8531			  0x00070570
> >  #define PHY_ID_VSC8540			  0x00070760
> > @@ -658,6 +659,19 @@ static int vsc85xx_probe(struct phy_device *phydev)
> >  
> >  /* Microsemi VSC85xx PHYs */
> >  static struct phy_driver vsc85xx_driver[] = {
> > +{
> > +	.phy_id		= PHY_ID_OCELOT,
> > +	.name		= "Microsemi OCELOT",
> > +	.phy_id_mask    = 0xfffffff0,
> > +	.features	= PHY_GBIT_FEATURES,
> > +	.soft_reset	= &genphy_soft_reset,
> > +	.config_init	= &genphy_config_init,
> > +	.config_aneg	= &genphy_config_aneg,
> > +	.aneg_done	= &genphy_aneg_done,
> > +	.read_status	= &genphy_read_status,
> > +	.suspend	= &genphy_suspend,
> > +	.resume		= &genphy_resume,
> 
> With the exception of config_init(), suspend and resume, everything else
> is already the default when you don't provide a callback. To echo to
> what Andrew wrote already, if the purpose is just to show a nice name,
> and do nothing else, consider using the Generic PHY driver (default).

Ok, I'll drop this patch for now, until we handle more features for that
PHY.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
