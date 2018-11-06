Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7323EC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE372083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KhjB0f0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE372083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbeKFKIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 05:08:43 -0500
Received: from ozlabs.org ([203.11.71.1]:40961 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725760AbeKFKIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 05:08:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42prT05J7kz9sDT;
        Tue,  6 Nov 2018 11:46:12 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541465172;
        bh=JR6OcGsOqeOqPLXq6nGmhkMblAMHHzB2nj8bdENocnw=;
        h=Date:From:To:Cc:Subject:From;
        b=KhjB0f0AiUnMIwbYQV8UsiSz/NdsXgj3O864do3DN6bElqT11qXLnRbvnKbaIMFwy
         MkRXe6a/HQTk7a2TsvZTyj6y2b/4pl3aSDkJXQKqAoXDB/dMz/nLwSsWDGvw8TWX5/
         PASWAXO0rMmBOmbpLZ+xE3pjtkGSvwav2RcCDBrAch9y5sCZKvNgglqRjupF7WdO6n
         W5Q53YJSAorfgJFwa88dQyUTbx++4vpmRZsreHmVDiqtPM1dhHD1ZVvPmg7SZaViBC
         wFoJqO7gOcvx/vyrJIWpWIHtZzOXDd7Sf9Kzpv7IS2wxkhHCM77d3I6J1Yoo6V1Btm
         9BzskjdeMYyuA==
Date:   Tue, 6 Nov 2018 11:46:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: linux-next: build warning after merge of the tip tree
Message-ID: <20181106114612.7de37ce1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/N6lF17XaqNoDIvuq=/eVQdC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N6lF17XaqNoDIvuq=/eVQdC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

warning: include/asm-generic/atomic-instrumented.h is out-of-date.
warning: include/asm-generic/atomic-long.h is out-of-date.
warning: include/linux/atomic-fallback.h is out-of-date.

Exposed by commit

  8d32588077bd ("locking/atomics: Check generated headers are up-to-date")

--=20
Cheers,
Stephen Rothwell

--Sig_/N6lF17XaqNoDIvuq=/eVQdC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvg5FQACgkQAVBC80lX
0GwzrwgAhMwHEY0O0SoRXUoAooVfrZ2qjDJASJviFmmamTrwW8/ZlELKByNFgwEg
wqE8CfU2XVQszSFt/GJ+2t5eFoUW8ETnnDPTq54wD55Ux3PK9D/zzCI+jipMXBht
4M/LK4BB/UyJVlXonpAnW4WDFfP0ZCpZ2eLAyukmPwm5jCANV9JlvxwvW5VxVQvT
Ds2Q7upwkIodzD6cxwjLt/W+zFcKQ89IQwgsOP02SPDa+KGV0zYaBigl2hWcp5Wv
8Uoj34273ywDn6saTbBdndvzCIu7jnw2Wr5uzJCQ0PlhQWHqfDztKc1B9AxysHzK
flAVrng/xB8Anew1y8Nz/9xurayfYw==
=Z6vy
-----END PGP SIGNATURE-----

--Sig_/N6lF17XaqNoDIvuq=/eVQdC--
