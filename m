Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E34C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F002174A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="P9+nMtw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F002174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeH0Eo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 00:44:59 -0400
Received: from ozlabs.org ([203.11.71.1]:52941 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbeH0Eo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 00:44:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41zD8Q5Cl1z9ryn;
        Mon, 27 Aug 2018 11:00:38 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535331638;
        bh=y3nrkoGJas7CGeKtq+/7v/YnAxHWg0A940dxtVfXI00=;
        h=Date:From:To:Cc:Subject:From;
        b=P9+nMtw2wkej+sDzYV9GR3aZcHVMP86/+oJvJrX24UW/YvyNy411ZmFMWkFXeeHIA
         U//eglNDyZmrV04h3U3vOibi3cyLBp6jfcNgYkBk4PF6Bw8ZWiwNXfVHI19i6PLvxc
         lmeabCnZAYauyA3EF3ludck8TnTH0h43uh1A9l527ff8dKM8ATm8fcoNRwD71xS4gD
         vj+z5FO2SZ1T1rBINHa+yZKUYMnqG307t2s5jAgjG1rV8qhDPuBPExcfH10b8TB5bA
         zhok0VPoZVj+avx4oso2G/M0COBGFafpSDLV6cdjGDHz0y7Vfg3W+GOYpVQslNQJJA
         QbFag8QAqKwdw==
Date:   Mon, 27 Aug 2018 11:00:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Aug 27
Message-ID: <20180827110038.2800ce18@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/M.Dft36Zq7RS0arIwr2QkgC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M.Dft36Zq7RS0arIwr2QkgC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180824:

Dropped trees: xarray, ida (temporarily)

Non-merge commits (relative to Linus' tree): 427
 585 files changed, 17988 insertions(+), 5276 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There are also quilt-import.log and merge.log
files in the Next directory.  Between each merge, the tree was built
with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
multi_v7_defconfig for arm and a native build of tools/perf. After
the final fixups (if any), I do an x86_64 modules_install followed by
builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
and sparc64 defconfig. And finally, a simple boot test of the powerpc
pseries_le_defconfig kernel in qemu (with and without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 287 trees (counting Linus' and 65 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.

--=20
Cheers,
Stephen Rothwell

--Sig_/M.Dft36Zq7RS0arIwr2QkgC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluDTTYACgkQAVBC80lX
0GyESwf/cDHOAZc+1nTycCzjdQtGv1poHfwHcQvkiTx78ACQCf0s57TIbj/HZmXO
Lt9CTB+gc+vZMui1q/zxFDIWCS15RjWVkiLheOwFgnUTsP7yc5CpCjWBmGWW2Szg
D7oy6lCxs7u2KYnq6bHeO1DmSSphHa1eD4MDFeXSDuzCkYtp1Spz7SG4uFBivq0J
6CzIOT+XQH+iRQfJ4N9R1GSkE5KRuFLgpaZRMknpxsUUec03yoTPMqvHDfM24j79
WCk25ubNURW6aEP9wiEh/sDabSwETe1/uMi95CBuf2tnNCnZwbvEQSNujSAl2c8C
tZT2dEHjmDW4gOxN31p0pzM4P3F/xQ==
=SV7X
-----END PGP SIGNATURE-----

--Sig_/M.Dft36Zq7RS0arIwr2QkgC--
