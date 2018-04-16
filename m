Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523904291; cv=none;
        d=google.com; s=arc-20160816;
        b=YSdpyFbdtuOyfwzyuZyzAnGPta72TLw+2Y5pvV7kxAsPc8IL2sjZWck/cv8dh1bQih
         3t9LABqN74Ht41ajYpVDKc5UduIg76vyYhCspky7Y4yJdQi0sLGi+5HbFFEEeX/1b7Jt
         RbSNzodViH+nTN9T0nnbGENBIOBY8mxduVmLt+xoOiFvIVkIHfPxb2UW3TTNSUjJdR9y
         BgCoICGXNCBzny1DbarXsfmq/vrMcnx5W9qNDrMNIs8uLq5excS4MSQI+WVv/AUnDfqn
         gHqIjxUTmFj37WKRASi9fsJibqgRSxkOvJnayAefVjQm2KrNXDoAqurCs8mTNxY3ffGh
         XJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=8/CrPGjzeLLLusrO6naj7RnsP9u4vNbp9fw3H9q6blU=;
        b=LVqXAlyUa6wxVhlVvacckLCbA8K2OVbNEG9ksmz/s0NprzHUIu+5cbMnEfuURa9lAb
         1JuJdZ0P2OP3u6jN462ukpFF/qObZj0sxiInU91XKN4sqOjJD/28eFxpi2N0nEdW30Y+
         N+cUDoxw74oOAOMH4HzGLmR8cwkmoSYcxDFbvZFqJ+GN1qzakuc6OsOmXXrbAVS1bU1l
         pDAZNgTnk9o9m0QkEzmjmfUR5n0bGl0N2FBXgh8K4Pkd1dYgH1zmSd9td4tC4PLvIoVG
         Dm88yzqB/td9/Q04a259wVqmiSh/0pr13AhpZeIy2/yup2kuPEsbghRT4YxjK78Uw3TM
         BvZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx4+CZFDbXdVd8nE6bjTfnqWpRgw+v2hzZ3uOo9q2BtgOM//NRTzW8XxkZvc9NRzktTREAul3Uw==
Date: Mon, 16 Apr 2018 13:44:50 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Rutland <mark.rutland@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Andrew F . Davis" <afd@ti.com>, Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: afe: add binding for adi,lt6106
Message-ID: <20180416184450.zbxk6ebarscvfn6d@rob-hp-laptop>
References: <20180410152802.30958-1-peda@axentia.se>
 <20180411141555.15044-1-peda@axentia.se>
 <20180411141555.15044-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411141555.15044-2-peda@axentia.se>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597459588817312399?=
X-GMAIL-MSGID: =?utf-8?q?1597929466608012550?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 04:15:54PM +0200, Peter Rosin wrote:
> This is a current sense amplifier from Analog Devices.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../devicetree/bindings/iio/afe/adi,lt6106.txt     | 50 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt b/Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt
> new file mode 100644
> index 000000000000..98b6d93596f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt
> @@ -0,0 +1,50 @@
> +LT6106 36V High Side Current Sence Amplifier
> +============================================
> +
> +This binding assumes the typical application of the current sense amplifier
> +as described in the LT6106 datasheet.
> +
> +http://www.analog.com/media/en/technical-documentation/data-sheets/6106fb.pdf
> +
> +                                             .------.
> +    Vin --------------------+--------------+-|Rsense|-+-----.
> +                            |              | '------' |     |
> +                            |              |          |   .---.
> +                 .--------------------.  .---.        |   | L |
> +                 |          V+        |  |Rin|        |   | O |
> +                 |                    |  '---'        |   | A |
> +                 |                    |    |          |   | D |
> +                 |                -IN |----'          |   '---'
> +    Vout ---+----| OUT   LT6106       |               |     |
> +            |    |                +IN |---------------'    GND
> +         .----.  |                    |
> +         |Rout|  |                    |
> +         '----'  |          V-        |
> +            |    '--------------------'
> +            |               |
> +           GND             GND
> +
> +The voltage Vsense over Rsense is measured by looking at Vout. They
> +are related as Vout = Vsense * Rout / Rin. The current Isense through
> +Rsense is (almost) the same as that through the LOAD. Hence, the
> +interesting LOAD current can be calculated as
> +
> +                 Vout * Rin / (Rout * Rsense)
> +
> +Required properties:
> +- compatible : "adi,lt6106"
> +- io-channels : Channel node of an io-channel measuring Vout.
> +- sense-resistor-micro-ohms : The Rsense resistance in microohms.

> +- input-resistor-ohms : The Rin resistance in ohms.
> +- output-resistor-ohms : The Rout resistance in ohms.

Are these generic or specific to this binding? For the latter, they 
shoudl have vendor prefix.

> +
> +Example:
> +
> +sysi {
> +	compatible = "adi,lt6106";
> +	io-channels = <&tiadc 0>;
> +
> +	sense-resistor-micro-ohms = <20000>;
> +	input-resistor-ohms = <200>;
> +	output-resistor-ohms = <10000>;
> +};
