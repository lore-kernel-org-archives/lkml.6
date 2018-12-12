Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E4AC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D2720870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEQ8omnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D2720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeLLLEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:04:53 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45611 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbeLLLEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:04:50 -0500
Received: by mail-ed1-f65.google.com with SMTP id d39so15153786edb.12;
        Wed, 12 Dec 2018 03:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8XBdB4wGoJxZeKLmCNx0g6FBv4hCo/x4Ft6tvL/sy0Y=;
        b=iEQ8omnTfknZ/v7wawkkQKEQ8YTwYvm7DtJ7oTMFNEEotkGLwmkEEBM/oFFKOeuQSt
         dHrqCG5TjJ1tDNkPdG1IN75jfedRqIucGGSO0RVQCFSRuI7EH/x/yr5DEkpa2kQf8W2s
         +vJgHJ4HvplaWWuIIgJTPPocd4Dx/Fni5UuGFOBCjrOOnMeZBNwYZCfJ3/Sor0ABQf7V
         Zoq0qyIFkSofIHqFipaosfEguFkNAwl5h730/45IhVEL9ACwHMF2Q1r2DM8eyoZsbYVk
         LOAr3glLHZwEJWSUIpBBNoAcRWBVQFzjsTO654uEI4giAeXx42fCftoYzBRnuFJ0WpWg
         S8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8XBdB4wGoJxZeKLmCNx0g6FBv4hCo/x4Ft6tvL/sy0Y=;
        b=t2pdiFx8vKQ/4jgEnmy3T/+eS2xacegL3IXfseILMbdoSkvwnn0f2NH/PtvLzToG6w
         r3+EmoLLuahs+JCyq/rcPXiCC/iTLfxX3lq+/p8eKRhFYwaMPbU6IGhLixAiXY8fq+hS
         yE54YKmaOCz/5Xj/3Ke+kNKC/9WI5BXodexwZBilFE8O45yx6sChGLXZ/xA0uMA0PdTd
         GIRo4JpIfkUKdoy5lqxyJTG9L2By0XE2L+BbLTsM2FwoUiAPthE63WfsV3/5IHv9D3YI
         j66deRkhVZ1oaKpklpc4nhydG9i2avCMVl+YRyQNq8+ZyHWmLG/8oHwrstG9tKZ1SLjJ
         mGsw==
X-Gm-Message-State: AA+aEWaVA1oqfzr6LSayYRQDnTNmWDz44QV4mV3OhXy7dkV51P5nCwPh
        J8RryLdxa64AHlaRwYqDxtDwBF/j
X-Google-Smtp-Source: AFSGD/W9vpJYLglZs0AcQlCa51K3fxMz7S3WZ0Yp7nuD7oWzl/EqH8ozC/dLpsB/Svf+E3H/JzknpA==
X-Received: by 2002:a17:906:1f99:: with SMTP id t25-v6mr15123791ejr.36.1544612688242;
        Wed, 12 Dec 2018 03:04:48 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id p1-v6sm2616623ejo.49.2018.12.12.03.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 03:04:47 -0800 (PST)
Date:   Wed, 12 Dec 2018 12:04:46 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Suji Velupillai <suji.velupillai@broadcom.com>
Subject: Re: [PATCH 2/2] pwm: bcm-kona: apply pwm settings on enable
Message-ID: <20181212110446.GF17654@ulmo>
References: <20181107093613.26734-1-peron.clem@gmail.com>
 <20181107093613.26734-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Content-Disposition: inline
In-Reply-To: <20181107093613.26734-2-peron.clem@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 10:36:13AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> From: Suji Velupillai <suji.velupillai@broadcom.com>
>=20
> When pwm_bl framework calls enable, a call to pwm_is_enabled(pwm) still
> return false, this prevents the backlight being turn on at boot time.
>=20
> Signed-off-by: Suji Velupillai <suji.velupillai@broadcom.com>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  drivers/pwm/pwm-bcm-kona.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

I see v2 and v3 of patch 1 of the series. Did you work on v2 of this
patch (2/2) as well? I don't see it on the list and it didn't seem like
everyone was happy with this version.

Thierry

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ604ACgkQ3SOs138+
s6HurBAAu4FglpN1Tc0q8ipMLFF7FdNMQKJc5c8pjpK3EyqwfmtJXPZiEPKvA38F
kuOTau+A8Nu/AjwEtnVKp6h2XzOy9DUXtWEU8JnhGKQvomm01SucysxEd6a/f0/N
7WAlzabOMvYwhXZGAgeuIMiGNmlw5q2AuKhXOtCFeTmjHJC1tJU/kqYHrTjLOdoH
JCNCp8WzLLSsMXPi/4EkBz0T14kS3iWpnm5Bx3fVORyT+Ep22IRWf7r1wi21aK3X
6z88IqprWiKCjFdnhVoa3b3Qf152e+Rzr854Y5pZ4ihvdTqA735MZ+forHlxbjK7
VGUtEcK5NrjDP0l3r3qhH9dkGlfb/UpAX1001H9TzS0gcMyamlMVJneQ+ipBWRcL
BfTmyyuNiXShJjQ1UzkgOY+Je9vvdq9XV3NIzTA3d8qsHANM1JyPzus0WtIklDHf
RYxXw68OlbbFUKv70ShbWzYyKVBEGXN/BknUvM4lTcISMRVfxi0VwMQwlGXIDGND
d8Y25zA1J/s41H6ZxhG2h6/Na6ymsSJkNSaye/X5+BcpXEfDH1oZmkizKYqkuCnt
cMmzg/T1KlUxMIGKgB2TQ1+KzNbT+RiIDmLi6xFSnqhJwN3tQoCFi/83Kuy+fIRM
vVxxz9NyfZB9vMiZnk0qAndDSq4rc/DIMfg2JVGHv1ZM/GzYLSA=
=/vm3
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
