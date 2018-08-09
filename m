Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EA9C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A655321C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9gLWpaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A655321C2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbeHIOIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:08:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39220 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHIOIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:08:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id q8-v6so6108988wmq.4;
        Thu, 09 Aug 2018 04:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2O64D21CDbg2u16TCdwTDTrmq0bt3geq2E5lt3eL/Y4=;
        b=m9gLWpaMxqIwOIqlgMUffHzUMXl1C9/n9UomTFMSndCQgMKYwplLYRg8kRYKLURQFd
         fsdteu3+cxk9Cl6T+b6R12CqzIqm8jAIDQFjGXJIeSpSSM2MhOBStZiAhAFLULgKECX/
         8TCm18rOfzMUprgRp48bOv+av8jZCjjxfFnVRLF2gBecQmDNIMUeik93j0c1YyicL/6U
         XvgFzWpuXfdnNTV7Yg9ge9BjOEAKjkESefnj6KObvOOQ2WKyT4bbRFqnzqmNwTG/6FDt
         VGJSuhcfZyvKBrBlqUACloWxT9fE/fsMfbitV2xYqD7EPOJhHl0JrHrpXVhq+JMnXtga
         U50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2O64D21CDbg2u16TCdwTDTrmq0bt3geq2E5lt3eL/Y4=;
        b=rx1kXf2koz+fJjB9QGXWkQP7jaz85Gz3dJbrk5ejoxayzTO5Bg9AofwfX0n+DyUAes
         u+ujETyehyg8CGIy7qA2TnefbvqV8h8fIxdQZ0R++ccF1pgYs6iNehrK65RdwlpY7heP
         HsMNS51pE9cCVM4++ijPJIRNri4BhFpDuTm/O3Iek8xmC6jatgajfpnfn5X2bTLQm9QL
         mMcKh6dNnqa84plKbq1z114thiTFnHygBdkEu7qEQatY3DGj7GKSm243QzDvkgCXiBy3
         oDC5NQVaKgYpIf+6zUuEf2kAvhkI6Zo0kHOh+8r0Rg+BtxwI/8UChim/f9fzbyHZ1BiH
         ZwOQ==
X-Gm-Message-State: AOUpUlFOq8Tp6ISsOHdEgSf+xwcUtvhCTugeJZVRj8L9KUk1uGSnvDtC
        e6D5iTK+r9AEbsKGl6bK/Fw=
X-Google-Smtp-Source: AA+uWPz8YD6He7lmFmcMugnOV0woNrlKPIh/HrfvhpkfFpySv2lTA/2OnUTDNNcyt+Tp4YjHfFaNiA==
X-Received: by 2002:a1c:7c13:: with SMTP id x19-v6mr1457235wmc.27.1533815027610;
        Thu, 09 Aug 2018 04:43:47 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id f132-v6sm14216743wme.24.2018.08.09.04.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 04:43:46 -0700 (PDT)
Date:   Thu, 9 Aug 2018 13:43:45 +0200
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
Subject: Re: [PATCH 3/8] mmc: tegra: Implement HS400 enhanced strobe
Message-ID: <20180809114345.GL21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-4-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HBg0C3yr6HVa1ZCc"
Content-Disposition: inline
In-Reply-To: <1533650404-18125-4-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HBg0C3yr6HVa1ZCc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2018 at 04:59:59PM +0300, Aapo Vienamo wrote:
> Implement HS400 enhanced strobe.

Can you provide a little more information about what the impact is of
this? Does this increase throughput? How much?

>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 426f7ea..d81143b 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -43,6 +43,9 @@
>  #define SDHCI_CLOCK_CTRL_PADPIPE_CLKEN_OVERRIDE		BIT(3)
>  #define SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE	BIT(2)
> =20
> +#define SDHCI_TEGRA_VENDOR_SYS_SW_CTRL			0x104
> +#define SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE		BIT(31)
> +
>  #define SDHCI_TEGRA_VENDOR_CAP_OVERRIDES		0x10c
>  #define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_MASK		0x00003f00
>  #define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT	8
> @@ -271,6 +274,22 @@ static void tegra_sdhci_set_tap(struct sdhci_host *h=
ost, unsigned int tap)
>  	}
>  }
> =20
> +static void tegra_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc,
> +					      struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host =3D mmc_priv(mmc);
> +	u32 reg;
> +
> +	reg =3D sdhci_readl(host, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
> +	pr_err("enhanced strobe: %d\n", ios->enhanced_strobe);

Left-over debug error?

> +	if (ios->enhanced_strobe)
> +		reg |=3D SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
> +	else
> +		reg &=3D ~SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
> +	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);

You might want to add blank lines around the if ... else ... block for
readability.

Thierry

--HBg0C3yr6HVa1ZCc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsKPEACgkQ3SOs138+
s6Eb1RAAloFX6Tv2ZWx0XzekpM2KJlXdnj3HP5A+Eny4d69pJScQlCGD2eG8NRhJ
/CZpDUSjuB2vz49uA80N0c1OeHFHch7hd5k+rKVeK/p7q1s/vi1mD9IgKIbo89gQ
5TvgFnW8gMsmD7rPci7RY5a2De2U6/KIt0WxSK01QyCodAizS3gtrUX4rfcDv74y
V5MGe6gDTx6jXBu6X4WHf90fl9a2DcVXiSC8LkDuobYV0ukr6NEA32ogOW5+94e4
EqDoIj+V68+eRe/04Pcxg2CIGTwwCHhsFGQv53a09aPnaiS50AS62YqnhFnnoF1c
dBn8cVaUP7bTGktb9jWd5mvmTCIsTWY8p4iIidQ/M4RW7+9uDAYFswdJtLvhTcLg
f4zZxKqY8C/B5AibHjFCzJR77FHjmrpyjSo3C2Skg2zry3DxFRnwYD/5CbRbbLUj
5V0PqwbFHO78K1hn6hRS2aPmOp42OO4aaut4k+oCEaIm42KxlYTvM7P4TgkjxtkS
qDuO/evqbDGKVece7a+Rk/MSRc/NGnJBmOS7RlXzYqkgB1ivXXhKq9EwqevPSyIa
0YhQzOOydXvP9t9F57P1SS2u94wgjpGcWVhAbRLyJuInz+B1Dnpi+HHiuZQ6vdHn
hWr3iJvLi0yAUWrA4rKPYr9FfbgqGdYigdxqkK6QkslhJafBoUE=
=qF0n
-----END PGP SIGNATURE-----

--HBg0C3yr6HVa1ZCc--
