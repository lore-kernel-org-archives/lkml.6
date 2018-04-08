Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx4+5iI2vKwKW0NPxnr5E24CuOT33s7QtUz7kPEoMJ7cbnyAo+x6MsEgKjjxzSjhVp0en0ryR
ARC-Seal: i=1; a=rsa-sha256; t=1523206239; cv=none;
        d=google.com; s=arc-20160816;
        b=cY5U4qS9Z7V/MOFigJAvG3eAGchyiMCxMD1d0hUmKxJXq84FCJL/WsiD8SC2PrG8D5
         gg8J6eFhsfK4MwRtphdlPZO7pf66v1pU9EtpbKpBaecKr3IPPV/LrrKnT+f3GeM4gBEl
         ecmfX2Ywg4IMmiWdMBZFdwG62THXp3XsjoUF8ooF99wBW9bQjalqtFGd7AHj1YBaMx1p
         /VANGYT0ecW9brLBXG+Gz2LZsch5eSe4Z/YaxzI/a7Z7Ojjz++jlDB03tjWq5VCAqFLU
         1IWg0zuBmmllrXx2aH5vUJJwzGg4C8UrjQW2vb25AZQ2CA6uVwg5K4MtOgMK4m9S5Eo/
         fbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=8GW8Dx86SzSr71EqKmCgzejAW8BQCxy4oHOsRqr+FdY=;
        b=WYzgJB9HRJV4p5Y6UFoJWtKVNjZZPwPzNMMijZRQy84kAgPeB/JnvOwlp6R7to+/gc
         BgE1cXMXkfZGvNrh1A+GW7vimA20ueGcwVq2UhWVX8xmK1T9pLwE69mVtJo7NAH8H2Bk
         qJxTIg1XaTc7dqyBQkZynSGjw5C+LXCPJFG2s/Hoq+nPgM/qe5rTM+LrGMykk6GpB0MQ
         VEG9ofEKNxBeTwtcpCO2mZXT9Q9MqRcOOalKRG7M7ExGg3/RYT7LBB4qdgzNT/eS0FoA
         UGHy+6YMplSsXPZLLk7okQcmW4/MXGyyZz2e+Yaa/68a6I5lZ/pQOJF3t/ayo6n+CHRK
         qrpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2FD21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 8 Apr 2018 17:50:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, "David S. Miller" <davem@davemloft.net>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Michael Hennerich <michael.hennerich@analog.com>,
 Phil Reid <preid@electromag.com.au>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: afe: add current-sense-cuicuit
 and voltage-divider
Message-ID: <20180408175031.4945e2d7@archlinux>
In-Reply-To: <20180403153635.8228-2-peda@axentia.se>
References: <20180403153635.8228-1-peda@axentia.se>
	<20180403153635.8228-2-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596739881382169628?=
X-GMAIL-MSGID: =?utf-8?q?1597197506236780541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue,  3 Apr 2018 17:36:34 +0200
Peter Rosin <peda@axentia.se> wrote:

circuit in the patch title is spelled wrong.

> An ADC is often used to measure other quantities indirectly. These
> bindings describe two cases, a current through a sense resistor, and
> a "big" voltage measured with the help of a voltage divider.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Will definitely be wanting wide opinions on this one - Rob in particularly
for the binding side.

One comment inline. What we have here is nice and generic, but is
it what would be 'expected' for current sense circuit?  Should we
also be more specific in the naming.  There are lots of options for
current sense circuits and this is just the simplest (current loop
for example).

One option would be to use current-sense-shunt perhaps?

https://en.wikipedia.org/wiki/Current_sensing_techniques
Gives a few that I didn't think of beyond current loops etc.


> ---
>  .../bindings/iio/afe/current-sense-circuit.txt     | 45 ++++++++++++++++++++++
>  .../bindings/iio/afe/voltage-divider.txt           | 45 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++++
>  3 files changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
> new file mode 100644
> index 000000000000..0bc7d89387c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
> @@ -0,0 +1,45 @@
> +Current Sense Curcuit
> +=====================
> +
> +When an io-channel measures the voltage over a current sense resistor,
> +the interesting mesaurement is often the current through the resistor,
> +not the voltage over it. This binding describes such a current sense
> +curcuit.
> +
> +Required properties:
> +- compatible : "current-sense-circuit"
> +- io-channels : Channel node of a voltage io-channel.
> +
> +Optional properties:
> +- numerator : The io-channel scale is multiplied by this value (default 1).
> +- denominator : The io-channel scale is divided by this value (default 1).
> +
> +Example:
> +The system current is measured by measuring the voltage over a
> +3.3 ohms sense resistor.

Hmm. It sort of feels like the binding doesn't really reflect the
hardware as directly as it might.   Should we be explicitly having the
resistance in this case?  (with some more mapping logic needed in the
driver to figure out the scaling this causes).

> +
> +sysi {
> +	compatible = "current-sense-circuit";
> +	io-channels = <&tiadc 0>;
> +
> +	/* Divide the ADC voltage by 33/10 (i.e. 3.3) to get the current. */
> +	numerator = <10>;
> +	denominator = <33>;
> +};
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
> diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt b/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
> new file mode 100644
> index 000000000000..fd4a215d9e6d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
> @@ -0,0 +1,45 @@
> +Voltage divider
> +===============
> +
> +When an io-channel measures the midpoint of a voltage divider, the
> +interesting voltage is often the voltage over the full resistance
> +of the divider. This binding describes the voltage divider in such
> +a curcuit.
> +
> +Required properties:
> +- compatible : "voltage-divider"
> +- io-channels : Channel node of a voltage io-channel.
> +
> +Optional properties:
> +- numerator : The io-channel scale is multiplied by this value (default 1).
> +- denominator : The io-channel scale is divided by this value (default 1).
> +
> +Example:
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
> +	compatible = "voltage-divider";
> +	io-channels = <&maxadc 1>;
> +
> +	/* Multiply the ADC voltage by 222/22 to get the system voltage. */
> +	numerator = <222>; /* 200 + 22 */
> +	denominator = <22>;
> +};
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
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 36a28e979e9a..9dbe5019c6bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6889,6 +6889,13 @@ F:	drivers/staging/iio/
>  F:	include/linux/iio/
>  F:	tools/iio/
>  
> +IIO UNIT CONVERTER
> +M:	Peter Rosin <peda@axentia.se>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
> +F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
> +
>  IKANOS/ADI EAGLE ADSL USB DRIVER
>  M:	Matthieu Castet <castet.matthieu@free.fr>
>  M:	Stanislaw Gruszka <stf_xl@wp.pl>
