Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2C4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12F720851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KGeDR4CF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfAQWb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:31:58 -0500
Received: from ozlabs.org ([203.11.71.1]:36131 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfAQWb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:31:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43gf2K6KlWz9sBZ;
        Fri, 18 Jan 2019 09:31:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547764315;
        bh=plpHrhB1lCjH8EvKGtgeLyOUdwg63dbWnLV3KXy0ZFM=;
        h=Date:From:To:Cc:Subject:From;
        b=KGeDR4CFo4yslzL9xv8X4uBfgHLRIYWL0t3TN2Cy6YB+3Bxz+Fxwh6frzDYRk/Wqy
         iH5CfzzGkeGmonsgtrMdSiOqcqxhcpL8qfiQjK/YCzRTAcP4sc9PklggHE23G+alg+
         E80Tw0h0iA+TNs0KRT+2rNdQ+prfEmGQeVyLckDtrHThEhaNNGbJNhqavcPIgoSwL4
         7rlqIMlOc8U8KjMRGM4Do7BjeY6odDjplsXIRxtFi4/dS5N7rqfPsHjdUoMNqSe5Zj
         KBZ7UjHQAsw/kM63PfGrr5JxEHkkAIQQXgQgW16WWieY5O7aCAAoT5tpAKdDHso01i
         3MR0cAdoaKF8w==
Date:   Fri, 18 Jan 2019 09:31:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20190118093135.39cf071e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AqHG0K4+LaYSP5cre78SC7M"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AqHG0K4+LaYSP5cre78SC7M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  a31e184e4f69 ("x86/pkeys: Properly copy pkey state at fork()")

Fixes tag

  Fixes: e8c24d3a23a ("x86/pkeys: Allocation/free syscalls")

has these problems:

  - SHA1 should be at least 12 digits long

--=20
Cheers,
Stephen Rothwell

--Sig_/AqHG0K4+LaYSP5cre78SC7M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxBAkcACgkQAVBC80lX
0GwqQgf/R7FSce8yihSxWinaT3Z/YltX1oHHs9AIPl82Ent2gd6gwX7Ix5pvBHLT
B4VLjtxDJBq822TVI4UxWT7cjFTJ++u40OiPj5AORzy3ygVwrf/bYHV1lPBSf4zg
i8/R9aNmefUj/Ui7He3V4G6/gYNl4/UVyDHQBHfz4mVmUjFTUNLNuaEN6nd4cw/i
ZZ00Ugv5ZV7xBSBX+0Yu09jrbDbNMzoNUC+bVJZ39Jqy1V0bHDe52OhNpepdizaE
Nk5diD+BgM7FrOgblT0AreymtJQDOe9wABz5vhdJpkz2dJu4Z2ZGu3aXKqBaPOYd
gkwYTA/0uH7EowhAm5MOmhIQdIndGg==
=ECMj
-----END PGP SIGNATURE-----

--Sig_/AqHG0K4+LaYSP5cre78SC7M--
