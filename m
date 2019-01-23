Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CB3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC54217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eP/MLqRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfAWMJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:09:46 -0500
Received: from ozlabs.org ([203.11.71.1]:34005 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfAWMJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:09:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43l3xg1x8Lz9s9h;
        Wed, 23 Jan 2019 23:09:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548245383;
        bh=2bv4b6RAdyZ+UGJDqVwfTCjY2ENt0anszj1bNhynj5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eP/MLqRZYIArrVYNruP2QBUKoGaqRxLkPHYXQJ3PblLhICFgHhpYkLnDFdm5qQkjj
         SmYvqUvMO9EcMUKwdqFBzujtK4B0UjEHba+XOEISUspaoobNOHkfxZIZD2IdL06G34
         JVhF1+ow1mahb9AUoHm1RPi5BWJvgpYjvl81sElNmigelPOanMHWfWvlK1CnlNmTbe
         wkmyopYGirv8YADH8UR+6HnO8+WKocSyg5J6+oTA3uOlfZ7AV0j69dNgV4op5rzh/g
         HGSH2K43W5zh4Q41izXjK6dq9Wj2ik4x/T0EQ8wvP/NJyqzBx4f/S/UTjudbImJjEe
         OL6Zvm5pAU7lg==
Date:   Wed, 23 Jan 2019 23:09:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: linux-next: Fixes tags need some work in the dma-mapping-fixes
 tree
Message-ID: <20190123230915.18046ca7@canb.auug.org.au>
In-Reply-To: <20190123071933.GA24861@lst.de>
References: <20190123074747.7cd44f12@canb.auug.org.au>
        <20190123071933.GA24861@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zfTzgZkjMu+JxxAL2Rw8Bfk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zfTzgZkjMu+JxxAL2Rw8Bfk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Wed, 23 Jan 2019 08:19:33 +0100 Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jan 23, 2019 at 07:47:47AM +1100, Stephen Rothwell wrote:
> >   - SHA1 should be at least 12 digits long =20
>=20
> When did we decide on that?  As far as I know it was bumped to 10
> a while ago.  12 basically makes the line even more unreadable.

=46rom Documentation//process/submitting-patches.rst:

"If your patch fixes a bug in a specific commit, e.g. you found an issue us=
ing
``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
the SHA-1 ID, and the one line summary."

Apparently we already have some clashes for 11 digit abbreviations.
Also, the git-config man page has:

"core.abbrev
           Set the length object names are abbreviated to. If unspecified or
           set to "auto", an appropriate value is computed based on the
           approximate number of packed objects in your repository, which
           hopefully is enough for abbreviated object names to stay unique =
for
           some time."

and when I set mine to "auto" it produces 12 digit SHA1 abbreviations
in the linux-next tree and in Linus' tree. So there has been some
discussion of suggesting core.abbrev not be set (which is the same as
"auto"), or being set to 13 to give some leeway.

> > In commit
> >=20
> >   8218a55b6b91 ("sbitmap: Protect swap_lock from hardirq")
> >=20
> > This later patch appears to already be in Linus' tree as commit
> > fe76fc6aaf53 (also with an incorrect Fixes tag :-() =20
>=20
> That commit is not from the dma-mapping tree..

This is in my linux-next tree today:

$ git log --oneline origin/master..dma-mapping-fixes/for-linus=20
702e8ed37bed arm64/xen: fix xen-swiotlb cache flushing
eda14f8977df nvme-pci: fix nvme_setup_irqs()
7c6f88f2fb4b nvmet-tcp: fix uninitialized variable access
8218a55b6b91 sbitmap: Protect swap_lock from hardirq
f5ac6c1e96a9 md: Make bio_alloc_mddev use bio_alloc_bioset
2490a5f5f2f8 block, bfq: fix comments on __bfq_deactivate_entity

origin/master is Linus' tree and dma-mapping-fixes is
git://git.infradead.org/users/hch/dma-mapping.git#for-linus

However, the committer of 8218a55b6b91 is Jens Axboe, so have you
accidentally based your for-linus branch on something from Jens?  That
commit does not appear in any other branch in linux-next.
--=20
Cheers,
Stephen Rothwell

--Sig_/zfTzgZkjMu+JxxAL2Rw8Bfk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxIWWsACgkQAVBC80lX
0GwxsAf+LPHzHY6BWlHBnlYeErRWrj2FYpDzkLOAcdVXGmfCkVXwn3rIO9o87f/n
gJxESJTa8jOhvb0IKkK8/BH4mJxyYt948M/580ENL6i7jefwE+7n45nmw/uMvyqF
8C4trhf22rYfwtN6/e4IYQkeGoINccsX0XH0LdouxvDXhAYFHI78WGLzTk0CpG2p
2PBiZpdoHUcFGPRld/GYJn8M+pn14/wGkcSyUq4+Wocahcn/VWQFgrX4VBUW+1uv
LIc9/VNuhA4/l9BTOoqQje/TiVp6suYBCl4NO+PhJeHDNatKoYWh4S7yejW2IOaf
5gPUSv73vGfnUm5SkYZhXgyTEot98Q==
=8yEt
-----END PGP SIGNATURE-----

--Sig_/zfTzgZkjMu+JxxAL2Rw8Bfk--
