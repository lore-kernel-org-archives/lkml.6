Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900CDC2F42E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA6B2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iYoirHZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbfAUPfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:35:46 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16064 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbfAUPeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:34:44 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c45e6710000>; Mon, 21 Jan 2019 07:34:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 21 Jan 2019 07:34:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 21 Jan 2019 07:34:43 -0800
Received: from localhost (10.124.1.5) by HQMAIL101.nvidia.com (172.20.187.10)
 with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 21 Jan 2019 15:34:42
 +0000
Date:   Mon, 21 Jan 2019 16:34:40 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <m.szyprowski@samsung.com>,
        <hch@lst.de>, <rmk+kernel@armlinux.org.uk>, <bskeggs@redhat.com>,
        <tjakobi@math.uni-bielefeld.de>, <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] ARM: dma-mapping: Clear DMA ops on teardown
Message-ID: <20190121153439.GA21078@ulmo>
References: <2f5833b7639543d614095cd3f5ab0dc0274e26d6.1548081277.git.robin.murphy@arm.com>
MIME-Version: 1.0
In-Reply-To: <2f5833b7639543d614095cd3f5ab0dc0274e26d6.1548081277.git.robin.murphy@arm.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548084849; bh=10LZ1mtxpIfqj+R9CVQkhdg+32AqVCTSZIVyHC9oUxM=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=iYoirHZ1CuEkXMqTPnnak45ZTCLsmEUxDlyYGhn1yGZ0qkxZCzc2EIGWEnDqNmlnI
         tXY+dzsLO769NT4XOfzo8Bx3097ShU5u1ti6kHD0qJQeJYUQV7iylcJF4qRH17+4Zw
         q2i+kRu0nbL7KpRZpGPNYWqFRRb4OjVErhhROB33df1i+h9IGbkXN26cHK76bOMDDk
         d+1MrtFG62YusvLz1ZWa0mocChM2j+RIAiCrwvYvhDuDZK9weoNUjukFj7jjzJHzX3
         fRS31qblheD6TqbKq0xXVuPswizofLV9bOYjYaoOg9Wlj0SoLYHFAhPLusoIs02TuA
         A6sVW8WxEGO5Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2019 at 02:52:16PM +0000, Robin Murphy wrote:
> Installing the appropriate non-IOMMU DMA ops in arm_iommu_detch_device()
> serves the case where IOMMU-aware drivers choose to control their own
> mapping but still make DMA API calls, however it also affects the case
> when the arch code itself tears down the mapping upon driver unbinding,
> where the ops now get left in place and can inhibit arch_setup_dma_ops()
> on subsequent re-probe attempts.
>=20
> Fix the latter case by making sure that arch_teardown_dma_ops() cleans
> up whenever the ops were automatically installed by its counterpart.
>=20
> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_de=
tach_device()"
> Tested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>=20
> Sorry for the delay - there was a giant email infrastructure cock-up just
> at the point I wanted to go back through my archive and double-check the
> discussion around the original commit...
>=20
> Robin.
>=20
>  arch/arm/mm/dma-mapping.c | 2 ++
>  1 file changed, 2 insertions(+)

I had also tested your draft on Tegra last week and this looks
identical, so:

Tested-by: Thierry Reding <treding@nvidia.com>

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxF5osACgkQ3SOs138+
s6Hu1w/+PREMHDE0jWgKBN3n9eINXN6aliHOhCeWQxco5/iJjCSeCofcMvFzuKx2
p8nZ8OfIMZvj4AatYeryqn7bPLSQiRfwVtC8qOfERTv7z+8m4F+o4rPSKmr0/1qI
rSqpTFY4exsTlp7Lp7DHsg2sbd0Av6UvgiNJSLpTLai0loCYfPuF+lvbdlw/x6wC
CNa6SBE+rI/u+QRNY1jRPkgEMovOnsvkKY4bf7+v3elI3X7bZhObqyNLnTLkNpYL
w01hvCpxpo4vrX12kTDzuhOxxnKF1md/QrlviZWl/K6CI5L/UqlP1ttSj3p5INna
nGQ4Zjr+ykq1enUBHlLwkfVGD7mV//BaVxvIyMtKtWewJ3YoQbPhrcWCAg1pqjJ7
C9ksb5Njf7vOyF5KPGdcyePUIVw7NaIytAQrRE3ww7iuZg78fBs7oxjdzyK4D6G5
+2DcaumIx18jwD44wP8g6z0foo1GgN6IitWoAcH/UhVX9ID/eMl5KNxHogW1N2bW
GJDagpZCD09vxmKBcYFctXGbL3RoLKS4+mVu93vjPNhRs813nXAPMC5E+NZcI6vZ
l7CYkq3/V6af54QGr7/0K87mIT6dIjkOCVYNjH4ZHPLjJolBZ8iS5636DyDoldk0
SlUgLWwfZ80fcqNh19syiJRaVIpW2CahirFJilXtoFd2cvDOLPM=
=LcGP
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
