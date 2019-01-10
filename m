Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2460C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69691214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6/W8jjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfAJPGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:06:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36645 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfAJPGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:06:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so11771163wrp.3;
        Thu, 10 Jan 2019 07:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bKoTonZFpL8wFNazhGuwpEsbqEjP2P3Lm4aj9p9CJKs=;
        b=s6/W8jjw6LIwpd0kSi7Mhmu9XJ1TJry2Q391iEw3f/UUUALfdldVcaXUXyABrBrAMv
         ByICqncqf26YKO/trTX2fQFQ6D0m+mpTfauq5ndxF6Qvn15xK2VRHYczeMjcRlcU1mIW
         kaQswl4PI78MhsLnOMeNWoaL1C4meyNkBk53f1Wm7S6325JEkHoLJutIPEfddC2ljYim
         Mbo+SKpw+ih5PUZiJPAN62KGP+yur1VFCjpa/TJoC2a9M6kMBp4lNZ0lG489NAurRFF7
         PTx2TQlEUBW8RvZ6FnfmvcoTVb5G5GSZMHSRxB4XZBuNE0YMffXpqGz/EtJJxX1wDDlg
         vFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bKoTonZFpL8wFNazhGuwpEsbqEjP2P3Lm4aj9p9CJKs=;
        b=TMx+D9yPtyS5XIEq7QCTurj7D7wg5N7KF9RZvp6gk6N6D9+UiIo/wu6jpbUgPfhHVK
         LJoBjJMKLZLnc6O434LxxSRjVR0HK3FR95N+li6EFVK8cguAkuyWX5NZ09bK9f8e+r7s
         38LxuYrRepXCjv1cKNZdxJ7/GqZ+3qmcUxnMUeriBAk7MoCzmZ+7ooDSVTKCzfjrAS1+
         4sej0hxFq1iiUWaTTumsluV/gkfPQjdKKdykIYrjyJJkMwffW+TEL4FOvuG9gmAqtr3Q
         h520VQsDjFhz08w/3ORq5fxiofwCyKwyMw7glVPpwRiaEWJ6P4pdT9jOoWyX8s9bxC9a
         dPqQ==
X-Gm-Message-State: AJcUukdVEqRWLKZp8hTYQvjVzgSW0MkKcViW6edRUEWQfijk88R21de/
        rk/1dVzqIYVllM/04b85UJE=
X-Google-Smtp-Source: ALg8bN5H3kOKn+Ps3dS93kxHqfdoN8t7BJFGNhjmZjLQ9KPp3ru1rWhaBMLSof8x70uq4Nd2tqeP2w==
X-Received: by 2002:adf:9205:: with SMTP id 5mr9622359wrj.189.1547132764625;
        Thu, 10 Jan 2019 07:06:04 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id k19sm78614540wre.5.2019.01.10.07.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 07:06:03 -0800 (PST)
Date:   Thu, 10 Jan 2019 16:06:02 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com,
        jonathanh@nvidia.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH V3 3/3] mmc: tegra: SDMMC pads auto-calibration
Message-ID: <20190110150602.GC25353@ulmo>
References: <1546462674-22856-1-git-send-email-skomatineni@nvidia.com>
 <1546462674-22856-3-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <1546462674-22856-3-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 12:57:54PM -0800, Sowjanya Komatineni wrote:
> Programs initial drive code offsets which will be used by auto
> calibration process.
>=20
> Programs fixed drive strengths for SDMMC pads when auto cal
> timeouts. Fixed settings are based on Pre-SI analysis of the
> pad design.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 107 +++++++++++++++++++++++++++++++----=
------
>  1 file changed, 81 insertions(+), 26 deletions(-)

Hi Sowjanya,

this looks really good. Some minor comments below.

> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 7b95d088fdef..f8361249cf57 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -75,6 +75,7 @@
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL	0x7
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD	BIT(31)
> +#define SDHCI_COMP_PADCTRL_DRVUPDN_OFFSET_MASK		0x07FFF000
> =20
>  #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
>  #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
> @@ -121,6 +122,8 @@ struct sdhci_tegra {
>  	struct pinctrl *pinctrl_sdmmc;
>  	struct pinctrl_state *pinctrl_state_3v3;
>  	struct pinctrl_state *pinctrl_state_1v8;
> +	struct pinctrl_state *pinctrl_state_3v3_drv;
> +	struct pinctrl_state *pinctrl_state_1v8_drv;
> =20
>  	struct sdhci_tegra_autocal_offsets autocal_offsets;
>  	ktime_t last_calib;
> @@ -130,6 +133,9 @@ struct sdhci_tegra {
>  	u32 dqs_trim;
>  };
> =20
> +static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage,
> +							bool state_drvupdn);
> +

You're rewriting most of that function anyway, so might as well move it
up here. The diff should be about the same in terms of readability, so
you don't need the forward declaration.

>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
>  {
>  	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> @@ -437,6 +443,7 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_ho=
st *host)
>  			pdpu =3D offsets.pull_down_3v3 << 8 | offsets.pull_up_3v3;
>  	}
> =20
> +	/* Set initial offset before auto-calibration */
>  	tegra_sdhci_set_pad_autocal_offset(host, pdpu);
> =20
>  	card_clk_enabled =3D tegra_sdhci_configure_card_clk(host, false);
> @@ -460,19 +467,15 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_=
host *host)
>  	if (ret) {
>  		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
> =20
> -		if (ios->signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_180)
> -			pdpu =3D offsets.pull_down_1v8_timeout << 8 |
> -			       offsets.pull_up_1v8_timeout;
> -		else
> -			pdpu =3D offsets.pull_down_3v3_timeout << 8 |
> -			       offsets.pull_up_3v3_timeout;
> -
> -		/* Disable automatic calibration and use fixed offsets */
> +		/* Disable automatic cal and use fixed Drive Strengths */
>  		reg =3D sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
>  		reg &=3D ~SDHCI_AUTO_CAL_ENABLE;
>  		sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> =20
> -		tegra_sdhci_set_pad_autocal_offset(host, pdpu);
> +		ret =3D tegra_sdhci_set_padctrl(host, ios->signal_voltage, false);
> +		if (ret < 0)
> +			dev_err(mmc_dev(host->mmc),
> +			"Setting drive strengths failed %d\n", PTR_ERR(ret));

It's customary to align the first argument on subsequent lines with the
first argument on the first line. Also, I find it more readable to have
a ':' separating the error code:

			dev_err(mmc_dev(host->mmc),
				"Setting drive strengths failed: %d\n", ret);

Also note how you don't need to cast the ret value because it is already
an integer.

>  	}
>  }
> =20
> @@ -743,27 +746,73 @@ static int tegra_sdhci_execute_tuning(struct sdhci_=
host *host, u32 opcode)
>  	return mmc_send_tuning(host->mmc, opcode, NULL);
>  }
> =20
> -static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage)
> +static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage,
> +							bool state_drvupdn)

Same as above, make sure the bool state_drvupdn argument aligns with
struct sdhc_host *host.

>  {
>  	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>  	struct sdhci_tegra *tegra_host =3D sdhci_pltfm_priv(pltfm_host);
> -	int ret;
> +	struct sdhci_tegra_autocal_offsets offsets =3D
> +					tegra_host->autocal_offsets;

Perhaps make this a pointer to avoid copying the whole structure? You
could even make it const if you want to be very explicit that you're
only referencing the autocalibration offsets.

> +	struct pinctrl_state *pinctrl_drvupdn =3D NULL;
> +	int ret =3D 0;
> +	u8 drvup =3D 0, drvdn =3D 0;
> +	u32 reg;
> =20
> -	if (!tegra_host->pad_control_available)
> -		return 0;
> +	if (!state_drvupdn) {
> +		/* PADS Drive Strength */
> +		if (voltage =3D=3D MMC_SIGNAL_VOLTAGE_180) {
> +			if (!IS_ERR(tegra_host->pinctrl_state_1v8_drv) &&
> +				(tegra_host->pinctrl_state_1v8_drv !=3D NULL)) {

Perhaps:

	IS_ERR_OR_NULL(tegra_host->pinctrl_state_1v8_drv)?

but then, do we actually need this? It looks like pinctrl_lookup_state()
will always return either an ERR_PTR() encoded error code or a valid
pointer. Under what circumstances would pinctrl_state_1v8_drv be NULL?

> +				pinctrl_drvupdn =3D
> +					tegra_host->pinctrl_state_1v8_drv;
> +			} else {
> +				drvup =3D offsets.pull_up_1v8_timeout;
> +				drvdn =3D offsets.pull_down_1v8_timeout;
> +			}
> +		} else {
> +			if (!IS_ERR(tegra_host->pinctrl_state_3v3_drv) &&
> +				(tegra_host->pinctrl_state_3v3_drv !=3D NULL)) {
> +				pinctrl_drvupdn =3D
> +					tegra_host->pinctrl_state_3v3_drv;
> +			} else {
> +				drvup =3D offsets.pull_up_3v3_timeout;
> +				drvdn =3D offsets.pull_down_3v3_timeout;
> +			}
> +		}
> +
> +		if (pinctrl_drvupdn !=3D NULL) {
> +			ret =3D pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> +							pinctrl_drvupdn);
> +			if (ret < 0)
> +				dev_err(mmc_dev(host->mmc),
> +					"failed pads drvupdn, ret: %d\n", ret);
> +		} else if ((drvup) || (drvdn)) {
> +			reg =3D sdhci_readl(host,
> +					SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +			reg &=3D ~SDHCI_COMP_PADCTRL_DRVUPDN_OFFSET_MASK;
> +			reg |=3D (drvup << 20) | (drvdn << 12);
> +			sdhci_writel(host, reg,
> +					SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +		}
> =20
> -	if (voltage =3D=3D MMC_SIGNAL_VOLTAGE_180) {
> -		ret =3D pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> -					   tegra_host->pinctrl_state_1v8);
> -		if (ret < 0)
> -			dev_err(mmc_dev(host->mmc),
> -				"setting 1.8V failed, ret: %d\n", ret);
>  	} else {
> -		ret =3D pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> -					   tegra_host->pinctrl_state_3v3);
> -		if (ret < 0)
> -			dev_err(mmc_dev(host->mmc),
> -				"setting 3.3V failed, ret: %d\n", ret);
> +		/* Dual Voltage PADS Voltage selection */
> +		if (!tegra_host->pad_control_available)
> +			return 0;
> +
> +		if (voltage =3D=3D MMC_SIGNAL_VOLTAGE_180) {
> +			ret =3D pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> +						tegra_host->pinctrl_state_1v8);
> +			if (ret < 0)
> +				dev_err(mmc_dev(host->mmc),
> +					"setting 1.8V failed, ret: %d\n", ret);
> +		} else {
> +			ret =3D pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> +						tegra_host->pinctrl_state_3v3);
> +			if (ret < 0)
> +				dev_err(mmc_dev(host->mmc),
> +					"setting 3.3V failed, ret: %d\n", ret);
> +		}
>  	}
> =20
>  	return ret;
> @@ -778,7 +827,7 @@ static int sdhci_tegra_start_signal_voltage_switch(st=
ruct mmc_host *mmc,
>  	int ret =3D 0;
> =20
>  	if (ios->signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_330) {
> -		ret =3D tegra_sdhci_set_padctrl(host, ios->signal_voltage);
> +		ret =3D tegra_sdhci_set_padctrl(host, ios->signal_voltage, true);
>  		if (ret < 0)
>  			return ret;
>  		ret =3D sdhci_start_signal_voltage_switch(mmc, ios);
> @@ -786,7 +835,7 @@ static int sdhci_tegra_start_signal_voltage_switch(st=
ruct mmc_host *mmc,
>  		ret =3D sdhci_start_signal_voltage_switch(mmc, ios);
>  		if (ret < 0)
>  			return ret;
> -		ret =3D tegra_sdhci_set_padctrl(host, ios->signal_voltage);
> +		ret =3D tegra_sdhci_set_padctrl(host, ios->signal_voltage, true);
>  	}
> =20
>  	if (tegra_host->pad_calib_required)
> @@ -805,6 +854,12 @@ static int tegra_sdhci_init_pinctrl_info(struct devi=
ce *dev,
>  		return -1;
>  	}
> =20
> +	tegra_host->pinctrl_state_1v8_drv =3D pinctrl_lookup_state(
> +				tegra_host->pinctrl_sdmmc, "sdmmc-1v8-drv");
> +
> +	tegra_host->pinctrl_state_3v3_drv =3D pinctrl_lookup_state(
> +				tegra_host->pinctrl_sdmmc, "sdmmc-3v3-drv");

If this truly is optional, then I suggest we do something like this
instead:

	tegra_host->pinctrl_state_1v8_drv =3D pinctrl_lookup_state(...);
	if (IS_ERR(tegra_host->pinctrl_state_1v8_drv)) {
		err =3D PTR_ERR(tegra_host->pinctrl_state_1v8_drv);

		if (err =3D=3D -ENODEV)
			tegra_host->pinctrl_state_1v8_drv =3D NULL;
		else
			return err;
	}

With that we can use the much simpler condition everywhere:

	if (tegra_host->pinctrl_state_1v8_drv)
		...

Thierry

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw3X1cACgkQ3SOs138+
s6EDTA/8DjnVSHIviys5AJDenprXWJrcg20SoNCTgMM05IuH2vDGw/ubbbrey+zw
TmKnk0ww5ZBA+slQxNCq1ZIHWaH1t6u8oQUM5gy+gp/sYrOeEPtQB/ifwLr0yclS
3CQEF1MdXpLHpzZsMb4Dk4hvKUxcREMzOavmEeUeKQ6DNlVvcoezsOhqP+TPx1dB
BeQFus+oF6ZhL6u8d1p0mbrXHLC+eozW+6vLGgevBiX+n9bSQ2Y9ixwFBAzwweIY
rrfj3YpLIqPxsD4XwrTmHXHNt/O6YAAilBMfYXUI0b+Tdn+pFWkOqWskqUeJLmPj
TmmrpQIYaqwEZVvYVtd6CT43wc1nRy+6ak81/EMXmg8mugSvUyiwXlRB4MJrHecS
k6mlS8glteDzQoYRQrCamlsF6745ngzUG+U1bW5QoZT0PzTSt2DphPze6VxF8ZYh
TOTWNKvuJKSOyMEhszTIqr1XqdTsJiPXNc4XSQwcmFGigfJE0VXIMQ7OWK8enIXb
yorgVM3/WqTP4CJy/0g5rXClpP/MLpEO7rqrU+qpbXQf44e1jMYZAVlLXTsMdvOu
bOAe2UUWpeT7asQbQbVNNbA63FCf533fGCxL3bD9bGJjZh9WNlBDd/XajM01trCc
Ti1Uz6aeVzmX358LhwjBMu0YBtRU5LbKCm9cul57uttdMgP/7qI=
=Gdwa
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
