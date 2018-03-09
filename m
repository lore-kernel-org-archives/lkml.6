Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbeCIJ1X (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:27:23 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56379 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbeCIJ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:27:21 -0500
Message-ID: <1520587632.19507.3.camel@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: i.MX25: define SSI FIFO depth
From: Lucas Stach <l.stach@pengutronix.de>
To: Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>,
        Martin Kaiser <martin@kaiser.cx>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Date: Fri, 09 Mar 2018 10:27:12 +0100
In-Reply-To: <20180309093738.7cd5fded@karo-electronics.de>
References: <1520373499-13623-1-git-send-email-martin@kaiser.cx>
         <20180308161135.1f3d3d18@karo-electronics.de>
         <20180308153832.GA28454@botnar.kaiser.cx>
         <20180309093738.7cd5fded@karo-electronics.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lothar,

Am Freitag, den 09.03.2018, 09:37 +0100 schrieb Lothar Waßmann:
> Hi,
> 
> On Thu, 8 Mar 2018 16:38:32 +0100 Martin Kaiser wrote:
> > Hi Lothar,
> > 
> > > > Thus wrote Lothar Waßmann (LW@KARO-electronics.de):
> > 
> > > > diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> > > > index 9725705..cf70df2 100644
> > > > --- a/arch/arm/boot/dts/imx25.dtsi
> > > > +++ b/arch/arm/boot/dts/imx25.dtsi
> > > > @@ -269,6 +269,7 @@
> > > > > > > >  				dmas = <&sdma 24 1 0>,
> > > > > > > >  				       <&sdma 25 1 0>;
> > > > > > > >  				dma-names = "rx", "tx";
> > > > > > > > +				fsl,fifo-depth = <15>;
> > > > > > > >  				status = "disabled";
> > > > > > > >  			};
> > > > @@ -329,6 +330,7 @@
> > > > > > > >  				dmas = <&sdma 28 1 0>,
> > > > > > > >  				       <&sdma 29 1 0>;
> > > > > > > >  				dma-names = "rx", "tx";
> > > > > > > > +				fsl,fifo-depth = <15>;
> > > > > > > >  				status = "disabled";
> > > >  			};
> > > You are changing the global .dtsi file. Did you test this change with
> > > all devices that are affected by it?
> > 
> > I changed the hardware description of the imx25 SSI to match the
> > reference manual.
> > 
> > I did test this change on an imx25 board with audio playback. This uses
> > the SSI description I modified. I verified that the driver is actually
> > taking the modified setting into account and that this causes no
> > problems.
> > 
> > As of today, this setting is used by the fsl_ssi driver to set the fifo
> > water level for dma requests.
> > 
> > Of course, I don't have access to the enitre range of supported imx25
> > boards and I don't think this is required for submitting patches.
> > 
> > Do you have any indication why this patch should not be merged?
> > 
> 
> Usually patches should not willy-nilly change the behaviour of existing
> configurations unless they fix any real life bugs.

With this logic we wouldn't be able to get most driver changes applied.
If it is matching the reference manual and has been tested on the
affected hardware it should be good to go.

If you know about any specific corner cases that might break with this
change, please speak up now. Don't reject patches based on the
overarching "it might break something" argument.

Regards,
Lucas
