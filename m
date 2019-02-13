Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ED6C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3E7222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tNemEN1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbfBMGte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:49:34 -0500
Received: from ozlabs.org ([203.11.71.1]:46135 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfBMGte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:49:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43zqrV5wC9z9s5c;
        Wed, 13 Feb 2019 17:49:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550040571;
        bh=mCIOb0ADz4WtQRLQC81fOoAZNjpyhJw0QmXZufwVGfc=;
        h=Date:From:To:Cc:Subject:From;
        b=tNemEN1M3ZP+7WBfh/OqtcwVWf3rww3cYqtQRSpQgWNqMC8VGL503PHlEVIlMxSHt
         1vuNR1z40EC/BrDdw4vkUYipptyfH81IMMaDv+Fw3E8xKftrmJf8B0fJp2FGcTkk/r
         Vnm/AIi2+0kzW1QH9SjZs2l+dP5UCet28dsK9PkkuQIfKxcKYU1VrbbwMVr4pE82+m
         7IVtcFrnIuRVruLHc2QLX7L/UTkVvF+V/GLmwYjEXZLTz+ulLCm/+hJ03k13mYn7Sy
         cKSpHftNiWT8bXZU8NI2IoB/xk4O6g9eVSlJXDWWFAsg7RDLVxiXc6m/8mcke1yIzZ
         dxOQ559jykNGQ==
Date:   Wed, 13 Feb 2019 17:49:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: linux-next: manual merge of the akpm tree with the tip tree
Message-ID: <20190213174928.18128be0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/46bUxRtCSLx_u3UBCkH3naR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/46bUxRtCSLx_u3UBCkH3naR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  scripts/atomic/check-atomics.sh

between commit:

  4ad119545d78 ("locking/atomics: Check atomic headers with sha1sum")

from the tip tree and patch:

  "scripts/atomic/check-atomics.sh: don't assume that scripts are executabl=
e"

from the akpm tree.

I fixed it up (this latter patch is now needed against the new
scripts/atomic/gen-atomics.sh instead) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/46bUxRtCSLx_u3UBCkH3naR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxjvfgACgkQAVBC80lX
0GxhPQf/WZPKKMkkBisXpXhIIF+AQilxcK4XmHrYowxx1ih4uoPYys+Y9eRvfvk4
eXSeyTcUovEWn8BmMKtGNNLSAEa9tdweE1NfPQ5TDRUqW8xTEeKShK9JFLYXoQMd
/GU4DtWNfXVPkC/HWSclSV00G+Gz4Z+zqVbVehkYgs0x4X8lxo4GXUuqO11797Ib
1sZtHKLpmDlXnOOYySDkkRuuTY7sTwmAC4D/Y/m8agSpHXpBxeXGlTVY5XYNMFpF
YGrD5Xk2fGiHyzmcHRyYh2NBF3ukk1SdmR1WQmetcTggnw8IH9W5UNBc6t0qhEVi
MDy1gBe+xlRo4LbsSN9cuIYefIAjxw==
=ZAbZ
-----END PGP SIGNATURE-----

--Sig_/46bUxRtCSLx_u3UBCkH3naR--
