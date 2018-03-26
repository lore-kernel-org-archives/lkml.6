Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522059175; cv=none;
        d=google.com; s=arc-20160816;
        b=PfIXHyvjVTsYAQHt7cZqsEhevW4kFeLOTypN5fbAEdEcjdRgV9kI+YQ46cjae8XjnX
         7NKJBs3GzK0MuZbuQM/cWq3RSai1xOxLpGG+MOwsa1V9i7nndnm6FIAi+ZynTAv+jNJM
         JOhyxAAqWlgVm3awd9wmJuycPhlzcRI81U3zS8vmFzBqWjaPrmX7yzmgbzkqlaBAHOk/
         uZLC723gMZcM3szVwZ1di/CjGAXgACxMoc8nKagK4LvfrFD/4rWG5hRlkbAtokTq3EdV
         GrcvBmHTnSgw0Mv8lYMITQmd+69IZBGwhWYySDiHwpV2FXOjzOn+nPFua8BqJknDo/HM
         7Wng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=mIt2nkooN/lrRvE+dHA+bJcbbHNJlx2F5V98nrRH2nU=;
        b=N0//hnLfLIrJioyndS1zjY2s/rYhG5bIbpwIqyOIKnPeAJFvDXvngIj+RCgVWf/ENV
         PFLx/f4bOJAZE4TE/VmeoHcUbyfGHe1oUk/ndnaHaOM/jiqXK1Ek9YtgKZdSuea9OXbd
         itWhgwbRgoNNcs10Nko4fuii4K0SYzI8a2wgterMZ+5vCAEnYZ5/Bf7XGTSUt6FXqaDK
         xI7PJNzSQZDUb8z1G/kYInl46N55hO1tvzyb0RUxywtvMr0QYuNk7rfEC9aUZbk+kafm
         QHLh195bKcKuiOj2SMTnTuAU1dlluY4x6ERqrksxthSu8+3joenheSVuhZUyTA1CnuLa
         sIGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XE2ErK6W;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XE2ErK6W;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AG47ELuvxWc2Gl2X48OnodU0ZuGXLRMNyeZIenLQszHG4r8Au9wHkCJJ5GYX8w7U3BKWUI7EeREe8+H1qJMXW8t7hw4=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180323110020.19080-12-boris.brezillon@bootlin.com>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com> <20180323110020.19080-12-boris.brezillon@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Mar 2018 12:12:54 +0200
X-Google-Sender-Auth: efwvJAPYgE6xiSWdibSHmeZaZ0Q
Message-ID: <CAMuHMdX3TLmaN14gM4fTgzXwy1dgsMxCFBs_3wCFWM8rX=+8vA@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1595994721876692321?=
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

> +- #interrupt-cells : Should be 2.  The first cell is the GPIO number.
> +  The second cell bits[3:0] is used to specify trigger type and level flags:
> +      1 = low-to-high edge triggered.
> +      2 = high-to-low edge triggered.
> +      3 = triggered on both edges.
> +      4 = active high level-sensitive.
> +      8 = active low level-sensitive.

These are identical to the values in <dt-bindings/interrupt-controller/irq.h>.
Perhaps you can refer to those definitions?
I don't think we want to see the hardcoded numbers in DTS files.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
