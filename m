Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90948C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C25320839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gixeMBLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C25320839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeLLKON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:14:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38998 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeLLKON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:14:13 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so15053430edt.6;
        Wed, 12 Dec 2018 02:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v1eJluHvCzjsMp8bBVSmsOmgE8eXgaTc+VKwmXNINjk=;
        b=gixeMBLYDgtmHUhBMoyIh+7S5cRViPrOrXGU/ORK3oRi5FBgiqCr4BbS7SQHweaTtX
         Pd36vxs2rWJTkqKCORLt7+gkUZnVwIaqHo8WpzbQjKrIqnYVpo7CB/4vHUX78VA0VLgr
         m0L3KJ/N8FXun/CkOI0G7QNqsEUUsQsMB4YdsHfrjgEVYuYeFayMkVnE7XpjWmA62g+G
         GG8eBaAyQCgJhDPNA/eawRqv/UVK6N//2iGs+8Ll7dte/Ep1/vTW8eKQPF9lJ6QL27nm
         QBboxz9e2ZG7NwAKPhxPwEYBgQVwUhWXoktB/Kv93GoaSJRqC8aWtVh/Y62LFi3XJHqw
         aKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v1eJluHvCzjsMp8bBVSmsOmgE8eXgaTc+VKwmXNINjk=;
        b=SYo2Zfvhdy/k5qapr57OJHraW7vKasCd+fzACK+eoYfQAeh9xV0+r3m5EuhIvRfj+i
         2H065WToJaaxUmZoLURCflOdVatOoxmoIKvWsRVz0xs/gfuH2YAiYWUNpx3gUpL7fvTA
         XeI6iuxZaZHzEjmH/OMUMtuH1EMifcK6v0ZwaVLr8/w7c6QrSyns8s4VmlRDj4P4wD8h
         iFZgs/4bVyH94E70SMNjWd74bdu+00KMinO56uxuULahYWD31ppIq0HAPUxdPwAa0WSj
         VfpWWKXdhHaul3+hPGQtQphUi6CcY4MXjikS4YzAMuJwTKCiYUD30T1OB560ZkJ1kN+V
         By/A==
X-Gm-Message-State: AA+aEWaNUBeNerlxP5IRvnBLUbscbH5CKsLR4Xxgq+SjIXa204D5E8/G
        mc4KOtt0MvNoFDhlNI/BPQY=
X-Google-Smtp-Source: AFSGD/XQFmrXPjyEjnwjFxzkxkKJDIQK9M5pMzs/MGSIhbKJ8rIVg3uUfMt81OTFuPjbOf3VP9r9XQ==
X-Received: by 2002:a17:906:e5a:: with SMTP id q26-v6mr14386310eji.168.1544609648705;
        Wed, 12 Dec 2018 02:14:08 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id t24sm4657255edb.7.2018.12.12.02.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:14:07 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:14:07 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 13/21] iommu/tegra: gart: Integrate with Memory
 Controller driver
Message-ID: <20181212101407.GJ15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-14-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Do4IU1xF/9sod/r6"
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-14-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Do4IU1xF/9sod/r6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:42PM +0300, Dmitry Osipenko wrote:
> The device-tree binding has been changed. There is no separate GART device
> anymore, it is squashed into the Memory Controller. Integrate GART module
> with the MC in a way it is done for the SMMU of Tegra30+.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/Kconfig      |  1 +
>  drivers/iommu/tegra-gart.c | 77 ++++++++++++--------------------------
>  drivers/memory/tegra/mc.c  | 41 ++++++++++++++++++++
>  include/soc/tegra/mc.h     | 27 +++++++++++++
>  4 files changed, 93 insertions(+), 53 deletions(-)
>=20
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index d9a25715650e..83c099bb7288 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -282,6 +282,7 @@ config ROCKCHIP_IOMMU
>  config TEGRA_IOMMU_GART
>  	bool "Tegra GART IOMMU Support"
>  	depends on ARCH_TEGRA_2x_SOC
> +	depends on TEGRA_MC
>  	select IOMMU_API
>  	help
>  	  Enables support for remapping discontiguous physical memory
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index 835fea461c59..0a72b6afa842 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -19,16 +19,17 @@
>   * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
>   */
> =20
> -#include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/iommu.h>
>  #include <linux/list.h>
>  #include <linux/moduleparam.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/vmalloc.h>
> =20
> +#include <soc/tegra/mc.h>
> +
>  /* bitmap of the page sizes currently supported */
>  #define GART_IOMMU_PGSIZES	(SZ_4K)
> =20
> @@ -397,9 +398,8 @@ static const struct iommu_ops gart_iommu_ops =3D {
>  	.iotlb_sync	=3D gart_iommu_sync,
>  };
> =20
> -static int tegra_gart_suspend(struct device *dev)
> +int tegra_gart_suspend(struct gart_device *gart)
>  {
> -	struct gart_device *gart =3D dev_get_drvdata(dev);
>  	unsigned long iova;
>  	u32 *data =3D gart->savedata;
>  	unsigned long flags;
> @@ -411,9 +411,8 @@ static int tegra_gart_suspend(struct device *dev)
>  	return 0;
>  }
> =20
> -static int tegra_gart_resume(struct device *dev)
> +int tegra_gart_resume(struct gart_device *gart)
>  {
> -	struct gart_device *gart =3D dev_get_drvdata(dev);
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&gart->pte_lock, flags);
> @@ -422,41 +421,39 @@ static int tegra_gart_resume(struct device *dev)
>  	return 0;
>  }
> =20
> -static int tegra_gart_probe(struct platform_device *pdev)
> +struct gart_device *tegra_gart_probe(struct device *dev,
> +				     const struct tegra_smmu_soc *soc,
> +				     struct tegra_mc *mc)
>  {
>  	struct gart_device *gart;
> -	struct resource *res, *res_remap;
> +	struct resource *res_remap;
>  	void __iomem *gart_regs;
> -	struct device *dev =3D &pdev->dev;
>  	int ret;
> =20
>  	BUILD_BUG_ON(PAGE_SHIFT !=3D GART_PAGE_SHIFT);
> =20
> +	/* Tegra30+ has an SMMU and no GART */
> +	if (soc)
> +		return NULL;

This looks weird. Why do we even call tegra_gart_probe() on anything but
Tegra20?

> +
>  	/* the GART memory aperture is required */
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	res_remap =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	if (!res || !res_remap) {
> +	res_remap =3D platform_get_resource(to_platform_device(dev),
> +					  IORESOURCE_MEM, 1);
> +	if (!res_remap) {
>  		dev_err(dev, "GART memory aperture expected\n");
> -		return -ENXIO;
> +		return ERR_PTR(-ENXIO);
>  	}
> =20
>  	gart =3D devm_kzalloc(dev, sizeof(*gart), GFP_KERNEL);
>  	if (!gart) {
>  		dev_err(dev, "failed to allocate gart_device\n");
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  	}
> =20
> -	gart_regs =3D devm_ioremap(dev, res->start, resource_size(res));
> -	if (!gart_regs) {
> -		dev_err(dev, "failed to remap GART registers\n");
> -		return -ENXIO;
> -	}
> -
> -	ret =3D iommu_device_sysfs_add(&gart->iommu, &pdev->dev, NULL,
> -				     dev_name(&pdev->dev));
> +	ret =3D iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
>  	if (ret) {
>  		dev_err(dev, "Failed to register IOMMU in sysfs\n");
> -		return ret;
> +		return ERR_PTR(ret);
>  	}
> =20
>  	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
> @@ -468,7 +465,8 @@ static int tegra_gart_probe(struct platform_device *p=
dev)
>  		goto remove_sysfs;
>  	}
> =20
> -	gart->dev =3D &pdev->dev;
> +	gart->dev =3D dev;
> +	gart_regs =3D mc->regs + GART_REG_BASE;
>  	spin_lock_init(&gart->pte_lock);
>  	spin_lock_init(&gart->client_lock);
>  	INIT_LIST_HEAD(&gart->client);
> @@ -483,46 +481,19 @@ static int tegra_gart_probe(struct platform_device =
*pdev)
>  		goto unregister_iommu;
>  	}
> =20
> -	platform_set_drvdata(pdev, gart);
>  	do_gart_setup(gart, NULL);
> =20
>  	gart_handle =3D gart;
> =20
> -	return 0;
> +	return gart;
> =20
>  unregister_iommu:
>  	iommu_device_unregister(&gart->iommu);
>  remove_sysfs:
>  	iommu_device_sysfs_remove(&gart->iommu);
> =20
> -	return ret;
> -}
> -
> -static const struct dev_pm_ops tegra_gart_pm_ops =3D {
> -	.suspend	=3D tegra_gart_suspend,
> -	.resume		=3D tegra_gart_resume,
> -};
> -
> -static const struct of_device_id tegra_gart_of_match[] =3D {
> -	{ .compatible =3D "nvidia,tegra20-gart", },
> -	{ },
> -};
> -
> -static struct platform_driver tegra_gart_driver =3D {
> -	.probe		=3D tegra_gart_probe,
> -	.driver =3D {
> -		.name	=3D "tegra-gart",
> -		.pm	=3D &tegra_gart_pm_ops,
> -		.of_match_table =3D tegra_gart_of_match,
> -		.suppress_bind_attrs =3D true,
> -	},
> -};
> -
> -static int __init tegra_gart_init(void)
> -{
> -	return platform_driver_register(&tegra_gart_driver);
> +	return ERR_PTR(ret);
>  }
> -subsys_initcall(tegra_gart_init);
> =20
>  module_param(gart_debug, bool, 0644);
>  MODULE_PARM_DESC(gart_debug, "Enable GART debugging");
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index 55ecfb2d8cfd..4cae1c3a853b 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -702,13 +702,54 @@ static int tegra_mc_probe(struct platform_device *p=
dev)
>  				PTR_ERR(mc->smmu));
>  	}
> =20
> +	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_GART)) {
> +		mc->gart =3D tegra_gart_probe(&pdev->dev, mc->soc->smmu, mc);
> +		if (IS_ERR(mc->gart))
> +			dev_err(&pdev->dev, "failed to probe GART: %ld\n",
> +				PTR_ERR(mc->gart));
> +	}

Perhaps if we add a check for for !mc->soc->smmu here we can avoid
passing this data structure to tegra_gart_probe() and remove the
corresponding check from tegra_gart_probe(). That seems more like a
more logical sequence than attempting to probe GART on device that may
not have one and return.

Also, since there's no error return here, do we want to set mc->gart to
NULL on error to avoid crashing later on...

> +
> +	return 0;
> +}
> +
> +static int tegra_mc_suspend(struct device *dev)
> +{
> +	struct tegra_mc *mc =3D dev_get_drvdata(dev);
> +	int err;
> +
> +	if (mc->gart) {

=2E.. like here?

> +		err =3D tegra_gart_suspend(mc->gart);
> +		if (err)
> +			return err;
> +	}
> +
>  	return 0;
>  }
> =20
> +static int tegra_mc_resume(struct device *dev)
> +{
> +	struct tegra_mc *mc =3D dev_get_drvdata(dev);
> +	int err;
> +
> +	if (mc->gart) {

And here?

> +		err =3D tegra_gart_resume(mc->gart);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops tegra_mc_pm_ops =3D {
> +	.suspend =3D tegra_mc_suspend,
> +	.resume =3D tegra_mc_resume,
> +};
> +
>  static struct platform_driver tegra_mc_driver =3D {
>  	.driver =3D {
>  		.name =3D "tegra-mc",
>  		.of_match_table =3D tegra_mc_of_match,
> +		.pm =3D &tegra_mc_pm_ops,
>  		.suppress_bind_attrs =3D true,
>  	},
>  	.prevent_deferred_probe =3D true,
> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
> index db5bfdf589b4..5da42e3fb801 100644
> --- a/include/soc/tegra/mc.h
> +++ b/include/soc/tegra/mc.h
> @@ -77,6 +77,7 @@ struct tegra_smmu_soc {
> =20
>  struct tegra_mc;
>  struct tegra_smmu;
> +struct gart_device;
> =20
>  #ifdef CONFIG_TEGRA_IOMMU_SMMU
>  struct tegra_smmu *tegra_smmu_probe(struct device *dev,
> @@ -96,6 +97,31 @@ static inline void tegra_smmu_remove(struct tegra_smmu=
 *smmu)
>  }
>  #endif
> =20
> +#ifdef CONFIG_TEGRA_IOMMU_GART
> +struct gart_device *tegra_gart_probe(struct device *dev,
> +				     const struct tegra_smmu_soc *soc,
> +				     struct tegra_mc *mc);
> +int tegra_gart_suspend(struct gart_device *gart);
> +int tegra_gart_resume(struct gart_device *gart);
> +#else
> +static inline struct gart_device *
> +tegra_gart_probe(struct device *dev, const struct tegra_smmu_soc *soc,
> +		 struct tegra_mc *mc)
> +{
> +	return NULL;
> +}
> +
> +static inline int tegra_gart_suspend(struct gart_device *gart)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int tegra_gart_resume(struct gart_device *gart)
> +{
> +	return -ENODEV;
> +}
> +#endif

That doesn't look right. If we don't enable GART, then the dummy
implementations will be used, but they return error codes, so
suspend/resume of MC will also fail, causing the whole system to
not be able to suspend if GART is disabled.

I think it'd be better to avoid the dummy functions and instead add
extra checks for IS_ENABLED(CONFIG_TEGRA_IOMMU_GART) where these are
called. That way references to these functions should be discarded
at translation time.

To be specific, tegra_mc_suspend() and tegra_mc_resume() would change
like this:

	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_GART) && mc->gart)

Thierry

--Do4IU1xF/9sod/r6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ324ACgkQ3SOs138+
s6Fk7xAAsQkWgAOy3a1e8km4a/1eMiv+ODQ/SxbNo9Owwn4+IXOYQVrSP85ooA/Z
fHAuNcOKgCGw/buzgv2CXzMBmQyHDr92OS1PSHWMpC0qtTOqlXTZIWiyizvk1lQ1
glkqDjBj3uInQWunUadUhyD3gsyjSNxDXbCrJ0YlOjrGKtekWGqqtVyLK7Rb9/qg
zvQNgTJf+tvy562WbWz3+OC6rxhE0iwnpwPibT89LpG6tYy9zEB4LIxieD1uhH6R
r+iN4ghp/uFq1a2kK8x46C/OBFnuy+TwvTMC0R4Rf56tKkAG1FyG72o3Q2UGQb6P
1NH3j+xvFyax0j834pYUp5GGy/T0w0M7dA3AYFWoMIQgpmUQxqRn8Lm1k7JZ6lHP
mJFCMhwdm33vb04W/XC+nRu6l3HHvcQscCqxS7VIw4Cj+3FpTPrY1jSAgsyE0MRw
dELYf9wVxj6ZfozyZAXRbwJit4S93ckrXRpMtDv9/n3ULZ66WO7IVuylWrd86rlx
FmsFoQ/1CL/HrrnzSED/dh5kNC5H1Upn6n+R6tZua70oHAhlh3LuD5gUyAK8aWB9
KMd5ZJ94t/fIn/FPPIyxgmZUGp6xL1ljvXQ47TFbfqiYAhnqd+NPDk2CJ2wwaEjj
UQaZiHNJt8JzZMLbwLCq3MySIRtaArTn7B9yZFrW8UyH+mzS3jI=
=aFQ1
-----END PGP SIGNATURE-----

--Do4IU1xF/9sod/r6--
