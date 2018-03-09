Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeCIIht convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:37:49 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:55299 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbeCIIhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:37:48 -0500
Date: Fri, 9 Mar 2018 09:37:38 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: i.MX25: define SSI FIFO depth
Message-ID: <20180309093738.7cd5fded@karo-electronics.de>
In-Reply-To: <20180308153832.GA28454@botnar.kaiser.cx>
References: <1520373499-13623-1-git-send-email-martin@kaiser.cx>
        <20180308161135.1f3d3d18@karo-electronics.de>
        <20180308153832.GA28454@botnar.kaiser.cx>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kZQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 8 Mar 2018 16:38:32 +0100 Martin Kaiser wrote:
> Hi Lothar,
> 
> Thus wrote Lothar Waßmann (LW@KARO-electronics.de):
> 
> > > diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> > > index 9725705..cf70df2 100644
> > > --- a/arch/arm/boot/dts/imx25.dtsi
> > > +++ b/arch/arm/boot/dts/imx25.dtsi
> > > @@ -269,6 +269,7 @@
> > >  				dmas = <&sdma 24 1 0>,
> > >  				       <&sdma 25 1 0>;
> > >  				dma-names = "rx", "tx";
> > > +				fsl,fifo-depth = <15>;
> > >  				status = "disabled";
> > >  			};
> 
> > > @@ -329,6 +330,7 @@
> > >  				dmas = <&sdma 28 1 0>,
> > >  				       <&sdma 29 1 0>;
> > >  				dma-names = "rx", "tx";
> > > +				fsl,fifo-depth = <15>;
> > >  				status = "disabled";
> > >  			};
> 
> > You are changing the global .dtsi file. Did you test this change with
> > all devices that are affected by it?
> 
> I changed the hardware description of the imx25 SSI to match the
> reference manual.
> 
> I did test this change on an imx25 board with audio playback. This uses
> the SSI description I modified. I verified that the driver is actually
> taking the modified setting into account and that this causes no
> problems.
> 
> As of today, this setting is used by the fsl_ssi driver to set the fifo
> water level for dma requests.
> 
> Of course, I don't have access to the enitre range of supported imx25
> boards and I don't think this is required for submitting patches.
> 
> Do you have any indication why this patch should not be merged?
> 
Usually patches should not willy-nilly change the behaviour of existing
configurations unless they fix any real life bugs.


Lothar Waßmann
