Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E526C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417AB21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRSw/Fjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417AB21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbeIRU0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:26:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53223 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbeIRU0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:26:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id y139-v6so2835692wmc.2;
        Tue, 18 Sep 2018 07:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y/LImtI77WbvppPpYulQhtnVUfOHOiot/eF64hsrivI=;
        b=fRSw/FjrThaHVHlGjbjdL4NRsEiZGG4vihVK+ww1aynUTZn4RbtJnN/1QalMh6CEAV
         C2RhgjvfydTzOgSp78Pv7esF9ipUUczsi2r9jCydwhID9VVgIGBol648SGlcdC20m9Hr
         pObZMEjEC7hTGt44tFPu4jEsleqWJ2MQmTrGTvNR7zZbkBqtwoJhw8gCGfNrZ88nGD30
         PyzMQQ923djiaBz4RDBYD6lj2FdGuMX/YxasB5HhDF9iPpkarrDsgHRq4yEpPwvS23l1
         Ao2odJz7TRqb0+s38NpayqroXXnTrmIUz06ReoxwZEBw2w3AM1PrTTKccThdwZTORVU3
         XqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y/LImtI77WbvppPpYulQhtnVUfOHOiot/eF64hsrivI=;
        b=f4UIatXw7/a7+dEvIZZA54hujxT72I1c2FqkGVeWjmnsbuT07BL0DaKcCbymL+3IG/
         gCmm4pZMWugEZhK3NqkurkCZN9umSGkEOoQ77kUqbCAIX0kA51VOp8UXCoDbg17BgWqV
         QX3wHELjh98AXrfRPDP7V8IYXnAPdrpdDh7EzD3/jfYOO73ZoJHyjZqNooDoED6QVc2R
         HSlg63VCyvGPDw4VBTsqdTbxqRlCcDWcyF7+V3QKdBiLFLIhXI/ppZpnB+2LC4tjX+YB
         v/rRMEf7Q7lDL5PZNx6Rs48WvQa/ublql0rkgiDg5ldHE2qImR0syILQ9EkAt8CusuDE
         OCsQ==
X-Gm-Message-State: APzg51BzK0ZPHJt4A9PZzspxMKkogzQ8La+jTb6r9Xswv7yW2N3ydMKa
        qk9IEmUelqMUA6pDgXF1JI0=
X-Google-Smtp-Source: ANB0VdaY+ce95/Cj6Lqv+WUnvIeFy02scNDHJstZtYvKG7RVkkx7a0pav2Hdcg3xeithcVobr2IQXA==
X-Received: by 2002:a1c:68f:: with SMTP id 137-v6mr16722279wmg.82.1537282413746;
        Tue, 18 Sep 2018 07:53:33 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id x204-v6sm2598546wmg.27.2018.09.18.07.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 07:53:32 -0700 (PDT)
Date:   Tue, 18 Sep 2018 16:53:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     airlied@linux.ie, jonathanh@nvidia.com, ajitn.linux@gmail.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180918145331.GB30386@ulmo>
References: <20180731200705.GA21510@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <20180731200705.GA21510@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 01:37:05AM +0530, Souptick Joarder wrote:
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().
>=20
> With this conversion, tegra_drm_fb_suspend() and
> tegra_drm_fb_resume() wil not be used anymore.
> Both of these functions can be removed.
>=20
> Also, in tegra_drm struct's member state will not be
> used anymore. So this can be removed forever.
>=20
> Fixed one sparse warning.
>=20
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> ---
>  drivers/gpu/drm/tegra/drm.c | 20 ++------------------
>  drivers/gpu/drm/tegra/drm.h |  4 ----
>  drivers/gpu/drm/tegra/fb.c  | 24 +-----------------------
>  3 files changed, 3 insertions(+), 45 deletions(-)

Applied, thanks.

Thierry

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluhEWsACgkQ3SOs138+
s6EA8A/6AmB4OarNe5zAtfb8ic1nBpHWwywo/0/2jJ2LQQAI5OZNJCbna/9ib8CQ
1CC7uKaInsLTF9Kqn+dsK/8Nn76lWPUfo9G7vKg8Y1+H+2uneWIEcQd33btG7CG3
SEQ1VWekdXlwPJLGsih1zoshZxlWoRIb+3bvgiHjMcq/D1wktMSMxEkb0LA/ej+3
4zfHEToH8LfQojEemsL/2lbnJVMNSeeedvS71rE42/kZchbPHi8upSQ32UbIOQel
uVKjGJmndm/5/hIlHZB6eyDKTlimTgwLBoQdvqveXlG/vSrXb2Pc3qPmcqX6CSPe
FcAOedcaU+f7FPH32j2RsKUxhkKaD92CPigknMeDRG3fcbFKoI6oIlDALzCLKplB
raGxVvXm4U/0/RMl1sRYvwuNYPW9TDaZblVarlDubW4uw1ctys850nukqKn0H+QU
ALaiBP7M3sCvyRY9vEtataNWmL2bCN3gY22GhGKv55yPYsn3mPBWE7Mbj0mg9+JO
IWfdA71R299TO2ZkQzTivDBYhKlS6Or35IHVWJS1XmqSDJhrRoT4o0lGnAxxCpTV
Zqpc4mPe6AgyddipdhBaHknBamPjwQjR3/eyF0MD4Wf8pC6qpQ6QN3+vwt12rMUg
yvgpJQJzOTsxIYQOW83jUxracihfkryAa8YETCgUUskM7Oi5nrY=
=P7mw
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
