Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CE9C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F7021DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGHGZAQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F7021DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbeHIOvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:51:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43000 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHIOvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:51:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so4967088wrs.9;
        Thu, 09 Aug 2018 05:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n+Ouop13FtcziFnx4o3aR/TqWyB507vCjz+CJAGGfsU=;
        b=nGHGZAQmtaRKarpErIcFLDu0xdBvGsyWGgNzJHm3UOSpMgKI6HMEbGycNZlyU91UMm
         PvBNj2kkCCOG1lvbPkxYrR21dmRaWXYYj1FaTTImAdaUf33oiQN58SiJNI7IFiwTZ5MM
         sE4OJ6G/muMu2hfyZpUKZGVzBmqYZbrNItmq6UJUxPE2DKUAYhe01AlKGK3Hk2zrpbYc
         4f9XCQChgsIRVmTH8LIg10FzeqgIA6SOhQB/UCSmkrtdZhPMYIlhm0U5r3QUaTLVMeSS
         mk+HazAWIsIfwCyTrMJ9htPH7PujOucek87g+JWeoTBFKZnIEKBNvJ5h99c+0YZ8fmAe
         s0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n+Ouop13FtcziFnx4o3aR/TqWyB507vCjz+CJAGGfsU=;
        b=KG2miYHq/U1qyaGuvqWfx+5VnhYjdgoRTAfdsEtsmfo4LuGl8nPMOTQWh8fu+1C7OG
         WQC5bMMtDQeTMSd1X6b5XYgFChKjPSkQzou60PVAdZq62RDImQyLjJYarc5lTapXvZ/j
         +WBwUrvy9Toj/cdv08xGHKWy3OpHA2dEuR0umIMLaMlEqLtMn6cgCFp/lhtJyjr+Nwxc
         ryYNbmt+n2QDeHLziybpkdGKuWOLpsaKBUelsLftaL4/Uatvj5Xr4mbjBSuCoiPw4bHE
         8mN0ItMfp4VggWzY+bysr7Ae/pIwRSNXW+qZ4FiX0TLDeJsNguL7DQmPaZkhKsYJ+mAm
         IFfA==
X-Gm-Message-State: AOUpUlH39yI5mWiIQqv4Z8D9eV+o0AUnEppRUccj3yAvbzSeloeCKL02
        96Hl6LWM03oW1cDlu1/ostobiZXI
X-Google-Smtp-Source: AA+uWPzPOw3gv8Cf9tE/pQ6dlNeuf5Qa9rE90OJXqGSVz7iY3n/LVLakjuReNZ2SmB0v8r6rG21idg==
X-Received: by 2002:adf:cd82:: with SMTP id q2-v6mr1387638wrj.118.1533817628224;
        Thu, 09 Aug 2018 05:27:08 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id 9-v6sm12852207wrb.48.2018.08.09.05.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:27:07 -0700 (PDT)
Date:   Thu, 9 Aug 2018 14:27:06 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 10/40] soc/tegra: pmc: Implement pad configuration via
 pinctrl
Message-ID: <20180809122706.GT21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-11-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v15hXiddb3kq3Bam"
Content-Disposition: inline
In-Reply-To: <1533141150-10511-11-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v15hXiddb3kq3Bam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:32:00PM +0300, Aapo Vienamo wrote:
> Register a pinctrl device and implement get and set functions for
> PIN_CONFIG_LOW_POWER_MODE and PIN_CONFIG_POWER_SOURCE parameters.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 187 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 185 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
[...]
> @@ -1704,6 +1863,12 @@ static const u8 tegra124_cpu_powergates[] =3D {
>  		.name	=3D (_name),			\
>  	})
> =20
> +#define TEGRA_IO_PIN_DESC(_id, _dpd, _voltage, _name)	\
> +	((struct pinctrl_pin_desc) {			\
> +		.number =3D (_id),			\
> +		.name	=3D (_name)			\
> +	})
> +

Do we really need the explicit cast to struct pinctrl_pin_desc here?

Thierry

--v15hXiddb3kq3Bam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsMxoACgkQ3SOs138+
s6G7Rg/7B8Fm6KFvtD0N3miwZP45DmwbCTXTCEWTPZTYnII1X5RaNv1dM7ayNm7P
qZRHNilYwChe/O+5h9CsWLbR4TaTqQSVwd+hMJ8GAmgerwrChVuSsN/q77Z1DHG7
7Vy+uwQL0Dwqw9C4en61SHAuUhJuuDYtPtY3UikfZ2M/TDd8zcplGzdL3SonrHGj
t6T0AItW+EXMFEr6oI/4aYdGgPPjrapMeaU3ir4vwO440HXWWIrm9ymAPVMjt2ym
xhUTzJqI7qLrFYj78jdmUQTwQDnfLSqY07jwslGH9firpIAW7goSvy72899lggng
4qVAKqClYSGI1ADlDaX9drkL4WcLwTSymHCj1Rh7MoHgbPFxAC1+VmpvkEqhhvE4
6KHfOW34WzdPkyf/ZX4Kslveg7S8xTuif78Ws3kGOus/wlTdkT1SBBZGJUr9wybM
zKMlP0Nyp0JISmzyprFEd4ZoOmT1oraAG6DudSBYra6xNRByI9W7wAj7obFCAp8B
8t7bO1T3TcL9IAjfUzDsM4IghokQn1BZZh7vkfsyphsVwOeLMLlej05EaQrVduS0
wOgbmECGbBa5468PlIyiurjEJXaKWcKjubs/+rWEoDgKCry68+hzq09OgG2rlvU9
u0MfxFJnD9uenTQY6pJfSNlmtKTeHZwLIHfX5aM3gBW7KkxwBG8=
=teHV
-----END PGP SIGNATURE-----

--v15hXiddb3kq3Bam--
