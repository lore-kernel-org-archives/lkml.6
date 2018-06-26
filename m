Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF4DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D8E25CC8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oQ5FRMrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D8E25CC8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933162AbeFZXAC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:00:02 -0400
Received: from ozlabs.org ([203.11.71.1]:57911 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751026AbeFZXAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:00:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41FhMM0q76z9rx7;
        Wed, 27 Jun 2018 08:59:59 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530053999;
        bh=cXSVxjpEG2idlBMhjbEYVrtgvXJwxmSJ81HuywzkR+s=;
        h=Date:From:To:Cc:Subject:From;
        b=oQ5FRMrdbjxgXbTj3QwQLMLr4t2SnsGFFA9nVk3+d9zwBcFB/c6ObpObZFPfvoNs6
         pygBLg0OHXB8qPFYx/IkPxQ7fJNWqpp4VAouhS1duUbmaJtU2C2DHJvadYeXJ1VWMQ
         sHRBAxqwoT3jvJ+UcLfmc/hrfhwvryyxOl6NiZcq2tUMV8SrRjCn6UbIyNNwgnyl2S
         KOkSdlOzWmx1iv0R0AJpPqvteh/aS3vxnkvFfldmYDyc4Ez7cqCpeOKZz2fX5iRCLi
         eSqQYsElERFffyXv0hmqI14BoOddtAJ9YQLYJHDJ9pRju2zJmj/UqbIMilCTrjAbfU
         Pz5eRsYW+OdFA==
Date:   Wed, 27 Jun 2018 08:59:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: linux-next: build failure after merge of the btrfs-kdave tree
Message-ID: <20180627085936.4f9cc4f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Gc5.ysKSf/P6u8XUl=a85nT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Gc5.ysKSf/P6u8XUl=a85nT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the btrfs-kdave tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

fs/btrfs/print-tree.c: In function 'print_extent_item':
fs/btrfs/print-tree.c:56:3: error: implicit declaration of function 'btrfs_=
print_v0_err'; did you mean 'btrfs_print_tree'? [-Werror=3Dimplicit-functio=
n-declaration]
   btrfs_print_v0_err(eb->fs_info);
   ^~~~~~~~~~~~~~~~~~
   btrfs_print_tree
fs/btrfs/relocation.c: In function 'find_inline_backref':
fs/btrfs/relocation.c:602:3: error: implicit declaration of function 'btrfs=
_print_v0_err'; did you mean 'btrfs_print_tree'? [-Werror=3Dimplicit-functi=
on-declaration]
   btrfs_print_v0_err(leaf->fs_info);
   ^~~~~~~~~~~~~~~~~~
   btrfs_print_tree
fs/btrfs/extent-tree.c: In function 'btrfs_lookup_extent_info':
fs/btrfs/extent-tree.c:871:4: error: implicit declaration of function 'btrf=
s_print_v0_err'; did you mean 'btrfs_print_tree'? [-Werror=3Dimplicit-funct=
ion-declaration]
    btrfs_print_v0_err(fs_info);
    ^~~~~~~~~~~~~~~~~~
    btrfs_print_tree

Caused by commit

  2a191bb344ee ("btrfs: Add graceful handling of V0 extents")

# CONFIG_BTRFS_ASSERT is not set

I have used the btrfs-kdave tree from next-20180626 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Gc5.ysKSf/P6u8XUl=a85nT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsyxVgACgkQAVBC80lX
0GxHFAf5ARcfTS0B66ZbZdRC5Xdk/V4G9EDZe9WsajXozGh0sVX+hJNHezVL5e2D
9jpbqYcSVzpgNChtqLGyIggB3cTjHTTzUK2p7JgDGa5xqUeSqXCdXwlUGX+YmDT5
76OU5f4KRoppYjV7JfcXWvlu3ElWnvSSkvaINUlPYC4rE2UPgBLS+o2h7AIrsvGU
hY2ICY4TBbuG1Xyh8B7q9yN6Mk6Nj6VI+IMGDxKDixRFLPXwkMXMYjDNOtcFqtCV
TiKwxWMz4GNQSuDXmGB0bnalctI3Uqhthgr9nSzV7CBRLisccQaYPo0xGSVGMDz7
h4ATPV0Am4Ywoj/Niy3Lwb1pvf9hfg==
=7KNM
-----END PGP SIGNATURE-----

--Sig_/Gc5.ysKSf/P6u8XUl=a85nT--
