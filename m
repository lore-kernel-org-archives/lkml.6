Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx489gPCd9J1PgkFbPNEzcWEY1M2sDJ/MRbz6YBEnPyv5nD0Is351Bz3YK55MgUKRHUACVTty
ARC-Seal: i=1; a=rsa-sha256; t=1523821741; cv=none;
        d=google.com; s=arc-20160816;
        b=mbE284DQRHcQN6MlWcgUhV8o/H+gPMKf20734Hp7gaQdfAROTa6Wut8S4Z7abWmRR1
         +MmVmGh0HJhNhxumw5HzGMRajN3tJ15+7bMH7BXDRz4OHsMxZlt9Taz2/Vccs2UQYDwL
         BRe8WAy0sMrX2Yoo8ozmO6U7M65icZUYK1OrAYP/jwPnW8HtqhNT35K7hBWsAd3JT1Jo
         8i58T7fEjag5M7bcqYix8maFk05iZHXK0I2TzJ8SXD0VJ37AlSIK9EKxc/DLgoqC7j6M
         hzrkSYrIT9S6evuCJGHsxlXjTEQEKUap46yERZg9mB1a8S7VyCK4Th2E8XWqJU7kIRin
         qPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=kEDCfx2IcOFQ2weBh02x5eXa0hV1yNC7hbbUEsXW4vE=;
        b=Naa2sh0at/CEUYE51hy6/BHTraxzjKr035yAtV9Vc3NT+U68YnAb0hVSCJ2W3nlzbw
         nQfn0ECbb1cygnHO20OplsdP2Nj80QeUyqu2+TRaeQdHKoilJfoqluECRHkbbwLhwBZk
         0pcKSaOjsxNlc3d0qFLgnLx1UmUypOQFpWxb8gNJDLDDkxMOTtmnQpYKi/FdgeTuqZzO
         ng4MG7O5/JyWPBvqlBO2Prm+LzUJNXfY/tP9SLOAYHNxqQlav+mL1XwiwFX1IIbIxndi
         YuezHkeAjB1KWHq6P+SQxJEd7x34NGOuhoHCsMlZ6SLAKzkEeFYnrYY4vmJdg7Lauz1f
         Uiog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44332176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 20:48:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: =?UTF-8?B?SGVybsOhbg==?= Gonzalez  <hernan@vanguardiasur.com.ar>,
 knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/14] Move ad7746 out of staging
Message-ID: <20180415204855.4393fbd2@archlinux>
In-Reply-To: <d59b997761d752877a9942e6be664d2ae1d25637.camel@perches.com>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-14-git-send-email-hernan@vanguardiasur.com.ar>
	<20180415180451.4d538830@archlinux>
	<d59b997761d752877a9942e6be664d2ae1d25637.camel@perches.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649762786653919?=
X-GMAIL-MSGID: =?utf-8?q?1597842906485931472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 15 Apr 2018 11:46:09 -0700
Joe Perches <joe@perches.com> wrote:

> On Sun, 2018-04-15 at 18:04 +0100, Jonathan Cameron wrote:
> > On Fri, 13 Apr 2018 13:36:50 -0300
> > Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:
> >  =20
> > > Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> =20
> >=20
> > A few comments inline. =20
>=20
> And a trivial typo and other bits
>=20
> > > diff --git a/drivers/iio/cdc/Makefile b/drivers/iio/cdc/Makefile =20
> []
> > > @@ -0,0 +1,5 @@
> > > +#
> > > +#Makeefile for industrial I/O CDC drivers =20
>=20
> Makefile
>=20
> > > diff --git a/drivers/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c =20
> []
> > > @@ -0,0 +1,855 @@ =20
>=20
> Perhaps use the SPDX tags
There was some resistance around this so we dropped it from suggested chang=
es
before moving these drivers out of staging.  Can sort it out later.

>=20
> > > +/*
> > > + * AD7746 capacitive sensor driver supporting AD7745, AD7746 and AD7=
747
> > > + *
> > > + * Copyright 2011 Analog Devices Inc.
> > > + *
> > > + * Licensed under the GPL-2.
> > > + */ =20
>=20
> []
>=20
> > > +static const struct iio_chan_spec ad7746_channels[] =3D {
> > > +	[VIN] =3D {
> > > +		.type =3D IIO_VOLTAGE,
> > > +		.indexed =3D 1,
> > > +		.channel =3D 0,
> > > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> > > +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
> > > +			BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > > +		.address =3D AD7746_REG_VT_DATA_HIGH << 8 |
> > > +			AD7746_VTSETUP_VTMD_EXT_VIN, =20
> >=20
> > Hmm. I never like to see a single location used to hold two different t=
hings.
> > I would suggest perhaps having address be an enum then have have a look=
up
> > into an array of structures that have the two elements separately.
> > (use the ad7746_chan enum again for this?) =20
>=20
> And perhaps it's nicer to align the multiple
> BIT(identifier) uses like
>=20
> 		.info_mask_shared_by_type =3D (BIT(IIO_CHAN_INFO_SCALE) |
>  					     BIT(IIO_CHAN_INFO_SAMP_FREQ)),
>=20
> The extra unnecessary parentheses allow at least emacs
> to align the BIT uses properly.
>=20
> []
>=20
> > > +	[CIN1] =3D {
> > > +		.type =3D IIO_CAPACITANCE,
> > > +		.indexed =3D 1,
> > > +		.channel =3D 0,
> > > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > > +		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> > > +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_CALIBBIAS) |
> > > +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > > +		.address =3D AD7746_REG_CAP_DATA_HIGH << 8,
> > > +	}, =20
>=20
> So this one could be:
>=20
> 		.info_mask_shared_by_type =3D (BIT(IIO_CHAN_INFO_CALIBBIAS) |
> 					     BIT(IIO_CHAN_INFO_SCALE) |
> 					     BIT(IIO_CHAN_INFO_SAMP_FREQ)),
>=20
> etc...
>=20
>=20
