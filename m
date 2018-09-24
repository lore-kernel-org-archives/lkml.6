Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1181BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AC92087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEfocBIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6AC92087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeIXQEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:04:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39587 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeIXQEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:04:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so9373109wmq.4;
        Mon, 24 Sep 2018 03:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bcErAxWh9lP1ki+2174vw2wIRaLHj7qqDWT1MDv3NSo=;
        b=hEfocBIGksL3x9DAyxWFus89GNQcgSOxAIm3SDCeGfop+gjcj3RhUZ0Lv8PXDVCxTF
         muC7mQp56V5pQR9XZ+Vzc8ZLn8SNboq+sy81RLqN2vMjPUTiYg4dDANl//gZIMWmtV1w
         dZyK78/fWfIlg+0rj4P9djkt9oTkPpH5Oi+f85S4D5JKHlxmTXPQ7z0Oa62Ikm/hiPwz
         cmZtnjXJAoi8Qs7GK4cIdsiE8DT72kRFZJRE8+wBNC0iExwRVcfL3fSG/qZzmIkBaaus
         WmFMC5S5ztaFfdct+tL2RfccY88APqD4rcSFnQN5976SSuO2bh2QtNuNyFUBRyrCLnQ1
         wzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bcErAxWh9lP1ki+2174vw2wIRaLHj7qqDWT1MDv3NSo=;
        b=HVvIxtL73IAAdE6+6j5/LLp0bcTS9gj/c5L8vX4OalJ8ujrfjaCR/UkuMakDPMAfvQ
         kShAZOn3q/g35ZJbmsGTuJGAj9KUxb7fIo7ga4rBkxipN/CsiFbo/KauX9/bQokHvOLs
         U3FaeyIIFl+PUiVaVChj0EoCSNGiLg5KzO9HqoeedIImZq+XsEGUYTj162cUGVRf2weI
         MOeWOfNAIjYpXWfjnqZefYmS60gwY/IzU6xzss+6c6Rb7QOe9CRtSgAjKz3zF7r582Ju
         Rz6u4fQMZbqnKnLnW580JOdZOpMIFiZuZxMKxm6FeGYrusKLMiNUuHNWHqdlGEJwoyGp
         Q8PQ==
X-Gm-Message-State: APzg51AIRYj03GoqNM5anUbu5qNXahPU0ZNQ6d4I3sz5126XyqUK0Lvm
        5PanO1bitXotScjn7YYqhVs=
X-Google-Smtp-Source: ACcGV62a+WznLUJVFYJZwxARIB85sL77+J++7gGjREHfypuRUxO/lG9C6OP9WMC/3BusmkewCSnJ9A==
X-Received: by 2002:a1c:1bc9:: with SMTP id b192-v6mr5827480wmb.160.1537783370184;
        Mon, 24 Sep 2018 03:02:50 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id m68-v6sm27253825wmb.10.2018.09.24.03.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 03:02:49 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:02:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/20] iommu/tegra: gart: Clean up driver probe errors
 handling
Message-ID: <20180924100248.GD21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-3-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:35AM +0300, Dmitry Osipenko wrote:
> Properly clean up allocated resources on the drivers probe failure and
> remove unneeded checks.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluotkgACgkQ3SOs138+
s6H+Ig/6AsRUs4KWmrmToJo+c1f02b2It0bq/cQpS4YE4Fb/cuifGolvSB3Afecy
UPZufETrXZWicqUZRaC7CEwqaHq82IRHi3a8KcbTHGz20fg5TTQN+5eD2RDFTUOX
jxbYiwUkAI2gjZM/7FnGBKPxf4FWWNcbLozxedgEU+MzISVmqk6nRxB1oMDI6GEA
vMYnyOTte2LKdZ9AMvzWOSlShZXR1zqtym/F6fs/klhn+bp/E+SQ/09Yq2TDtMNS
jwdU2dKylUyD56+QpJCZkDQCfe3U7FpSIaPWszpKjDy/pVaV9ww+eIzN+02+wgig
GMmBDn8BIiZvDwrDxjuuCx6ZdRTAoz0Umx1elhssVozBVO+EloK5wVfFLpprVmSv
GB/r+pztQzhS2TNnVsFjOKwd0OqTdaHVt5FIFClcZgfKz7m9aeTyaijQeWl9AsRO
bgl5e5/0WFBNIEB01QaZU0ADhB8C9DI5z70Fxo7tPKst1n9UAliomV+nAdIpZOq6
qVJjvBHQivUyDIggDkQ7HbT2SBxViCUDfka3GyRXMb/m8zC+9acz0AUl+tHd68eO
tI+VAI5z0w0O5qYXN2lunhXloiQYGDlLOlTfI1oNXGAi1YRFgImbPMkvy4+mcryx
WUl03xjUHhV2cHMuvT0l8HC7KRxhQCSF8UjFueKo/pe3Dyeb0jI=
=wGqS
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
