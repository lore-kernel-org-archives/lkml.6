Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7879DC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BB32086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuKYxT3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BB32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeJLSQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:16:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43361 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJLSQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:16:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1-v6so12900990wrt.10;
        Fri, 12 Oct 2018 03:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TG27+xIK25GzwB3sLm2rIdsHlo9uLNjnjrSgSL3ZnIA=;
        b=MuKYxT3WxdCe3DNB4E+EIrsXFel+QDJZLORESJgPvIaGSwL/9W2f5bkeBEp/d6ZflK
         huEIqSLTUawcjlyD8/tLviy+4aExa3LRzi1zWMMfqQkELfEnlLC8e6yXyY34kTCrB9cw
         uW2Ol2Ph8x1XzqnbKXfuIhdvpBQm9yy7cgddMPSz6Cl48KnYbnSKt9MbCAmBWGw4enQC
         m5lKsOLDctFYJWDWVylYuqBTdQ+W2V628P6Ssgm/obW1Jp5S50cNwAZIsBT3jXpXAypa
         +Zpn+xej+fVe0gCw3e/CGyLGKeeJa8S663VY3CVAfwLxfzetb0kJcL0xlpDWAHghUylD
         +rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TG27+xIK25GzwB3sLm2rIdsHlo9uLNjnjrSgSL3ZnIA=;
        b=FP019INhDKYxDdAoLk4mmJpUPyeCcquWv3eCG07Gfj7BT34p+VM3D0MLq/Y0pOkr46
         vYgXbbA1C1H1umd4W9YJJ2JRpmBN78VYxUXayDqUICvJHb4HVrqK8cP9Y3bCiKT1gbSA
         jDb0N3sszE9NFTGGBFESnZi4MTpvU399il4iyRGSFkni7xwVb1HmICOteDBvE4t63TUj
         mjtucF5fk0IY/SaIocP2+BD7bMzY/ybxHjl2qpdSMMJQF/ghLDM6olGNjZrdtisL82Hg
         cKIre1p8bqU60nM+M7K3CVg2ZtZRpHZnQaJ299PXFEe+OQZx6ivo2hROdkQ3itHoeo80
         teIg==
X-Gm-Message-State: ABuFfogKCQCMdZBRI25SwLwJt0+p6DlzRxFMVahg8WAooGbQQ7Wl+ffb
        QKp0Z1rStd1MrkRuwEgORYo=
X-Google-Smtp-Source: ACcGV600/DfgP3odqNjuoljwtfkJMsad/+0s5NUbtEdoHcQeyydpu8eODNn904bIOnkQFF3K3l/mmA==
X-Received: by 2002:a5d:4c4d:: with SMTP id n13-v6mr4475150wrt.120.1539341054544;
        Fri, 12 Oct 2018 03:44:14 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id j46-v6sm1139280wre.91.2018.10.12.03.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 03:44:14 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:44:13 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 14/24] pwm: jz4740: Drop dependency on MACH_INGENIC,
 use COMPILE_TEST
Message-ID: <20181012104413.GL9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-15-paul@crapouillou.net>
 <20181012104150.GH9162@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KIbT1ud6duwZIwNL"
Content-Disposition: inline
In-Reply-To: <20181012104150.GH9162@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KIbT1ud6duwZIwNL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 12:41:50PM +0200, Thierry Reding wrote:
> On Tue, Aug 21, 2018 at 07:16:25PM +0200, Paul Cercueil wrote:
> > Depending on MACH_INGENIC prevent us from creating a generic kernel that
> > works on more than one MIPS board. Instead, we just depend on MIPS being
> > set.
> >=20
> > On other architectures, this driver can still be built, thanks to
> > COMPILE_TEST. This is used by automated tools to find bugs, for
> > instance.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> >=20
> > Notes:
> >      v5: New patch
> >    =20
> >      v6: No change
> >    =20
> >      v7: No change
> >=20
> >  drivers/pwm/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>

Again, technically:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--KIbT1ud6duwZIwNL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAevwACgkQ3SOs138+
s6GelQ/+IO3/3WkTMSnpQ2QJHnzotuHHGdyWg9WiVsJXTCWZBd3gXvHrg8HwLrDH
DrxXd4eh/0ZJLoY5/HO0UdtsWcSkCm5DyL3UrZ8WeIYjxZAQGTnxsHGip1yMnOtN
grZXhj171MGsvyJlnjULrWYRjOKQaHlMNusp1J54zLH9gsfKAiv3kjhunxPTCfWT
5yxsy7dAlKp2mlwKg5nT3PFEJvRIk803EvKcivowpSIzhiK5uijW0vWYM/KpyGUJ
1zHK1HJsm097AJrb1d7MXbVx72uMjclZTmVk8RXgqESYGOSHqt5LdenA2xlqUwZ5
Myp5bbr2I0F45H8A8NCw7BYQwXUkSLoCLw+Up9U142QAEjG02rV09vgBzC2gAbxB
piSs6XMY5IHmf6oR7ujMLM/14epj1BdrGPwG/VH7dSKt+VERC6QZ4eNYdyOUzkHr
RtdrCk2Vol8cedHbk70hdWQMMSY8sB3QurTCYaTg/ZIIyViUxR/lu2Zf3xwFqbt7
w/+ICttqjsY750sU/aFUv7lIS40skAgYEIPXxu3Nj95nkaWmrEtfvFQ7YJ+GkPgT
5j4g6cStKFoJ498CDkZGThTGD8Eyb5vJZGFMS768xKdlRkXajXOwoP9cSuqBJGaS
/IbRlVmrzOy7/VYQzJNWzwfEUz+6a5CUi51+6na99M/eT0xsBDE=
=yYfr
-----END PGP SIGNATURE-----

--KIbT1ud6duwZIwNL--
