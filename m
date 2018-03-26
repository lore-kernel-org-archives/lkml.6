Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522059447; cv=none;
        d=google.com; s=arc-20160816;
        b=W1R6vdmaJZaFzy3xM+NKErLfU8MIKcQaP+Ibe+kq0KPDXUmxJNVRAe7kPCyxkjl7GK
         m6Gy/Jkt8zLCVqTuIn6+DnKX0kt0rS5BwG6cRqxwtNwo7TfgXyy3lx2rj9Dm00uaiUR0
         r+yqh+yw5O1qP9vmlWMFpVnqfE28CaSN+0kXpgCthOgBPvaWdZDl7FbSpe4eWcRMTfdq
         Bok82MYIod+4G1a46U91yz3JvHS2NJd0e5+dmMzT+swf7wfGg4Zm0vXgHjhrXy9Yokb0
         z8ZaQ5DiQW8ootff7IXjw3dkZ48CZP4AaNRhIMGbAmM5/Bgn61VoBYMHd/72NLoeJ46W
         L0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ZKqOul/kec4iDidMaORhkR9f2Fbr1JLdFyV1peJH0Rk=;
        b=q4mE4QP0+lAFEuDBMHaxAYARa6KFKj9eC/GTxO5JJh+5VguDI8VAOn+IJ9CkfWy8X6
         ltDzBEtMliTzoAwI8t5/M9VnAR2il32akWtr4uAYidADL9M3SZ0Y+pk9G9bk3SWaykI+
         q1JCvc7pCKkCmW6HAPmDOlgsFABmRcTTWFzI5SqZ5XsYoUWh2yjj2/C+Uj+QHa9V1neJ
         0ro4AxOAEKd1A39TuxLzMqag4/zzhhEOlf9+0/kTldvvfOfaTx0mRnemN7DqGkDclOhw
         s2ayQykM/+gqWAunwLNEr1eqhYWJEEqfsdsAa5glpiIghB/3/dAnv3iG8gOThwxzSJ7e
         zuUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Zpmzi/7E;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Zpmzi/7E;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AG47ELv90GETGiEYYbz4QQf7sHWr+l9S37k9WB/BaAQy2Alu1NxNgd3TDtryaDvpQ5MQgWDQSgWlLMxT+IDOOegCAi8=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180323110020.19080-12-boris.brezillon@bootlin.com>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com> <20180323110020.19080-12-boris.brezillon@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Mar 2018 12:17:26 +0200
X-Google-Sender-Auth: ju2M0xymCiqy35mqHjEvEgkJzKc
Message-ID: <CAMuHMdUH3iB6ngF-0Zkij-oNN-Oms=EwXgoceLp06xbdcq1S=w@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] dt-bindings: gpio: Add bindings for Cadence I3C
 gpio expander
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vitor Soares <Vitor.Soares@synopsys.com>,
	Linus Walleij <linus.walleij@linaro.org>, Xiang Lin <Xiang.Lin@synaptics.com>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725936015625601?=
X-GMAIL-MSGID: =?utf-8?q?1595995007642961454?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Boris,

On Fri, Mar 23, 2018 at 12:00 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Document the Cadence I3C gpio expander bindings.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>

Thanks for your patch!

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
> +       Provisional ID. See Documentation/devicetree/bindings/i3c/i3c.txt for
> +       more details.
> +       Should be <0x0 0x392 0x0>.

No compatible value?

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
> +       i3c-master@xxx {
> +               ...
> +               i3c_gpio_expander: gpio@0,1c9,0 {

gpio@0,392,0?

> +                       reg = <0 0x392 0x0>;
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +               ...
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
