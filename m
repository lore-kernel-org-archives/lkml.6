Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522059745; cv=none;
        d=google.com; s=arc-20160816;
        b=Bk6JUDaVDYJ2K/dLSnenR7V04Ng6Rl5woVYgwGwev31YPGE/RauBC58/HZU1HyymGQ
         xOhtpoxwfCJnLAYNBaEqGRouYEJlZ0VVIC2WAHQBZBHMGl9ywckCKwpExoVwrPX5b9Ck
         JoQDZ4iv5UZcLFp8vz8NODrqmClAFzA1yjz42d2We/mW9XJbHrIiOfW0fjxVuOyoMHJj
         fqhG/Ey/JdWpraXqh9IQPUYciEb4BCYimUgB6aUQ8gPE8tUfzHTxbjvPNMQ27Hmw6GI8
         3dcJFPCs9V4dExgDR9CwDXkb6KAOI5YEK1uEmWtgKhCZ/NeqjTVtzNIoJOTOIY65ZoLD
         Jqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=qLFfH7b/3FbE1+YzlreJpjA1VSKGglmNy7P6ehv26Po=;
        b=unlkRDRp6ax8wt2gtDKcSD7oIBGbUpDe1hkZxqEkUJKRNVPQKRjIDBg7RA0NsyrCjf
         Ty99cGILICfQLaFNRlSK5iATktU0kVqnr4NQFJthsSKbAIkilnOOomp/8K3VwN0gE30k
         xU6gyvDGw0bAvRhwZMlXnjZngulmLB7BLF23TsRfRXMkdRgAWNOAZtvPyVfBfN7sCvag
         EExhas6Pnd/LOb8au6uBuQ2Wm7s4q1a8YCrcAFi47MuA7/KwEsuRx8PrDpndovkqYzTI
         DXhVgdb0HAfwxtWN1aM7bdUSbqhKkU6jYfzfA8DiHvLnYVazHn0UtjxdurGUEbxJQIOI
         FqLA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=f1TVkZxF;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=f1TVkZxF;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AIpwx48CMfytEgXendCNkmxaRNlO2pnpmNBOAyOcmou4Nnurt6FDxzR+BsSuKoOcHeUFgwrYSiMITwVxCIwaGq5u4OI=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180323110020.19080-6-boris.brezillon@bootlin.com>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com> <20180323110020.19080-6-boris.brezillon@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Mar 2018 12:22:24 +0200
X-Google-Sender-Auth: WvZ9vqglGvDVAt6lprKQlbbkeCU
Message-ID: <CAMuHMdV9xW8o6zuOmOxB+=h1XTdi-VFq2mp897SUjZKtRMOWOw@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] dt-bindings: i3c: Document core bindings
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
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725932611927845?=
X-GMAIL-MSGID: =?utf-8?q?1595995319989203572?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Boris,

On Fri, Mar 23, 2018 at 12:00 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
>
> A new I3C subsystem has been added and a generic description has been
> created to represent the I3C bus and the devices connected on it.
>
> Document this generic representation.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/i3c.txt
> @@ -0,0 +1,140 @@

> +I3C devices
> +===========
> +
> +All I3C devices are supposed to support DAA (Dynamic Address Assignment), and
> +are thus discoverable. So, by default, I3C devices do not have to be described
> +in the device tree.

But if they're described, they should have a compatible value, no?

> +This being said, one might want to attach extra resources to these devices,
> +and those resources may have to be described in the device tree, which in turn
> +means we have to describe I3C devices.
> +
> +Another use case for describing an I3C device in the device tree is when this
> +I3C device has a static address and we want to assign it a specific dynamic
> +address before the DAA takes place (so that other devices on the bus can't
> +take this dynamic address).
> +
> +The I3C device should be names <device-type>@<static-address>,<i3c-pid>,

named

So the i3c-pid in the unit address is represented as a 64-bit number, not as two
comma-separated 32-bit numbers?

> +Example:
> +
> +       i3c-master@d040000 {
> +               compatible = "cdns,i3c-master";
> +               clocks = <&coreclock>, <&i3csysclock>;
> +               clock-names = "pclk", "sysclk";
> +               interrupts = <3 0>;
> +               reg = <0x0d040000 0x1000>;
> +               #address-cells = <3>;
> +               #size-cells = <0>;
> +
> +               status = "okay";
> +               i2c-scl-frequency = <100000>;
> +
> +               /* I2C device. */
> +               nunchuk: nunchuk@52 {

@52,8000001000000000?

> +                       compatible = "nintendo,nunchuk";
> +                       reg = <0x52 0x80000010 0x0>;
> +               };
> +
> +               /* I3C device with a static address. */
> +               thermal_sensor: sensor@68,39200144004 {

No compatible value?

> +                       reg = <0x68 0x392 0x144004>;
> +                       assigned-address = <0xa>;
> +               };
> +
> +               /*
> +                * I3C device without a static address but requiring resources
> +                * described in the DT.
> +                */
> +               sensor@0,39200154004 {

No compatible value?

> +                       reg = <0x0 0x392 0x154004>;
> +                       clocks = <&clock_provider 0>;
> +               };
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
