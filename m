Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755993AbeCHPi5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:38:57 -0500
Received: from botnar.kaiser.cx ([176.28.20.183]:43156 "EHLO botnar.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755624AbeCHPiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:38:55 -0500
Date: Thu, 8 Mar 2018 16:38:32 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: i.MX25: define SSI FIFO depth
Message-ID: <20180308153832.GA28454@botnar.kaiser.cx>
References: <1520373499-13623-1-git-send-email-martin@kaiser.cx>
 <20180308161135.1f3d3d18@karo-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180308161135.1f3d3d18@karo-electronics.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lothar,

Thus wrote Lothar Waßmann (LW@KARO-electronics.de):

> > diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> > index 9725705..cf70df2 100644
> > --- a/arch/arm/boot/dts/imx25.dtsi
> > +++ b/arch/arm/boot/dts/imx25.dtsi
> > @@ -269,6 +269,7 @@
> >  				dmas = <&sdma 24 1 0>,
> >  				       <&sdma 25 1 0>;
> >  				dma-names = "rx", "tx";
> > +				fsl,fifo-depth = <15>;
> >  				status = "disabled";
> >  			};

> > @@ -329,6 +330,7 @@
> >  				dmas = <&sdma 28 1 0>,
> >  				       <&sdma 29 1 0>;
> >  				dma-names = "rx", "tx";
> > +				fsl,fifo-depth = <15>;
> >  				status = "disabled";
> >  			};

> You are changing the global .dtsi file. Did you test this change with
> all devices that are affected by it?

I changed the hardware description of the imx25 SSI to match the
reference manual.

I did test this change on an imx25 board with audio playback. This uses
the SSI description I modified. I verified that the driver is actually
taking the modified setting into account and that this causes no
problems.

As of today, this setting is used by the fsl_ssi driver to set the fifo
water level for dma requests.

Of course, I don't have access to the enitre range of supported imx25
boards and I don't think this is required for submitting patches.

Do you have any indication why this patch should not be merged?

Best regards,
Martin
