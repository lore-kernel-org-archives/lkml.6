Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeBXN2X (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 08:28:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750772AbeBXN2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 08:28:21 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59F221774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Feb 2018 13:28:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: sd-modulator: fix
 io-channel-cells
Message-ID: <20180224132814.392603c3@archlinux>
In-Reply-To: <c221e43d-c7fb-c33b-6fd1-bbf8aca6fa49@st.com>
References: <1519384041-23782-1-git-send-email-fabrice.gasnier@st.com>
        <c221e43d-c7fb-c33b-6fd1-bbf8aca6fa49@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2018 14:46:19 +0100
Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:

> Hello,
> 
> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> 
> Regards,
> Arnaud
> 
> On 02/23/2018 12:07 PM, Fabrice Gasnier wrote:
> > io-channel-cells should be <0> since sigma delta modulator exports only
> > one channel, as described in ../iio/iio-bindings.txt "IIO providers"
> > section. Only the phandle is necessary for IIO consumers in this case.
> > 
> > Fixes: af11143757b7 ("IIO: Add DT bindings for sigma delta adc modulator")
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> > index e9ebb8a..ba24ca7 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> > +++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> > @@ -3,11 +3,11 @@ Device-Tree bindings for sigma delta modulator
> >  Required properties:
> >  - compatible: should be "ads1201", "sd-modulator". "sd-modulator" can be use
> >  	as a generic SD modulator if modulator not specified in compatible list.
> > -- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
> > +- #io-channel-cells = <0>: See the IIO bindings section "IIO consumers".
> >  
> >  Example node:
> >  
> >  	ads1202: adc@0 {
> >  		compatible = "sd-modulator";
> > -		#io-channel-cells = <1>;
> > +		#io-channel-cells = <0>;
> >  	};
> >   
