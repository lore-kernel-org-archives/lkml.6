Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2612C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631362177D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqo3RMP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631362177D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbeHINee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:34:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37579 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbeHINed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:34:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so4793010wrr.4;
        Thu, 09 Aug 2018 04:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MjxQPl9DV4LcyoYmHzSI/cWF+OZRoEDrNBOTEDbXW9k=;
        b=tqo3RMP/Y/SUpdpSZZJSZtQiueE61qMNMdeXZ1gPIuZ+J1yTwcs6ZndKu4pnDtDQhF
         GITsXCyigM9s9UhH319VArlTUvACUexDfXCMCjniH+19NWC5GGE9FEueLwfwL1gC30Cm
         7BEOxmZSfqlU7CBo/n/FQn75Qt9LalKwvTxyvs0ZN1gHXX2joLi5ZOaIkrgKP5W6wghr
         /iUpCwrbsf6WB/WxqaM6TOtbccp3ZRi3m5YoRSKND/W2rJV05Y/MAadVLDbiSpoAyAcC
         bPfq/1aG8B5if9AR5vijhDAthe9mxvW6jrH5DGtlLYDGZA771v6KTmcralfC3fPWQuN3
         ClqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MjxQPl9DV4LcyoYmHzSI/cWF+OZRoEDrNBOTEDbXW9k=;
        b=coezu132R43bzUdGtcbsuLsJ/Y1EN/xkNvT5iow7YebvWYNg25K6I4AIfnqsk6wDwn
         w25DYbMt24yG8HS230qk+l2i5JlAIxONlAPYOvbGwZKdW01Zt2O/Dx4xxGHTeiZVOyQD
         VglqL9xzkR8AH28ZEOdaSrr2TZWOG/3tW+9SIICwNh/QOQDRPUH/4DW4mhFwYrOdlQ0w
         jzP0gq38x2C1e5K12usQIpeb0LqVFWUfs/XUWgTt0KZ9PIENfHZaPgyhhf4MvIvyxi04
         4+dVcLdSHphrtUxjd3MY4z1xYjFYWIOLOHYm82bXy8s5cpUy5HqP1Fn6tYkjQoT+q8gj
         Xwbg==
X-Gm-Message-State: AOUpUlHlq+DfP+kTuzrAPcYg2QMAgkgiLLRpkfZOA50u/Los69SpEXiK
        jt7mVrzMNpwkuptR9BlQnpZwLhvX
X-Google-Smtp-Source: AA+uWPxXy9+VaaOg+PrGmkNQjq5mtkGE48gw4/rSJtCqPOZeKFT0Prx9AkQ9ZLzTPs39z7P6+rhPXA==
X-Received: by 2002:a5d:504d:: with SMTP id h13-v6mr1122587wrt.18.1533813010345;
        Thu, 09 Aug 2018 04:10:10 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id 8-v6sm14859386wmw.34.2018.08.09.04.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 04:10:09 -0700 (PDT)
Date:   Thu, 9 Aug 2018 13:10:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] memory: tegra: Provide facility for integration
 with the GART driver
Message-ID: <20180809111008.GF21639@ulmo>
References: <20180804143003.15817-1-digetx@gmail.com>
 <20180804143003.15817-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
Content-Disposition: inline
In-Reply-To: <20180804143003.15817-2-digetx@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 04, 2018 at 05:29:56PM +0300, Dmitry Osipenko wrote:
> In order to report clients name and access direction on GART's page fault,
> MC driver need to access GART registers. Add facility that provides access
> to the GART.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.c | 26 +++++++++++++++++++++++---
>  include/soc/tegra/mc.h    | 13 +++++++++++++
>  2 files changed, 36 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index e56862495f36..4940d72b5263 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -72,6 +72,8 @@ static const struct of_device_id tegra_mc_of_match[] =
=3D {
>  };
>  MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
> =20
> +static struct tegra_mc_gart_handle *gart_handle;
> +

Why the global variable? Can't this be part of struct tegra_mc? We
already do a very similar thing with the Tegra SMMU integration, why
invent something completely different? Can't we stick to a similar
mechanism?

Given that struct tegra_smmu is opaque at the memory controller level,
we could even go and store the GART related data in the same pointer.

How about the registration code goes into a struct tegra_gart_probe()
function that is called from tegra_mc_probe() right after the SMMU
block:

	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_SMMU)) {
		mc->smmu =3D tegra_smmu_probe(...);
		...
	}

	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_GART)) {
		mc->smmu =3D tegra_gart_probe(...);
		...
	}

?

Thierry

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsIRAACgkQ3SOs138+
s6EOag/+KWyfIYwlunu77wU6xbe78ZNj4WUCSKcxoA4GExTvqLDNvtjmcxGHxeuh
1LSf4obEVQZLqCECC0Ie0u24NTosHH+Dm3bjoiXbDPN07JFSBj8PDVdtHoI1+cA/
H7AqwOhOezhKWdisxNf3mP+aRPLrjqAZQ1IDdK/b0xHlSJA6d97L39nA/h8wKhM8
4vqm+HD/kJlLAT7gbMQ4J4NVw0amivAeHqI/xSk+MJoghrliR4t9xnOCkJKGsbjH
BxyaXE1A4HxURPKB1t+LOgOWSgfGY5eeO+CC2Ll2sVG8mfHAKQj3bAr5XXd9Ggl6
vINQ6xeK0JFJfzw1YKP7bC12DzTU0LWE8KUtdmdND3To0vUj53AjSKX5u0og0jui
eZIRPva3Om4tGefl2vqraG7DmkJZB02y2l4CqGfJvjZfs8JCeUyxzXAXN47U+gXv
V8lgCnbUZi/NguOnErGuF3RGjsWbm5t9e2sS2ncSNSpD256iKmHJwdP/myrUX3AL
GmeG8aeDkk8mqE2zXWBr2agNs/0n95WVdZTTAdW+goVJkkQ62vqUzxyor1Tmw6GP
664aTF3YssY6/pvJcQeOcdyyZNuRSUg8R1qy0MPBh0v99iagVVRVqJP4cyzuHjcQ
NCfu9WcqGhTYF84r632VjAr8KVPOY83zQOE5gSiqmD0iRmV3n8A=
=IZWX
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--
