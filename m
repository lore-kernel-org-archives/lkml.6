Return-Path: <jic23@jic23.retrosnub.co.uk>
X-Google-Smtp-Source: AG47ELudCGiqGn2r1NQFp9AjNf8QApj0i9IKmgNCKSuRYc/HWJFD22KjCQfAHnDas/5eqhx84EwB
ARC-Seal: i=1; a=rsa-sha256; t=1521900412; cv=none;
        d=google.com; s=arc-20160816;
        b=YbrPe/Suq3Jlf3xkYH+l2RsjX4leHxxe1NnJkBya3Isn1JbA7UTQfTIV1707MeuQCQ
         Lgf9B0tLV8w2g5qPIOfmB1Cm4aGSg6nz6bchqp3fm15kgKymdXGuEsJ0ZeO8J8LWw/ut
         F5AsUCB6Jwsm1qv+TarBFDCzc9UAt+cztvCMLVn/KaSIXE7iHi1R/Z+VUXOOLaOr6d4a
         C8gf3N7N03LkNFYmpJ0DRuNiKOoF/3ETPB38+C3FXknPhk5dSQEBMhUdNGKemcyeN/Fe
         kdr14ryXjA/NzqRP/IU23++VM0HpBNN0jB0RIVLmRPOJckPHmj6rTlN6Sb0YaPkKv99T
         tZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=aVHH283nd6O2jWVHdOqDypY6b8ZCW4hOxN0oUJuWvpQ=;
        b=uBbHyxASY3I8SC1sqItukEB4jRqwnnVYQ6gwrbb3DY14xi7gS0BpOcnf63hI8Ef09j
         wQjxecXWgnDEevLliidWFvHelRggBAcZqwgqNM/4aySkgB9c6cXKxT33BjZE3ue4mhwm
         C5YgbCsEnpK4FfeCwDAI6KVXZHCUcgECiaDxO4xAFPBa32DDIUZzQ4jdKJ79rYvtISeZ
         /VBRNnE1mMkgrsfPPLutSBDoM75PhAMlhuI4oNtc6nPH10dSQymqvyZA1cgub38w9k/c
         Z594DigxmAldfbAdOPJiJ0gqor/65EqehWE5v0xhfWPHMD3FMlTjAsYVM961YDhQGHm9
         Xoww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jic23@jic23.retrosnub.co.uk designates 2a00:1098:86::1:1 as permitted sender) smtp.mailfrom=jic23@jic23.retrosnub.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jic23@jic23.retrosnub.co.uk designates 2a00:1098:86::1:1 as permitted sender) smtp.mailfrom=jic23@jic23.retrosnub.co.uk
Date: Sat, 24 Mar 2018 14:06:48 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, "David S. Miller" <davem@davemloft.net>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: wrapper: add
 io-channel-unit-converter
Message-ID: <20180324140648.116b6b00@archlinux>
In-Reply-To: <20180324135319.4ba6ce92@archlinux>
References: <20180319170246.26830-1-peda@axentia.se>
	<20180319170246.26830-3-peda@axentia.se>
	<20180324135319.4ba6ce92@archlinux>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386352511078978?=
X-GMAIL-MSGID: =?utf-8?q?1595828246949292665?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 24 Mar 2018 13:53:19 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 19 Mar 2018 18:02:45 +0100
> Peter Rosin <peda@axentia.se> wrote:
> 
> > Allow linear scaling and modification of the type of an io-channel.
> > 
> > When an ADC channel measures the midpoint of a voltage divider, the
> > interesting voltage is often the voltage over the full resistance
> > of the divider. Likewise, measuring the voltage over a resistor is
> > often a way to get to the current through it.
> > 
> > This binding allows description of such hardware which is external
> > to the ADC.
> > 
> > Signed-off-by: Peter Rosin <peda@axentia.se>
> > ---
> >  .../iio/wrapper/io-channel-unit-converter.txt      | 84 ++++++++++++++++++++++  
> Hmm. I'm not convinced by the naming really though I can see where you care
> coming from as it can effectively use a voltage ADC to measure a current.
> 
> Lets see if the devicetree people or anyone else has a suggestion on this.
> 
> Could go with AFE as that is how a chip doing this would normally be described.
> It's just that here we are doing it in old fashioned resistors...
> 
> There are a few unusual elements in here binding wise so definitely looking
> for input on the bindings!
> 
> Thanks,
> 
> Jonathan
> 
> >  MAINTAINERS                                        |  6 ++
> >  2 files changed, 90 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt b/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
> > new file mode 100644
> > index 000000000000..23af661abe32
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
> > @@ -0,0 +1,84 @@
> > +I/O channel unit converter bindings
> > +
> > +Allow linear scaling and modification of the type of an io-channel.  
> I can certainly conceive that we will have simple non linear cases in future
> though they get awfully hard to describe so we can tackle that when it
> happens.
> 
> > +
> > +When an ADC channel measures the midpoint of a voltage divider, the
> > +interesting voltage is often the voltage over the full resistance
> > +of the divider. Likewise, measuring the voltage over a resistor is
> > +often a way to get to the current through it.
> > +
> > +Required properties:
> > +- compatible : "io-channel-unit-converter"
> > +- io-channels : Channel node of the parent channel.
> > +- io-channel-names : Should be "parent".
> > +
> > +Optional properties:
> > +- numerator : The parent channel scale is multiplied by this value (default 1).
> > +- denominator : The parent channel scale is divided by this value (default 1).
> > +- type : The type of the wrapped channel is modified to this type. The default
> > +	 is to use the same type as the parent channel. Recognized types are:
> > +		"voltage"
> > +		"current"
> > +
> > +Example 1:
> > +The system voltage is circa 12V, but divided down with a 22/200
> > +voltage divider to adjust it to the ADC range.
> > +
> > +SYSV        ADC       GND
> > +  +          +         +
> > +  |  .-----. | .----.  |
> > +  '--| 200 |-+-| 22 |--'
> > +     '-----'   '----'
> > +
> > +sysv {
> > +	compatible = "io-channel-unit-converter";
> > +	io-channles = <&maxadc 1>;
> > +	io-channel-names = "parent";
> > +
> > +	/* multiply the ADC voltage by 222/22 to get the system voltage */
> > +	numerator = <222>; /* 200 + 22 */
> > +	denominator = <22>;
> > +}
> > +
> > +&spi {
> > +	maxadc: adc@0 {
> > +		compatible = "maxim,max1027";
> > +	      	reg = <0>;
> > +		#io-channel-cells = <1>;
> > +		interrupt-parent = <&gpio5>;
> > +		interrupts = <15 IRQ_TYPE_EDGE_RISING>;
> > +		spi-max-frequency = <1000000>;
> > +	};
> > +};
> > +
> > +Example 2:
> > +The system current is measured by measuring the voltage over a
> > +3.3 ohm resistor.
> > +
> > +sysi {
> > +	compatible = "io-channel-unit-converter";
> > +	io-channles = <&tiadc 0>;
io-channels and same above.

> > +	io-channel-names = "parent";
> > +
> > +	/* divide the ADC voltage by 33/10 (i.e. 3.3) to get current */
> > +	numerator = <10>;
> > +	denominator = <33>;
> > +	type = "current";
> > +}
> > +
> > +&i2c {
> > +	tiadc: adc@48 {
> > +		compatible = "ti,ads1015";
> > +	      	reg = <0x48>;
> > +		#io-channel-cells = <1>;
> > +
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		channel@0 { /* IN0,IN1 differential */
> > +			reg = <0>;
> > +			ti,gain = <1>;
> > +			ti,datarate = <4>;
> > +		};
> > +	};
> > +};
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 96e5503bfb60..5dd555c7b1b0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6884,6 +6884,12 @@ F:	drivers/staging/iio/
> >  F:	include/linux/iio/
> >  F:	tools/iio/
> >  
> > +IIO UNIT CONVERTER
> > +M:	Peter Rosin <peda@axentia.se>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
> > +
> >  IKANOS/ADI EAGLE ADSL USB DRIVER
> >  M:	Matthieu Castet <castet.matthieu@free.fr>
> >  M:	Stanislaw Gruszka <stf_xl@wp.pl>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
