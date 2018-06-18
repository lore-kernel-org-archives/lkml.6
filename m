Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62863C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F666208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m9qRQmsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F666208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754587AbeFRDf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 23:35:29 -0400
Received: from ozlabs.org ([203.11.71.1]:44175 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754525AbeFRDf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 23:35:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418GvH57hFz9rvt;
        Mon, 18 Jun 2018 13:35:23 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529292925;
        bh=+HU/5uXJZ9k6UADYwutS4s+xQSPo5PiNpd8DqUJEJPE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m9qRQmsjHVZqPjgTRKdWVy9L0nSs6aDwm90xe3ILBDHzwH0P4LIbAjGD+cW7Hgo6y
         u+VqmuGCz7Q2RVlEy45pdQ1IdSKEWlfdk3PK9xW5XyiGSs25g1kOqYP9h496j7YNce
         STZ/CtzQA2ZNoCacJ/XiUX2LcMxfh8S2qGsHNNqA/2BxqDjbZcXZr/imJ44KGJCdJE
         394ImfsLzC3eKFfbl9G9bcYrJetq26JmgK5OfMxs0iQ+ScGvMVhFkpS+O/3jD42b6v
         ijJs046V90YP1ccAElQavn7Hroogm0/MuPoBcSHeakyYBQTWnBClxtECRXhc6R18F3
         +MMwpJnkIdXnA==
Date:   Mon, 18 Jun 2018 13:35:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: Re: linux-next: build warning after merge of the random tree
Message-ID: <20180618133523.30db3ba0@canb.auug.org.au>
In-Reply-To: <20180608133748.58a272d5@canb.auug.org.au>
References: <20180608133748.58a272d5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WvEGn6V4zyq42Awr/rh53y8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WvEGn6V4zyq42Awr/rh53y8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 8 Jun 2018 13:37:48 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the random tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>=20
> lib/vsprintf.c:1668:13: warning: 'have_filled_random_ptr_key' defined but=
 not used [-Wunused-variable]
>  static bool have_filled_random_ptr_key __read_mostly;
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Introduced by commit
>=20
>   bfe80ed3d7c7 ("vsprintf: add command line option debug_boot_weak_hash")

I am still getting this ...
--=20
Cheers,
Stephen Rothwell

--Sig_/WvEGn6V4zyq42Awr/rh53y8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsnKHsACgkQAVBC80lX
0Gyxdgf+JYXhDm2AqKh8ppqArOgpQqrN7f1zI1J0d4P0Jpg/la/xJV89DaR0Ngn8
8QdkOMmXgAS/Y+K9B0IP5Ml89x5Oaw7/bUjkz69uJ+9shZIoysr5w6qIX314imRj
k90yb8J77CYYg0oFa0zeipxF6aaMtNPBtSyDBH703nksKI4ImDiIvbWoB03QrKlC
cj4N5wiYssiH6Nv1CBZp4Fc+I1TxQz4RnRlSVqRO1IWgY7yKdAeUFpQAF2PeyJu4
zIfABCDHE1Aj0rAYzbYp0WMTuN3lWWxj6NX9dIDTfyrpIbt51fSCSBHig77CYTZR
bkYwtL4Zd5z794fsbruPd9URvjx88w==
=mUl2
-----END PGP SIGNATURE-----

--Sig_/WvEGn6V4zyq42Awr/rh53y8--
