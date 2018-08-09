Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A40C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD09A217D2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzFiUWGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD09A217D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbeHION6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:13:58 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54540 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHION5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:13:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so6061876wmb.4;
        Thu, 09 Aug 2018 04:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nMYBYO5busSRNczUDBxGf4b3cJkQdh89BhFNKmFqXag=;
        b=MzFiUWGDyYAmtXiai5SFo+PeNhau0Fwo6ufvy1zCKYgA+SwwGavke6cmoHi1FOTU8Q
         p31S8t0XHqpo4YG4npZSPIeznqLRvigVhc6KVzOztDSST/knzybRDgS4XC+w3Fa4aL08
         vN89Luq3w6FyOR7F9FtdL+wV7+WBO9lh4payDDjU+wTeZJn6+hr13x5Voru4RR0c7wYK
         7WKqY+9LByrVyri3oVd9A+SQq4V/+XHgOM5oRCBj14M31f2t/yfto/uLWjSWOvLlVnrx
         jAarw+DildH3+0g0l/8wD6w5gf9doj6ib6kgG/O746X62Bb+HbOrgIWEoW63OqpnERca
         y52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nMYBYO5busSRNczUDBxGf4b3cJkQdh89BhFNKmFqXag=;
        b=OVYPEwHH89VO3k6Zz6JJ+3HnGIjp6XH+AmrrprdOhWhGSsTjCLHKchoOnhCZd+l20Z
         K6IijNyQb5Bss7G5pYV25Yrvqi1Z2Wwj08v2DYb6X101zev3h/s4fgdqFmbnDnp0BqE4
         HJvuezvtoQzwveW8wCg3uM8EAYwymNwIFbvnRiMghHrpCfK67SqtrXWcqEWHU9Xw+v+j
         T3NDWTANOFC7gkixvICPSo+s/MAhuFc1XoRuWytfUkS/+o+snXiui9Z+Xyzzsw6TD06j
         p/gdbVc7Y9+cutzWntC4OisS4ahooo2HnCPIW6PlkzHePHadgBpAx/G0q0pto1xofpG8
         Y8LQ==
X-Gm-Message-State: AOUpUlEwswBC66daroFzl4wB4tpwiGsN0syhfLus2/aV/A50AzenFaBB
        Of0RIYxbxlVjjB/+EnEvkz8=
X-Google-Smtp-Source: AA+uWPzto7bpHURI/VfN1sIruJSvy8eTUrw8a4eND85nthbPaaEg45OpYkyH25sBgEhdzva8EIOYRw==
X-Received: by 2002:a1c:8414:: with SMTP id g20-v6mr1540839wmd.90.1533815364502;
        Thu, 09 Aug 2018 04:49:24 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id y33-v6sm14145256wmh.37.2018.08.09.04.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 04:49:23 -0700 (PDT)
Date:   Thu, 9 Aug 2018 13:49:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] arm64: dts: tegra186: Add SDMMC4 DQS trim value
Message-ID: <20180809114922.GN21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-6-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uMPAU7A2Er6+wvsD"
Content-Disposition: inline
In-Reply-To: <1533650404-18125-6-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uMPAU7A2Er6+wvsD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2018 at 05:00:01PM +0300, Aapo Vienamo wrote:
> Add the HS400 DQS trim value for Tegra186 SDMMC4.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra186.dtsi
> index 6e9ef26..9e07bc6 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -313,6 +313,7 @@
>  		nvidia,pad-autocal-pull-down-offset-1v8-timeout =3D <0x0a>;
>  		nvidia,default-tap =3D <0x5>;
>  		nvidia,default-trim =3D <0x9>;
> +		nvidia,dqs-trim =3D <63>;
>  		status =3D "disabled";
>  	};
> =20

Isn't this technically dependent on the board layout and as such would
belong in the board DTS file? Or does this value work on all existing
Tegra186 platforms?

Thierry

--uMPAU7A2Er6+wvsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsKkIACgkQ3SOs138+
s6FaxhAAkSMLQgzbXmF3OtTbNWRdMzt74oz8j77GI5emDQIIoqQ+pCLWVyXEUT1B
WQ4qw+1pjv9A/D0voG7KgAsdGdjAZ8yeSZlWNr/Fbyv7g+s/5PwSGF4kV0Mvr/ts
UaTNHQhp16yvY+RLoTA14PrbevAMrNibF9DAg9k6uOlndyfqmZWk8HI8PJHLPkSR
1F3EXr3+5T7S0IkjxXLIFutKzzWxZYoo9ETBdGuaCnZUGQK93cWldPAl3FywyHai
WQCJh08lTI+Rg2F18Z5/SSLGzBZ17/jNhv8IYm02JQz4WHmIq2u4bY87mGIX4D/K
ZDui4/NFiIduZ4zZk7CXzy1QjKP/sXUTqnaDYI1NWVWgMF9CqZaBOfhzpWlzo89F
UjTWUHy2fwvkkzPis4rQGX/IAyu8B1cya7VjmArhu6XyYjVMiOlUlm6t2X0V2xA1
rho2tpdmkC04i/ZKTEIFIWEwIQ97Keu1iCKdblmHjCEjmoLml1sP0tkVXDF3uup5
dC7ulRKVnU5NJN84lwZOVOIFVAxJqGL/uP+FDSgniRrH8w94uMsceKEsDGnb3aNh
bxAtQorWWqG84Ujsnw3HbXDllRCEPchcEArS2GiCjd7akO/8gosaXXC3o206HNjW
aCMNHzqTwu8iNJxWY7ME/0eDWAZBy5HeUPqePFYRJqajJoUDE9I=
=MO3S
-----END PGP SIGNATURE-----

--uMPAU7A2Er6+wvsD--
