Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B82CC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24DA208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HZ7/n2QE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24DA208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbeG0MRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:17:04 -0400
Received: from ozlabs.org ([203.11.71.1]:41983 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730801AbeG0MRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:17:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41cQqB22W5z9rxx;
        Fri, 27 Jul 2018 20:55:34 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532688935;
        bh=shcQjxVoCY+DjFr3Ex7Y62uYNWHJiGaJU5AFxWFVwd4=;
        h=Date:From:To:Cc:Subject:From;
        b=HZ7/n2QEDgyRiIotrBFuGAFRVlIb7sP8jIMvXsRP0b5fX/9qpG1TEIodWMgyci6S5
         ymQ8zMHMKUDxr82SUD7otwH0eMFOSHpuHefQX0WCEmaTtL10FfloU3zt37Vk9A27TJ
         NcX1VDXcfvCU13FZcoxLa+2e2NsnNssGfIS7ZBqdkbPWwPt6eMYwfbBxPg76FID638
         Z0YSokzsegkek+dFh/XqpMIo3Ojc0Lqi9WW20nQJs2qULCTelDtYY5U92NAyj+ByP0
         HWDEAadYRgJBiHy0l9/HLwcWf7uxfH0QV3GrQ63BCPIr8KF/TcVPcFnnjf489nbvX6
         Ym73sOXXaKR4A==
Date:   Fri, 27 Jul 2018 20:55:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: linux-next: manual merge of the akpm-current tree with the arm64
 tree
Message-ID: <20180727205532.28de3353@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/I6jsFjSkCEl6JqXAley0Bo6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I6jsFjSkCEl6JqXAley0Bo6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Today's linux-next merge of the akpm-current tree got a conflict in:

  drivers/firmware/efi/libstub/Makefile

between commit:

  0b3e336601b8 ("arm64: Add support for STACKLEAK gcc plugin")

from the arm64 tree and commit:

  08cc64a7109b ("module: allow symbol exports to be disabled")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/firmware/efi/libstub/Makefile
index 25dd2a14560d,0d0d3483241c..000000000000
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@@ -21,7 -21,7 +21,8 @@@ KBUILD_CFLAGS			:=3D $(cflags-y) -DDISABL
  				   -D__NO_FORTIFY \
  				   $(call cc-option,-ffreestanding) \
  				   $(call cc-option,-fno-stack-protector) \
- 				   $(DISABLE_STACKLEAK_PLUGIN)
++				   $(DISABLE_STACKLEAK_PLUGIN) \
+ 				   -D__DISABLE_EXPORTS
 =20
  GCOV_PROFILE			:=3D n
  KASAN_SANITIZE			:=3D n

--Sig_/I6jsFjSkCEl6JqXAley0Bo6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlta+iQACgkQAVBC80lX
0GyBBQgAkjx9lFZiVVmRQG0IHn6JyjQYAuHrN/pDk1XEG+IsupYq0zEfKVC8wLrL
mWkCYbQRw3tpFOTMzCoIfde45u7bTjYgAwPUzcqMRCXrSm/U3u3bRLLdax8h0hrN
7lBnbHX6mJ0jFM81AwwqNRxyNE9SwVHgUke4XtboVKbnaIz8kLTwfx6rK3t6A793
Za09IQe8V5KBAUqJThchsULA1nfEhYXTsomMMQFxZ88NV+4Q8yVHx38/3EPoG90a
XBhc/x4/CF2vwm6lzXJyXh3TE35iIVrizSb4UjUr9u1K+UHo1iRtaiZiD3lChmiF
q1AzuTw/WtLnkfh4UbRH5BPTRbUN5Q==
=Amwj
-----END PGP SIGNATURE-----

--Sig_/I6jsFjSkCEl6JqXAley0Bo6--
