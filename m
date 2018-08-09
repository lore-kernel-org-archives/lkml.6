Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05D8C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91D621BC9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjQT5pYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91D621BC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbeHIPRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:17:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52292 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHIPRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:17:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so85250wmh.2;
        Thu, 09 Aug 2018 05:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=74pw69CFcxj6x7lHSJZlDLgf++xSeYk0a/pCD0SkezM=;
        b=UjQT5pYyMhlZgLETVMkXHy0djjYdkhqVx7YOfLxosXcg1yBuB1cEyG6QkqTzUE+B8q
         fcui+z2/ifoJ471mmlKrBo39FHpQ5oKulKAevloaIP7ggOfTwLylxeroLUIVc2oSv0dq
         Z56K23IL+xBmj3SZqU/7FTasqX5K6tomq2y4djK1vd6zVYp9Z6lURaL7OkGkIenPNIzD
         EsiHtnSCL7w5mXhQqPSk57DC57mwSgRcyKARn2dqDUMDY9KXRYyem3PRwBkj4kxpImKI
         fqeoafxfBVYJrk3DXVkBuI3eczFJpVHih4PPrW8d77luK9YXTSH4RDlYoL2uwxcKC9Y+
         7Y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=74pw69CFcxj6x7lHSJZlDLgf++xSeYk0a/pCD0SkezM=;
        b=EEpp5e9D8sPyPk2DTLfJ8Olb8BHLNTyJVlXvj9+XGBqp3D2PDJf4JduyuLd447q+GE
         M667/1sjYqJKZenhZD/KpdjR+Zx5P60Q7dTFC+jbLZEqLhJhAJ+pDnHaASXO9LGvyX5c
         9xU32sJdt/NKJ8mqY7Duj0M7aiMp9BCNqIfULFZ7XYVyA+OWnF4VWQ02nEn90JNuNTDk
         lMdw8trU1yp7w46araM9wxl02Gdxh7VV5cjWA+JDpl+PPx+zntGVw9rw2uSh5YS6dkbR
         Bh6GlWWrWVAIyAKb/3giLGvnSoqy6zOYJw1VbFZC1+RUGD7B/gKG/+yfcgzOzlXkU3At
         YndQ==
X-Gm-Message-State: AOUpUlESug3xlXnNMR9YByk2y7HHf9zT+YKcf7Vv0K3a/d4QOS3hbcNu
        fjkgN3go+yphsOBeob0ks9I=
X-Google-Smtp-Source: AA+uWPyOBVaJEsLvpLBKg8DHr8Srw6KB8MWYmpekeWvd63cqjmtYd05AA9Yq0F90jTRYKwqz5Contw==
X-Received: by 2002:a1c:1802:: with SMTP id 2-v6mr1471016wmy.81.1533819148299;
        Thu, 09 Aug 2018 05:52:28 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id o4-v6sm9198908wmo.20.2018.08.09.05.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:52:27 -0700 (PDT)
Date:   Thu, 9 Aug 2018 14:52:26 +0200
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
Subject: Re: [PATCH 15/40] mmc: tegra: Power on the calibration pad
Message-ID: <20180809125226.GW21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-16-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7kW37LRKoI6fR2de"
Content-Disposition: inline
In-Reply-To: <1533141150-10511-16-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7kW37LRKoI6fR2de
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:32:05PM +0300, Aapo Vienamo wrote:
> Automatic pad drive strength calibration is performed on a separate pad
> identical to the ones used for driving the actual bus. Power on the
> calibration pad during the calibration procedure and power it off
> afterwards to save power.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 53c035b9..9e22fec 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -54,6 +54,7 @@
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL			0x1e0
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL	0x7
> +#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD	BIT(31)
> =20
>  #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
>  #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
> @@ -240,11 +241,32 @@ static void tegra_sdhci_reset(struct sdhci_host *ho=
st, u8 mask)
>  	tegra_host->ddr_signaling =3D false;
>  }
> =20
> +static void tegra_sdhci_configure_cal_pad(struct sdhci_host *host, bool =
enable)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * Enable or disable the additional I/O pad used by the drive strength
> +	 * calibration process.
> +	 */
> +	reg =3D sdhci_readl(host, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +	if (enable) {
> +		reg |=3D SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD;
> +		sdhci_writel(host, reg, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +		udelay(1);
> +	} else {
> +		reg &=3D ~SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD;
> +		sdhci_writel(host, reg, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +	}

Might be worth extracting the common write as well. This would of course
mean that we either have to conditionalize the udelay() again, or we
just keep it in both cases. Doesn't really hurt to wait a little on
disabling, right?

Either way is fine with me. Though it would be nice if we could make the
udelay() go away and use a sleeping variant if possible. This isn't run
very often, so even if we overshoot by a couple of microseconds it isn't
that bad. 1 us is pretty short, but I've been burnt by busy loops a
couple of times, so I like to avoid them at all costs.

Thierry

--7kW37LRKoI6fR2de
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsOQoACgkQ3SOs138+
s6GZtxAAoh/mGnKo4jAJUsNpr86cp6zTl3H564xjbckbeB0P7XHqLkqvnOYab14D
fywWzwse5T1zB6cNeps6OpmLkjptQeQ91suM5N/4kvHHjlWJmOtfh6OZ0+w7MtF/
FI5gxpXdpV77t5cny8rGBl+sn34TXyxTTWWBTlAPOwT1EqlSt4FfGZIF5jCt/BRS
yneA0xmznO0GY9PTjc/x48Rl0AMjACowGItoAyL0J5YLxIRKoUT3ygsaDwYa/KRd
dE6xN2H+y84d3+C7Jkwk2ytgqCkQP+kkYpACt/JmhvCrJrtX7TtVF7s37w2oJZYC
0cXlrgYAJsDFUejofCn60t3QhRArJ+rpnM+TfPYFiuA6EMLgA7tgJtzNlFx0GB3X
mA7Hcyp/LZl7apdrHYNjVZN5SpRN0geeoCDw2WDuUw7BCg6ga+juuxLI30HcISRD
dILKNjTElMnXmBbb8p7Xo4Kn6v406yTWknIRGdOV0mdZ1xv/Fiyw2v+R3yEqdXyt
Dz+eyK8ciV1uRvJO1W4xAO28ENq7lfAAkr0dFU0I2/K3eJjaulwLPmtjSsbZVH1G
yuEQqv7zdmJ2VPuxxfbwZLQAdogJDflmUJisk6s5DiKSlR0dVryrt8svUe/sX1Xa
8FbI3dfkY4oZHv9riRlJ/+K4gJzATTW6I0NoWUfBJ550qDtSv5A=
=Blms
-----END PGP SIGNATURE-----

--7kW37LRKoI6fR2de--
