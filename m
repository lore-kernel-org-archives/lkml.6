Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C84ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2543521470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EyCJ8hsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2543521470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeJRKgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 06:36:16 -0400
Received: from ozlabs.org ([203.11.71.1]:37385 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbeJRKgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 06:36:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42bCrD5WLVz9sBk;
        Thu, 18 Oct 2018 13:37:32 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539830252;
        bh=ghz9NABgz8TN4CV6le1vCAMo/S2eZUuuLlVYk1OxVEY=;
        h=Date:From:To:Cc:Subject:From;
        b=EyCJ8hspfiQnUhcmuKR4PNrQB24ZlReW5pzE3fYskPh65/DxlgVNa2N+zP1nyLoEG
         WD4NL/HbzIGRj03ajpsV6mZ6c+3W14R7zUYwYO8fbttNDybErFtv5jXEaT8Aj7t0HI
         qCLMtjnkkb9SEQW6pPmtfloWnxNL++MZoTYwmyDz0kPjtZO1G2+sJZhTC8w8JwfP32
         SEzoIrTdrJQf0FoXGBV77Q57kxNbgq/ltHePPB7G0+9Mo5KNgRakTTag6g+GZUtlg0
         6pPCfqdiCuu8GV/MficIjOH96CeBrRMJpeVzF6a278dneV6MRLYtMdljNag2YD8GFD
         irLBOm9QfvCmQ==
Date:   Thu, 18 Oct 2018 13:37:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>
Subject: linux-next: manual merge of the kvm tree with Linus' tree
Message-ID: <20181018133731.12efd882@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/BPbrHQzprApBsXaeGGEniYO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BPbrHQzprApBsXaeGGEniYO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/x86/kvm/vmx.c

between commit:

  5f8bb004bca4 ("KVM: vmx: hyper-v: don't pass EPT configuration info to vm=
x_hv_remote_flush_tlb()")

from Linus' tree and commit:

  a5c214dad198 ("KVM/VMX: Change hv flush logic when ept tables are mismatc=
hed.")

from the kvm tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/kvm/vmx.c
index e665aa7167cf,abeeb45d1c33..000000000000
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@@ -1567,19 -1577,15 +1577,19 @@@ static int vmx_hv_remote_flush_tlb(stru
  	if (to_kvm_vmx(kvm)->ept_pointers_match =3D=3D EPT_POINTERS_CHECK)
  		check_ept_pointer_match(kvm);
 =20
- 	if (to_kvm_vmx(kvm)->ept_pointers_match !=3D EPT_POINTERS_MATCH) {
- 		ret =3D -ENOTSUPP;
- 		goto out;
- 	}
-=20
 +	/*
 +	 * FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE hypercall needs the address of the
 +	 * base of EPT PML4 table, strip off EPT configuration information.
 +	 */
- 	ret =3D hyperv_flush_guest_mapping(
- 			to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
+ 	if (to_kvm_vmx(kvm)->ept_pointers_match !=3D EPT_POINTERS_MATCH) {
+ 		kvm_for_each_vcpu(i, vcpu, kvm)
+ 			ret |=3D hyperv_flush_guest_mapping(
 -				to_vmx(kvm_get_vcpu(kvm, i))->ept_pointer);
++				to_vmx(kvm_get_vcpu(kvm, i))->ept_pointer & PAGE_MASK);
+ 	} else {
+ 		ret =3D hyperv_flush_guest_mapping(
 -				to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer);
++				to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
+ 	}
 =20
- out:
  	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
  	return ret;
  }

--Sig_/BPbrHQzprApBsXaeGGEniYO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvH8esACgkQAVBC80lX
0GzUtwf/f9l6eGjmKQRJnv2Pc+dW+IpNvGQTiBE0Ivxw1iCx4kymjPPts7cm1aFs
QQJ69xAt46AO4dpmSLBl/lcD5DznlSsvMQ8D6ir5QicoVQ8dcZuDUnbKFHRdWsCq
FNTISeP6OgWL6KCgMVWQVOcdhHNEPk3sDVBFkj1sTn4DJvyWsBs55DZDtHwf5Fc4
SdzMBimAgY7JxzFGSRuLFy9ikInDvw0VAoeU81ONXoYE2cUu6I4UhOCdAEOBgXEJ
jOqOzJyuRnChPC3C0qULnDtRBIMfcaG4xwniaK8dcEcdRN4FYhrbdvO8+E7SRcBH
t1d2iFFR/DO9JBSdfu2iQ8+6hXrqSw==
=Oy8l
-----END PGP SIGNATURE-----

--Sig_/BPbrHQzprApBsXaeGGEniYO--
