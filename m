Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F34C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC2020672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YmnvJB7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC2020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbeJ2MP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 08:15:59 -0400
Received: from ozlabs.org ([203.11.71.1]:50975 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729231AbeJ2MP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 08:15:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42k0Sh3fd5z9s7h;
        Mon, 29 Oct 2018 14:29:08 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540783748;
        bh=WE5UbtH6QfhUwzN2O8U2Lhj902t+JV2KxBq6n2XqyIE=;
        h=Date:From:To:Cc:Subject:From;
        b=YmnvJB7Tvx9FOawgplPRBxLXJ4C946xpANmjsXj0/I8gVU9pi8qWULOnynrqOB5Fj
         egmVtlBBPGjSWFeuUV3H4c46e1c1e81l4+X0TeZt7B5BjzTu9kVWndoLbN+GRl9aZ1
         O0PXmOaLsxJZOTczVhOnwAiYwhTY8nzBkPuw040asUPL1/ppEg3D6rzdRwij1XQ+uj
         M93P/IIcAwOehllFQs6kxFP37doHXb+e8ZiiiLK2SalIh0k0v+BUD1NS83d+Cxtwkw
         huKE0KYAz7qWkOFgC5ti2OrWSyjuXs02xHl/ZHmDMXJjH1T7eIOOu2ZppeIB+ARRKn
         43VxAW4wHvmGQ==
Date:   Mon, 29 Oct 2018 14:29:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: linux-next: manual merge of the drivers-x86 tree with Linus' tree
Message-ID: <20181029142907.54af8715@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Z70_.MwEBWKiMq+VPT.I5xX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z70_.MwEBWKiMq+VPT.I5xX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drivers-x86 tree got a conflict in:

  drivers/platform/x86/intel_telemetry_debugfs.c

between commit:

  f2c4db1bd807 ("x86/cpu: Sanitize FAM6_ATOM naming")

from Linus' tree and commit:

  1a7938a632ce ("platform/x86: intel_telemetry: Get rid of custom macro")

from the drivers-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/platform/x86/intel_telemetry_debugfs.c
index cee08f236292,30988e31c713..000000000000
--- a/drivers/platform/x86/intel_telemetry_debugfs.c
+++ b/drivers/platform/x86/intel_telemetry_debugfs.c
@@@ -319,8 -308,8 +308,8 @@@ static struct telemetry_debugfs_conf te
  };
 =20
  static const struct x86_cpu_id telemetry_debugfs_cpu_ids[] =3D {
- 	TELEM_DEBUGFS_CPU(INTEL_FAM6_ATOM_GOLDMONT, telem_apl_debugfs_conf),
- 	TELEM_DEBUGFS_CPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS, telem_apl_debugfs_conf),
+ 	INTEL_CPU_FAM6(ATOM_GOLDMONT, telem_apl_debugfs_conf),
 -	INTEL_CPU_FAM6(ATOM_GEMINI_LAKE, telem_apl_debugfs_conf),
++	INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS, telem_apl_debugfs_conf),
  	{}
  };
 =20

--Sig_/Z70_.MwEBWKiMq+VPT.I5xX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvWfoMACgkQAVBC80lX
0GyGFwgAm4/uf6yaHxuA5bCMWjTt9NQIImmssHqyY2cr2IQY3GY3+0/AVeQAGsxj
9fDAnQlOktEflmWLa4zdaiw4Wb4dtNvqPIRoSKgtjFTjuBbT1cWfx5PpWZ7QhnfF
7vNY43lMzxkhZu+1dXHgENtn2ZnmEYc+jcpVu2PUJxDIq9ODi5b4NUBdvC0kPsl7
pC9a3MCzegAzMrQFYBJEtRMgnkGQyEeCbt1zDqE4PKXqf5RMBxVd+OdOKCkswUAG
mkeGfHbn/HAKleFE0pZN6oXHVeQpuqQkp1Vu0R0ex2saXawYecGv0NmkaMumwIj+
KN4ia4Gqnm8PE+RtElKLQ8dHq4pZtg==
=0YUy
-----END PGP SIGNATURE-----

--Sig_/Z70_.MwEBWKiMq+VPT.I5xX--
