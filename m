Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77705C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DB621A86
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioqje86m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DB621A86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbeHIPjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:39:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34229 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbeHIPjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:39:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id l2-v6so2326908wme.1;
        Thu, 09 Aug 2018 06:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hq/8l0OpGGUU+c0gPx4UAt5IuPrPXX6DDQjcCZAxw84=;
        b=ioqje86mBvUcsq4kSwrMMAy/VtGOrsTCoqrckR1rXJvv7PTkX2ffC/gV/KsbC3wrv+
         anYzmsSzmyjTjg8bMWYryyFiMZlwk7q7E84JuqTJi4SShWnLlaJ7EYmahbmE4qKQ7u/W
         AvdwSUku7W0e2cXA2BkecRoRcY2hV9KeWUdJ8CHmStTGM2E6OQu91hyqJAXWalFhtwPj
         ZjtJO4HtzXQs7sMP+bLq85Wa77l5pKFxjKGEeNvWP4s0DIuG/gPIQjueoFyyywWujwhK
         e7zwpC+IQDL+HrZ6tRsHOea2yT2rHChvW9QXXlXmcwFZ1czVsDyKblYkWRNLyVaYVZny
         pADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hq/8l0OpGGUU+c0gPx4UAt5IuPrPXX6DDQjcCZAxw84=;
        b=meBXeyckVaZWzfzxAL+G6FZOTG+WX02wIKmK1LCAE/IuNmPfq9BUS+uGZgBN5qmi1H
         RHfwsxwbTfvoLIBjeO4GsLhxGuAXfv8Mx/j3EHqQfxMeYSYasPcnoyb0waJc4CiCQv7G
         8s4XBQPE+HqQpWfGR2GAxJPI3Zk+olpm8br43U7D/vFPOBHtWQRbZ6DkJ3SaVcP6GUpp
         A6TIV2o24bK+66iK9SMjY6WJy/vI9D544R9zu8cIwFNaNHPZJPXwZ2cT5/xfkqNOz6Lc
         XnXFzpscPyJo9Wtz1zTYKFQnLKLlbSZzw7qBmj7uCt6vHpzvJrAEFa5K8jb2SV6yK7aX
         H7MQ==
X-Gm-Message-State: AOUpUlF8GuVj4AsqcmkjZ64eXinBIjbqW1N2cuP4cLy/xn5nn1qmlMs6
        p4rS7NQgDdPnNGO1/2AJPCFMBfRS
X-Google-Smtp-Source: AA+uWPynpWbXhJS23IbfIqMFOuMG/3pa3D0H5h+N0zgAakDbf+mDPZRSz+nHuvYuY9vW00xBXCAw7g==
X-Received: by 2002:a1c:1252:: with SMTP id 79-v6mr1567583wms.70.1533820468644;
        Thu, 09 Aug 2018 06:14:28 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id v10-v6sm7392081wrm.18.2018.08.09.06.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 06:14:27 -0700 (PDT)
Date:   Thu, 9 Aug 2018 15:14:26 +0200
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
Subject: Re: [PATCH 12/40] mmc: tegra: Reconfigure pad voltages during
 voltage switching
Message-ID: <20180809131426.GB21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-13-git-send-email-avienamo@nvidia.com>
 <20180809124346.GU21639@ulmo>
 <20180809155239.00265efd@dhcp-10-21-25-168>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JoJCGVnM/36AiBh+"
Content-Disposition: inline
In-Reply-To: <20180809155239.00265efd@dhcp-10-21-25-168>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JoJCGVnM/36AiBh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 03:52:39PM +0300, Aapo Vienamo wrote:
> On Thu, 9 Aug 2018 14:43:46 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Wed, Aug 01, 2018 at 07:32:02PM +0300, Aapo Vienamo wrote:
> > > Parse the pinctrl state and nvidia,only-1-8-v properties from the dev=
ice
> > > tree. Validate the pinctrl and regulator configuration before unmaski=
ng
> > > UHS modes. Implement pad voltage state reconfiguration in the mmc
> > > start_signal_voltage_switch() callback. Add NVQUIRK_NEEDS_PAD_CONTROL
> > > and add set it for Tegra210 and Tegra186.
> > >=20
> > > The pad configuration is done in the mmc callback because the order of
> > > pad reconfiguration and sdhci voltage switch depend on the voltage to
> > > which the transition occurs.
> > >=20
> > > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > > ---
> > >  drivers/mmc/host/sdhci-tegra.c | 138 +++++++++++++++++++++++++++++++=
+++++++---
> > >  1 file changed, 131 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-=
tegra.c
> > > index ddf00166..7d98455 100644
> > > --- a/drivers/mmc/host/sdhci-tegra.c
> > > +++ b/drivers/mmc/host/sdhci-tegra.c
> > > @@ -21,6 +21,8 @@
> > >  #include <linux/io.h>
> > >  #include <linux/of.h>
> > >  #include <linux/of_device.h>
> > > +#include <linux/pinctrl/consumer.h>
> > > +#include <linux/regulator/consumer.h>
> > >  #include <linux/reset.h>
> > >  #include <linux/mmc/card.h>
> > >  #include <linux/mmc/host.h>
> > > @@ -55,6 +57,7 @@
> > >  #define NVQUIRK_ENABLE_SDR104		BIT(4)
> > >  #define NVQUIRK_ENABLE_DDR50		BIT(5)
> > >  #define NVQUIRK_HAS_PADCALIB		BIT(6)
> > > +#define NVQUIRK_NEEDS_PAD_CONTROL	BIT(7)
> > > =20
> > >  struct sdhci_tegra_soc_data {
> > >  	const struct sdhci_pltfm_data *pdata;
> > > @@ -66,8 +69,12 @@ struct sdhci_tegra {
> > >  	struct gpio_desc *power_gpio;
> > >  	bool ddr_signaling;
> > >  	bool pad_calib_required;
> > > +	bool pad_control_available;
> > > =20
> > >  	struct reset_control *rst;
> > > +	struct pinctrl *pinctrl_sdmmc;
> > > +	struct pinctrl_state *pinctrl_state_3v3;
> > > +	struct pinctrl_state *pinctrl_state_1v8;
> > >  };
> > > =20
> > >  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> > > @@ -138,12 +145,46 @@ static unsigned int tegra_sdhci_get_ro(struct s=
dhci_host *host)
> > >  	return mmc_gpio_get_ro(host->mmc);
> > >  }
> > > =20
> > > +static bool tegra_sdhci_is_pad_and_regulator_valid(struct sdhci_host=
 *host)
> > > +{
> > > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > > +	struct sdhci_tegra *tegra_host =3D sdhci_pltfm_priv(pltfm_host);
> > > +	int has_1v8, has_3v3; =20
> >=20
> > Can these be boolean?
>=20
> In some cases regulator_is_supported_voltage() can return a negative
> error code.

Okay, that's fine then.

Thierry

--JoJCGVnM/36AiBh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsPjIACgkQ3SOs138+
s6EEEw//Yls8UaQngkn+4wjkqO0q8BxTMos/Ff8tXJxw6JlckEbmVU+DES/iZ5eo
XNg1JtVE46aJ1D4A0MM7+JLBPOjammhuqax80pf1szfzXYdBhBRBbEy2tfALgdSp
7fdDevIcgtnbSCy3yInGTdUD1Qxo6WTgZ5of7gIC/HVCBHsLF0G63te4tzoxCAm8
4tfibOAAPkZMDQmwpunlcAo4C2Pt7UW32MD8yWnFzhnjpChm10WcldE4239KX4Oc
mOP0nZJoIGqETBmYuz8rkOZHFOylipKp0iiEqTvfGnnkf4dK+i2ZNRZ5QeX6QTgv
C+tCT319q3tvxaehHBSfRxzT019ooSjS9WHyjgy7j2WapXW0+86qqnXQzgX4eqs1
zD6c2M3av994kS6EgFS3fdrOG1dUmcc+x+ebdoVj8Mji38pf/hGlD8FqeqThU1ol
7R/8BmfAeXgRJarO7MP65emMbGXQVe3yo0bMIJNz3vOYA4xDm3XGBNSbsqm7cGuk
MNaLmCUDArgS8iNyt6GuWUT/475cAQyexVLWk66fobR9ksmjubHdwvYddN48WfYo
QvHMd/ZrJLNFC8yEmcF06PMU3ChyvA0PzeI4+LyDsWyD+/eGlZoJWdCjruAD00/W
YwK1VUKal6OgGMl5CIX2QyD9o6/2G6SfZDPk+7N0iS+z4Rlw41Q=
=mO+9
-----END PGP SIGNATURE-----

--JoJCGVnM/36AiBh+--
