Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AB8JxZrhcLRFyvTube9Zi7KaMhdUKEx5sKa/fhRzVY/7vQN/5LOadMF/x8J5oJwPjR8D9lf2kXYg
ARC-Seal: i=1; a=rsa-sha256; t=1524934756; cv=none;
        d=google.com; s=arc-20160816;
        b=Pp1Eseht+4ZCUNJDCMVzEO/FdYP5AmTtby8QjFynGHVXDplvmNKhRja2kytk4t9At7
         HcNCvXWdorgwsHYAnipA/PwOpNJtXuFGrSAKwupu19BlZs1qWQBPE4OPjZaTYZUVASgS
         ea2Kf+9wrVFFo2b4bGIedGhE0FXAvUDRE9FrjbaHAHfILZURovvDq+WzF7iMiXPAnraZ
         Ea5UsUeelfYwa2fQ/jTmpuBPgyD28q9ol8uJe4kDqAogeDYYp2ag82n4uic+WVrfQ2/a
         fl7I6LYpTvfAertZ5pld3TH8oe/1xaVYxSDmomHP1pXPwJYEF/Z1HlVT0GsqUUMOpMk0
         kLNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=MYbNRdyxFOZdd5yDtgyajK4XO+b15HgplTkw9dmJFzA=;
        b=cM+srUpzMG/znHgYvrELyzZ2jdWeOewkQmgoHMFcDJeET+bGsLc1NS2YRaOFbpjCrt
         T5dlNsAW5ZydcfS+tQZKTfXlHthsgj+to1P4rNNra40tVzxxZYlTFHFLJw6xzXuTMtA6
         6uh5lGYEUW43lgGYNKv0nwNEnPAE2oDPHQR46OWIwtfLmHsDwE8L5HO+HLpeRVnw6Lsy
         m6W9S8rqhLJfJ+vfZIV/cuoaFKapuz7eoXOCbmUKWabX2gl6XDXAbBKWZWdZLN95hZZv
         9W2ZhwFsAX2Qezc58xM8ozp/QOk0e9Q5g0CoXHXI1tg066mm7vnbuvXipNw9Zfkm8eDv
         b3qw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB102256D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 28 Apr 2018 17:59:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, "David S. Miller" <davem@davemloft.net>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Andrew
 Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 "Andrew F . Davis" <afd@ti.com>, Fabio Estevam <festevam@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: iio: afe: add binding for
 current-sense-shunt
Message-ID: <20180428175909.512410d9@archlinux>
In-Reply-To: <20180423210809.29586-2-peda@axentia.se>
References: <20180423210809.29586-1-peda@axentia.se>
	<20180423210809.29586-2-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598572682864091893?=
X-GMAIL-MSGID: =?utf-8?q?1599009986665069423?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 23 Apr 2018 23:08:06 +0200
Peter Rosin <peda@axentia.se> wrote:

> An ADC is often used to measure other quantities indirectly. This
> binding describe one cases, a current through a shunt resistor
> measured by the voltage over it.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>
One small whitespace issue inline that git am pointed out.

I fixed it.

Thanks,

Jonathan

> ---
>  .../bindings/iio/afe/current-sense-shunt.txt       | 41 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
> new file mode 100644
> index 000000000000..4d842aa85040
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
> @@ -0,0 +1,41 @@
> +Current Sense Shunt
> +===================
> +
> +When an io-channel measures the voltage over a current sense shunt,
> +the interesting mesaurement is almost always the current through the
> +shunt, not the voltage over it. This binding describes such a current
> +sense circuit.
> +
> +Required properties:
> +- compatible : "current-sense-shunt"
> +- io-channels : Channel node of a voltage io-channel.
> +- shunt-resistor-micro-ohms : The shunt resistance in microohms.
> +
> +Example:
> +The system current is measured by measuring the voltage over a
> +3.3 ohms shunt resistor.
> +
> +sysi {
> +	compatible = "current-sense-shunt";
> +	io-channels = <&tiadc 0>;
> +
> +	/* Divide the voltage by 3300000/1000000 (or 3.3) for the current. */
> +	shunt-resistor-micro-ohms = <3300000>;
> +};
> +
> +&i2c {
> +	tiadc: adc@48 {
> +		compatible = "ti,ads1015";
> +	      	reg = <0x48>;

The line above has some stray spaces - cleaned up.

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
> index 36a28e979e9a..0f7bec878919 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6889,6 +6889,12 @@ F:	drivers/staging/iio/
>  F:	include/linux/iio/
>  F:	tools/iio/
>  
> +IIO UNIT CONVERTER
> +M:	Peter Rosin <peda@axentia.se>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
> +
>  IKANOS/ADI EAGLE ADSL USB DRIVER
>  M:	Matthieu Castet <castet.matthieu@free.fr>
>  M:	Stanislaw Gruszka <stf_xl@wp.pl>
