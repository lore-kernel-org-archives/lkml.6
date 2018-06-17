Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E90C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 22:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B4D20891
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 22:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tdIIlJ+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B4D20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbeFQWIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 18:08:21 -0400
Received: from ozlabs.org ([203.11.71.1]:57665 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752906AbeFQWIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 18:08:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4187dp3M63z9s3M;
        Mon, 18 Jun 2018 08:08:14 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529273296;
        bh=a/88qDRzPlH3z5yh4U9E+Ga6qv8pGep/JN5DEiCZx4c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tdIIlJ+Cl3Gonrvys2BWmjcbK8lo/O/Xg09LhiUjTQSoQhs9/HLfcLHAn59iDicWu
         5CmKX4PCQjA3hldDMUG+KMgWlyOqcp9waVoA0NWHld0Ploi6N7DLyVS1oGxSmEgWcv
         06b4YBBo+3geffWXmJ9Ep4P/fdeShLSv3j4x/SGFLFbDTfNx2wgxup3tjoHvnH8k0w
         c+iQLCA/tJOQ3VQxcHSgrSGX9zW7cKF4wcqpJSE+XergAf61XUY1saplb/Evv9M2Co
         m71T1Pk5ANkkfAOBogFDRnDayKPkg7XLIlTOyZKa+5NzzCjUHjlPFflw1Sf440T/I6
         3faO6CwiwnDxQ==
Date:   Mon, 18 Jun 2018 08:07:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-netdev <netdev@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: linux-next: Please add mlx5-next tree
Message-ID: <20180618080759.528b3525@canb.auug.org.au>
In-Reply-To: <20180617185253.GA7393@mtr-leonro.mtl.com>
References: <20180606192500.GZ2958@mtr-leonro.mtl.com>
        <20180608074726.5b3883e2@canb.auug.org.au>
        <20180610054128.GG12407@mtr-leonro.mtl.com>
        <20180617185253.GA7393@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=X4x6njnBngG4eYYIfSgoe3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=X4x6njnBngG4eYYIfSgoe3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Leon,

On Sun, 17 Jun 2018 21:52:53 +0300 Leon Romanovsky <leon@kernel.org> wrote:
>
> On Sun, Jun 10, 2018 at 08:41:28AM +0300, Leon Romanovsky wrote:
> > On Fri, Jun 08, 2018 at 07:47:26AM +1000, Stephen Rothwell wrote: =20
> > > Hi Leon,
> > >
> > > On Wed, 6 Jun 2018 22:25:00 +0300 Leon Romanovsky <leon@kernel.org> w=
rote: =20
> > > >
> > > > Can you please add the branch "mlx5-next" from the following tree t=
o the
> > > > linux-next integration tree?
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/
> > > >
> > > > The mlx5-next branch is used to send shared pull requests to both n=
etdev
> > > > and RDMA subsystems and it is worth to have linux-next coverage on =
it
> > > > before. =20
> > >
> > > I try hard not to add new trees during the merge window, sorry.  If I
> > > forget to add it after -rc1 has been released, please remind me. =20
> >
> > Thanks Stephen, I'll do.
> > =20
>=20
> This is reminder.

I have added it from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/=X4x6njnBngG4eYYIfSgoe3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsm278ACgkQAVBC80lX
0Gyw0Af/UZjyXvpBi7/6D62OuQIPHTSdlekvGZQwu4cKo/EyfNXewR5gqF/aNZje
K2PAFwVUbvY7+xoJjfGJ3JI7iFvRPZCCRd59JKObY7OUYn+YMrli04S243fu0JtJ
tBOkxDiSbOImhUlTkKupWVOm4cqvBBDG5lLpFS+kb3nD3sALxC9s8kTCaO+/v9my
OSGyrycbM6xfCyhsniE2wRmOhgj2d3AvnAobLUbnl2aJQ7j3IKRWaJfmzHWRZwCq
KQ4H4E3psbUjpdJ7LcncXwdLlo+M+axHjmJTQnqiQm+OHRArjW8K3GhP7q5Yj3FK
HOd5bB5vVL+5BkUcLkqBrDjSIhLAUA==
=cUHO
-----END PGP SIGNATURE-----

--Sig_/=X4x6njnBngG4eYYIfSgoe3--
