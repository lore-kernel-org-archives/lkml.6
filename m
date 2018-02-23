Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AG47ELtGJCTtNtxOi0Jj2KMjQ3HLQ7655aKLclteWnfxH5zTQURR8Hl27JXj8eEY0wQLbOrk82OQ
ARC-Seal: i=1; a=rsa-sha256; t=1519425958; cv=none;
        d=google.com; s=arc-20160816;
        b=jhEULfjIQFF9mxu9/lzAeVbcIpSifPX/ixgsbJlty5NRYBZiFFP0Wdvvt6KjT38FPF
         cxJvs4rUoNGsLwSHyUCHyxzbq+hN1hJ+1q2qE2GkSb8nPW8f83NkqBrSJte7z/7U+9eo
         2aOpBNOcHoQ4E3aWFwA72tjGg7ErPBtw2eAKxBc3z2ZJiCBKH3X4zBaidXN2mg0BySic
         F9bAPGVI+s8gJT622Kfgg5PLK9Zz5KgsffwMIg1rVsuU2RIpOQGEKQMlxiz/GOs1ccHk
         /LQfvwny+3yyJHCppSey+1xntQjrwbxEqU9ikxXYKRUQttyaUbzGMTvEAeXFebEMK56c
         jXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=F7Mixr0hngXAii99j5jtr0nYghQE+6/BT/bACq/PxuQ=;
        b=ZSeXbkP33VdwoqFnQiVO6qXE9xPQH9tVbqU6QfxDz++EToZP6W668t3uWiUOyk9ddz
         vWj9sXmsxAz5SeeHcC9AjD08/FDnvk6+fGI7/umC58oEB8mzTrNpMa7eXpitdUoH8WeS
         Fhr+XlOXD62aN7D2ljXYppMQOOugwZ0sr+y69szir0yCcGIOMNIE8rWHAi1ptJJbdJ7o
         rAVQj638t6KxKESWVDYjwmd9IOWKNYzsI+QwE1AxtiA05oGUZoCWTjzjU4zdPWAlUwWs
         2EndvyNigz2/Oz093FJDPHb3JgOvojZARtLC0j61PB5Hun5O68GtfZog/4mJmw0vB4HC
         V09Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Fri, 23 Feb 2018 23:45:46 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Vitor Soares <Vitor.Soares@synopsys.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Wolfram Sang
 <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw
 Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan
 Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian
 Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>,
 Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose
 <sureshp@cadence.com>, Thomas Petazzoni
 <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, "Rob
 Herring" <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
 Rutland <mark.rutland@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, "Kumar Gala" <galak@codeaurora.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Linus Walleij
 <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/7] i3c: Add core I3C infrastructure
Message-ID: <20180223234546.54e62150@bbrezillon>
In-Reply-To: <b39f9016-b2ff-6d8d-96b3-945f32ab2b67@synopsys.com>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
	<20171214151610.19153-3-boris.brezillon@free-electrons.com>
	<b39f9016-b2ff-6d8d-96b3-945f32ab2b67@synopsys.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586772916728163872?=
X-GMAIL-MSGID: =?utf-8?q?1593233594046378953?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Feb 2018 16:56:14 +0000
Vitor Soares <Vitor.Soares@synopsys.com> wrote:


> > +
> > +/**
> > + * struct i3c_ccc_setda - payload passed to ENTTM CCC
> > + *
> > + * @mode: one of the &enum i3c_ccc_test_mode modes
> > + *
> > + * Information passed to the ENTTM CCC to instruct an I3C device to en=
ter a
> > + * specific test mode.

Oops, copy&paste error. I'll fix the kernel-doc header.

> > + */
> > +struct i3c_ccc_setda {
> > +	u8 addr;
> > +} __packed; =20
>=20
> =C2=A0what do you mean with struct? Maybe setdasa? if so, what is the add=
r?

It's the payload passed to SETDASA and SETNEWDA, hence the generic
_setda suffix. addr is the new dynamic address assigned to the
device.



--=20
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
