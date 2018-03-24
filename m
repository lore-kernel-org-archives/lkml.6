Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AG47ELvU7/5wdwmIlncezt53h+BrLLUP5FFxdCd8hB8Q/MMMKtxYOfXXBkIGL8JAXHMuRevt2Uey
ARC-Seal: i=1; a=rsa-sha256; t=1521899605; cv=none;
        d=google.com; s=arc-20160816;
        b=HCkZQKNRRtVbRhi74ZrQFc6kbJDV/aQyaonC3YC3IEoAika4kvvQU79gzYggsE4DPw
         TNswwGFpkA8zV13cd+lATj+rAfcD5aQClnBL77LZGZ7UJeG0clrLWJ2E5OC67q0lVYW3
         TUp8A+7xRff36UuKAFBffcG3cmtjt5YLuP7fBj07c8k7xnp6epQoSY0jwsv04fTsZLNU
         xRDgp6fokVhJ9eXl9wULDtvUIF66iR/P+SpKKqoEY2qeMJtbBms1WX/WouFGKfQa7Iw4
         YE0FBZaK6L3aKE+8icJ/iYQfgI2+iBXGLl0PjDLqq2RrfMge97aE//HscHPL4aj+daXJ
         12dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=NVJaw65hDDdDoPpqmdLO5Tdv2DjpcsIvScd6ByJt4/Y=;
        b=PrYj7BnfZbVSXn7l/ICoEef1QINRcjVkki8aCOBcP8bs9wca2z6JNV9BQIKjFtHko4
         46f3OrYDCaxQCfKTZJjSeIMVy/3rT3Pls7N19ivT+rvUbRk1PwugoWiWl/yPRr7nDWYG
         DNDRcaCNKRTwR5FJrkRomwIxSomM2BPq/Oay4h7rp8Gc+4bsvpAepN3dLnpd+O/G1rSa
         pXPbV+YPAn9/+TxYELKpNYaCBGm5zP66wwx9WuL3+Rw/QqOzlxRikT31mfCZO9eD1FiT
         GL7DwzSPkcKmdE5X0LzAExuKNxEb3h2elB1swtbhj/ZR/zx2CPjT8o89tkATUmEaCMU+
         P/sg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E622172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 13:53:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
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
Message-ID: <20180324135319.4ba6ce92@archlinux>
In-Reply-To: <20180319170246.26830-3-peda@axentia.se>
References: <20180319170246.26830-1-peda@axentia.se>
	<20180319170246.26830-3-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386352511078978?=
X-GMAIL-MSGID: =?utf-8?q?1595827401115549568?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 19 Mar 2018 18:02:45 +0100
Peter Rosin <peda@axentia.se> wrote:

> Allow linear scaling and modification of the type of an io-channel.
> 
> When an ADC channel measures the midpoint of a voltage divider, the
> interesting voltage is often the voltage over the full resistance
> of the divider. Likewise, measuring the voltage over a resistor is
> often a way to get to the current through it.
> 
> This binding allows description of such hardware which is external
> to the ADC.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../iio/wrapper/io-channel-unit-converter.txt      | 84 ++++++++++++++++++++++
Hmm. I'm not convinced by the naming really though I can see where you care
coming from as it can effectively use a voltage ADC to measure a current.

Lets see if the devicetree people or anyone else has a suggestion on this.

Could go with AFE as that is how a chip doing this would normally be described.
It's just that here we are doing it in old fashioned resistors...

There are a few unusual elements in here binding wise so definitely looking
for input on the bindings!

Thanks,

Jonathan

>  MAINTAINERS                                        |  6 ++
>  2 files changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt b/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
> new file mode 100644
> index 000000000000..23af661abe32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
> @@ -0,0 +1,84 @@
> +I/O channel unit converter bindings
> +
> +Allow linear scaling and modification of the type of an io-channel.
I can certainly conceive that we will have simple non linear cases in future
though they get awfully hard to describe so we can tackle that when it
happens.

> +
> +When an ADC channel measures the midpoint of a voltage divider, the
> +interesting voltage is often the voltage over the full resistance
> +of the divider. Likewise, measuring the voltage over a resistor is
> +often a way to get to the current through it.
> +
> +Required properties:
> +- compatible : "io-channel-unit-converter"
> +- io-channels : Channel node of the parent channel.
> +- io-channel-names : Should be "parent".
> +
> +Optional properties:
> +- numerator : The parent channel scale is multiplied by this value (default 1).
> +- denominator : The parent channel scale is divided by this value (default 1).
> +- type : The type of the wrapped channel is modified to this type. The default
> +	 is to use the same type as the parent channel. Recognized types are:
> +		"voltage"
> +		"current"
> +
> +Example 1:
> +The system voltage is circa 12V, but divided down with a 22/200
> +voltage divider to adjust it to the ADC range.
> +
> +SYSV        ADC       GND
> +  +          +         +
> +  |  .-----. | .----.  |
> +  '--| 200 |-+-| 22 |--'
> +     '-----'   '----'
> +
> +sysv {
> +	compatible = "io-channel-unit-converter";
> +	io-channles = <&maxadc 1>;
> +	io-channel-names = "parent";
> +
> +	/* multiply the ADC voltage by 222/22 to get the system voltage */
> +	numerator = <222>; /* 200 + 22 */
> +	denominator = <22>;
> +}
> +
> +&spi {
> +	maxadc: adc@0 {
> +		compatible = "maxim,max1027";
> +	      	reg = <0>;
> +		#io-channel-cells = <1>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <15 IRQ_TYPE_EDGE_RISING>;
> +		spi-max-frequency = <1000000>;
> +	};
> +};
> +
> +Example 2:
> +The system current is measured by measuring the voltage over a
> +3.3 ohm resistor.
> +
> +sysi {
> +	compatible = "io-channel-unit-converter";
> +	io-channles = <&tiadc 0>;
> +	io-channel-names = "parent";
> +
> +	/* divide the ADC voltage by 33/10 (i.e. 3.3) to get current */
> +	numerator = <10>;
> +	denominator = <33>;
> +	type = "current";
> +}
> +
> +&i2c {
> +	tiadc: adc@48 {
> +		compatible = "ti,ads1015";
> +	      	reg = <0x48>;
> +		#io-channel-cells = <1>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		channel@0 { /* IN0,IN1 differential */
> +			reg = <0>;
> +			ti,gain = <1>;
> +			ti,datarate = <4>;
> +		};
> +	};
> +};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96e5503bfb60..5dd555c7b1b0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6884,6 +6884,12 @@ F:	drivers/staging/iio/
>  F:	include/linux/iio/
>  F:	tools/iio/
>  
> +IIO UNIT CONVERTER
> +M:	Peter Rosin <peda@axentia.se>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
> +
>  IKANOS/ADI EAGLE ADSL USB DRIVER
>  M:	Matthieu Castet <castet.matthieu@free.fr>
>  M:	Stanislaw Gruszka <stf_xl@wp.pl>
