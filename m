Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52827C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EB921D6A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPCxbtod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EB921D6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbeHIOrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:47:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45691 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbeHIOrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:47:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id s16-v6so2756352edq.12;
        Thu, 09 Aug 2018 05:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xjZBlwGwTHjpCCQGKVbtdGA4UAlyUj0sd83TZhldMaQ=;
        b=NPCxbtodpKeuft6hJThN8fu4/9jONzC4Ft6XnvYJ8WI/2KIchRwt34q8JBR5Opi7PK
         +jo8WbjVKLNrzaUww8veBHBH46lvsIwaH0FS2JoDtzbe/vZblxCwRM8p70oVUyuvJpZq
         kaBqOfiCapfEl1zfHuxyBPVDhJfyLdbxRiv+kdl+lHyeqC+WsPoLcg1e/5esFP1p7B1a
         jJktGrGl2R8N41pTpiXpgKko3BrZpiCSNf8ilgJlDYgIagaPIuwxqm2QVsKBgGrgGka6
         ILmBRq3FjX5LnfHEBKSjEFCvxRriIMbRavTrBVYpYDTFmDbds5sx59lrhkL89xtFAtLp
         gbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xjZBlwGwTHjpCCQGKVbtdGA4UAlyUj0sd83TZhldMaQ=;
        b=C8DfqRtWuRzyn5fwlhNdeU9HsaGK3CeqDo3fj6Z15K2ffeEJCcieWAFbNtYcG3SwXj
         oUsDG23GExxEWOqERJPf5wpxQPJ8IKaizLhAjaY+j0KftazulPYrpKbi3DkHczeDKGe5
         kz4VVceruh/KsqzerSrAp1kQuBDH0XZvk9WnvHwPAbVNuGDKVQv9PrFqjksA3SLWsLi8
         ZQCtD2UKzjLSCYjcJnusTw7N2ZBlBYKHZf6kuhZ+IHswLrzAu7HHfgG1p+6PzixM1v2c
         Im9u3r0GHwev1rY0AS7cxcVmJlkY41v8aoIBXBsm3Z/T0qZTWQ85jZcjn9A0M2F89WOO
         2wGQ==
X-Gm-Message-State: AOUpUlGgwL2viZtK8bmUfA/UZaOkg33kJaovzMP1inrP04WG/Hw25oMT
        rnl27I004ABOo2VX03e9YJA=
X-Google-Smtp-Source: AA+uWPx2/mfJZxh6RXl2C5hki4S7mOHepTK1ZufGSgyVDKxZY7pANtGmu/GEtww4JJEwXw8o3Rkpww==
X-Received: by 2002:a50:bec2:: with SMTP id e2-v6mr2938170edk.283.1533817348095;
        Thu, 09 Aug 2018 05:22:28 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id w1-v6sm10613296eda.63.2018.08.09.05.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:22:27 -0700 (PDT)
Date:   Thu, 9 Aug 2018 14:22:26 +0200
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
Subject: Re: [PATCH 07/40] soc/tegra: pmc: Implement tegra_io_pad_is_powered()
Message-ID: <20180809122226.GS21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-8-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WVXkb2QE2eH0aWe4"
Content-Disposition: inline
In-Reply-To: <1533141150-10511-8-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WVXkb2QE2eH0aWe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:31:57PM +0300, Aapo Vienamo wrote:
> Implement a function to query whether a pad is in deep power down mode.
> This will is needed by the pinctrl callbacks.

"This is needed..."

>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 393ca72..784c182 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -1075,6 +1075,22 @@ int tegra_io_pad_power_disable(enum tegra_io_pad i=
d)
>  }
>  EXPORT_SYMBOL(tegra_io_pad_power_disable);
> =20
> +static int tegra_io_pad_is_powered(enum tegra_io_pad id)
> +{
> +	unsigned long request, status;
> +	u32 mask;
> +	u32 value;

These can go on a single line.

Thierry

--WVXkb2QE2eH0aWe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsMgIACgkQ3SOs138+
s6HcZxAAqCg/j/84XaWdFZuexhsITHhgWr2RXdBAqYHGBTA8sLTPH8pyJW/S3mD6
ke/0fdpETpE8jtqJdWaWytiaycw4aLmwcWz/QMozEJ6SY4IBUKBBiPYKrNzhWTHO
Av/l1sBGyQ0zN2SeoJjHttsykzRis1k/9ATv0whkJdUytTuPkpf4X2o142rGYsuV
NpUkVoDYIHzI7YrHTfppWCpqiEFv4zEm/qCGJxkCNAlDU7xI48+WbGQjIaTmyoxD
XVEVpaEi8GEU1vkgyQtY8l3PS2ywJ7OaH1naRTUs8BtkobxnYqpjRpJFNs8TQp+A
ZHf/xKZXPAu0j/RkbFnu576Mujde0r+W0zVWRHXRA4dEmQnZJeGxon97S1qNo5LG
N7ibgxCoPhumQvCkqyhEPW82CpfUpTI/yDbLd0aXXr1AQV/AvMH/KkxIST44JnyH
DtQBt2OVeG8cYzonDXdXV5ZUGQyNPhPLwoxAgrQSSF45GUC/caxN1sy0ZchgZ+J2
gO2S5qQCBCNTojn7lK9oY7geKG3/ZX4Ci1HY50qi03pxO8xRDBfTN+B4x4Snw+zR
excumyHUyrvVKR/CsUDMmG7wVCfGS9ruh5+g8lXLxH4iwEwZ1nE0bXttm6+8Yeoa
1sB+B/adpqEUdp/YeR/Qns3DJGXMw1jnychvgfu2Y8GlFW2Wu7s=
=WfhN
-----END PGP SIGNATURE-----

--WVXkb2QE2eH0aWe4--
