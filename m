Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522396522; cv=none;
        d=google.com; s=arc-20160816;
        b=vqyRigce4P7KAOaotZCfy5l/abT+Sv9Ho3TARNFzCe40s30VMv3jPs33r4LOGbOU3o
         KFtLfyMqFi7qumFv4GeMnAsc3JC5mXjihPJfsvY7D8YNY7Ktk8xQqlifNq9nh60u/XzX
         iS5f2UBHEEae0WyjTd1bzRQIoqszELbXEusHkxUHCSrYO7tUrmXFXxifXvLfcDGRIssx
         t/ep49ymkah5x59SvJbMNk3mrTiFQEPsxpDrjB8A9Ucs+BvpfsWjPsbzucbnOzxMifR5
         ngtljtXf5m/iad7A/KOK34/6khrkVVXkdeMpTmYBf0HBNGhxFIBW6rMQeDLf0c/zuqDg
         ZQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=NgPkZTc8EoLB7dtNGzLHY3q6bgIElIYHJ/aIoORdA1s=;
        b=JXQD571FXW4/U1j9qUFZSjTHbvoJ0IiEURRr+FFbwUhNte+Fg8R5XWO8zyQBX55EXq
         GLACttcwTIDlpSEnnL5uUgqksHozqlHVHd3EN1GBmNyhV2q6sHlTGeK6CRZZemYykJMf
         MM9NmQLwwwmwGfP6uuh1j9CxS3Z8OgYG1zZw+hy/Yw9e8YY58cSdnxNYB/l0gsrKKRs4
         q/lb4JXiycDvqhoYOyV5QqnbubQRf4pC7JG8ad3FGhnTR9XyXj7DoIlQnefS7Jz7ta2I
         e9hR1qoJ8VybJBFZxN1uEJR8dGBPnpLJrS93jDpX4e2CycivNtlha5ZUzBN58A2RiMuG
         e2Nw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TxZDpNrH;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TxZDpNrH;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AIpwx49omFZqhUFGx0K0OcS4G+5pXSjQ7VF4YN7bT+6rFwYlMM5Qh1wssClOijFOJV81EcMUlCVH1Ynk08zvRxfin5I=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180330074751.25987-5-boris.brezillon@bootlin.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com> <20180330074751.25987-5-boris.brezillon@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Mar 2018 09:55:22 +0200
X-Google-Sender-Auth: gLUpy2HHb04rvKAfBmAsfUidLYc
Message-ID: <CAMuHMdW-MhzaW-bWL25Y+--UHxLB+Mm5+SmhwA+PiezUEg0Ycw@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] dt-bindings: i3c: Document core bindings
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vitor Soares <Vitor.Soares@synopsys.com>,
	Linus Walleij <linus.walleij@linaro.org>, Xiang Lin <Xiang.Lin@synaptics.com>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596347989623961595?=
X-GMAIL-MSGID: =?utf-8?q?1596348456023256292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Boris,

On Fri, Mar 30, 2018 at 9:47 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> A new I3C subsystem has been added and a generic description has been
> created to represent the I3C bus and the devices connected on it.
>
> Document this generic representation.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
> Changes in v4:
> - Clarify the fact that static address == I3C address and dynamic

static address == I2C address?

>   address == I3C address

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
