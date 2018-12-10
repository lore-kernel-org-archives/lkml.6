Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A68C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68A82146D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uBkAv19U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68A82146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbeLJVxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:53:23 -0500
Received: from ozlabs.org ([203.11.71.1]:49341 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbeLJVxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:53:23 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43DGzM3sx6z9s3Z;
        Tue, 11 Dec 2018 08:53:19 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544478799;
        bh=RFlzYzntr8AAkIOhsxW4s9XG7lAhTInPS5Dghu5tAnU=;
        h=Date:From:To:Cc:Subject:From;
        b=uBkAv19UtIOSziMtWhSG62oFcvzo3V/p9HqYxRhJLiR4YI82SX7Ij7AaacFaD4jMV
         s10bdzdaFFrtrCzHb56T6qZ1vz7UCYlCc3Ipvy5OqXj1qolCvYrNWTtrYEVfwHB1fV
         RPy6u1Mk0lqzkVHZj9E4lZNl9RQPywDRvnv9uYEfKltffFwWr9cc8gAzpBydiYri5l
         CA6LBhIx8dd/TVB4Blt1vJhCGllTKRVV0b9Jy+auxVyqp1UEOnVkDMXa+XHXe+rl7v
         XoTtdvTeMJnd/mkY5jG3DR5/L91ncR+GJKhsm0FJw9F5v1PsljzcP0ZNWchpXYqMAi
         JMb8lTToVHqWw==
Date:   Tue, 11 Dec 2018 08:52:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: linux-next: manual merge of the arm64 tree with Linus' tree
Message-ID: <20181211085257.6e689038@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VrS5QPttYezG16fiWIRB03H"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VrS5QPttYezG16fiWIRB03H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm64 tree got conflicts in:

  Documentation/arm64/silicon-errata.txt
  arch/arm64/Kconfig

between commit:

  ce8c80c536da ("arm64: Add workaround for Cortex-A76 erratum 1286807")

from Linus' tree and commit:

  a457b0f7f50d ("arm64: Add configuration/documentation for Cortex-A76 erra=
tum 1165522")

from the arm64 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/arm64/silicon-errata.txt
index 8f9577621144,04f0bc4690c6..000000000000
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@@ -57,7 -57,7 +57,8 @@@ stable kernels
  | ARM            | Cortex-A73      | #858921         | ARM64_ERRATUM_8589=
21        |
  | ARM            | Cortex-A55      | #1024718        | ARM64_ERRATUM_1024=
718       |
  | ARM            | Cortex-A76      | #1188873        | ARM64_ERRATUM_1188=
873       |
+ | ARM            | Cortex-A76      | #1165522        | ARM64_ERRATUM_1165=
522       |
 +| ARM            | Cortex-A76      | #1286807        | ARM64_ERRATUM_1286=
807       |
  | ARM            | MMU-500         | #841119,#826419 | N/A               =
          |
  |                |                 |                 |                   =
          |
  | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_223=
75        |
diff --cc arch/arm64/Kconfig
index 0d9a45f948c2,4dbef530cf58..000000000000
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@@ -478,24 -504,18 +485,36 @@@ config ARM64_ERRATUM_118887
 =20
  	  If unsure, say Y.
 =20
+ config ARM64_ERRATUM_1165522
+ 	bool "Cortex-A76: Speculative AT instruction using out-of-context transl=
ation regime could cause subsequent request to generate an incorrect transl=
ation"
+ 	default y
+ 	help
+ 	  This option adds work arounds for ARM Cortex-A76 erratum 1165522
+=20
+ 	  Affected Cortex-A76 cores (r0p0, r1p0, r2p0) could end-up with
+ 	  corrupted TLBs by speculating an AT instruction during a guest
+ 	  context switch.
+=20
+ 	  If unsure, say Y.
+=20
 +config ARM64_ERRATUM_1286807
 +	bool "Cortex-A76: Modification of the translation table for a virtual ad=
dress might lead to read-after-read ordering violation"
 +	default y
 +	select ARM64_WORKAROUND_REPEAT_TLBI
 +	help
 +	  This option adds workaround for ARM Cortex-A76 erratum 1286807
 +
 +	  On the affected Cortex-A76 cores (r0p0 to r3p0), if a virtual
 +	  address for a cacheable mapping of a location is being
 +	  accessed by a core while another core is remapping the virtual
 +	  address to a new physical page using the recommended
 +	  break-before-make sequence, then under very rare circumstances
 +	  TLBI+DSB completes before a read using the translation being
 +	  invalidated has been observed by other observers. The
 +	  workaround repeats the TLBI+DSB operation.
 +
 +	  If unsure, say Y.
 +
  config CAVIUM_ERRATUM_22375
  	bool "Cavium erratum 22375, 24313"
  	default y

--Sig_/VrS5QPttYezG16fiWIRB03H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwO4DkACgkQAVBC80lX
0GxUKAgAoEbJ1qc+Ct7woPIsnJYrNJI/SFxoQ79RJQGVPR5yaMOkOl7ng3G8dMY+
w36bKwtndk+yKWFEt2RaEFTi8k5G5GPBwd5/vSCAHxlmbxcTlLQ0JAb8abhTg4pa
g2Lo0qeemDTWUkDJc5sMbydZO5Drxy//EBAYu1jmjnj9lgPVrdNBUCz1fnXSd7aW
yLqSsM6lOvrdy4KMu1kJ3vjYFts6IUrx0xHVaTjXonUXZk79c8Cht6ylzEN1GESx
OQi96uTnZTKry0nlUEL4Wqtu3QOIeJo1X5VzY2svo6bCbtkIXwVtqhSYQeD+vouD
QTALj2bhMA7dHLmNLJEUFSNTqsRWGg==
=/k/H
-----END PGP SIGNATURE-----

--Sig_/VrS5QPttYezG16fiWIRB03H--
