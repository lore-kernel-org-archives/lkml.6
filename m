Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755366AbeCHIyo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:54:44 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40201 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755259AbeCHIyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:54:43 -0500
Date: Thu, 8 Mar 2018 09:54:40 +0100
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com,
        michael@amarulasolutions.com
Subject: Re: [PATCH v2 2/2] ASoC: Add bindings for PCM1789
Message-ID: <20180308095440.515458eb@dell-desktop.home>
In-Reply-To: <20180307223048.lqnryaazr5egg2m7@rob-hp-laptop>
References: <20180305124817.7421-1-mylene.josserand@bootlin.com>
        <20180305124817.7421-3-mylene.josserand@bootlin.com>
        <20180307223048.lqnryaazr5egg2m7@rob-hp-laptop>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Thank you for the review.

On Wed, 7 Mar 2018 16:30:48 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, Mar 05, 2018 at 01:48:17PM +0100, Mylène Josserand wrote:
> > Add a device-tree binding for Texas Instrument's PCM1789 codec.
> > For the moment, only I2C bus is supported but SPI could be added
> > in future.
> > 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/sound/pcm1789.txt | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/pcm1789.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/pcm1789.txt b/Documentation/devicetree/bindings/sound/pcm1789.txt
> > new file mode 100644
> > index 000000000000..a6cdc2c83c98
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/pcm1789.txt
> > @@ -0,0 +1,21 @@
> > +Texas Instruments pcm1789 DT bindings  
> 
> What function does this device provide?

Sorry, I forgot to mention this information.

> 
> > +
> > +This driver supports the I2C bus.  
> 
> Bindings describe h/w, not drivers.

True, I will reformulate it.

> 
> > +
> > +Required properties:
> > +
> > + - compatible: "ti,pcm1789"
> > +
> > +Required properties on I2C:
> > +
> > + - reg: the I2C address
> > + - reset-gpios: GPIO to control the RESET pin
> > +
> > +Examples:
> > +
> > +	codec: pcm1789@4c {  
> 
> audio-codec@4c
> 
> If that's the function...

Yep, I will change that.

> 
> > +		compatible = "ti,pcm1789";
> > +		reg = <0x4c>;
> > +		reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
> > +		#sound-dai-cells = <0>;
> > +	};
> > -- 
> > 2.11.0
> >   

Thanks,

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
