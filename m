Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD63ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3186A2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TltPAZ6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3186A2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbeIQT1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:27:38 -0400
Received: from ozlabs.org ([203.11.71.1]:56481 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbeIQT1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:27:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42DSS41C1Wz9sfR;
        Tue, 18 Sep 2018 00:00:04 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537192805;
        bh=dN8DA6qWj3DOHBoW9P1rRy4BtXV5+hXZuJkzYtNGGXM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TltPAZ6P0PzS+Gv4cbuZjscDKiUkFyFmy4R0KT0i/IlYEuh3inSVAo47vYEyWWVTC
         p/rzBdE4jwRG77RX8y8ZhvwPGUWJS4TsrHt2oLcPtKxYKjIxcDvQm8/wgJQ6lG2cWR
         SzlH30jRJtc99VkqdA9MHAj0eN7HxNoRqgmZ/3/KQ+EAeZU2MJ9e2SLnofN6NzrSBa
         xdOo+ij8hd4QPZABS1bpMiz8VzqckPzteE5l+n4nWAls2xB/kBnFBTDuJ6MbpURZQe
         zZzJ+Mj7LG2O4AEppfPLiik63e7pgdgYyBbzx7ckBWlIj8ViPGlp3DJ/LzqPYx0zmq
         WcHJ3X2n8aFTQ==
Date:   Tue, 18 Sep 2018 00:00:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        Ingo Molnar <mingo@elte.hu>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: changes in the maintainership of the percpu tree
Message-ID: <20180918000003.1ecd47b1@canb.auug.org.au>
In-Reply-To: <CAOS58YNVTVLzBhQSQBkQkh_Zr101L9_cjhPSK3iTQSScjjYFrg@mail.gmail.com>
References: <20180917210339.21ebb029@canb.auug.org.au>
        <CAOS58YNVTVLzBhQSQBkQkh_Zr101L9_cjhPSK3iTQSScjjYFrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7SfTbO3LG8=meyGLg=eapV="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7SfTbO3LG8=meyGLg=eapV=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dennis,

On Mon, 17 Sep 2018 07:53:29 -0400 Tejun Heo <tj@kernel.org> wrote:
>
> Ah, yeah, please switch the tree to Dennis's for-next branch instead of
> mine.
>=20
> Thanks.
>=20
> On Mon, Sep 17, 2018 at 7:03 AM Stephen Rothwell <sfr@canb.auug.org.au>
> wrote:
>=20
> > I noticed commit
> >
> >   1194c4154662 ("MAINTAINERS: Make Dennis the percpu tree maintainer")
> >
> > Just wondering if this means any changes to the tree/branch I should
> > fetch or the contacts I should use for the percpu tree in linux-next.

I have switched the percpu tree to be the for-next branch of

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git

and added you to the contacts for problems with that tree.

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

--Sig_/7SfTbO3LG8=meyGLg=eapV=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlufs2MACgkQAVBC80lX
0Gxzkgf+PnH3rZ5wPB9u1Q2xDyV1NGZLaXQza85B4hZyyWB1SeF+LS3CC0nj5dt4
6htgPJTOzIYsAwz4EBoOi0FI67m6wb6NXIuP1bhZ1lcmOtEiwCpktE5lhucO6Ju4
fYA00ys3L3V5acHkH/ZULbInx1+Vq6xmeXS6bYjSTLuQcrumtb5OKXCq4xalnZbx
p/vyclLMVlQop8Ow6mJjr+2uLpVJihMDyrF+CAIvP0vE6grf5LsDKPtrxn189MHT
GrkjRfnC33fmcsXx1sojzSrhdMmRIK6xOg1WP4g5REzcWE/i8ZsnUCi5ZB7jx8Bo
VZULNwlUkata8TkFISWtOXgMhIF3/w==
=hW0G
-----END PGP SIGNATURE-----

--Sig_/7SfTbO3LG8=meyGLg=eapV=--
