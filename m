Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8425AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C4A2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FqdvmRLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbeLQFWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 00:22:39 -0500
Received: from ozlabs.org ([203.11.71.1]:42553 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbeLQFWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 00:22:39 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43J8fv52lzz9s8r;
        Mon, 17 Dec 2018 16:22:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545024156;
        bh=SQ0vqzxqHO0cZNxGkzFDfeMICmQLIabYvMcs6qDBxfA=;
        h=Date:From:To:Cc:Subject:From;
        b=FqdvmRLiwGu9z/YrKX1BWHJRDi9rQSsflcRjrreeB7TuY9otT+fq9SR3i5JMUBNzk
         cFs0OxlOia9B4st9/gV4o6Eb7adOemSWIWEp5H9jo3CJdxmjLIZ5RbyAnV/wKEIEnM
         IYIEOW1EdvmpuK7qd+JzmumuHu+fYleZJSkyffWLt/zOkD4kWHYgBYRgihefVSKuPc
         2hEgvEDRbyn0oxH5k4xeSQLEQ1UQ+eDvx959jXy+MYUdfwj1pm7Ycn78Ve/D+wYJa6
         KV4RofkK/nesEh7hYcB9yfPqDCHz/UJyZKxZjmOYIkR5r9j38l+gcd48d4oQ0OgHqv
         k9gctqSgwjyKw==
Date:   Mon, 17 Dec 2018 16:22:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: linux-next: manual merge of the kvm tree with the tip tree
Message-ID: <20181217162228.3c30feec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OyfY+_NdlGcil7qPBSyO+8H"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OyfY+_NdlGcil7qPBSyO+8H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/x86/kvm/vmx.c

between commit:

  a97673a1c43d ("x86: Fix various typos in comments")

from the tip tree and commit:

  a821bab2d1ee ("KVM: VMX: Move VMX specific files to a "vmx" subdirectory")

from the kvm tree.

I fixed it up (I removed the file and then made the same changes to
the file in its new position (one change was already fixed)) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b8fa74ce3af2..c90fffdc5a93 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2214,7 +2214,7 @@ static __init int alloc_kvm_area(void)
 		 * vmcs->revision_id to KVM_EVMCS_VERSION instead of
 		 * revision_id reported by MSR_IA32_VMX_BASIC.
 		 *
-		 * However, even though not explictly documented by
+		 * However, even though not explicitly documented by
 		 * TLFS, VMXArea passed as VMXON argument should
 		 * still be marked with revision_id reported by
 		 * physical CPU.

--Sig_/OyfY+_NdlGcil7qPBSyO+8H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwXMpQACgkQAVBC80lX
0Gw8FAgAhFK77KopU/9fKE7F73xZ3etOlp4ecy3B4jU0B8YCxmWHhCha+dBgk6ki
YobgAJx7P+tl3qbEixAqrZsMD2K/ACBA6hiyuqOZqPHoYI8mwGc1oP/mQ1jzGPCY
GyNbYnyHt8wtTvOmrZfRdEtSV8cujZjSUEX7sqzmC5e7DA6BfBF1IF9662sYLNB/
yX4UYeV/TrkzJZgRHX4NXc6LIe8GUV0jgSr41kUaZh1BHysgOeG6r26dob+TLwCi
V3wsbolivyFmK3ZHKQsk9z2BPoD6qQtWtHc+tEUNFeIIF2c3mtFxtua5+s31RHgy
oMv9DMXSOxQJG9hprh8eeNQRPh8vag==
=YaXU
-----END PGP SIGNATURE-----

--Sig_/OyfY+_NdlGcil7qPBSyO+8H--
