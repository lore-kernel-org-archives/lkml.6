Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeBXNLp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 08:11:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbeBXNLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 08:11:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51F421741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Feb 2018 13:11:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: stm32-dfsdm: fix types, add
 missing pinctrl
Message-ID: <20180224131137.1b2a79f3@archlinux>
In-Reply-To: <7e40cdfc-8d9f-ccfb-f3fd-8d639a87d5b0@st.com>
References: <1519384260-23875-1-git-send-email-fabrice.gasnier@st.com>
        <7e40cdfc-8d9f-ccfb-f3fd-8d639a87d5b0@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2018 14:47:36 +0100
Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:

> Hello,
> 
> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

I'm feeling conservative today so will be wanting a devicetree
maintainer ack for this one..

Jonathan

> 
> Regards,
> Arnaud
> 
> On 02/23/2018 12:11 PM, Fabrice Gasnier wrote:
> > - Add missing pinctrl description. Support is made optional as dfsdm
> >   may use internal sources (e.g. via registers)
> > - Fix typo in IIO STM32 DFSDM filter "MANCH_F" description.
> > Basically, this should be "falling edge = logic 0", not "1" that applies
> > to "MANCH_R".
> > BTW, make the description complete by describing both rising/falling
> > edges as described in reference manuals.
> > 
> > Fixes: 6c82f947fc97 ("IIO: add DT bindings for stm32 DFSDM filter")
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
> > index 911492da..ed7520d 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
> > +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
> > @@ -32,6 +32,10 @@ Optional properties:
> >  		  to "clock" property. Frequency must be a multiple of the rcc
> >  		  clock frequency. If not, SPI CLKOUT frequency will not be
> >  		  accurate.
> > +- pinctrl-names:	Set to "default".
> > +- pinctrl-0:		List of phandles pointing to pin configuration
> > +			nodes to set pins in mode of operation for dfsdm
> > +			on external pin.
> >  
> >  Contents of a STM32 DFSDM child nodes:
> >  --------------------------------------
> > @@ -68,8 +72,8 @@ Optional properties:
> >  - st,adc-channel-types:	Single-ended channel input type.
> >  			- "SPI_R": SPI with data on rising edge (default)
> >  			- "SPI_F": SPI with data on falling edge
> > -			- "MANCH_R": manchester codec, rising edge = logic 0
> > -			- "MANCH_F": manchester codec, falling edge = logic 1
> > +			- "MANCH_R": manchester codec, rising edge = logic 0, falling edge = logic 1
> > +			- "MANCH_F": manchester codec, rising edge = logic 1, falling edge = logic 0
> >  - st,adc-channel-clk-src: Conversion clock source.
> >  			  - "CLKIN": external SPI clock (CLKIN x)
> >  			  - "CLKOUT": internal SPI clock (CLKOUT) (default)
> >   
