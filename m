Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE7CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670142174C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VeuuaRXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670142174C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeHCKcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:32:15 -0400
Received: from ozlabs.org ([203.11.71.1]:52583 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbeHCKcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:32:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41hgPz1w68z9ryt;
        Fri,  3 Aug 2018 18:36:55 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533285416;
        bh=5Dg1e5CoI5Rdi6oInJiCrn1vuRna2h2wob67l6ZAtGU=;
        h=Date:From:To:Cc:Subject:From;
        b=VeuuaRXhgNhO/65p39KSqJN8g1xX9uEx98cfzMXaxwgRbtp00vEN/Syn7VbLHeX/x
         lm4qIQpUrJfvgTuLV8p2CgJSFD7NGSRYXrDwnaLEa6hzT4oZVW5cGPxxSeka68EGb5
         5JS3EJkzJaW92vY9u21ZkTEOwlFhdovBk9Rqou7bsvFUlub46T0Cox0m+SsSfi1Ajv
         gOzT6KxM04FgXBInZZA1c2x/EivKDFmhotqOchbDORfzD+FOoHMN1K5vnCe6ud5if9
         0RlW+Ni81v/016xNhadxg109WnQ9UdK4nVTBJn4nZwHWJ41XoaprkjSuDR0jy4KGlt
         6CoNq1QoV1axg==
Date:   Fri, 3 Aug 2018 18:36:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the akpm-current tree with the kbuild
 tree
Message-ID: <20180803183653.4d394bcf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MAJjaLh58Iau11g91//MwJq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MAJjaLh58Iau11g91//MwJq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  lib/Kconfig.debug

between commit:

  06ec64b84c35 ("Kconfig: consolidate the "Kernel hacking" menu")

from the kbuild tree and commit:

  bbd89226bb66 ("fs/buffer.c: add debug print for __getblk_gfp() stall prob=
lem")

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

diff --cc lib/Kconfig.debug
index 46f755a60872,01ec99f1cf2e..000000000000
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@@ -1729,10 -1713,9 +1727,9 @@@ config KPROBES_SANITY_TES
  	bool "Kprobes sanity tests"
  	depends on DEBUG_KERNEL
  	depends on KPROBES
- 	default n
  	help
  	  This option provides for testing basic kprobes functionality on
 -	  boot. A sample kprobe, jprobe and kretprobe are inserted and
 +	  boot. Samples of kprobe and kretprobe are inserted and
  	  verified for functionality.
 =20
  	  Say N if you are unsure.
@@@ -1851,12 -1820,8 +1844,11 @@@ config TEST_HAS
  	  This is intended to help people writing architecture-specific
  	  optimized versions.  If unsure, say N.
 =20
 +config TEST_IDA
 +	tristate "Perform selftest on IDA functions"
 +
  config TEST_PARMAN
  	tristate "Perform selftest on priority array manager"
- 	default n
  	depends on PARMAN
  	help
  	  Enable this option to test priority array manager on boot
@@@ -2062,6 -2018,8 +2045,12 @@@ config IO_STRICT_DEVME
 =20
  	  If in doubt, say Y.
 =20
+ config DEBUG_AID_FOR_SYZBOT
+        bool "Additional debug code for syzbot"
+        default n
+        help
+          This option is intended for testing by syzbot.
++
 +source "arch/$(SRCARCH)/Kconfig.debug"
 +
 +endmenu # Kernel hacking

--Sig_/MAJjaLh58Iau11g91//MwJq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltkFCUACgkQAVBC80lX
0GxrlQf/SVZholYhG/AYcyN6U8Xh+3a11zWuzdqmj8ZUPxKLajb4ulE0R7PP4a/N
BkYF1P9OtQXClY2HTKQPmt+KP5SUThHeYYXk2+Uk388PAkt7jI+CPYc9pYUYU+s1
GnS7JGTC7Wv1ABGYQsHQpzJ3L2Kk8TOzf+vMROurb1+RWWvbHfijC2/tEuyQC5sh
Y+0u/6h/9DBQ9i7hoFIey5+33uCYPfpJ9jSdDXjQetfsR1aEUZ+ecGDQgh17r07R
vf+ocpqYZoaLk6zbeshUWsgiOPmlQL2GiixmFzv2+yG0R85rd+o5S8NLWXC4Akn4
r9cmICwSh4+6XhHXJJnS1ZggznM/2A==
=cDEf
-----END PGP SIGNATURE-----

--Sig_/MAJjaLh58Iau11g91//MwJq--
