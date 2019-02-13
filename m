Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2F2C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C8C222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf8/mNzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404082AbfBMMaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:30:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52837 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfBMMaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:30:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so2257549wml.2;
        Wed, 13 Feb 2019 04:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z8Pbw8nsn78pX+cUzXYH4ai9XOvErZm+J21VGm9bB2U=;
        b=Gf8/mNzJvDyCeyfkJ9kJbCAoKog0jwzDY/FHKypZkk1ByZ1Ssdf/NhWdkL4lHAjF4c
         vU+Tb536ODysTmykrP5pOlqJ9qZkO8GnWbl0rR/6YdEGmvGPZwIfLhcTon9sVlwOejCf
         iZlfEL5ss/CqdI3tqHl5k6pd6qevpVsRTABo/DpG77nTYDln0dOP4jIPpF9fKoaB3ZkX
         DeprHJMfwTnLRrsm0O3aBEIArzKSYT757jn0VKhHdQr0CwQzvWkBHEBPVE5gGp18ncSZ
         iXFpRR4Na+ktSweByGsdWaUuzsKekUOmC1ZOB8ujufv5lPJdVP/J4PzPSsN5LwJM0Ynu
         dDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z8Pbw8nsn78pX+cUzXYH4ai9XOvErZm+J21VGm9bB2U=;
        b=BQ4tNOQ/u/1yEWmAJ1Afjxze5OhFL21VZ913HaNwN9uWoBRnn5Yd7a3eWqoF8MwZws
         YEFAsUjYWknbH/xAHU4VBUKf5KV76f1sULr5ugUM/Lqu7TMxCDZzt8opTZw+aqi54NAn
         wGdXCy5oZjosaXCNqd8rLLMhAUoDrxtO17ljCCbDv1dHMxST7YPwzWx1MbaPs/FYOUDz
         AEtCaVBI05qxvGsLqPEZvZO0pUph+WwwPqlvyt5laiKfdC5bDX7lN8pKoLH/XSgg55hv
         elavXYkYYk9VImoIpJWht7ssaQxV7iTxIvKKzallXXJ3tqmG+1VROfHqlcd+memv1Mvr
         NRGA==
X-Gm-Message-State: AHQUAuZesrFDWvE1vsYlzvVDQqsO+o2zP02IyvimcOnokxoUnDV7Ll8S
        A/U2K+HxRgkRLmPHHJp9gps=
X-Google-Smtp-Source: AHgI3Ib7AP7WU7QwBmUCrbLqo3YgGuANdACjPwNTJFgK1UeKVWXGU90+Vs76v2xeOCTiBHrAHz5eyw==
X-Received: by 2002:a1c:2787:: with SMTP id n129mr140725wmn.128.1550061004863;
        Wed, 13 Feb 2019 04:30:04 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id d16sm14083801wru.52.2019.02.13.04.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 04:30:03 -0800 (PST)
Date:   Wed, 13 Feb 2019 13:30:02 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Mathieu Othacehe <m.othacehe@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: hibvt: Add hi3559v100 support
Message-ID: <20190213123002.GC647@ulmo>
References: <20190212094927.5900-1-m.othacehe@gmail.com>
 <20190212094927.5900-2-m.othacehe@gmail.com>
 <20190212142850.iwgi4n6v6oep4oin@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
In-Reply-To: <20190212142850.iwgi4n6v6oep4oin@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 03:28:50PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Feb 12, 2019 at 10:49:27AM +0100, Mathieu Othacehe wrote:
> > Add support for hi3559v100-shub-pwm and hisilicon,hi3559v100-pwm
> > platforms. They require a special quirk: pwm has to be enabled again
> > to force duty_cycle refresh.
> >=20
> > Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
> > ---
> >  drivers/pwm/pwm-hibvt.c | 26 +++++++++++++++++++++++---
> >  1 file changed, 23 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
> > index 27c107e78d59..bf33aa24433c 100644
> > --- a/drivers/pwm/pwm-hibvt.c
> > +++ b/drivers/pwm/pwm-hibvt.c
> > @@ -49,6 +49,7 @@ struct hibvt_pwm_chip {
> >  	struct clk *clk;
> >  	void __iomem *base;
> >  	struct reset_control *rstc;
> > +	bool quirk_force_enable;
> >  };
> > =20
> >  struct hibvt_pwm_soc {
> > @@ -56,6 +57,7 @@ struct hibvt_pwm_soc {
> >  };
> > =20
> >  static const struct hibvt_pwm_soc pwm_soc[2] =3D {
> > +	{ .num_pwms =3D 2 },
> >  	{ .num_pwms =3D 4 },
> >  	{ .num_pwms =3D 8 },
>=20
> The members of this struct are used as of-data (in struct
> of_device_id::data below). When looking at the usage:
>=20
> 	{ .compatible =3D "hisilicon,hi3516cv300-pwm", .data =3D &pwm_soc[1] },
> 	{ .compatible =3D "hisilicon,hi3519v100-pwm", .data =3D &pwm_soc[2] },
> 	{ .compatible =3D "hisilicon,hi3559v100-shub-pwm", .data =3D &pwm_soc[2]=
 },
> 	{ .compatible =3D "hisilicon,hi3559v100-pwm", .data =3D &pwm_soc[0] },
>=20
> this isn't exactly easy to understand. I would prefer to do it as
> follows:
>=20
> 	static const struct hibvt_pwm_soc hi3516cv300_soc_info =3D {
> 		.num_pwms =3D 2,
> 	};
> 	...
>=20
> 	static const struct of_device_id hibvt_pwm_of_match[] =3D {
> 		{ .compatible =3D "hisilicon,hi3516cv300-pwm", .data =3D &hi3516cv300_s=
oc_info },
> 		...
> 	};
>=20
> Then you could also add a member to hibvt_pwm_soc to signal if that
> force_enable quirk is necessary and would not need to use
> of_device_is_compatible() to determine this. The result is that you have
> a description of all relevant differences in a single place.
>=20
> @Thierry: Also this is yet another driver instance where a num-pwms
> property would simplify the driver because up to before this patch this
> was the only difference between the different variants.

We don't need the num-pwms in device tree if it can be derived from the
compatible string.

Thierry

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxkDcgACgkQ3SOs138+
s6FumA//UXRbb4IpLIkxjoOLtrXebSP9Ky4IE3i9sgcBnKi9gOF5vYGNTzD+phlk
nqyuxFjBZjQ0hEF7FFJYnpk2TdWta7YgNBn94L/rYP9mPWUmAiO2cZjgKrUsqcU5
bMYYARdcP02FHPQdtyB/mM6cCcnrVCDx1UOI23U+C23dm3T/SwPEqlIFnKiayOeQ
0HzXG7Gkbj6sSPG+NL+4pZVkFAMdNiAhyVwWWgCFKm09vLkbuzD4w+YMHnA/LAea
SGUAlgkw2L79ytpDDiEVcqkfccBCrOQktqozG5v2EDjbyDb+aG7aAje0wfqaVKWu
HeJW+I3TaPeM3I+k8uJ7akUXQAXBRPrjpfYzfavIdIg8j1/YmhZrLGs3tsY6ZDCF
7SLqCrHa8QHQje+auoHJ1nN22WiHj2Nfrm6QEIIXuXz2FcwAXpvxecAAaheAUSDr
R/1kHB5Bcf/XmMPv5ixbInHCg5rmDw3l9s+gCRmLzO9oPkFlL7/BZFqYBw7j5Tk5
w/HVP8MUO2FjouJBbnCopozSyhKsmluI3t8lGxQIEDPU2x9poIB6wlwSuf3+nIUY
83W4KDT9M9weSSUBv4EZyq7Y4H7m0QtLcVt46a0w2jk7SFqiOT38eOaR6N6ihaaA
LUThRR9KasBfWMuoz6nvLrczNpkrFNiFh3j4b5TkKWuJYLEnST0=
=2fgf
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
