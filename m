Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeCMRTz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751523AbeCMRTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:19:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71D1205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Tue, 13 Mar 2018 17:19:28 +0000
From: James Hogan <jhogan@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org, david.daney@cavium.com,
        paul.burton@mips.com, Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Doug Ledford <dledford@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] MIPS: Update dma-coherence.h files
Message-ID: <20180313171927.GH21642@saruman>
References: <1516758010-7641-1-git-send-email-f.fainelli@gmail.com>
 <1516758010-7641-3-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFBW6CQlri5Qm8JQ"
Content-Disposition: inline
In-Reply-To: <1516758010-7641-3-git-send-email-f.fainelli@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFBW6CQlri5Qm8JQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Jan 23, 2018 at 05:40:10PM -0800, Florian Fainelli wrote:
> diff --git a/arch/mips/include/asm/mach-ath25/dma-coherence.h b/arch/mips/include/asm/mach-ath25/dma-coherence.h
> index d5defdde32db..63bce15fa54d 100644
> --- a/arch/mips/include/asm/mach-ath25/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-ath25/dma-coherence.h

> +#define plat_unmap_dma_mem	plat_unmap_dma_mem
>  static inline void
>  plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr, size_t size,
>  		   enum dma_data_direction direction)
>  {
>  }

This could presumably be removed too.

> diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
> index 9110988b92a1..165e13aba3ff 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h

> +#define phys_to_dma	phys_to_dma
>  dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
> +#define dma_to_phys	dma_to_phys
>  phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);

I suppose these #defines can be dropped since commit ea8c64ace866
("dma-mapping: move swiotlb arch helpers to a new header").

> diff --git a/arch/mips/include/asm/mach-loongson64/dma-coherence.h b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
> index 1602a9e9e8c2..0a9bbc4c1449 100644
> --- a/arch/mips/include/asm/mach-loongson64/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-loongson64/dma-coherence.h

> +#define phys_to_dma	phys_to_dma
>  extern dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
> +#define dma_to_phys	dma_to_phys
>  extern phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);

same here

> +#define plat_dma_supported	plat_dma_supported
>  static inline int plat_dma_supported(struct device *dev, u64 mask)
>  {
>  	/*
> @@ -69,6 +70,7 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
>  	return 1;
>  }

That can be removed too, no?

Cheers
James

--nFBW6CQlri5Qm8JQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqoCBoACgkQbAtpk944
dnquCRAAlu6XQSUMxkcAhSlf2aUyMkX+OGAvymFtCDCLFPlgx1+Rf4wCGmg/jzPB
SwWOAOG5BGohSwQE8ydW0uA6X4yegRIuqag4byGOwdOs6mqqnLYUu3eAzZN/5aVc
YFinonmpK0dZ4jlSPaOwfrngvVOlv5On9UMd4h8q5TFViWCcDjl4wfffxudY07tO
fHYVr05gFUthZ80Rpu466z/BO8Lk/Sbs+E0LMZJY7JihpoTqfnbYVwMuHVp1qJ3a
k2UsWIug3EyYwlTFMjap3Khq7m8MzYoSzj6B/0Y+1E2ZQTe5VNrxneQ+TJSPYVn0
H84YeXL7C3d3g/K31jQ984WMiZnQDaiOy91nvVVw+dVAvpJjMRhZfPWanaEEMWrY
0Fw64u/UOSg/lch/1FEy/hnB2Ig9ZTrOx7O48U47QJNAUiPGuqdzj1OCUpewOeXB
/nzl5mOzSaLuPyNQr9rCSkj9xVIjJURkaWFeowYIjfOzKcA7pGM7jqk/OU0+ybur
SaHB8TW3kM7www/WWvO78Hkel/LHOKPZcogC9XLddi7jhxjYZkdIoYSmw6nk6W8l
Vj06Td6PHJtukzpxyng9hBJyNAnqlcMhxmUj/ro/xwznVCY9CuHmr4zwLOLtYwc5
cnW1P44A5vjJiZtH536cWfUG1oNeInG5GH3UAwZdNVNabjWzh/A=
=Xkh4
-----END PGP SIGNATURE-----

--nFBW6CQlri5Qm8JQ--
