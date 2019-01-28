Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E9EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B20021736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTFn80Qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfA1IBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:01:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51495 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfA1IA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:00:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so12874842wmj.1;
        Mon, 28 Jan 2019 00:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6pqyTrqi3V/W0Zymt8LPgmSBW2gYoCLiE0KGMYFz0gM=;
        b=aTFn80QnvISWmMJToS1DbENtnorL4p7F4DlpPhEYzsmHeYKMKYMCcPS/6RLvctAKGi
         3BltTJm1ecyplqqVK8Fjuf9Q6/OHh7hTTTqPXwNmaNkHt3+uZAhYOV7I8Cbdd1uYCgII
         7/XOQyfW1BaNGV0uMvUiEsrztpmm26Ff7DGBVIfy6JSoIsCo/5LACCMwfsyUk49jWfqq
         SiQTwaZlsk0NZOSF/jfbWuaGBkilMm+0MI+MqVSO6hXIyG+w8lZtRDXZ51erBhyMPRwu
         Zi8/LWOwfHVbJGwFg4lrc2Xns+IKXxEupFQur7yUkQeSfm/SOk/pFPwPEyBd0Ma+Xjps
         VQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6pqyTrqi3V/W0Zymt8LPgmSBW2gYoCLiE0KGMYFz0gM=;
        b=JORtOeJdA3cmoe1fFnq0K099qvE4L8T6EEwXKNAwG6hn/tL3gS5uAbgv++dgmg2dBZ
         psRUpUfI4dbOK0Klhr9xxmw5NVt8sAMJu4rUkH1z9UagdUf+bFEL4UiJAkR+WyjR0U6D
         HKtzqcosOHgjamafEJIjJB3zR1C2FmVZio2ccfWxZ0E+uAbeqrlo8uSnMRa4qETtRudc
         /eN+IiRpeqNqXLCYWjqzWsRdheZRSNnlQ3dmtHfCBEhvdUZ9WhI8rq2e9i3mtyZ3FjnG
         azUNLQQPZL9fjSoH3MkoqgQW2anum8W0nuJ51iC86PXLtGFV1PIaReCMEI5qC2pYaLAs
         1VGA==
X-Gm-Message-State: AJcUuke7yMiw8YqQjX7t2+CddNfCkjyVpmK8MdOQF03uREK+QP8aw2FY
        AMnOolD3Kc0xWPQX0N+V+4Y=
X-Google-Smtp-Source: ALg8bN6UCti6jKU1azpX3wExIDo9bV+yUIThcuJAel89Wss3Wr0t2patUD8+JVDSHcTY20dYWw7fqg==
X-Received: by 2002:a1c:c64e:: with SMTP id w75mr16763413wmf.46.1548662456733;
        Mon, 28 Jan 2019 00:00:56 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id a12sm125532695wro.18.2019.01.28.00.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 00:00:56 -0800 (PST)
Date:   Mon, 28 Jan 2019 09:00:54 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     jckuo <jckuo@nvidia.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] phy: tegra: xusb: Add support for power supplies
Message-ID: <20190128080054.GB18124@ulmo>
References: <20190125112525.10697-1-thierry.reding@gmail.com>
 <20190125112525.10697-4-thierry.reding@gmail.com>
 <786247a4-81d1-9c2e-21b5-258dc818ccb9@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <786247a4-81d1-9c2e-21b5-258dc818ccb9@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 03:22:09PM +0800, jckuo wrote:
> Hi Thierry,
>=20
> I think any non-zero return value of
> regulator_bulk_enable()/devm_regulator_bulk_get() means error.
>=20
> Thanks,
>=20
> JC

Theoretically I think only regulator_bulk_enable() could return a
positive value, but even so it never will in practice because all of the
regulator_enable() (see _regulator_enable()) calls will only ever return
negative error codes.

I can change this and resend if you have strong concerns about this
possibly missing legitimate error cases.

Thierry

> On 1/25/19 7:25 PM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Support enabling various supplies needed to provide power to the PLLs
> > and logic used to drive the USB, PCI and SATA pads.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >   drivers/phy/tegra/xusb.c | 34 +++++++++++++++++++++++++++++++++-
> >   drivers/phy/tegra/xusb.h |  5 +++++
> >   2 files changed, 38 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> > index 57a2d08ef6da..e510629f4f1c 100644
> > --- a/drivers/phy/tegra/xusb.c
> > +++ b/drivers/phy/tegra/xusb.c
> > @@ -864,6 +864,7 @@ static int tegra_xusb_padctl_probe(struct platform_=
device *pdev)
> >   	struct tegra_xusb_padctl *padctl;
> >   	const struct of_device_id *match;
> >   	struct resource *res;
> > +	unsigned int i;
> >   	int err;
> >   	/* for backwards compatibility with old device trees */
> > @@ -901,14 +902,38 @@ static int tegra_xusb_padctl_probe(struct platfor=
m_device *pdev)
> >   		goto remove;
> >   	}
> > +	padctl->supplies =3D devm_kcalloc(&pdev->dev, padctl->soc->num_suppli=
es,
> > +					sizeof(*padctl->supplies), GFP_KERNEL);
> > +	if (!padctl->supplies) {
> > +		err =3D -ENOMEM;
> > +		goto remove;
> > +	}
> > +
> > +	for (i =3D 0; i < padctl->soc->num_supplies; i++)
> > +		padctl->supplies[i].supply =3D padctl->soc->supply_names[i];
> > +
> > +	err =3D devm_regulator_bulk_get(&pdev->dev, padctl->soc->num_supplies,
> > +				      padctl->supplies);
> > +	if (err < 0) {
> > +		dev_err(&pdev->dev, "failed to get regulators: %d\n", err);
> > +		goto remove;
> > +	}
> > +
> >   	err =3D reset_control_deassert(padctl->rst);
> >   	if (err < 0)
> >   		goto remove;
> > +	err =3D regulator_bulk_enable(padctl->soc->num_supplies,
> > +				    padctl->supplies);
> > +	if (err < 0) {
> > +		dev_err(&pdev->dev, "failed to enable supplies: %d\n", err);
> > +		goto reset;
> > +	}
> > +
> >   	err =3D tegra_xusb_setup_pads(padctl);
> >   	if (err < 0) {
> >   		dev_err(&pdev->dev, "failed to setup pads: %d\n", err);
> > -		goto reset;
> > +		goto power_down;
> >   	}
> >   	err =3D tegra_xusb_setup_ports(padctl);
> > @@ -921,6 +946,8 @@ static int tegra_xusb_padctl_probe(struct platform_=
device *pdev)
> >   remove_pads:
> >   	tegra_xusb_remove_pads(padctl);
> > +power_down:
> > +	regulator_bulk_disable(padctl->soc->num_supplies, padctl->supplies);
> >   reset:
> >   	reset_control_assert(padctl->rst);
> >   remove:
> > @@ -936,6 +963,11 @@ static int tegra_xusb_padctl_remove(struct platfor=
m_device *pdev)
> >   	tegra_xusb_remove_ports(padctl);
> >   	tegra_xusb_remove_pads(padctl);
> > +	err =3D regulator_bulk_disable(padctl->soc->num_supplies,
> > +				     padctl->supplies);
> > +	if (err < 0)
> > +		dev_err(&pdev->dev, "failed to disable supplies: %d\n", err);
> > +
> >   	err =3D reset_control_assert(padctl->rst);
> >   	if (err < 0)
> >   		dev_err(&pdev->dev, "failed to assert reset: %d\n", err);
> > diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
> > index bb60fc09c752..5d5d22f6cb41 100644
> > --- a/drivers/phy/tegra/xusb.h
> > +++ b/drivers/phy/tegra/xusb.h
> > @@ -370,6 +370,9 @@ struct tegra_xusb_padctl_soc {
> >   	} ports;
> >   	const struct tegra_xusb_padctl_ops *ops;
> > +
> > +	const char * const *supply_names;
> > +	unsigned int num_supplies;
> >   };
> >   struct tegra_xusb_padctl {
> > @@ -393,6 +396,8 @@ struct tegra_xusb_padctl {
> >   	unsigned int enable;
> >   	struct clk *clk;
> > +
> > +	struct regulator_bulk_data *supplies;
> >   };
> >   static inline void padctl_writel(struct tegra_xusb_padctl *padctl, u3=
2 value,

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxOtrYACgkQ3SOs138+
s6FxYhAAqdP0tXGBSsclrtod8uASYw6KUN8jlAU1XmP8NeZMRgWAsTfXTy2UGPAP
8ZWKwyVmmOMl3OwbmwRGZpcH5tHtoYxPF/fP6GCLnv9lJL3oj1f1JLziBZdFPXGq
zZ7MTv4CakKrecQhGB42LKhOJscfhcHUWgRLL1PQ5/DXodB1TQmOCDkoyJu8WvOy
RylQc6i86rgD6biZ8LNR/+2r9p8spqMew+3LjhuUICEMJ8eUwbLAq512EV5ZCPGr
P6qs9M2RhdqLNhz1ITZhsDqUeqOkyKwvjeIyKmj7stYJPN+ElIlyym0rr9dPOXTi
4f1iyKThxFNggn6LE8DobxMcfJyWcfD2b5X9jCdKeXPzFxlkUMGDXjl1AriPZL8d
WNIWQlhRhvTFgkgbQcAtrnZMJ7MCv1ZV0zWN0U9M8dMfeX1gHfruhTa5zKO5B9GE
f5dUZnJpwYF1laD17bGJiCWaIdSb6rDu2Cgb16ElB4Xkg2NTMAr5n8EKVE9pFsbA
oRGpk2XEuiMBbXR6XoQly/iPVrN9i7mCEFnmTz3j1naJsUxVhISIfgndv7RqGmqh
RZ+Yd0APHgcnikYD6MMzLi/e13//9FvsqLrIze9VZWk/tmiRmJfvEpBTcZ4YuKmC
Pyrujs4yja9RYJNIhihfQGhZYNSyhFjj0yHx32idpkSSFnJsVTQ=
=NVsY
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
