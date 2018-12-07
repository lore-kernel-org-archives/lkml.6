Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD49EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66498208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gnJd6Sla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66498208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbeLGClM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:41:12 -0500
Received: from ozlabs.org ([203.11.71.1]:51753 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGClM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 21:41:12 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439xYJ4TPcz9s8F;
        Fri,  7 Dec 2018 13:41:08 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544150468;
        bh=in799l+gwWSc81BCXQVEnX5dyVSowkohU7xYyUBmvaU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gnJd6SlauLMtY/oBYZC/IkIZp6VTURaEPyoleSWGHDYgJtYs8NegJAAfggM9yFssd
         e7x4ReW9WLFMvTiwnNrWU1+CneDyRnM7tIuxKS8qdS5OflB7TH2PyWVMleTZimdKTf
         BOwnlRQKFHhdRPx1bCfxQKcW6/YrnKZHKQ/hwshoyrjfWPifzThZdRPjjyT5wjYiL9
         LHt4W7gVcYvsamcSdAFnXfg38q8g7L6kn5uPVVvfZ36judrjIUb2SHUIUBmslUMCWc
         L+Z0flGTFGit+Y+2abT02GkjVtO5b7jx+/v5QmjkX4+gDMz1UFtLebQi/jpS0A4uyr
         Ibc3OgVaxw2dA==
Date:   Fri, 7 Dec 2018 13:41:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Guy Levi(SW)" <guyle@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
Message-ID: <20181207134108.0abc681a@canb.auug.org.au>
In-Reply-To: <20181204094256.GX6462@mtr-leonro.mtl.com>
References: <20181204114731.48b18bfc@canb.auug.org.au>
        <20181204015247.GR12288@mellanox.com>
        <20181204094256.GX6462@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gcP/NiGqojFUI51DhDFM8j0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gcP/NiGqojFUI51DhDFM8j0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 4 Dec 2018 09:42:59 +0000 Leon Romanovsky <leonro@mellanox.com> wro=
te:
>
> On Tue, Dec 04, 2018 at 01:52:54AM +0000, Jason Gunthorpe wrote:
> > On Tue, Dec 04, 2018 at 11:47:31AM +1100, Stephen Rothwell wrote: =20
> > >
> > > After merging the rdma tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > >
> > > ERROR: "mlx5_get_send_wqe" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] un=
defined!
> > >
> > > Caused by commit
> > >
> > >   34f4c9554d8b ("IB/mlx5: Use fragmented QP's buffer for in-kernel us=
ers")
> > >
> > > mlx5_get_send_wqe() is still used in drivers/infiniband/hw/mlx5/cq.c
> > > and declared in drivers/infiniband/hw/mlx5/mlx5_ib.h ...
> > >
> > > I have used the version of the rdma tree from next-20181203 for today=
. =20
> >
> > Huh. So apparently every compiler that tested this patch (0-day, mine,
> > the submitters) optimized this call away because is_atomic_response()
> > always returns 0: meaning mlx5_get_atomic_laddr is never callable and
> > can be deleted entirely, including the call to mlx5_get_send_wqe.
> >
> > Not sure what compiler setup will hit this, but it is clearly wrong
> > code..
> >
> > Guy/Leon, please send a fixup.. Maybe just delete all this
> > handle_atomics stuff? =20
>=20
> I deleted it and will wait for the results of regression prior to send th=
e patch.

I am still getting this error.

--=20
Cheers,
Stephen Rothwell

--Sig_/gcP/NiGqojFUI51DhDFM8j0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwJ3cQACgkQAVBC80lX
0GyItAf9FvphDCI5EvBs04a8UQkDV4gtTtTtrXDrKPrI92z34gRHAOlAtiCIRQXY
K6S85AYP95aN/ocOjR+DAb1tk9oOWAiMI3xUL/RFauxWF+q0yMXO0JhDyRMXsCPK
GOhrxGzKC1dl2WWuaNxapRg92W5Q4U2EXWXRepFT/ZJH+nmH0MESEGLjEzYDXSxt
485XWOLNESYR/9y6hxlWsmaCi9qit4e0bzrne8aLmyjHh+8sWJaLbVbSSLzdvqaS
15DienmVveQePTcpHazrw3U8aBTJ5+ABwYBBGjl0WnVutEyFHhdhMuitGElLchoZ
+emd3VHSObcBWNM0rNTU8ayZNjx/sQ==
=b4Ih
-----END PGP SIGNATURE-----

--Sig_/gcP/NiGqojFUI51DhDFM8j0--
