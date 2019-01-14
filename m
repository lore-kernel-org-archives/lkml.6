Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9DFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227572086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cs6vHpZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfANQJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:09:07 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6852 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfANQJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:09:06 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3cb4130000>; Mon, 14 Jan 2019 08:08:51 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 14 Jan 2019 08:09:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 14 Jan 2019 08:09:06 -0800
Received: from localhost (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 14 Jan
 2019 16:09:05 +0000
Date:   Mon, 14 Jan 2019 17:09:03 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Ben Skeggs <bskeggs@redhat.com>,
        Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] Revert "ARM: dma-mapping: Set proper DMA ops in
 arm_iommu_detach_device()"
Message-ID: <20190114160902.GB9218@ulmo>
References: <CGME20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594@eucas1p2.samsung.com>
 <20190114132240.12125-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
In-Reply-To: <20190114132240.12125-1-m.szyprowski@samsung.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547482131; bh=Hho0bexQ0Le6MfmPACNhTD5m6Tyma+N1LaqmRui0WM0=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=cs6vHpZiji7SXIcN2FueDybgSToz6R4hpwkbq6GSdkDhQzBeGK9qH8ROvIgEzf787
         X8J9FWUB6tctQOEc53b7T4nS7w/9pizSXMRhCaBn7jUsCbTCR9RmGzFssbYW1L3fZi
         5rTTMcX8yqHw7K5jxhXDlU2KpFKxrVzlcMRnGGenrntWm7dqS9mU8ZLWK5y8n1hlAE
         3yqxy4sE0BdQ5C7gEOQDjwlgyVCDgjmHtq9HInM7QMRO2RB/adKHzK2GyBunMtWLz/
         8g8xZDg5TJI+kzAIFQqnEpcJVvPj2jmPV3NqRONIjTq46dnsu4n0prFhIyF57gmSiB
         U4Ntgy5f2GzNA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 02:22:40PM +0100, Marek Szyprowski wrote:
> This reverts commit 1874619a7df4b14b23b14877e705ae15325773e3.
>=20
> That patch broke IOMMU support for devices, which fails to probe for the
> first time and use deferred probe approach. When non-NULL dma_ops is set
> in arm_iommu_detach_device(), the given device later ignored by
> arch_setup_dma_ops() and stays with non-IOMMU dma_ops.
>=20
> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_de=
tach_device()"
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/mm/dma-mapping.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Can you point out exactly what drivers break because of this change? We
need to find a solution that works for everyone. Reverting is only
marginally useful because somebody will just end up wanting to revert
the revert because a different driver is now broken.

Thierry

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw8tBsACgkQ3SOs138+
s6GvdA//W9RbyrwK0Z1YF6WLWPz/Vrii+8f8EHn/G8ZOdAmYNIJLbATdEhoF+3zo
Fr6+hdn1ZOtXfyMMTXz63/c47xpiJVqpCj09vIt5qv7Mixu4xA90obTA227xDvVE
7ta1T3DXzMskYiUgqSQUceJh2MIHLjpF4yFtoAvsn4y9Uji7CkcVbaoCmRVy3fGJ
rNGPBRSbbIR29Ox3fpECd+zf+9Ca4YhwD08+IuZ04vBO2JOnAh/gzephofRsYf/o
uqkxLdRux2c5tvzJIkuovYrbSYKNCuB/2GMy+mDVdUVpKpuOeI+XnryipeaGLX1W
wD+hXq7uJ63s6HEH7IkIb6s7TjZEhHmtYSA8vw5KWbGPj47t1Yr3P+aD4dZ5hOaU
w9EhRJW3WKUgWH5jioTtXU9npYXwDfJG3+TKe+XNB2fQ6gOhttoch+lMggtgNEzK
a85jKxcnXV7Xpo7UHz7KJGivug20QvAsYSipVjhn6CXBdIg6PEfOgOmAULhpX/O7
gQxUdeVhvW4N8WS4nkVMJ8Kudo8370WQ7gHW7kYSLE7ncksa17cbMegb3jq5dvax
9HygtnaTqdO8VlbdXghXU8C7X3z1eWeUJO2ZcedmsVPSRzJ4lfYxfK4ep/YsqS2q
fgCBQmOzZV6JNPJNUZzeVedrIArWbr6DejaXff4LjfO/Y94Q7rA=
=cziU
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
