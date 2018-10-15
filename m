Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BF6C7113E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053A0208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m2s4/xQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053A0208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeJPEU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:20:56 -0400
Received: from ozlabs.org ([203.11.71.1]:39977 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeJPEUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:20:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Yqsj5zj8z9s1c;
        Tue, 16 Oct 2018 07:34:01 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539635642;
        bh=1T4hZJOLP6G7YljEjWCW5p0/Pv8gnlga4gxUqDsdBRk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m2s4/xQndbI88NPSHEgjil0bTlsl5DfMPciT6NKj31Y6AyFzqpIGp7gAwMf4QMA47
         Eey3meOSPwh/QDYEFaiyEySXk37qfVYPFtMtlnCaTfU78yGUweJUFhpLJNSXt9p+rH
         KXU7XQKyyo25VYqYpyy0zTRHvRtqBYEmEGOcO2l/E9+wliPt07a+M7MGbR7XQ8LCN7
         o8nT9mdzyQbimWSaoDMaBzXBVsfOo2GRE2YmD870lntkAN9lGT6tUor+iNJ/NdAIOZ
         +mOzhx86PHKoMyWpbDpP0EqJCTgJNoUfM6Sx4ppdqbaiul03RkAjSsqKEryF3lk6BV
         9JdPPr7w7aq1g==
Date:   Tue, 16 Oct 2018 07:33:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: Tree for Oct 15
Message-ID: <20181016073359.3fa7bb32@canb.auug.org.au>
In-Reply-To: <20181015193914.GA9881@roeck-us.net>
References: <20181015192546.15faf3a1@canb.auug.org.au>
        <20181015193914.GA9881@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fuWQQII9Q570VSIIS3sw+k="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fuWQQII9Q570VSIIS3sw+k=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

[Again, just cc'ing the PPC folks]

On Mon, 15 Oct 2018 12:39:14 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Oct 15, 2018 at 07:25:46PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Changes since 20181012:
> >=20
> > My qemu boots of a powerpc pseries_le_defconfig kernel failed today.
> >  =20
>=20
> Bisect log:
>=20
> # bad: [774ea0551a2966c8fc29a6f675c3e28c5c6fa586] Add linux-next specific=
 files for 20181012
> # good: [0238df646e6224016a45505d2c111a24669ebe21] Linux 4.19-rc7
> git bisect start 'HEAD' 'v4.19-rc7'
> # good: [dfbf78faefa3c26d94208398e62bf25ea798e7f2] Merge remote-tracking =
branch 'spi-nor/spi-nor/next'
> git bisect good dfbf78faefa3c26d94208398e62bf25ea798e7f2
> # good: [3f296bb430327676912966c56d2f078f74e6b4ab] Merge remote-tracking =
branch 'tip/auto-latest'
> git bisect good 3f296bb430327676912966c56d2f078f74e6b4ab
> # good: [056ff0c45d1780f7bac1b54bd4160647efc500ad] Merge remote-tracking =
branch 'staging/staging-next'
> git bisect good 056ff0c45d1780f7bac1b54bd4160647efc500ad
> # good: [d7946b50c21a7d88af6c8e88d976ba3dfca651cc] Merge remote-tracking =
branch 'pinctrl/for-next'
> git bisect good d7946b50c21a7d88af6c8e88d976ba3dfca651cc
> # good: [72b5ca3121d5352fbb8fe3e1abaa86748205c0cb] Merge remote-tracking =
branch 'xarray/xarray'
> git bisect good 72b5ca3121d5352fbb8fe3e1abaa86748205c0cb
> # good: [e3895cf23a25da6dea2c8e986d4f6c24fafe5448] hugetlb: introduce gen=
eric version of prepare_hugepage_range
> git bisect good e3895cf23a25da6dea2c8e986d4f6c24fafe5448
> # good: [627f8833ac26e66d4b50676a0251499474bb4ee4] reiserfs: propagate er=
rors from fill_with_dentries() properly
> git bisect good 627f8833ac26e66d4b50676a0251499474bb4ee4
> # good: [e38910adf47ba1d0b5a5a573cc26bde1ec533147] memblock: replace allo=
c_bootmem_pages_node with memblock_alloc_node
> git bisect good e38910adf47ba1d0b5a5a573cc26bde1ec533147
> # bad: [f89bdd2c52666d9da4bf4ef3a97a7188586ba0fb] dma-direct: fix up for =
the removal of linux/bootmem.h
> git bisect bad f89bdd2c52666d9da4bf4ef3a97a7188586ba0fb
> # good: [3108d998dfc36eb7f6b7f2917fc561258f742094] mm: nobootmem: remove =
bootmem allocation APIs
> git bisect good 3108d998dfc36eb7f6b7f2917fc561258f742094
> # good: [1f94dacb1d0ed0d1068b89ad867a198d3eca7bf2] memblock: rename __fre=
e_pages_bootmem to memblock_free_pages
> git bisect good 1f94dacb1d0ed0d1068b89ad867a198d3eca7bf2
> # good: [c3954ade0c1b499ae587f3edb813876216212836] memblock: replace BOOT=
MEM_ALLOC_* with MEMBLOCK variants
> git bisect good c3954ade0c1b499ae587f3edb813876216212836
> # bad: [cde1c7f7e92aef241f1c1a09a4d1f1f06fd565b6] mm: remove include/linu=
x/bootmem.h
> git bisect bad cde1c7f7e92aef241f1c1a09a4d1f1f06fd565b6
> # first bad commit: [cde1c7f7e92aef241f1c1a09a4d1f1f06fd565b6] mm: remove=
 include/linux/bootmem.h
>=20
> Reverting this patch together with its fix-up "powerpc: fix up for remova=
l of
> linux/bootmem.h" fixes the problem. This also fixes the traceback seen wi=
th all
> other ppc64 images.
>=20
> Guenter

Thanks for this ... though a strange result as those patches were in
next-20181012 as well, so I wonder what else changed.

--=20
Cheers,
Stephen Rothwell

--Sig_/fuWQQII9Q570VSIIS3sw+k=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvE+bcACgkQAVBC80lX
0Gxq/wf9GyoruyeLCfuSKDpc2uXvs7Td7xLC/NLRfWGMRoMJ2RgUdB1T2qz+B2tH
/eXlQSoA5l2cb0+L08b1XwgthNkYkfoT7y5hjjpYmQ3gosrKH076rCBCIENccXsz
gPzGEDwe6FRNqzxrnUtNWwmHO4nAbE/yVLKH3DKJC620xD07uwmo0r/OMUhUC0kO
gWEkQfsB84K422TA7YnBi3z135Tcu8yJHOKK0SwKQhFk8bVGVK1LnKol+52a+kbt
Lfx3yoBJ/Cp6xH8AlN5Z0NIU6L7ThDEPTVr7GHGZ8YZF+lzqAXQBby8ZjWBCJw4O
z65IrCw+yC1FpszzxXmpjLevAPFtBQ==
=FOJU
-----END PGP SIGNATURE-----

--Sig_/fuWQQII9Q570VSIIS3sw+k=--
