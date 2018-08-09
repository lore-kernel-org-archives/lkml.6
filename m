Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911F6C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4045D21D68
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT2/a/TE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4045D21D68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbeHIOGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:06:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50703 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbeHIOGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:06:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so6056140wmc.0;
        Thu, 09 Aug 2018 04:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mUQRdaVRkeUyjH5TNmR3uZ8MsrqB3UjhyA0wY6v2nBI=;
        b=GT2/a/TE4qICo+QiezmJEAyflKlhbL96JeGUbSEO3t1DCkOnqHeZu3yTlz2RLGCT6C
         qRYouYjRunpUlIynIeas4hPl6o/qczGmfNE5yrtN4I16dhbn4UY0Bv1h0SnCWyTWLBO/
         NYGChNbrsiRENd1eV7NcKBxQ5QN2ZFaLR8SuE1h54BWFakB7u6d15I0cC3021iFGYNrJ
         A3/4q726HUkIKYF9DF1gNbU2jo17wKAvFr8OrXlCZSU7yOXyMLeQo4ZcEeySG1BTXqoy
         CnAQ6QwFPQnDSTT8ca42gP0Ou9bWZjNrhapkDU0BQQDY+DDQfcGwmGLdNmHdvQsT+DUR
         EgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mUQRdaVRkeUyjH5TNmR3uZ8MsrqB3UjhyA0wY6v2nBI=;
        b=K4fXK47ZVe1Xb12rSpCnugzF3wJY+IyiMMvFgeIzwgmUqxD2d2buXqZGhdBr+XKvm2
         JlXehro7kWa5XIw/EzFaYi6AaM2ezc46n6gj1WsG5TQ78tKb9tlzktxxmZ3dRnMjDz5k
         Tr24doXjYUdoAl66uiVCoH0FpeESJ3RExZYLrB0wliYPSU7wc8FcYzHsMGOaj1fpNxoK
         zUaP3Z6EYw3UMMHtsqd8wZ+lUI/zqKv419slmzBrJtIWpe1+z4uZG6Ug9DHE8WyaZfEm
         /bz2mFiLoB4gUM0a1o5Gk7kgnA/iLWK5gg16pgoQJKcqwYufvMIAszGnpPK1CKZ+EWSn
         eEfg==
X-Gm-Message-State: AOUpUlHKPqCTWdI4zwLIR7fRb9+RjFjwe/1BWMIdWvJwyMhfG/9B1pSO
        Palh04sWfiRz8RTsXK5LiwI=
X-Google-Smtp-Source: AA+uWPzolp3jgmy8WbQV64osD4n6AnLYgF5HkIzpmWeMRAMsM2i5q4SXvLvJSHE/lLvRdMgTnQZcvg==
X-Received: by 2002:a1c:dc89:: with SMTP id t131-v6mr1502609wmg.50.1533814936164;
        Thu, 09 Aug 2018 04:42:16 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id u7-v6sm6123993wrq.13.2018.08.09.04.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 04:42:15 -0700 (PDT)
Date:   Thu, 9 Aug 2018 13:42:14 +0200
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
Subject: Re: [PATCH 2/8] mmc: tegra: Parse and program DQS trim value
Message-ID: <20180809114214.GK21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-3-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ArrI7P/b+va1vZ8"
Content-Disposition: inline
In-Reply-To: <1533650404-18125-3-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Two more comments...

On Tue, Aug 07, 2018 at 04:59:58PM +0300, Aapo Vienamo wrote:
> Parse and program the HS400 DQS trim value from dt. Program a fallback
> value in case the property is missing.

"dt" -> "DT" because it is an abbreviation.

>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
[...]
> @@ -545,20 +555,33 @@ static unsigned int tegra_sdhci_get_max_clock(struc=
t sdhci_host *host)
>  	return clk_round_rate(pltfm_host->clk, UINT_MAX);
>  }
> =20
> +static void tegra_sdhci_set_dqs_trim(struct sdhci_host *host, u8 val)
> +{
> +	u32 reg;
> +
> +	reg =3D sdhci_readl(host, SDHCI_TEGRA_VENDOR_CAP_OVERRIDES);
> +	reg &=3D ~SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_MASK;
> +	reg |=3D val<<SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT;

Also, you should add spaces around '<<'.

Thierry

--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsKJYACgkQ3SOs138+
s6Ev6Q//THUoH4xdLk+zBGfsqxPr0KD3y5bVYew9QJz50OLbSpcXVGOk4ecz19WO
huaVBr8RTts6DzR6/bg7ppX4nM9t28LRt6LZW7PRZ61tewOFWwlnlhu8JR92HJRS
ipdW9g3uSLWhdQ3hkS74b5NdnQc/rU25Csj3S2sW9LkdG2D+VoC1zgLQOzYrUM6u
FbxYvDvfdZM6Lha8n99WV3heAnVD8ypaFNZ0hB8O6lZrrV/Qm70ETdXV/p82+Xgg
5f76xwTmm8CMIhZr2cG/gFYOBn9/vwJ1SwjaswX9ktnTSsDtpt8mQorsKs6R1yWY
kqXSpj0E9VHAdwVKeufet93xql0DKVA+WOr2XxHs1HpGFMR2ajTVck+j1zL7qn0W
VJl7BFJHahyPX+eXTUpudL+41WO0DzZIwU34m4jjC+iBpPTTyQ2qNrSo0cMADjIc
0BHrr39CJMQKrh1j4kXqj9YsJ7pprxCrmNnDd/uWBvsCs5ri6Fn1ABk40L0k377s
tUsbmYMg/t4tnG0Jaf1FW0r1pyDpz1yvacb9OPakzOMVyCDATzoCjsSyk15egkMU
u6E5MYgNZZUGQAeY/kOXeek8Fad6VGXGn0ZSpeWNts7E9DJHyXlkAmr8aQB4FPNL
BErjA8MxbEAxCcqB4AmroWyX7vu40EudIIaxCFPSz4f+idoULG0=
=g9ok
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--
