Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95293C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A0420675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LZ81sli+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbfAOP3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:29:17 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9490 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfAOP3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:29:17 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3dfc2e0000>; Tue, 15 Jan 2019 07:28:46 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Jan 2019 07:29:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 15 Jan 2019 07:29:15 -0800
Received: from localhost (10.124.1.5) by HQMAIL101.nvidia.com (172.20.187.10)
 with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 15 Jan 2019 15:29:14
 +0000
Date:   Tue, 15 Jan 2019 16:29:11 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Ben Skeggs <bskeggs@redhat.com>,
        Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] Revert "ARM: dma-mapping: Set proper DMA ops in
 arm_iommu_detach_device()"
Message-ID: <20190115152910.GA12652@ulmo>
References: <CGME20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594@eucas1p2.samsung.com>
 <20190114132240.12125-1-m.szyprowski@samsung.com>
 <20190114160902.GB9218@ulmo>
 <4f7fd8db-33e4-9c8d-2fee-1ca9c98a9276@arm.com>
MIME-Version: 1.0
In-Reply-To: <4f7fd8db-33e4-9c8d-2fee-1ca9c98a9276@arm.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547566126; bh=GivISyv5wDifw3bU4wrS5ZESZcrE9h8tpoH0rPhfzoc=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=LZ81sli+r63/kTW0onfgk4XLvffHXKSNK4kV1cG1nz28HRMSyaJMkLvTPYl0/18HB
         GKXfLQnMh9kNnMNjvxbqgeaQ6jvhCnVT77nwJyVuaag2bvasnYSHy+4brc1Xtu5hEq
         RJzm0uVd2Bk9d4sN/Q7vxewVoA4s9s3+/yVZFe6Yq5vz4AxSmtD5COtz6WJ/5+Rd7y
         Q8MPlHlgTdX4sa5c/eJopQBOtjJlIHeCQcflSU+eQv8N7FzuxhqACIV+tXP1bNUhsh
         eeRvvyKG1TG9TbTSWFK54JxBWtZKf+BWQncRd2QCq4lEpNbGzsnze0OUQx3Xn3AYIm
         PT/RWtPYq2AuA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 04:38:20PM +0000, Robin Murphy wrote:
> On 14/01/2019 16:09, Thierry Reding wrote:
> > On Mon, Jan 14, 2019 at 02:22:40PM +0100, Marek Szyprowski wrote:
> > > This reverts commit 1874619a7df4b14b23b14877e705ae15325773e3.
> > >=20
> > > That patch broke IOMMU support for devices, which fails to probe for =
the
> > > first time and use deferred probe approach. When non-NULL dma_ops is =
set
> > > in arm_iommu_detach_device(), the given device later ignored by
> > > arch_setup_dma_ops() and stays with non-IOMMU dma_ops.
> > >=20
> > > Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> > > Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iomm=
u_detach_device()"
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > ---
> > >   arch/arm/mm/dma-mapping.c | 12 ++++++------
> > >   1 file changed, 6 insertions(+), 6 deletions(-)
> >=20
> > Can you point out exactly what drivers break because of this change? We
> > need to find a solution that works for everyone. Reverting is only
> > marginally useful because somebody will just end up wanting to revert
> > the revert because a different driver is now broken.
>=20
> At first glance, it sounds like what we really want is for
> arch_teardown_iommu_ops() to completely clear any ops that
> arch_setup_dma_ops() installed - does the below suffice?
>=20
> Robin.
>=20
> ----->8-----
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index f1e2922e447c..1e3e08a1c456 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2390,4 +2390,6 @@ void arch_teardown_dma_ops(struct device *dev)
>  		return;
>=20
>  	arm_teardown_iommu_dma_ops(dev);
> +	/* Let arch_setup_dma_ops() start again from scratch upon re-probe */
> +	set_dma_ops(dev, NULL);
>  }

Seems to work fine on Tegra:

Tested-by: Thierry Reding <treding@nvidia.com>

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw9/EIACgkQ3SOs138+
s6FxyQ//ZXUg6+LaxF3qtCgUCjlJAxBQEY573IAkyXQRnqOtvp01En0lJhfI5fRy
oPY84NIYecY/Okx9GKAnsOSZ3/qDKN+XwHiwEnIF8Jwom8zDholM7xxHdQQDBxCE
QW9pHFDVVxNlm2tI1S//+Rrb/V8mSbxt/4Ufn9pOwh9ZEghQgyAVzXM8O0WYr+lu
ddkl/u50sBNO3VfJPTUP4gJFMus1RuYV35U37hqdgZNK9Scy8aB2ocpk0phA5LK1
7kX/jrFSkCw9mvGgnBH1Lqfwxl4ts6c+MWSz8A7tNFOhFystJLi7qQOkYHujU1on
yAFaC7Mq8VuUdigXsQ3pyTxBLQFAm/ifV1ut44VXnZU3OIuSCJHPHoVL9FnO3237
bqQBvA8LxO9mWsP9GFaHs38TaMkD1hoLispjSeZbRNa+EvI8xRBsqOBIW5mvXE8p
p125mj1mNIKdzOtmh2x1tFrorXMT6JgpD4AkDyj8450dpKeT73CELCntYkvdBzyh
pV8XidIaT1ilF5s2UOYzY8od4QeH1RyMIPiqCZHQQzqnx5U+u7KBeyCBi4osqtCj
pDwGeMuz6IxnPdKJRnfVIgOpq1YTelR/SknqK5mEI8vJGqHKDLsLWZRN0+kPB1dh
u9abmsyph4ctT+vL1gy8xh0moEBIBix0C7rodaP2MzxfrymikjM=
=hfU3
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
