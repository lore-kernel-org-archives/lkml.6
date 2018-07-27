Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE18C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0906520893
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FUADBBiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0906520893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbeG0K1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:27:54 -0400
Received: from ozlabs.org ([203.11.71.1]:60385 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729445AbeG0K1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:27:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41cNPj2hrZz9ryt;
        Fri, 27 Jul 2018 19:06:49 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532682409;
        bh=deMsmEmlqP4m8gQTNO32jKV15xaY6uLE/+0MaRNQNmI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FUADBBiQ581qX4eVOG6PbdQhNjenQxHR50hVEMudz8T8DRSuvscpEC3LVTNsh2xzE
         D6iDhYgpK2n77CUDGSGBFqZIS/XchqaLEIxazv6lKmZv69m+Cwkd/o04iV8qC0z5T4
         2iVHlJcVJNrA43jHD4IqLf2Qw3tuAazjGgBjSUKjMassI2YZGfykcKS6awkvwWx7tj
         ExmOdhFEv6cbvhgZCgNCW8mycIQB+YOBK0FtWxYh6GXvqKRc/2T4Lrh/fGv1zGO96F
         HaYkmJkuBYUHwG4cOfQWQH09d+liVwKfXmetClChHD5rSxQEVgYAWXn9fK/C9Vl2VN
         NYkFZZR5/xVmg==
Date:   Fri, 27 Jul 2018 19:06:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@google.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20180727190647.3525f5f7@canb.auug.org.au>
In-Reply-To: <20180727190207.7ce1c9b0@canb.auug.org.au>
References: <20180727190207.7ce1c9b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wdFTLvqeutYeitww.T9kxwp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wdFTLvqeutYeitww.T9kxwp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 27 Jul 2018 19:02:07 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the kspp tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> cc1: error: plugin stackleak_plugin should be specified before -fplugin-a=
rg-stackleak_plugin-disable in the command line
>=20
> Maybe caused by commit
>=20
>   a8b9eaddb9c0 ("gcc-plugins: Add STACKLEAK plugin for tracking the kerne=
l stack")
>=20
> I have used the kspp tree from next-20180726 for today.

Well, that obviously didn't work since the tree hasn't changed for a
few days.

I can't see what has interacted to make this happen, so I have dropped
the kspp tree for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/wdFTLvqeutYeitww.T9kxwp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlta4KcACgkQAVBC80lX
0Gzr3QgAkqCIZaHJGSaKsPNx8+PQOnrGT1M5B4QL6QPbBWeWMZXbBWV62hXQ4V+l
FiGNTxJa/49dOZaC7uZDusL9Xn67wi8M/v5jGQ9c36p+sJiVn+xk2XyY6kIHpWwy
AgBE20pn6ByBnkqTiQMtfpPVvRs+Thdr5Kx/lgOYFJ+feOq/SuRjlR2/oZLEd5jy
eRhLaVkYPXz9ptir/4i4hj+/kCJ62mHHQfUPe9I+AZaSZ5qRlv8YxHHsNes/uWtI
2xgaom7FuCK4Vfmc2sSLBtZ/3EaaSKlu+L51rrGb6JTTcwX74hyZ3bCvdbr8T/vi
99OSV7Dtlj1TYo0MNLWABoAAQQUqwQ==
=kCEe
-----END PGP SIGNATURE-----

--Sig_/wdFTLvqeutYeitww.T9kxwp--
