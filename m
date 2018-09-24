Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE88EECE567
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B192148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUq1kYdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B192148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbeIXRlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:41:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52840 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbeIXRlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:41:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id l7-v6so4525989wme.2;
        Mon, 24 Sep 2018 04:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dXPoNWE41vbbecThWtq7t0Lqw/jBW9psmqd/6w8F288=;
        b=QUq1kYdIRXZ3nFdsBDx6rGlgt6k8tB/z3Hnr3kuTyDx0FYM4Uhod/QDoOXgvhzkNQE
         bCCMK1SRZKR4Hohm0wmGDuP28kQU/McYRZ52plrK8q1Npy2kb6CXnL5zE8NHH3FXtGUB
         j+MmISvdyue3XTWOMxkxbutYdb6T7AY5JJwzm4I0zkMeC/7JWHei0rT5ilBQq5mWi8Kc
         Ydf9RIw7IILvIHptlE5jJuOD5e9QSLkLRyYENzKufcHkxXpZ6hFVUdgRI0OGRcNnuWhw
         8jIkItEq/5YUqbqN113U0MitD3pjG0AP0T3dh+itjDwb4DTTAwYRq/fXYZrwPLCoSNI1
         nfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dXPoNWE41vbbecThWtq7t0Lqw/jBW9psmqd/6w8F288=;
        b=EkNIbfUKU2brpQJncMVFVIdvYfS3RSdVDrY5GNLuBNbK5s81Od8e/aJFqNcvkkRrng
         l/kYiD4Pnpj4EMDrHsLTCC7RjaDrbTwCIgt3Nykg/4kYRb4opbANPyvMou6XN7NsfRaG
         6FHmBJo4yiD8+4+Bim+fXH4kZeC8Ud2gaYHRc2Ts7/t2pUgVMn2pdFolSSSMvXpr1a6B
         xHd3eI/pBMw08LrLRpvZS+pMWK0QZyamLQgGWfroocKrnYqwZyhac7SE5H97czrdpQ1O
         bJquSTCRKGQBrnLs7BsSEHfs0KwjBbK8jBMf8uUuNn7ewCcWe2c3gJK8TU67xepS/aPz
         tnTw==
X-Gm-Message-State: APzg51AtHLifCtBF7EIDaVMFVTK8f9S9cHhC6b08sRayiDde53oKvTym
        27cj2Hb//FVtVxfTxqbxYU8=
X-Google-Smtp-Source: ACcGV62/vft9iU3c2FLyo8cTwXtFYK5yByTWeJapQciiIuHVjT5Fv+AQhK2xiLF0i2YNFX1wDevdTA==
X-Received: by 2002:a1c:1188:: with SMTP id 130-v6mr6693532wmr.138.1537789205360;
        Mon, 24 Sep 2018 04:40:05 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id x14-v6sm1333815wmc.36.2018.09.24.04.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 04:40:04 -0700 (PDT)
Date:   Mon, 24 Sep 2018 13:40:03 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     ryang <decatf@gmail.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: tegra: Fix an infinite loop when clock rate is zero
Message-ID: <20180924114003.GS21032@ulmo>
References: <20180921220037.16862-1-decatf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jo46wx5DSA4a/gWG"
Content-Disposition: inline
In-Reply-To: <20180921220037.16862-1-decatf@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jo46wx5DSA4a/gWG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2018 at 06:00:37PM -0400, ryang wrote:
> Calling clk_set_rate or clk_round_rate will lock up the kernel when the
> rate is zero. This avoids the infinite loop and uses a slightly more
> optimized p divider calculation.
>=20
> Signed-off-by: ryang <decatf@gmail.com>
> ---
>  drivers/clk/tegra/clk-pll.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--jo46wx5DSA4a/gWG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluozRMACgkQ3SOs138+
s6FyUQ/+OUhFV4i9eXn8U9G/iqxDUf2Ipyhw3J5GM2xJ/e0BiinsHS5swaf5CBPI
s9k9ytlegplNxKOd0ZaARdw88f1k/d2nMYYDtSstaZWU6H0GFFCpJL8tnX49Og9w
mJYjw21oHmikNGjTwqbvmwv2DFcSPL+w4dx+t4ataXrZCsDElA2YT4N6RqSeMJ4f
uHPQHrCnC622rKRCWsS2iZbgHLIiWygrdn3kh97GtNmhQyYWfuUV7YToCPt4aQmx
yg9r7XS9FqrtVCp9LmuPgfIzQ+gBNB8gRrcmmnhn+L36GRSjbPtD2qfkcjTavM/g
LKNl0UB4gcO6AOe5RtVpFoix8wa4/KvM/lt5LyeDsQFizV3z8P0Cv6zEsGwITPJI
lRUoHZlHAz8h30OnR+cGnNKuFe+zoPYxAOHyB+nT0o7VcYSeXTLC4yhP/COZmkUc
SxBpxp5P0AfkUxT6RBFxeedAPft9BsnCrgJD4zMHaDYnVPxoBZlrTW7dxhoEoyQ5
8R/186CDt6vnUlHcrhjSl6ZElmbvYPF4YsZzzm6y1ePowwU1TpfUxC0iUTPNECtF
/GzHykooirqJ7Szlb2XrGU9yz6Plep5utMaLRneMsaJ79AfsO/kV8Yhxi8+/uHkY
+stR+cJjSuW5wIP2Yco9eAaAcuoyFUr7Ccijih5iiAPzZdIM/uk=
=k52X
-----END PGP SIGNATURE-----

--jo46wx5DSA4a/gWG--
