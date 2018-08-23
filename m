Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0234FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC9B208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RgWdSLhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC9B208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeHXCuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:50:52 -0400
Received: from ozlabs.org ([203.11.71.1]:32895 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbeHXCuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:50:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41xL2N6CNGz9s0n;
        Fri, 24 Aug 2018 09:18:52 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535066334;
        bh=7CC7O6IHLODZsFVKDdJjxviJjhaLFvlzQLDVKVnIYPU=;
        h=Date:From:To:Cc:Subject:From;
        b=RgWdSLhBH92NMEDciGcOMH6LDm10ffI4y39vkKCfaZDjaQWOtLwAMg2F4nFIlRAAu
         hx5B+qrQtuDQfDRlsMEbSdbQd+vkU29JYq/GQXGscIXj8Bb01KL2oGPWSy/DbpxK8V
         oeaWkPEFVldfksllR1p+o0TBT9tg8lnP9LO5t91nqkuj60Mclia+WNwUPnwTydcLF5
         pQfJmoaJZxpnQxuBq09vx4dAmEnkhdpOSM8h8X8FZkZZy6+eJRrZ1G5StYQ7fHKCjn
         vqWMo2nNXnnOuAMIjhRId5qI9Q2akMwCoa0Oa1X4B5GH3U7b6Lz3+lIoClxt4/93KX
         2DgvyRhHZFSwA==
Date:   Fri, 24 Aug 2018 09:18:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ley Foon Tan <lftan@altera.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: linux-next: manual merge of the nios2 tree with Linus' tree
Message-ID: <20180824091843.66cdda06@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_KbKSOVp9_kkKS2PDDeqRyk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_KbKSOVp9_kkKS2PDDeqRyk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nios2 tree got a conflict in:

  arch/nios2/Kconfig.debug

between commit:

  06ec64b84c35 ("Kconfig: consolidate the "Kernel hacking" menu")

from Linus' tree and commit:

  93bdd8902339 ("nios2: kconfig: remove duplicate DEBUG_STACK_USAGE symbol =
defintions")

from the nios2 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/nios2/Kconfig.debug
index 7a49f0d28d14,2ee8d5144c15..000000000000
--- a/arch/nios2/Kconfig.debug
+++ b/arch/nios2/Kconfig.debug
@@@ -3,15 -4,8 +3,6 @@@
  config TRACE_IRQFLAGS_SUPPORT
  	def_bool y
 =20
- config DEBUG_STACK_USAGE
- 	bool "Enable stack utilization instrumentation"
- 	depends on DEBUG_KERNEL
- 	help
- 	  Enables the display of the minimum amount of free stack which each
- 	  task has ever had available in the sysrq-T and sysrq-P debug output.
-=20
- 	  This option will slow down process creation somewhat.
 -source "lib/Kconfig.debug"
--
  config EARLY_PRINTK
  	bool "Activate early kernel debugging"
  	default y

--Sig_/_KbKSOVp9_kkKS2PDDeqRyk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt/QNMACgkQAVBC80lX
0GwR3Af/Z73aj1F3RnLQ6vxwDrB0eXpi1o7J+37TyO+3l/S3f8m2S5kDAco8hGiS
g5Tdw63Flwp/ke/Q3Pyhs2R6yydJtYVwO+AYmcqFfL78naIY+9kW7BASKiMwJy11
4H2LyIxHPDXSR6XOwnhhDfU/EfwA6nr+c0fauATzQbdiIZbSlxj1+8nyNBxNnhKq
mdmixnCYa1cIoSyet1io0O6kDS52U4SWLUWGs/WO+WqvJJ1a6T4l/127PDph6V3g
fEdibY0SHo++58DgKs3KyUZik0krz/bpJAO6r5go9lVa0fxgcky6z8/aGDBabvs3
7o4mXmQ9bq6F5f4J22gq9jP5DdUZew==
=oGDQ
-----END PGP SIGNATURE-----

--Sig_/_KbKSOVp9_kkKS2PDDeqRyk--
