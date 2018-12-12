Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97820C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDF42084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt2SxF7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDF42084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeLLNbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:31:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35163 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeLLNbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:31:31 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so15571138edx.2;
        Wed, 12 Dec 2018 05:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qXfBTq74QS1QlVqVk9ETatW8BNhm8ACEsO5w/xQW2bM=;
        b=dt2SxF7kr6mHPR5jml4+CONXYcNCFqdgnYOWchKwCqqiCLISZLMwL3tPwGaDRrQBF5
         V6Ff1Q8VQQKtCkR8vvY8ayurmi2J90qgLNnlLJOxYJcXx6M+Aw/qZuuQnSBT0K6TQ7i6
         R7rLgtDob1yHrIK58LRgk9KalqtzA/5PAepS8o2YWW7uZUhvEvDZ8zz7LJ4Gv81mvPls
         Mh4K7tWafMicUs3XCuU/K/v4t420NPo6BTj2f+z9ZkZGS4O6TFKz2k0ahKKL5Qtb9aRO
         +feL5N6IL1pbjZQhRaWt3Nf3x5yx4WqtVV98URFCXMrotbtyJH9LnIg3IE+kgQyUf+E3
         O7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qXfBTq74QS1QlVqVk9ETatW8BNhm8ACEsO5w/xQW2bM=;
        b=hcL8MWypuGbIEyBWChizC+/Z7JqzLLIaiLGwbLlel4MPdrfmkXRQGAITSnYEaeTTqY
         jehZ5hiQmxow4l3VAVSP/GiN0HfARMPXLgQ4ESJUHNaZ1qhx4mJ4Kskh4/eLRVWlApqe
         BhNhGYdtLdgEfMylOw0AFjb7UjvZ/fEFMMRpXrMpGFwbqeTBZpYSiwogryZlIknZ78kV
         +cH+LAuGJXe1ftPE2J4wngM//+jn3prUPjIGhOj3TdWXKtLrYU2XM+6JRFY+gNC2q3sF
         XN0r8xE/otq7c+yacy152e46zEqxWZCbMuROeg4kZopSTBz+aACFk+y6/ycnQMS2jhVJ
         dKFA==
X-Gm-Message-State: AA+aEWagO/f8GVEFILNz9oNQZ/ceU6cM0m1+k1A7vHp6SQDVy6syAGC9
        TMZnX6wCkjmfITG2zxC5yLE=
X-Google-Smtp-Source: AFSGD/XSEW/6BgmUWlEZT33bmGjEH4r8K6U80CRD/zy07QIDJrYkVuOUSzbYiBhcfrRL2NlXmCFlnA==
X-Received: by 2002:a50:9b1d:: with SMTP id o29mr17824671edi.246.1544621489449;
        Wed, 12 Dec 2018 05:31:29 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id h8sm4845267edb.95.2018.12.12.05.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 05:31:28 -0800 (PST)
Date:   Wed, 12 Dec 2018 14:31:27 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Aapo Vienamo <avienamo@nvidia.com>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: tegra: fix SMP build
Message-ID: <20181212133127.GB28521@ulmo>
References: <20181211143528.2024488-1-arnd@arndb.de>
 <154454887151.17204.5632248748272979028@swboyd.mtv.corp.google.com>
 <20c5f3a9-fd82-5634-6a1e-6384c0facece@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <20c5f3a9-fd82-5634-6a1e-6384c0facece@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 11:47:32AM +0000, Jon Hunter wrote:
>=20
> On 11/12/2018 17:21, Stephen Boyd wrote:
> > Quoting Arnd Bergmann (2018-12-11 06:35:07)
> >> When CONFIG_SMP is disabled, the tegra clk driver now fails to build:
> >>
> >> drivers/clk/tegra/clk-tegra30.c: In function 'tegra30_cpu_rail_off_rea=
dy':
> >> drivers/clk/tegra/clk-tegra30.c:1151:19: error: implicit declaration o=
f function 'tegra_pmc_cpu_is_powered'; did you mean 'tegra_powergate_is_pow=
ered'? [-Werror=3Dimplicit-function-declaration]
> >>   cpu_pwr_status =3D tegra_pmc_cpu_is_powered(1) ||
> >>
> >> I don't know if tegra works without CONFIG_SMP, but we can get it to
> >> build by making the calls conditional, and removing the pointless
> >> ifdef around the declaration. The assumption now is that in a
> >> non-SMP system, the secondary CPUs are always disabled.
> >>
> >> Fixes: 61866523ed6e ("clk: tegra30: Use Tegra CPU powergate helper fun=
ction")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >> Not sure if this is the best solution. If you think it's not, please
> >> submit a different fix.
> >=20
> > Hmm.. Is there any reason why the implementation of
> > tegra_pmc_cpu_is_powered() is under an ifdef CONFIG_SMP? I'd rather not
> > have to think about SMP or not in this clk code and have the
> > tegra_pmc_cpu_is_powered() function do the UP vs SMP code optimization.
>=20
> Not that I know of. I just think that the function should/would not be
> used for non-SMP.
>=20
> I was actually thinking that we could just leave the clk code as it is
> and simply drop the CONFIG_SMP from pmc.h. That would be fine with me.

Yeah, I'd be fine keeping that code around whether or not we enable SMP.
Chances are people won't disable it anyway. If they do, then most likely
only for testing purposes, in which case I'm sure they won't mind the
extra couple of bytes.

I think if we remove CONFIG_SMP from pmc.h we also need to remove it
=66rom drivers/soc/tegra/pmc.c to make sure these functions are available,
otherwise we'll likely run into linker errors.

Jon, is that something I can interest you in? If not, I can easily do
that myself.

Thierry

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwRDa8ACgkQ3SOs138+
s6ErqQ//QQ8TEeMrDY6UGU+RVWmBAT861+B/UFDH2amF7nWsdc2tNy6KRyt6E69I
tgyq0i3u9evpjM9AxIQPsFMONTaaGzoe3wPsr4AVI+em7q3Ibf6EjJoaJz2JoKbq
nY8cjagondItryNeUpPEZ+HHKa2dDvjoe1WQHf8CQwoC+rQ1Zj2VVezSSWm8006o
aYLTuRwGpJJBaEB5/zioDtRJ5dDDVmC8Sl3nPbMfwmaK8baXuPfbPQY07rLBGrgq
eoa98WEY1SeitDYkFG+RY3u411A3h71WwoFGrcLhoP7U+lJjd2PDqjYHgTU7fmgY
tHLjEJ6PdiVSjURbbqj5lfiOL20c6jtkwMWf3XNlFI2+xgC980hjcLomIeYqvCdq
7Kj/ZGQ5EfzM9saSaTBEnynRJexSXhfz2bOZHREyW83aQnh8X+70hzdOQl/XWc/6
qdNN5YUHvJO5vfJ7qMOwkx0uRYe3sSgtN8sU76nfs79rI1QhoytDjXfICNuxFQKH
y5tbuHYBB19ijFG3Rm8JtKt1yFkKE3vuakFaLNGvcf+Xv39Rehd1fQ+kEifldEYd
y/uolwemubklv4UVgeWq2VgDQdEavu2IA2yjVxGcGLkHA40R8WEmIfBBavFjWVNi
zxEEql43bUaH7CkGWHDnjkKIbr9lMku2+ExoaNinGeoWhZOomdM=
=3mGj
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
