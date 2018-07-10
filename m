Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFE1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4D82089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m+cMjB0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4D82089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeGJHbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:31:33 -0400
Received: from ozlabs.org ([203.11.71.1]:54969 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751103AbeGJHbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:31:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Pv5W1vJdz9rvt;
        Tue, 10 Jul 2018 17:31:27 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531207890;
        bh=Py1BMARtXnYZZUbz9R4w6CkY7lhSbOEluu0f6eYA8+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m+cMjB0miyYBiK8IXQR7pkV2sbEJ5rz0FWVjQej2broecFRlKppzjX6kPBzvCEgt/
         hSqqenlWmPfqP3dj3Ca7BOk2MfNV8RkcW0SXXDwjfztuKs4/mPZRpMN1qXyko4vV5+
         o41FiuHnzOf0xH7Dg3RfDStxshZss4YeM9VGvgV7hHscqcztKZuML3J+pHnV6n6xeY
         i6La+zBMwsDPlb0Sh4Ou9RArGryeLMs6nc3KBGQ/3RsUSEr3hLpoGvdZH+qF1Uztf7
         81LsD5tJL+WKWj1W4bqyfiy8F4y6W7tSHe8PpczhZmdT7qwe2xMA8mWQDDhpNBUkuj
         mebaCgV6epYhg==
Date:   Tue, 10 Jul 2018 17:31:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: linux-next: build warning after merge of the scsi tree
Message-ID: <20180710173114.17ee69ad@canb.auug.org.au>
In-Reply-To: <20180620132911.5f6ab464@canb.auug.org.au>
References: <20180620132911.5f6ab464@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kzjMS7hkaBT=6vyhyCFXfXm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kzjMS7hkaBT=6vyhyCFXfXm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 20 Jun 2018 13:29:10 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the scsi tree, today's linux-next build (powerpc
> allyesconfig) produced this warning:
>=20
> In file included from include/target/target_core_base.h:7:0,
>                  from drivers/target/target_core_tmr.c:31:
> include/linux/sbitmap.h:331:46: warning: 'struct seq_file' declared insid=
e parameter list will not be visible outside of this definition or declarat=
ion
>  void sbitmap_show(struct sbitmap *sb, struct seq_file *m);
>                                               ^~~~~~~~
> include/linux/sbitmap.h:342:53: warning: 'struct seq_file' declared insid=
e parameter list will not be visible outside of this definition or declarat=
ion
>  void sbitmap_bitmap_show(struct sbitmap *sb, struct seq_file *m);
>                                                      ^~~~~~~~
> include/linux/sbitmap.h:530:59: warning: 'struct seq_file' declared insid=
e parameter list will not be visible outside of this definition or declarat=
ion
>  void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m);
>                                                            ^~~~~~~~
> In file included from include/target/target_core_base.h:7:0,
>                  from drivers/target/target_core_ua.c:30:
> include/linux/sbitmap.h:331:46: warning: 'struct seq_file' declared insid=
e parameter list will not be visible outside of this definition or declarat=
ion
>  void sbitmap_show(struct sbitmap *sb, struct seq_file *m);
>                                               ^~~~~~~~
> include/linux/sbitmap.h:342:53: warning: 'struct seq_file' declared insid=
e parameter list will not be visible outside of this definition or declarat=
ion
>  void sbitmap_bitmap_show(struct sbitmap *sb, struct seq_file *m);
>                                                      ^~~~~~~~
> include/linux/sbitmap.h:530:59: warning: 'struct seq_file' declared insid=
e parameter list will not be visible outside of this definition or declarat=
ion
>  void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m);
>                                                            ^~~~~~~~
>=20
> Introduced by commit
>=20
>   24af1ccfe12a ("sbitmap: add helpers for dumping to a seq_file")
>=20
> in v4.11.rc1, but exposed by commit
>=20
>   eca7ee1f33e8 ("scsi: target: Convert target drivers to use sbitmap")

I am still seeing these warnings ...

--=20
Cheers,
Stephen Rothwell

--Sig_/kzjMS7hkaBT=6vyhyCFXfXm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltEYM4ACgkQAVBC80lX
0GyOOwf8C7idYXHXskyM+Q0xKibPieG/XF2sl5g6jfQ/hq4+HvIxhiK0UPvxufFq
OY3EL7qDmnpytxP3AU4Luo3LDOTgGssd/0RJ+VG2lTszjlb9RmYbn1YwukSPfE9x
KSUs/375mYOVvL8jMbQRXslYnsuLr09wj0XhGPNk0pEeTc7vTChJJUMhg55QPU2u
qww8Sl7r3rI4nVomSKedHhVc3gaeSBr37iTMTPN6Ts/UNHxWP5FIVsjGfSe/A/yc
H4KsnooLckfJyj8+K7pSLALLJTmZPAb9o1GWRVywpI0V7gG5bVEsh3Bvf12sZYFm
nEYwuyupgE6CORAIwTJ98TgyG/MGoA==
=PTOQ
-----END PGP SIGNATURE-----

--Sig_/kzjMS7hkaBT=6vyhyCFXfXm--
