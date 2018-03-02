Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428690AbeCBOo1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:44:27 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36975 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426404AbeCBOoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:44:24 -0500
Date: Fri, 2 Mar 2018 15:44:20 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: tpc: Device tree description of the TPC board
Message-ID: <20180302144420.37trllgposf4yet3@pengutronix.de>
References: <20180302121750.12865-1-lukma@denx.de>
 <20180302125159.gufvhyy4ipyunmil@pengutronix.de>
 <20180302142537.25764c8e@jawa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302142537.25764c8e@jawa>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:31:02 up 70 days, 22:49, 82 users,  load average: 0.23, 0.15,
 0.11
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 02:25:37PM +0100, Lukasz Majewski wrote:
> Hi Sascha,
> 
> > Hi Lukasz,
> > 
> > On Fri, Mar 02, 2018 at 01:17:50PM +0100, Lukasz Majewski wrote:
> > > This commit adds device tree description of K+P's TPC board.  
> > 
> > Can we get a hint what this board is? I assume this one:
> > 
> > Technologic Systems' Full i.MX6 Portfolio Including SBC, COM, and
> > Touch Panel PCs
> 
> I just took other imx6q boards as an example - e.g. 
> 
> 420127e5a5b53ff2cb5effaa781aed93709b09bb
> 
> Generally, descriptions of DTSes are rather short and simple.
> 
> > 
> > Anyway, future developers are thankful if they have the information
> > around when they have to work on that file or have to decide if it is
> > to be removed.
> 
> IMHO, there is plenty of information around (iMX6 Quad SoC, with
> components described in dts).

There may be future changes necessary which may be done by people who do
not know which hardware this. For them it will be convenient to be able
to search for the hardware and maybe even find a schematics. Anyway, it
will just help to have that information around.

> > > +&can1 {
> > > +	status = "disabled";
> > > +};
> > > +
> > > +&can2 {
> > > +	status = "disabled";
> > > +};  
> > 
> > These are not enabled in your base dtsi, so no need to disabled it
> > here.
> 
> But they can be enabled if needed.

Yes, they can, but that still doesn't make these node references necessary.
If I read this it seems to me that you explicitly want to disable these
nodes. A reader can't know you add them for convenience here.

> > > diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi
> > > b/arch/arm/boot/dts/imx6q-kp.dtsi new file mode 100644
> > > index 000000000000..47a10fb1d46b
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/imx6q-kp.dtsi
> > > +
> > > +	memory: memory {
> > > +		reg = <0x10000000 0x40000000>;
> > > +	};
> > > +
> > > +	pwm-buzzer {
> > > +		compatible = "pwm-backlight";  
> > 
> > What is it? A backlight or a buzzer?
> 
> It is a buzzer, which is controlled by PWM.

Then you should bind the pwm-beeper driver to it, not a backlight.

Regards,
  Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
