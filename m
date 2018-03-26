Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522064154; cv=none;
        d=google.com; s=arc-20160816;
        b=Q/XN9vcSifZEI8RCloDhquSrqLElvR34JF3CXoQTr7FfmmgQWPbWgYvZmIjSV4kkUE
         EwuwOIOtRam7hHoErl+Op9VZzUC7eDi9LHK955m+g6y1Hbvn1QmzfSsiZO84TO8Tmx1I
         OqlsImHa15jvmlfNZIxaBfcmmrUTcye46FbQBjSNrdByXv75LnIhIg2+VdKztA79DAnA
         9gR2EG4bXXHMe3a2Lc/NcVK9s61b3p6LJdiNqGQmFOHxx/L4vWuAlx2GVfmmczRMzran
         UiagXsFxYq/4T8k/I37zFmvW2cmEI1pUr3LJzIWyBnaOuWC6pO2RI17nDDHNHgb52od4
         5Vvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=v8GShf95lIyZmSlxKnaNrhtQzlN7re/MNslzHk+2rFs=;
        b=HAukHXm0Hpu7q8oNPiOrn42tFC5YjK/5EItmBVwMTpdZ1PoZYn+ZJq6lmGnPIckYWx
         lqL/7J9s95O63IpDA7SMU+vkuW3hAxyM331SA2Z07XQyvl+nag6iRW2eQK5ZiAeHedcS
         3zU0e+DUf1dUNX60sN5scrcI9v8Ntg5nUxLu/7Q7NJ4EH6Sh2YcGCDgyb5YstAyb/ji8
         rQ6LVfy57nJ8julVlhZP2+KuIrleYxnZpj2AYNnbcsEdW3XbCuX/eqvhjgrFrX5xrhy5
         /9QUDaOtmUBsDwhd9JdErLJjhv9SQ5ZDC5pkEE/q9akelflnVusqPgvBWDfp68NtzetY
         R1vQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E/8fWj7y;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E/8fWj7y;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AG47ELu9NubfToUboXrzk6Djcrby/dxCGlYx5DL6qUIrxgat2mxtQ6S1y21Yd9HVanlFe40ayPVOOJVOo83u25cBBgo=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180326132526.1634946e@bbrezillon>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
 <20180323110020.19080-12-boris.brezillon@bootlin.com> <CAMuHMdX3TLmaN14gM4fTgzXwy1dgsMxCFBs_3wCFWM8rX=+8vA@mail.gmail.com>
 <20180326132526.1634946e@bbrezillon>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Mar 2018 13:35:53 +0200
X-Google-Sender-Auth: VDRmG6Gx97o6jUwHOELIMIJfY_4
Message-ID: <CAMuHMdWXb+eSTG28eKRzfP3mq=KLXikOt94MGNaS+MYeiVdr3w@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1595999942730185370?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Boris,

On Mon, Mar 26, 2018 at 1:25 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Mon, 26 Mar 2018 12:12:54 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Fri, Mar 23, 2018 at 12:00 PM, Boris Brezillon
>> <boris.brezillon@bootlin.com> wrote:
>> > Document the Cadence I3C gpio expander bindings.
>> >
>> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>>
>> Thanks for your patch!
>>
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
>>
>> > +- #interrupt-cells : Should be 2.  The first cell is the GPIO number.
>> > +  The second cell bits[3:0] is used to specify trigger type and level flags:
>> > +      1 = low-to-high edge triggered.
>> > +      2 = high-to-low edge triggered.
>> > +      3 = triggered on both edges.
>> > +      4 = active high level-sensitive.
>> > +      8 = active low level-sensitive.
>>
>> These are identical to the values in <dt-bindings/interrupt-controller/irq.h>.
>> Perhaps you can refer to those definitions?
>
> Well, I'm not sure this is allowed since DT bindings docs are
> supposed to be OS-agnostic and macros defined in
> <dt-bindings/interrupt-controller/irq.h> are, AFAIK, only available to
> Linux.

If they're under include/dt-bindings/, they're part of the DT bindings.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
