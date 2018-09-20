Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA079C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E1F2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LPKtJV0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E1F2152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbeITRA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:00:58 -0400
Received: from ozlabs.org ([203.11.71.1]:41477 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbeITRA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:00:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42GDjd2FwKz9sC2;
        Thu, 20 Sep 2018 21:17:57 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537442277;
        bh=TC1GWstM5sKraWhl6YgMxEq0AAVppmVN5DGDUXbwct0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LPKtJV0yXEeDquMCaYNp8uYPC1d0hgIDFa7gXzdX37TrJOdXdfd1j7+bsNTY9kT1B
         1+rypTtCTKnbRTKvkKMpSRMEghj4ofc7/gqBms1x8/q1XZb963g3qFksqgpAGptgVR
         JeHIMgytEhWi2757CYEHVGNeCxcCTo9pkwYqGFqL+mnEziHNFDa+uaiVxZJP1Xjep5
         +Wsim9i5D/SpMCjNEtSa4EI80L5t4hR09Onl/dgf4XQXgIxD/Mz4MvBxNgKPquOp75
         eRz86XOYgUCQ2H5jiExRh0Lq0aQ297wJ3ShctYbeaJGs+CO3TA9+trziRPuvQ3yRLz
         HErBUbNkEbW0Q==
Date:   Thu, 20 Sep 2018 21:17:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>, robh@kernel.org
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Sep 20
Message-ID: <20180920211755.1fabd744@canb.auug.org.au>
In-Reply-To: <20180920210711.4561abee@canb.auug.org.au>
References: <20180920151243.5524c6ca@canb.auug.org.au>
        <87d0t8jvym.fsf@concordia.ellerman.id.au>
        <20180920210711.4561abee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/t4YctscrJcChV89uUiJm.9M"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/t4YctscrJcChV89uUiJm.9M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Thu, 20 Sep 2018 21:10:08 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Thu, 20 Sep 2018 20:37:37 +1000 Michael Ellerman <mpe@ellerman.id.au> =
wrote:
> >
> > Oodles of:
> >=20
> >   # < make -s -j 48 ARCH=3Darm64 O=3D/kisskb/build/linux-next_arm64-all=
noconfig_arm64 CROSS_COMPILE=3D/opt/cross/kisskb/br-aarch64-glibc-2016.08-6=
13-ge98b4dd/bin/aarch64-linux-  allnoconfig
> >   # make -s -j 48 ARCH=3Darm64 O=3D/kisskb/build/linux-next_arm64-allno=
config_arm64 CROSS_COMPILE=3D/opt/cross/kisskb/br-aarch64-glibc-2016.08-613=
-ge98b4dd/bin/aarch64-linux- =20
> >   /bin/sh: 1: pkg-config: not found
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        =20
> don't have it installed on my build machine either ...  do we have
> pkg-config installed in the build images?

Duh! ;-)

According to the commit message we gained a kconfig dependency on
pkg-config in 4.18.  I wonder what else depends on it.

Ah:

"pkg-config
----------

The build system, as of 4.18, requires pkg-config to check for installed
kconfig tools and to determine flags settings for use in
'make {g,x}config'.  Previously pkg-config was being used but not
verified or documented."

(from Documentation/process/changes.rst)
--=20
Cheers,
Stephen Rothwell

--Sig_/t4YctscrJcChV89uUiJm.9M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlujgeMACgkQAVBC80lX
0Gx2CAf/cJ0bt7I8hkCnLqIjschCrkFdf3Ik5nYOiE9027qSwJ2qTJ98WnUxYfNW
vqOObZ6swKIcSBaZB1SqmBcj8sR49ElZuWEm1/lzVX851Tr/yS78gbJ7arNrTbHt
ngcF/tirn5jKElFlz8Mbox19HojNClhdom8h5SAoMJLkRdZFd+YUOZ2K3fLBxNci
Ivr59zyr8FwBAI38ZtSRlrFUUhrskcdEyvSqajSUsojKh11MJz7u2wRTLcuyIyMs
JaxVXYGyHF1bvnFG9JixnSacS0ZzDzz7lYOLGKB4YuWICuhrps1MnUHv/2rNAXZ3
6UD7zVOoTqPKAUFk87GMcqEjra824Q==
=6ctV
-----END PGP SIGNATURE-----

--Sig_/t4YctscrJcChV89uUiJm.9M--
