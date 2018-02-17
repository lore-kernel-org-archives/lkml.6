Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AH8x227uDFx69R0uCc2UGlovYzAbDuRnTWXpGhWRGaAA641jOBIpJAntr/Usm/I9/rEMfgF/f42o
ARC-Seal: i=1; a=rsa-sha256; t=1518876569; cv=none;
        d=google.com; s=arc-20160816;
        b=eY6+TV1d1Ov94tMDVG/fu+N3oET8HqWtFUCZxnaJkcGVzdQ3st61WH+EgBwkqwQFFn
         /27SJASPa7SCjZNJaM0wCZkA+AUTBI/e9bOAqZsNsb/xgf7EAe4qK2mZEcv3p1kheeiF
         GN7y3VZXRLjX42kEu5CBeukk2Ada2VJCXgjKFlUXCu32xN/p08o6lM8jsf6BmV+jmxar
         QyWnQ95RXH5s8tXkyGeevu8jCFMG+hHRsx1VgAChac+ZhoI+iV3UtnoFryuwcZOhI6zD
         EtQDyQVs4d6vSRte67LYJvYocMsLsz/IvLd40rM4FtMWGnJVwDUzhkWE/Y/IxvVtS91h
         4r1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=VlOy16U0z+GlZB36JGMsk6STlITPAneanbCS41w2AvY=;
        b=pYCfjnzzXj84JFdatSJUsPVk3XRGCDZnjONLumWCHPhT53daQi4l8S2FAcjO19GAFL
         4Jzx00kb9BRhsuOfw7wqxTZ5YkmHjG+U94RfV0ENpHAmsYKpDj17kegJJV28e3SIguT4
         Ht8v7GnPTNJNlU1IDRFQn1Q6O20z0z2VitnupRd+yBFbzCyn9bfhVmfGV9smAaUkcFbi
         oKt+T+Kln4a0PWE06HpDQReYCnXw1Cg/bvSgHtsHcCOmmUx0mhiX0gKuB029op4Vrr73
         UuaG/KSThEuEy6eNYSR1m05EL1o7Wn773CHYeEbz3BszVOn6GS7FFcC6k3Q5kd/blS/k
         wZlw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434D7217CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Feb 2018 14:09:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, "lars@metafoo.de"
 <lars@metafoo.de>, "knaack.h@gmx.de" <knaack.h@gmx.de>,
 "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
 "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devel@driverdev.osuosl.org"
 <devel@driverdev.osuosl.org>
Subject: Re: [PATCH] staging: iio/meter: add name to function definition
 arguments
Message-ID: <20180217140834.2947e5e4@archlinux>
In-Reply-To: <20180216131658.h7b2y2ckkucetnzj@smtp.gmail.com>
References: <20180216125041.qfvg7xtpulc54tk6@smtp.gmail.com>
	<1518785796.9517.25.camel@nxp.com>
	<20180216131658.h7b2y2ckkucetnzj@smtp.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592561969326261427?=
X-GMAIL-MSGID: =?utf-8?q?1592657517593493555?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Feb 2018 11:16:58 -0200
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> Hi Daniel
>=20
> > Hi Rodrigo,
> >=20
> > I think this is a nice finding. One comment inline:
> >=20
> > On Vi, 2018-02-16 at 10:50 -0200, rodrigosiqueira wrote: =20
> > > This patch fixes the checkpatch.pl warning:
> > >=20
> > > drivers/staging/iio/meter/ade7854.h:157: WARNING: function definition
> > > argument 'struct device *' should also have an identifier name...
> > >=C2=A0
> > > +	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
> > > +	int (*write_reg_8)(struct device *dev, u16 reg_address, u8 value); =
=20
> >=20
> >=20
> > Any particular reason for using val vs value? I get that one is a point=
er
> > and another a plain type, but I think the name should be the same. =20
>=20
> Before I selected the name, I figure out that read_reg_* and write_reg_*
> was assigned inside the iio/meter/ade7754-(i2c|spi).c files by function
> like ade7754_*_read_reg_* and ade7754_*_write_reg_* .
>=20
> I considered to use 'value' name for both functions parameters, however,
> I noticed that function ade7754_*_write_reg_* adopted the name 'value'
> for the last argument and ade7754_*_read_reg_* named the last argument
> as 'val'. So, for consistency sake between the header file and the c
> code, I decided to use the same parameter name patterns.
>=20
Hohum. It isn't even that consistent ;)

ade7754_write_reg_8 uses val and ade7754_write_reg_16 uses value.

I would suggest another patch to make them all val.

Thanks,

Jonathan
>=20
> > thanks,
> > Daniel.
> > =20
>=20
> Thanks=20
