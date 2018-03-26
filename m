Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522103102; cv=none;
        d=google.com; s=arc-20160816;
        b=EB0OsK8xYALbLq8r2YGoiyLQsQkqOWn//kgqcoTbOXOOCWe+jNj41iyLkwjLQeLOb5
         k897s0RKRgVxHLeCXvzC/1SCLTo45p94GFxgSqbXFAgSjaBceoNzZ9IZZydzHT4N9mNA
         M/HUCqD8tNvP3xeWYoHdGF7PspjxkmcqfkATmVF6adNj0RgoWCd2GtKyLgfUFIef+9cG
         iyIqdfNX8MffWuUk5Gzeu6f/cQIGwCOXWRDDOMkfm7Gydj/jgQDPQ+a1NNUHDosj89xc
         y94YOpI2ZzbppMng+LUeaRTKyL824CEVev71h5vvd8CqADS2V2AT49ZjWE6d1Eu0dYh4
         C+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Xhb1X2YQBeXvwc0QSuxVH7Rv+N5LrS7mdjT64Fsksvs=;
        b=a5FtDAXoWl6uN2eOhgix48sdwPgRrZNiHKwMapQ3l7JPhV1oHmxVEmKlFlSfqXLJZE
         cczwNvQ4jnqT6CMH2vEvgY8ANimeX7N3Y8ihQzXWRcilNLePHWy5+pF9uerEVtmMiHFb
         HEqkjDxWB6qnYrtS4mRqQ1Qf9gLTA5ZrTx+N6Zjyu+YI53HO4XqDjm7SziqCbtpVg6Sl
         GJPxMoWwKgutC+s5wsWWCSFjWwy+lDgVf3tIGI36ORsaSOHP3sSrD6HoXcht2Tq/UwZU
         TxmhuPX5FqPMa2KXSYs0Tds1NmAYs0F9McI2Nd5ZmU0xU7CH2HDPOvQh3zOJSTpbhLxx
         MEeA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx4/JivyWN54jov0NU32Bmt7X2lfIs7AKfsS/C1iOK/MDlF3FxWJWswtx5M7xozBacVROEK3Lig==
Date: Mon, 26 Mar 2018 17:25:01 -0500
From: Rob Herring <robh@kernel.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Przemyslaw Sroka <psroka@cadence.com>,
	Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>,
	Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>,
	Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>,
	Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitor Soares <Vitor.Soares@synopsys.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 11/11] dt-bindings: gpio: Add bindings for Cadence I3C
 gpio expander
Message-ID: <20180326222501.exvvdjb6fbrtsvkv@rob-hp-laptop>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
 <20180323110020.19080-12-boris.brezillon@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323110020.19080-12-boris.brezillon@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725936015625601?=
X-GMAIL-MSGID: =?utf-8?q?1596040783836695822?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 12:00:20PM +0100, Boris Brezillon wrote:
> Document the Cadence I3C gpio expander bindings.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
>  .../devicetree/bindings/gpio/gpio-cdns-i3c.txt     | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt b/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
> new file mode 100644
> index 000000000000..634b1f268215
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
> @@ -0,0 +1,38 @@
> +* Cadence I3C GPIO expander
> +
> +The Cadence I3C GPIO expander provides 8 GPIOs controllable over I3C.
> +This GPIOs can be configured in output or input mode and if they are in input
> +mode they can generate IBIs (In Band Interrupts).
> +
> +Required properties for GPIO node:
> +- reg : 3 cells encoding the I3C static address (none in our case) and the I3C
> +	Provisional ID. See Documentation/devicetree/bindings/i3c/i3c.txt for
> +	more details.
> +	Should be <0x0 0x392 0x0>.
> +- gpio-controller : Marks the device node as a gpio controller.
> +- #gpio-cells : Should be two. The first cell is the pin number and
> +  the second cell is used to specify the gpio polarity:
> +      0 = active high
> +      1 = active low
> +- interrupt-controller: Marks the device node as an interrupt controller.
> +- #interrupt-cells : Should be 2.  The first cell is the GPIO number.
> +  The second cell bits[3:0] is used to specify trigger type and level flags:
> +      1 = low-to-high edge triggered.
> +      2 = high-to-low edge triggered.
> +      3 = triggered on both edges.
> +      4 = active high level-sensitive.
> +      8 = active low level-sensitive.
> +
> +Example:
> +
> +	i3c-master@xxx {
> +		...
> +		i3c_gpio_expander: gpio@0,1c9,0 {

The unit address is wrong here.

> +			reg = <0 0x392 0x0>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +		...
> +	};
> -- 
> 2.14.1
> 
