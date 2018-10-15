Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50639C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FA92064E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wxb+eNMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FA92064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeJOQ31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:29:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44197 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeJOQ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:29:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id 63-v6so20235549wra.11;
        Mon, 15 Oct 2018 01:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ufuzhKYnq8uqJos4sIyvko/QKM/XU/Y2YboVN29rboY=;
        b=Wxb+eNMSNuZOxzwANU1mB2LTJ88Ui0glmRXIh/0e5WR8GROXU5i+A/mM7xAPaH2WXU
         wVITEvoQmbRwP7fbxnFH4vqlD6H8T0LHfagoM1hyTwgCnD0l9WXfaDqJCGqoBULHvVBD
         G2Sc0iF2ci7IIcrHDkvmz+lDpFBG7Lj3CRFKlDBhiOcdhYZ1pGZzp6+wgjPvb7vJO73R
         JIm0oDQ1fVW+IAN6h+v02GhX0NXweI6PJiIN4nQpstIkw/d4kfz+R2B7hJ8AKQgHuRud
         6mhaJu9tM3Yi2cK1zDvRD8JC8hWv7gGu8Z7R20Q6gouDgSDG1ETataBdyE8uxj6Z1QgP
         boqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ufuzhKYnq8uqJos4sIyvko/QKM/XU/Y2YboVN29rboY=;
        b=gRMvzIwdmpzVcxvHoXqCRCnJzyEhqr3KZSD83HfeNSozjriW3AMyiiXQErqHYLVhQC
         TM9deqXZS6OoZxhHegH9Osv7PRPZrnEYlpa7JK2tKIh7DA4YUgrEvvIgdtJlfAPxze3Y
         N8APFTfYnAQCyQLx7n1Gx54ydaqzNadLHCJyMa8zvXVzN1o6Ljgp4ir6KdnW9aduqvAh
         BdZCjxfvQadiLKccPX0JyePf7zTTIO1IRxdzdElTFCWclHPgeEIlBRjxo0P8Cpxh+GC7
         p6RkIzT4TX4lPGzRpklm2fDYcNXUh15S2I2w1ajZtL4QGmlLzSuFYA6Qm8IkukmISZEb
         eFAg==
X-Gm-Message-State: ABuFfogAvUZXzsLXy9oLL3qJplGrXabB4qTzMP2CY1wj8Wi92gNjPVdy
        bBcCQIW+Bj4SkCXRJMDeArjO64Kh
X-Google-Smtp-Source: ACcGV63BDB6BRyY79OKC9qCoufFgCXqypIZLU/s1Szm5b/G+Du62U2+JglIUSCtDurNASEAdykoMKA==
X-Received: by 2002:a5d:60c3:: with SMTP id x3-v6mr14160998wrt.193.1539593107710;
        Mon, 15 Oct 2018 01:45:07 -0700 (PDT)
Received: from localhost (pD9E5106D.dip0.t-ipconnect.de. [217.229.16.109])
        by smtp.gmail.com with ESMTPSA id i15-v6sm7945382wro.58.2018.10.15.01.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 01:45:07 -0700 (PDT)
Date:   Mon, 15 Oct 2018 10:45:05 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@karo-electronics.de>
Subject: Re: =?utf-8?B?W1JDRsKgUEFUQ0gsdjIsMi8y?= =?utf-8?Q?=5D?= pwm: imx:
 Configure output to GPIO in disabled state
Message-ID: <20181015084505.GA12357@ulmo>
References: <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
 <20181012085720.GA9451@taurus.defre.kleine-koenig.org>
 <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
 <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
 <20181014202457.dohwgz3frgcpdpy6@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20181014202457.dohwgz3frgcpdpy6@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 14, 2018 at 10:24:57PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Fri, Oct 12, 2018 at 06:08:54PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > >> +	if (PTR_ERR(imx_chip->pwm_gpiod) =3D=3D -EPROBE_DEFER) {
> > > >=20
> > > > You must not use PTR_ERR on a value that might not contain an error
> > > > pointer.
> > >=20
> > > OK, thank you for valuable info.
> > > So it seems like the I2C folks are in troubles as well:
> > >=20
> > > 	https://elixir.bootlin.com/linux/latest/source/drivers/i2c/busses/i2=
c-imx.c#L996
> >=20
> > correct. I cannot find this documented though.
>=20
> I found in LDD3[1], chapter 11 on page 295:
>=20
> 	If you need the actual error code, it can be extracted with:
>=20
> 		long PTR_ERR(const void *ptr);
>=20
> 	You should use PTR_ERR only on a value for which IS_ERR returns a true
> 	value; any other value is a valid pointer.
>=20
> That is probably where I have my claim from. There is no further
> explanation though, so I'll post a patch adding a comment to the
> definition of PTR_ERR to find out if there is a relevant reason.

Michal's code above does an implicit IS_ERR() by comparing to an actual
error code. It's certainly true that PTR_ERR() on any pointer and then
using that value can be risky because it may not actually be an error.
So if you go and unconditionally print that error code even if it isn't
an error but a valid pointer, you've leaked a kernel address.

However, it's perfectly safe to use PTR_ERR(ptr) =3D=3D -EPROBE_DEFER (or
for any other error code for that matter).

Thierry

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvEU48ACgkQ3SOs138+
s6Gzqw//T+d8Wb41k3KDCT7WKo0TzK1p/AyL95o2ZS6lV2/+dd0DemSNRHykSY3s
otrx+vwMpgEhMCA9m9n40Nw0hkmTTDXO3b1ppvLcq0dDArI+wjFbDJfcIsKegx70
90b9ccfTB84TYtcf4bRWtIO7DypS668OQw8VFbbxZ9bBp/+4CNbuhIZyw3brmK/a
YSocK6ZuT3vauWO25LoIawz5WADU7RHl5mSl26ywUxKQ4zKe02RGUIH6qoB3jxmH
heWsXt5C5Yrftn7ns7xvIZT7iufNA2eTW2FsEBQPer7dtflI9RkseTabouJf/VKD
huryBYFmM2NjhcuzohnaPTNCp2txDDc8PFCyra0v4iiwgfwvhnIQYHTjFpiA3q6y
mnhukrI9jX0dw4u3pbz5va8HOnwoWejRJKiWVWMmHsQPXscIC86PYDI90LYPimsk
4l2KpQUwOIrI3m/yC+E7g/AnYSxl3ZSW+0JrOP1NRlgZD9qxODjlwENndxeNdRdi
8OJdrmKLD36rc4TWMNAq3A33S68gKafAz85fh2eraeNvo3EgcN08zezPlAhHhIfb
x2agre7MWxhiXolwD7Rbj6f5DaZAwpYtCXzhCcBAmjo1zoXCAcvb9cfRbiEyhB48
xGHF3lAyUxH+nFJ6unkqubdxMZz17jweaXvZ+6QsrCqnQdcrl4w=
=lOQ2
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
