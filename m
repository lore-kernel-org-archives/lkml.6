Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4A3C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F5721723
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dYyff9To"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F5721723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbeHOCJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:09:43 -0400
Received: from ozlabs.org ([203.11.71.1]:39183 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729705AbeHOCJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:09:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qpV42WqPz9s0n;
        Wed, 15 Aug 2018 09:20:12 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534288812;
        bh=HXnFjj2q27PQj5Ulfg/11snEeUEzGIQ0WYCeZ5ofm/Q=;
        h=Date:From:To:Cc:Subject:From;
        b=dYyff9To4uFEFF0L1uNE5IhP5uir/ho5aiyiQpWaYcEA4qODJ1kSHbjrZaMgmCMFT
         rPYeD1v7siAeIXTFFZ9hkULHLoZoAwtmUez/TeHgY2GYEd7SU3OKH+Ddrkry8SzBuo
         tKQsXTGt9IxswtCpco3vLS9e2Yb9oF4pXGb2fL9hDNk7Ne2i7+hJ8ffo18sppkz0+n
         W9CiX7XxdeQ4nFkIY/813MbiKdcaETbkkXoFLm2ZQOUk9C3xZIBg1jWH76oaLUZkCB
         FFgCzrOxcOaeWAqUOkXfNlaFHIQTQp8SaO12I7LMZhZlpMHaEcZJVjejht9YG+tVzD
         AH1kWXfRceH9g==
Date:   Wed, 15 Aug 2018 09:19:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Diana Craciun <diana.craciun@nxp.com>
Subject: linux-next: manual merge of the powerpc tree with Linus' tree
Message-ID: <20180815091945.16b2ead9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eOa9bvzEeNV/i6qES_KhouF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eOa9bvzEeNV/i6qES_KhouF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  Documentation/admin-guide/kernel-parameters.txt

between commits:

  05736e4ac13c ("cpu/hotplug: Provide knobs to control SMT")
  506a66f37489 ("Revert "x86/apic: Ignore secondary threads if nosmt=3Dforc=
e"")

from Linus' tree and commit:

  26cb1f36c43e ("Documentation: Add nospectre_v1 parameter")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/admin-guide/kernel-parameters.txt
index 5a67e409d370,4167bbea51e1..000000000000
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@@ -2761,10 -2687,10 +2761,14 @@@
  	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
  			Equivalent to smt=3D1.
 =20
 +			[KNL,x86] Disable symmetric multithreading (SMT).
 +			nosmt=3Dforce: Force disable SMT, cannot be undone
 +				     via the sysfs control file.
 +
+ 	nospectre_v1	[PPC] Disable mitigations for Spectre Variant 1 (bounds
+ 			check bypass). With this option data leaks are possible
+ 			in the system.
+=20
  	nospectre_v2	[X86] Disable all mitigations for the Spectre variant 2
  			(indirect branch prediction) vulnerability. System may
  			allow data leaks with this option, which is equivalent

--Sig_/eOa9bvzEeNV/i6qES_KhouF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltzY5EACgkQAVBC80lX
0GxLoAf+ICsDkgWQEtbkv5uSmmzKHAuvyGjRsEdxd6t4UEHyhqH17jOxVNALCnSS
yFf6xCAqDe08T006mSRKtji48cJAwTTzSvidQVlm6+QA0rQMmyzKprxtFQunAYyx
HUl5KhFzL8ZuuASDZcdlRfayt5/Ve4p+Wp5N4YknUpagHQ9XQzoizQUVp+UwSErb
2lyaebPZP4A2SZc4gxndxvlO/pLLpEnzrESzrIb4p1fD3NB0hYvnA7QcSoUmR4v4
KC9gHzcJoFEyqbywZUSxLzEk2qRsjhkfNdUCoJdkwQ9YPM3/ows8g01DgDi/sk49
3dxwTZLuLOGopdzA6SIK6GUdaNrsjA==
=Cpuw
-----END PGP SIGNATURE-----

--Sig_/eOa9bvzEeNV/i6qES_KhouF--
