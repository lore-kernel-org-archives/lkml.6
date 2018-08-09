Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A16C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A776C215A5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHSAZIWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A776C215A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbeHINmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:42:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37143 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730532AbeHINmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:42:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so4812318wrr.4;
        Thu, 09 Aug 2018 04:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=48uZkPK4Clwe2vitVoCcZ/Zmog4k2d7AfYyAyQ2Bpzk=;
        b=PHSAZIWXsd94jIVTytOxFge5s251RmFeW11tUy7dUPhqlPEBDgFlmM+Ebroplr8O+o
         AD3hcNSDZzwvmlRosxomo/VG9TIFW22F5qhhSpg3rAhuPAaXGr7CftdRmzAOVg7RWoK2
         N1yyB9MTM/iUQeeEWF6yHVyYVtWqiyEdll0ye1VeFeNjBgiZOE3Xz6I9cEPoOV9Edjrj
         E6CWtfl7do/6Q/+AUq5Prq22C6DuOc+myo6+90oM1JdQh9sOZ4qN0VmRb9/2dSirQvHN
         JWGB3fbxMC1Il9RjhiUw8hhahmFRKR19Ha6hAvZkHDgaGnvHwjB5wvRPTNoGebwVhTxa
         bYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=48uZkPK4Clwe2vitVoCcZ/Zmog4k2d7AfYyAyQ2Bpzk=;
        b=HaknMbWbUC49z5JtQ0XOPCgo+DbGlc4u4k++CFGsZ6ySdFav06M4USXNGpcnQ5xaWh
         hHEMP8HgM8qB3CboCEj6Dl8d/9oqkuIB19kO28MxV15sCQzmM89bZW9XMKwkO901VST6
         7JCjjBxI3D5V9lEnqJOutvW4qOjIO8JrSoYWre97V+CsN/SWVjY2pFQ/tJgZHeZaklKY
         1ZqXcpM/pCQ5krIRu7w6yBUP0febhpv/VKKtPaJHpbC2BubFsR2X2IqWSwx/VzR8XM4s
         JMcxxzkzjAeBJLDnfEtDEdDfySfeQKjw0FmeL+JBrN31RqK/aQVkxxBYknyWuOscOgSp
         qKyg==
X-Gm-Message-State: AOUpUlH0xgxvwSYJdwznNAQm8dlOWLW18GPG9qYSfXZiRAaxhQaojH5C
        rfdHoVwZZFNSAQoNxxHmTsM=
X-Google-Smtp-Source: AA+uWPyRYuUTPsHcGq0dPvtSz1k9xFkhM6IEyH2xx7JD8IwftOH0sQbedi004IjC2gEbWjl/548TWg==
X-Received: by 2002:adf:e9c1:: with SMTP id l1-v6mr1164030wrn.14.1533813468717;
        Thu, 09 Aug 2018 04:17:48 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id 8-v6sm14900782wmw.34.2018.08.09.04.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 04:17:47 -0700 (PDT)
Date:   Thu, 9 Aug 2018 13:17:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] iommu/tegra: gart: Provide access to Memory
 Controller driver
Message-ID: <20180809111746.GG21639@ulmo>
References: <20180804143003.15817-1-digetx@gmail.com>
 <20180804143003.15817-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Content-Disposition: inline
In-Reply-To: <20180804143003.15817-3-digetx@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 04, 2018 at 05:29:57PM +0300, Dmitry Osipenko wrote:
> GART contain registers needed by the Memory Controller driver, provide
> access to the MC driver by utilizing its GART-integration facility.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index a004f6da35f2..f8b653e25914 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -31,6 +31,8 @@
>  #include <linux/iommu.h>
>  #include <linux/of.h>
> =20
> +#include <soc/tegra/mc.h>
> +
>  #include <asm/cacheflush.h>
> =20
>  /* bitmap of the page sizes currently supported */
> @@ -41,6 +43,8 @@
>  #define GART_ENTRY_ADDR		(0x28 - GART_REG_BASE)
>  #define GART_ENTRY_DATA		(0x2c - GART_REG_BASE)
>  #define GART_ENTRY_PHYS_ADDR_VALID	(1 << 31)
> +#define GART_ERROR_REQ		(0x30 - GART_REG_BASE)
> +#define GART_ERROR_ADDR		(0x34 - GART_REG_BASE)
> =20
>  #define GART_PAGE_SHIFT		12
>  #define GART_PAGE_SIZE		(1 << GART_PAGE_SHIFT)
> @@ -63,6 +67,8 @@ struct gart_device {
>  	struct device		*dev;
> =20
>  	struct iommu_device	iommu;		/* IOMMU Core handle */
> +
> +	struct tegra_mc_gart_handle mc_gart_handle;
>  };
> =20
>  struct gart_domain {
> @@ -408,6 +414,20 @@ static int tegra_gart_resume(struct device *dev)
>  	return 0;
>  }
> =20
> +static u32 tegra_gart_error_addr(struct tegra_mc_gart_handle *handle)
> +{
> +	struct gart_device *gart =3D container_of(handle, struct gart_device,
> +						mc_gart_handle);
> +	return readl_relaxed(gart->regs + GART_ERROR_ADDR);
> +}
> +
> +static u32 tegra_gart_error_req(struct tegra_mc_gart_handle *handle)
> +{
> +	struct gart_device *gart =3D container_of(handle, struct gart_device,
> +						mc_gart_handle);
> +	return readl_relaxed(gart->regs + GART_ERROR_REQ);
> +}
> +
>  static int tegra_gart_probe(struct platform_device *pdev)
>  {
>  	struct gart_device *gart;
> @@ -464,6 +484,8 @@ static int tegra_gart_probe(struct platform_device *p=
dev)
>  	gart->regs =3D gart_regs;
>  	gart->iovmm_base =3D (dma_addr_t)res_remap->start;
>  	gart->page_count =3D (resource_size(res_remap) >> GART_PAGE_SHIFT);
> +	gart->mc_gart_handle.error_addr =3D tegra_gart_error_addr;
> +	gart->mc_gart_handle.error_req =3D tegra_gart_error_req;
> =20
>  	gart->savedata =3D vmalloc(array_size(sizeof(u32), gart->page_count));
>  	if (!gart->savedata) {
> @@ -475,6 +497,7 @@ static int tegra_gart_probe(struct platform_device *p=
dev)
>  	do_gart_setup(gart, NULL);
> =20
>  	gart_handle =3D gart;
> +	tegra_mc_register_gart(&gart->mc_gart_handle);
> =20
>  	return 0;
>  }

I see now why you've did it this way. We have separate devices unlike
with SMMU where it is properly modeled as part of the memory controller.
I think we should consider breaking ABI at this point and properly merge
both the memory controller and GART nodes. There's really no reason why
they should be separate and we're jumping through multiple hoops to do
what we need to do just because a few years back we made a mistake.

I know we're technically not supposed to break the DT ABI, but I think
in this particular case we can make a good case for it. The current DT
bindings are plainly broken, and obviously so. Also, we don't currently
use the GART upstream for anything, so we can't break any existing
systems either.

Thierry

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsItoACgkQ3SOs138+
s6HZlw/7BZMnc6smROHoV6LzKfkC1MQe+wBkDlSsOSENtduUUu5dN4qhZbqmpVST
N1FeQNRuW9UdhZT6gMZ93wCW8NdbF5HmSzYCX89+DBhcpxj61fIPPs1cBVcNFL7G
RNR4Zz/+DO6tThfKrYumIGq7vg3Qu89gzGVL407luzziNMthV8fdWv233rMqxU2P
3fK5ljv52zdqmh2Ayyb9WYF6wR//DzvVDJggHl4NcxRic0e9gxN9IUMVaUiE970n
xxRLhO/rNlMyacOf4YklFhZhovseG2vfd14Qmqci4lLKY68XSTZcZCImKyEAnwxN
T28ddTi7dyo1XuDkE7/E/zec4rABfk24gEe8q79OW5Wc3VhwzzFIIRbJ99pIWu+4
fuk7H4rn2VrDLIttR8mFo5arwztHHBrP80rPop3Jd6oDFVlKWHRwHZw+KyJC6Sar
pS4lHd+iipT+Fiz89NLcuplvwWvtHDIt6aCWmRyMwFaRKziu+2bn4xGh0vUNJQM5
wmyNB00ZDsZFTxFDv1a77nUrJmsxF7nFTteWVTcCEto+0uniGhbEnar+IDn1f0qf
rhMhGYib3LEm74MAG7gOJ8uH4uHU7liKwSrxbnB0DEMAyNQDrDOm2xfbwC16RiPq
VSd3WTnC0/sqGqdDlV2h10iVuaSbcfeJ4mgsLP0WCgzsGgXv+7M=
=s4am
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--
