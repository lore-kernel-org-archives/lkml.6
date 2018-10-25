Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816D9ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1B22083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tptmgEFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1B22083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeJYXnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:43:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33088 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbeJYXnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:43:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id u1-v6so9732434wrn.0;
        Thu, 25 Oct 2018 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KBLAORvlQUlnxGbFI7TytMCxXSU9OfvyczHDqWlANHM=;
        b=tptmgEFrhviq7P42HYTPSG+bFKknbos1g43MAC6hZw0LR3F8uE2kumAR7KRLU3gOv2
         K8tO4ilhYuk+yNX/UUDoo88NfNXU3VDDwxUkuDTMyUoxdspheKz8/aVO0lkw9JyEkDR1
         Pe213bz3qLygyvaOOiLzwFQY0J6Hzb1y6ieO9e6bIe6jCVob/SvrNdPpa7yATqCU5BVL
         N6DJ8jOTtRPiaaV3tk30Zz5IwNtVIvLWSs773sUl/0EuSf7+BY/CaopYtqSxP1M55g03
         LgbhHFWXDKSyLVY+Sm73y1iaN32r03S8wfss967RECwVmdPBtVjipasuHIpeIrxPPItY
         rnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KBLAORvlQUlnxGbFI7TytMCxXSU9OfvyczHDqWlANHM=;
        b=i+aFM6H2NrNOEEU70mPPOyhrLHW5VgYQ/CYUQuKAwJ5u+nAmXoiTtdcEhjWt+8XbBk
         u3WxK15OkKFkmslvN+bvoQV7gd6cd0eJEyyz3B2h3CHtr9LLGrkUqNGFiPQ3lEAx75RS
         bPv6Qm/FpZE6Sx6p6ykntfWfgtgky8LTPETGDMk62RUySZJerMenfwl3/nZwEnHL6eNU
         n+Lig3cfqdZ6amt+RfTZs9K1hRI3wsHKe4lyT3RkxcGv2j40rHTDgyywBFNL9qbQgyw5
         Mbu4noJ7zUIl0FaOB/kjvE3ErZrUvdqNL+j5STlg2bkTwDBhUgmoVMljSEK4dnXg5jRe
         WDjw==
X-Gm-Message-State: AGRZ1gIEQY6CN+CM2VBgkn++idHc6ijGu3k+Ci4pZO0+csVp0G10zOZX
        qVgTZ7MOCcNkNGUw6xIkokc=
X-Google-Smtp-Source: AJdET5cJc/qJ4FcP64zCoks50/V79sePhZnQd1P+A67sabSuneZzbRdVnilIDtvFFhzfaol9NL0uwQ==
X-Received: by 2002:adf:b245:: with SMTP id y5-v6mr1822305wra.90.1540480189983;
        Thu, 25 Oct 2018 08:09:49 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id u191-v6sm1718684wmd.31.2018.10.25.08.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 08:09:48 -0700 (PDT)
Date:   Thu, 25 Oct 2018 17:09:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com, yhsu@nvidia.com,
        snikam@nvidia.com, praithatha@nvidia.com, talho@nvidia.com,
        avanbrunt@nvidia.com
Subject: Re: [PATCH 3/3] iommu/tegra194_smmu: Add Tegra194 SMMU driver
Message-ID: <20181025150947.GN21521@ulmo>
References: <1540334347-7178-1-git-send-email-vdumpa@nvidia.com>
 <1540334347-7178-4-git-send-email-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tpyx7gKuSYt+mjHM"
Content-Disposition: inline
In-Reply-To: <1540334347-7178-4-git-send-email-vdumpa@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tpyx7gKuSYt+mjHM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2018 at 03:39:07PM -0700, Krishna Reddy wrote:
> Tegra194 SMMU driver supports Dual ARM SMMU configuration
> supported in Tegra194 SOC.
> The IOVA accesses from HW devices are interleaved across two
> ARM SMMU devices.
>=20
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  drivers/iommu/Makefile        |   1 +
>  drivers/iommu/tegra194-smmu.c | 201 ++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 202 insertions(+)
>  create mode 100644 drivers/iommu/tegra194-smmu.c
>=20
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index a158a68..84da9f9 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_OMAP_IOMMU_DEBUG) +=3D omap-iommu-debug.o
>  obj-$(CONFIG_ROCKCHIP_IOMMU) +=3D rockchip-iommu.o
>  obj-$(CONFIG_TEGRA_IOMMU_GART) +=3D tegra-gart.o
>  obj-$(CONFIG_TEGRA_IOMMU_SMMU) +=3D tegra-smmu.o
> +obj-$(CONFIG_TEGRA_IOMMU_SMMU) +=3D tegra194-smmu.o
>  obj-$(CONFIG_EXYNOS_IOMMU) +=3D exynos-iommu.o
>  obj-$(CONFIG_FSL_PAMU) +=3D fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) +=3D s390-iommu.o

I think we'll need a new Kconfig option for this. This is completely
different from the old Tegra SMMU, and as it is, it will build the
Tegra194 SMMU driver all the way back to Tegra30 where no such thing
exists.

Also, as the 0-day builder already reported there are dependencies that
aren't properly modelled and make the build fail under some
configurations. I think we'll want something like this:

	config ARM_SMMU_TEGRA
		depends on ARM64 && MMU && ARCH_TEGRA
		select IOMMU_API
		select IOMMU_IO_PGTABLE_LPAE
		help
			...

That should pull in the dependency as necessary.

It might also be worth considering to move the Kconfig and Makefile
entries closer to the ARM SMMU entries to clarify that they're related.

> diff --git a/drivers/iommu/tegra194-smmu.c b/drivers/iommu/tegra194-smmu.c
> new file mode 100644
> index 0000000..02109c8
> --- /dev/null
> +++ b/drivers/iommu/tegra194-smmu.c
> @@ -0,0 +1,201 @@
> +/*
> + * IOMMU API for Tegra194 Dual ARM SMMU implementation.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Copyright (C) 2018 Nvidia Corporation
> + *
> + * Author: Krishna Reddy <vdumpa@nvidia.com>
> + */
> +
> +#define pr_fmt(fmt) "tegra194-smmu: " fmt
> +
> +#include "arm-smmu-common.h"
> +
> +/* Tegra194 has three SMMU instances.
> + * Two of the SMMU instances are used by specific set of devices to
> + * access IOVA addresses in interleaved fashion.
> + * The 3rd SMMU instance is used alone by specific set of devices.
> + * This driver only support Dual SMMU configuration which interleaves
> + * IOVA accesses across two SMMU's.
> + * For the 3rd SMMU instance, Default ARM SMMU driver is used.
> + */
> +#define NUM_SMMU_INSTANCES 2

Can we parameterize this at runtime? I suspect that this is something
that could show up in a future chip as well but with a different number
of instances. If we parameterize that, supporting the next generation
may be almost automatic.

That said, it's probably fine to do that in a follow-up if indeed some
future chip requires it.

> +
> +struct tegra194_smmu {
> +	void __iomem			*bases[NUM_SMMU_INSTANCES];
> +	struct arm_smmu_device		*smmu;
> +};
> +
> +static struct tegra194_smmu t194_smmu;

Why the global variable here? It seems to me like the only reason for
its existence is to prevent multiple instances of the dual SMMU. I don't
think that's something we need to worry about. We should expect the DT
to contain the correct number of SMMU instances.

> +
> +static inline void writel_one(u32 val, volatile void __iomem *virt_addr)
> +{
> +	writel(val, virt_addr);
> +}
> +
> +static inline void writel_relaxed_one(u32 val,
> +			volatile void __iomem *virt_addr)
> +{
> +	writel_relaxed(val, virt_addr);
> +}
> +
> +#define WRITEL_FN(fn, call, type) \
> +static inline void fn(type val, volatile void __iomem *virt_addr) \
> +{ \
> +	int i; \
> +	u32 offset =3D abs(virt_addr - t194_smmu.bases[0]); \
> +	for (i =3D 0; i < NUM_SMMU_INSTANCES; i++) \
> +		call(val, t194_smmu.bases[i] + offset); \
> +}

Ah... the global variable is also used here. The fact that we need this
strange construct here indicates to me that this isn't properly factored
out into library code yet.

Thierry

--tpyx7gKuSYt+mjHM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvR3LkACgkQ3SOs138+
s6GXIw/+MYW/FNhjYquJSelnNEPbg7tLquxWBrCU5ixwd3MWYrRvS7tFpQstYtQg
lF0CUHFrnH2bv3uNVGm0TXncfc+g9EgjzLby+JH+yxV39N8aG7rLVMPNfz8XsPsO
v4slFAmp988RNHkTEgXQ0RmmzZHooSJ+RhdfsZ12qQBoEuKFmprRYKi3IP/mt/Qy
UwbiHyHR79YwPTsrHcRjbCp9t3GnSrV8ecanJp+cvQYoPWocKakm0UJVNFri1lap
0BWXsTpsUAVbR6eyG7KytEPfHM0I0Bc6Hc9CKqOd4GmQk3ksc80k7+tpEHWPpDmx
QQMM8x+R6HFBQfe8q/kmxYqz4+eGW1P2/mmhMSpsFqFV1sxNxArR9j4rqedEjOZu
+703bo4x34xZ7FAkMQwgia3wCdLJW/uiD+puSSMcNPhtdo2JJ8MT5dURzDnud40a
3mQ6aMhQn3wcvul6ZpYgz5oHIzAE41ebWAYREb5Jksfgj2H2w2Zkff3eh52TXaqn
U+SayV/SoofejHlo9xcwzF0NDwUp6XCBkOSIjdDxEsXUxjl8LSeanXhjSSitfj0B
XiLDfTTpLXauhcvDgKhFzjuAkO73E2RfC21d1iQ7babBF2yga57sV8Ot4EYk7jlV
164NqQhRx1bkTICORIGIY4Wcd++NdhXqbo52IHYADdkTo4smi9Q=
=QUXy
-----END PGP SIGNATURE-----

--tpyx7gKuSYt+mjHM--
