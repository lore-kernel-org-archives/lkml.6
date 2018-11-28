Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE924C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BBC2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKSgs+bX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BBC2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeK1URm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:17:42 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41638 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeK1URm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:17:42 -0500
Received: by mail-ed1-f65.google.com with SMTP id z28so21439728edi.8;
        Wed, 28 Nov 2018 01:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sTZWo8vDJpS8bhCf3AaS91rmTJ+wCscCrVtNvIoVmYA=;
        b=qKSgs+bXFQMp+lDonwb6C+IlnN5LTnFZrk1peXkjP3boJ72+8fu72IZqGsQeMEaMo1
         EXIcueanalZYEYhdm90pfqgyudLnXOgdMvmon+uz6yDmXen8McYrkheKOlcVnyIDYG38
         gu4ZIed/SCyU8OQ3unISMyNufVOAUvcOLv2LHekp+cyq96vm7NSnzPmT9cDs7LtpcK0J
         stN5KuU3WXNgt5HS/rKes09Fhq5vAUe9CbI2GJppAAWu2/QlB8sGYpzo/AA7elDs7E38
         wL3tCthPy5R2myWuDym2D9dRrCFayeCZ/zzyWu/SUumAZY2f8Lh3o4emgan5PotzpunD
         mUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sTZWo8vDJpS8bhCf3AaS91rmTJ+wCscCrVtNvIoVmYA=;
        b=uYkywrDlBU24OWo52QP1rh5FcS3UXR87Lkm8MOTPD7BcdfBs66WhyboyFyG/56So1M
         QsBDKDQ0H86TvPURfGJg+fe+75Ocyy2aeCSc783Koi18AkFEfAwMvCA8q1FRlMh9Xw47
         nWwfEZiV0e1AtknCLkaCq3D5ZsAlt/S3lFnkZNizqmXZoQSfLcq9gnTojX2tgo73SdaW
         +22J9ykkxksRbi21uAFTibQTOdz2v1+/pah2Fddf4G7yP1nD3/EZDPX3LHUTBI/LgOp+
         K7egUC1PY39lmgyon5QWfCejo+mHuNaJyLk1/woW/AkYAipB+qYjOK4hJ/4EEr6RZTNX
         Jl6Q==
X-Gm-Message-State: AGRZ1gJPqjWuJq078ChAZDdvsW8SWY5SBMmCfrTUyYzKd2mI3Uhd/7ZO
        htdurERWduuw/rGl/ls409+o3DRZ
X-Google-Smtp-Source: AJdET5czKFK5SluuV4AvHS748leQkeHTjt6q9BjX1K/8gs35j7N2dmcATYOM9e4RSbzLPtLtExprXA==
X-Received: by 2002:a17:906:d507:: with SMTP id ge7-v6mr25825718ejb.78.1543396604046;
        Wed, 28 Nov 2018 01:16:44 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id p22-v6sm978646ejf.48.2018.11.28.01.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:16:43 -0800 (PST)
Date:   Wed, 28 Nov 2018 10:16:42 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Robert Yang <decatf@gmail.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] clk: tegra: Return the exact clock rate from
 clk_round_rate
Message-ID: <20181128091642.GC17419@ulmo>
References: <20180925214940.15188-1-decatf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
In-Reply-To: <20180925214940.15188-1-decatf@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 25, 2018 at 05:49:40PM -0400, Robert Yang wrote:
> The current behavior is that clk_round_rate would return the same clock
> rate passed to it for valid PLL configurations. This change will return
> the exact rate the PLL will provide in accordance with clk API.
>=20
> Signed-off-by: Robert Yang <decatf@gmail.com>
> ---
> Changes in V2:
>  - Move input divider (m =3D=3D 0) check into the cfg constraints check
>    condition. Forgo adding WARN_ON and avoid using 0 input divider
>    all together.
>=20
>  drivers/clk/tegra/clk-pll.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv+XPoACgkQ3SOs138+
s6HcChAAsJUmStXiyFMnv33/TdFkGug/68b2CmxssoFUhVF9wVVzofb9WwJJJ+Gk
J34qPXy+v+GgCofh0KYrKkb0Jpz6c8fog+sjmvwyCpplml7rAqw2wM4EAfMACAyT
Hnb3bxRKgmK62ccu9IpMNl/bvHhEyYuh0zsm41PPx9Tbp+VOK4FVBPt2BFnPFpDY
rTf5riPCOzW7dhb63zSiNkx4SzRygBKDOiQOPQc28DJyKj4JLNVEoCB86mr7gqMU
BOt/1N8+aGUoO5uhs9BaijEZqexnvIn2H80lVjNRbdfz6PnXK7LWQbFgErvYApHn
2GLWiXPGK/HVC8YelBWvh+qL/CB/N0b6TCEq0WSd24zFJeY3EOXuGiqne0nNs/w3
rBLg9XjNIe3xs/sJ2h1Hj+LpIlnS7og0J60mE6psQRuYYr5JX86QhMcUnNx+N8DD
JywJpvLOaFLJONPwblmKwBqFRMc/EgBrOvQSjLqimyuH85JdgGNtgbYvLzq+pXMC
QWHhk7iizPslaS8ElgUsgB2jok5OlSGY5CAmieuOK7/AJQjGB0EDYFTPQi0wqrBu
qhdDUHwWPlVMbOx/0GreRS1RzNwp4mkfc6ZgZ5a2yEkFEtOI7vbOKLh1DIfq9LV9
RGiuLRnS0ChtoWI+6OugOTBH1h2wzBBvfkljGsyN07JqkZ9fbI4=
=vg/F
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
