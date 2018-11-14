Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2288C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776CA22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYtrf+Jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776CA22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbeKNVRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:17:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35818 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKNVRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:17:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id z16-v6so16846302wrv.2;
        Wed, 14 Nov 2018 03:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fpnLRuv5RFe8FT8LV4mKQ+SgydwlIYddjZNCbsY0MN8=;
        b=fYtrf+JzxY1o8JD7tswemOxavqDQEOYopTVY+dH4M79B6Yd67Rtgev1Z5teLx0s92A
         /mIhn0QtYaMhfrppx9UDkj1M9UgMZLSesXzx7DXvRzBvnaWsKyslewE5WDJfKk1C84Z6
         00AzQJbOd/yA+vTeUNn5Tc2CytFo/Kilfa0FePEgWUgZKyf5nfwpIqBl1iXxDSg7ClXf
         Kq7tpwkD4mKoqXgAqeZZ4kpwwEpwtzVX3UbalSFFgfk8tsTdb4Q8oMYfVBgH+MNEBQIa
         kMJYC7/1ZkPVugz2X6/K4pkZgYHy1hv8jAGyeKnFjkhAh6VP+gTN+kpQxdF5qJg7C5+R
         Lv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fpnLRuv5RFe8FT8LV4mKQ+SgydwlIYddjZNCbsY0MN8=;
        b=B1VIaMRpWfZzFZqwyKMVAmQJTIFfFyiA4jMPXE7hEUKmUP8dLwxsr6Ks28G9jxr/Aa
         n9OBWx2c2LpZwts0+3TDZCqsjrH8LJIa/yjdy04VC5G3WrMpVJWuyemDBgp7/rgeAXzE
         OVL2TFAHDtN7lGTfPXRb6xHWHdV8VhLbLME6iqCZ4Cg0jvQZAQgaakOYuSXYWty7WjC4
         aAMOvKtltL9LddHytq+PhPjVFLolwSDAR2VpvF3caQ78AnG94PKV+t3VXLPTFf3TxUcp
         nnLWphKejmoVeEOAunZj5ZjfuoYUKilTksUGDmFMj0P/3YiMA0MsW/CG7mH8sKe2S1vb
         gseA==
X-Gm-Message-State: AGRZ1gLEa50rpukZIZBJPmvP80nC0aGUAV0dZgeVzWcXzss3HMXWlJWw
        nO5Z6xAAcFnt3dVy7bpAZTU=
X-Google-Smtp-Source: AJdET5clvqjaV0P8jP7njApggpLH9t039G+Y+xzj0RUJmqjZSU+wt3lDEbaAxLSLNntO+Jm6YQ8/OQ==
X-Received: by 2002:adf:8281:: with SMTP id 1-v6mr1518034wrc.252.1542194057943;
        Wed, 14 Nov 2018 03:14:17 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id 11-v6sm11122053wms.24.2018.11.14.03.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 03:14:16 -0800 (PST)
Date:   Wed, 14 Nov 2018 12:14:15 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@karo-electronics.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: =?utf-8?B?W1JDRsKgUEFUQ0gsdjIsMi8y?= =?utf-8?Q?=5D?= pwm: imx:
 Configure output to GPIO in disabled state
Message-ID: <20181114111415.GA2620@ulmo>
References: <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
 <20181012085720.GA9451@taurus.defre.kleine-koenig.org>
 <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
 <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
 <e4289ee5-3fc1-2848-1cae-77d29b5ed93c@ysoft.com>
 <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
 <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com>
 <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2018 at 03:21:44PM +0000, Vok=C3=A1=C4=8D Michal wrote:
> On 7.11.2018 16:01, Uwe Kleine-K=C3=B6nig wrote:
[...]
> > For both the solution is to let the bootloader enable the pwm with
> > the right output level. Am I missing something?
>=20
> Bootloader is only a small part of the whole solution I think. And I
> suppose you meant: "enable the *GPIO* with the right output level".
>=20
>   - Even if you use GPIO in bootloader to set the required level the
>     time frame from imx_pwm_probe to imx_pwm_apply is not covered.
>=20
>   - Currently there is no support in Linux pwm-imx driver to detect
>     the PWM chip is already enabled at probe time. I actually send
>     patches for this a month ago [1]. No response yet.
>=20
>   - Inverted PWM does not work in U-Boot (on imx at least). And it
>     does not seam like it can be fixed easily. I do not know what is
>     the situation in other bootloaders.
>=20
> So my current bootloader solution is one of:
>   - Set the pin to the appropriate (HIGH) level using GPIO.
>   - Do not touch the pin at all, it has 100k pull-up by default.

First of all, I don't think we should rely on any bootloader setting up
things properly. I already said elsewhere that the reset defaults will
likely already be such that the PWM outputs zero power (i.e. high for
inversed PWM). Michal's comments above seem to suggest that this is
indeed the case. If the pin is 100k pull-up by default (I assume that
means on reset), then that's exactly what I would expect for this kind
of pin.

And that's also an excellent pin state for the kernel to use when it no
longer needs to actively drive the PWM. That means on pwm_disable() we
can simply revert to the 100k pull-up default and let the PWM pin be in
the very same state that it is on reset. Can't get any better than that.

So really, I think the only proper solution to this problem is to get
pinctrl involved and configure the pin as PWM when it is actively used,
and change it back to 100k pull-up otherwise.

And, yes, I understand that this slightly complicates the driver, but
it's really the right thing to do and it fixes all known issues, and to
me that's clear evidence that it is the right solution and therefore
definitely worth the added complexity.

Thierry

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvsA4UACgkQ3SOs138+
s6E/HA/+LNGOP9plUBaj0mGF70tAnkx3vTigto0VUCCyFlUU/vJQRSvufCPh2aV3
klxiBXTHYKE6L4BiIhheWwDjFWe7j33CDbD9JGqQ6vupLY1daRZdhTSjxjKNyutf
53ILYEli/JSs5g5pA2u4O4BcOMgdX1AVEMj9RTsu7T2zfM8JN6Kl7gzEYt33P3OJ
NWDScehY0PkiCdGc4vEQKIBXstzAQi7OTPRuQJDyOPftNlBYYLAkGzQDgOOL83s4
e0vrNaumRLgf6Ync8aGeTWM/k1KGVQc3IZiXaQwmV8QU/WxPWO2vLlHsFnuC/qYa
neAO8qA1RLE7xfRq443l23iCZA1ENxAGgs79JhonZ8fXAhoE5R/jnkPI1M2g5Z/U
y9mwnSPbJK+mvxZF5V14E43hrEqTJ8NaItXbZaeOXPzQwz9AVTP9Oof3KW6kJ/vw
+2ekiGfGTqWsb52R2qgQ0uXkPV31JGc336/7DdrBWuNX7L1h3sxaYUpPVggMdjE8
i+OcuDSJXJRaWL7kWSyrZXMvAfZ7vLF3xHhICzlau+9R6VbVNd8xlTTiBhogTFz/
cB8uvDl2HAL6G6Cfb56hOZWeypvtqW4rK2D7nDi2pHsrkuAqN2qhnOrF2q64guFE
3YepHHeWCoxXrUqjJYtdCuXSoGxqU54+YsBaKTu7P2C+8x2BI4U=
=r4V3
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
