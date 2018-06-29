Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D97EC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80F524DF3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jcwGFKeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80F524DF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753700AbeF2FQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 01:16:24 -0400
Received: from ozlabs.org ([203.11.71.1]:55569 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752451AbeF2FQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 01:16:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41H4cg3gyQz9s0w;
        Fri, 29 Jun 2018 15:16:19 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530249380;
        bh=PMrNLs8iftGfOAf1fGgy7wKaLegYQZy+f7bfXeXzV8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jcwGFKeSZ/rxaASsI7gGdB8lIImQA9g+sbsr+1nkjnFeHjnH9neOPur6LX0u+8BOf
         1LM0i6zcR20zD6eFSSybwQdv9siwTU6yQpTBXll9dXVLeV98x1Dg1EXjmbUOx7tawi
         grV3lymz74xjjAjLqTgXBzpyqP7I1udgWyQUOZUS+5sAJpJafdnNawSM5kxqbG90/i
         3XPOwsaUyHt3CIy32gjbFCvpDIuKOj6Jse+0sj5a4yc/+Z+hjbINOgV8mXx3rNCo8k
         XeIC2nofUeDpzUdXSXtobx8+UGtr39x0W/9N9O/ov5q5kU195IODQwZi1OmUET3/Jd
         zP2PxMxtvA4Eg==
Date:   Fri, 29 Jun 2018 15:16:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the scsi
 tree
Message-ID: <20180629151618.1da8d00c@canb.auug.org.au>
In-Reply-To: <20180620135458.7cc22318@canb.auug.org.au>
References: <20180620135458.7cc22318@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qSqQw0u5Cwk6TUGhAVC_Fo9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qSqQw0u5Cwk6TUGhAVC_Fo9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 20 Jun 2018 13:54:58 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the akpm-current tree got a conflict in:
>=20
>   lib/percpu_ida.c
>=20
> between commit:
>=20
>   acf3ff616ee2 ("scsi: Remove percpu_ida")
>=20
> from the scsi tree and commit:
>=20
>   0c4d6e08c775 ("lib/percpu_ida.c: don't do alloc from per-CPU list if th=
ere is none")
>=20
> from the akpm-current tree.
>=20
> I fixed it up (I just removed the file, but clearly the akpm-current
> tree commit could be removed) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

This is now a conflict between Linus' tree and the scsi tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/qSqQw0u5Cwk6TUGhAVC_Fo9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls1wKIACgkQAVBC80lX
0GxdgAf+Ljt2myxII87Rjb/ArZuduEzC/MOkJL/D1USx+2/90u8ToX8HPeHpBwt+
7V7PYYblLAqts601kwSH4xjpF7mIcu3+veOPsoCb5mmNyKwfLWXikw8lmWTPBBuo
Dq0hXgfZmeq/JKcQrqhAf1gCttxI77VycR5oHSV6Ipfaz+2dKaXHD61rjUMNl8Bp
LqOxbr3Loyz+SxFc6wmWobEowYKxv//W3phWy9bCbmYodA5vSyPl39+8NjN0qTk7
kqbPFntiqdzO5ZGxtaFGY3HRgoNIxW5lNl7ff2GIAQngmEL91sJ63AraDKf6bYh5
9vv621u22qQPI5MGW7oJK2z4ClcIug==
=34mt
-----END PGP SIGNATURE-----

--Sig_/qSqQw0u5Cwk6TUGhAVC_Fo9--
