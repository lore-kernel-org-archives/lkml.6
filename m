Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29866C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F63218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HaQpINCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfBRD1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 22:27:54 -0500
Received: from ozlabs.org ([203.11.71.1]:53323 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbfBRD1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 22:27:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 442q7V6MFwz9s3x;
        Mon, 18 Feb 2019 14:27:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550460471;
        bh=EnZSJ0lmXHUMZ7oaddG/0w8KNVS0r5OJwmBmT5l/fw4=;
        h=Date:From:To:Cc:Subject:From;
        b=HaQpINCkEUy0vog7pnQ9QLN5pgXMwud9m8NjUiJ8hRjwI1X2mHS6rx9L9igJaxG7f
         prCjsYNXz0O6RDYW/c9xtLga/MuoceERQQcndlu8EZ2fbyoc3SciOQTeFJ5ZE5LJ42
         YgN/WOYe01n80C5JkkeO1l/PRZHmQAvZCUNIrAFKVlHTpbmAG+/e83kDcLTHNcjZhh
         /Ic+6koSswS8JKTZlvwRvF+e+hF5O916qhhHYXPyVCRHbrC3ySJhCa+kZ1Y+Hx7U8m
         H6KgDBVEBsoykVBZcDdYpge/+eCT2uk0HHskbog0+SnldH4mq4zTZKRMpiw43tv8Ky
         8ZoCZBpiXlsHQ==
Date:   Mon, 18 Feb 2019 14:27:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luwei Kang <luwei.kang@intel.com>
Subject: linux-next: manual merge of the kvm tree with the kvm-fixes tree
Message-ID: <20190218142749.04daecaa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zq4D+8ArvcK_JRDm6BNeBnl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zq4D+8ArvcK_JRDm6BNeBnl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm tree got conflicts in:

  arch/x86/kvm/vmx/vmx.c
  arch/x86/kvm/vmx/vmx.h

between commit:

  c112b5f50232 ("KVM: x86: Recompute PID.ON when clearing PID.SN")

from the kvm-fixes tree and commit:

  abd2fb15a57e ("KVM: x86: Sync the pending Posted-Interrupts")

from the kvm tree.

These 2 commits are very similar so I just used the latter version of
the comflicting bits.

I fixed it up (see above) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/zq4D+8ArvcK_JRDm6BNeBnl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxqJjUACgkQAVBC80lX
0Gz+Nwf/WVzAAx/aqMYuwqlu9CBxLl71/F19xDtrLRYZmNOVihMu6UWezsKEgPDp
+ICSAyMI7rdgkSIml2kcdrPj7IVRUMw7dXUe2iU3/zT9ccg6qLrGZDwj7tCz5Qmo
MojziMb6YILT3lG2moiTQiCQk52X2AEfC/YupHL1ANk0DldqdWWVfTfg9JGnuWK5
X6LIOIYDKuMtduN6L8ardPgXeIYqJ7vKtDG4XRaTMnxR3DamzA5vPnym9Q0BSR2I
CNyt2vFJBon26NJqp1J4Ow9c70flDAJNEhY0PbuEfHrKSVdYYyVJUJhuf19EHLC2
r3J1hGdQB3MMLpGK0NEcU4RHvxYLCg==
=8t9u
-----END PGP SIGNATURE-----

--Sig_/zq4D+8ArvcK_JRDm6BNeBnl--
