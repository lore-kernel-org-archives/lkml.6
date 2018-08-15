Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3E3C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 04:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADE021534
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 04:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PrrorfjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADE021534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbeHOHOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 03:14:52 -0400
Received: from ozlabs.org ([203.11.71.1]:44743 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbeHOHOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 03:14:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qxF35V4Pz9s7Q;
        Wed, 15 Aug 2018 14:24:23 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534307064;
        bh=Nh2A90xJbr67PMhNyQ75I22ndXia35A2LUcHqHc6Wuc=;
        h=Date:From:To:Cc:Subject:From;
        b=PrrorfjFj0Qi9jl5b17paaZrFHjgt9kueRAv1BnWlTOWXskZD5QsXt5iEIM4fAI4x
         svRuz68rDNE/IwiS1BJ4uXhnugLGjGAH48rgEUhsV3IdRx5WJDWKf1TB3D8hLvCXX9
         xew5x9xudkcZyfAUAsA42VeIA16PgXVeqBtY34gfleASvFVq4sYmxAOWtOrgf26bfm
         Ftp7P3+bq+D73jmrTuWqOa3l5AsMlabGo6dzCKwKIdPHik41yOuv1gzaIVsknywTGY
         qMO7E9Gn12sr97Ro35wKifKEW7iIrcbgqI5c8zgkKRCabjk9TWyIWhLT0Q6nd/MwV/
         NLOmQFaFAyIYg==
Date:   Wed, 15 Aug 2018 14:24:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>
Subject: linux-next: manual merge of the kvm tree with Linus' tree
Message-ID: <20180815142423.03ee8eae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1OR5IY1NiBKGFC38Vf+v5vT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1OR5IY1NiBKGFC38Vf+v5vT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/x86/include/asm/kvm_host.h

between commit:

  5b76a3cff011 ("KVM: VMX: Tell the nested hypervisor to skip L1D flush on =
vmentry")

from Linus' tree and commit:

  4180bf1b655a ("KVM: X86: Implement "send IPI" hypercall")

from the kvm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/include/asm/kvm_host.h
index acebb808c4b5,c18958ef17d2..000000000000
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@@ -1418,7 -1457,10 +1462,11 @@@ int kvm_cpu_get_interrupt(struct kvm_vc
  void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
  void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu);
 =20
+ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
+     		    unsigned long ipi_bitmap_high, int min,
+ 		    unsigned long icr, int op_64_bit);
+=20
 +u64 kvm_get_arch_capabilities(void);
  void kvm_define_shared_msr(unsigned index, u32 msr);
  int kvm_set_shared_msr(unsigned index, u64 val, u64 mask);
 =20

--Sig_/1OR5IY1NiBKGFC38Vf+v5vT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltzqvcACgkQAVBC80lX
0Gwhggf/ctETGDs4D+j+ZclbWNzdrsRwImGfMqVPCgWj4yCipovQVpyPKTBC5148
8p0tUPzfIKH70jYNCLJ7ZM3SqzZDdq8nTGyzee6yK8mMYoQmZQWA/rK3PVxIy9OW
p2AwmgGSyLXhZbg93P+Y/nSgFtAcxC5cXp9CDrWn5pfBWyyM8cfLoP0Eeyp+BVfR
EMkyJAoCSqddKrC4CtuNeXsky3krLmqCZ7GgYz3W03AOh36VwioPCAOfCN+Y6J9K
ALYoEW8vES7Dw7aY3rhvY4MlMPixA3+DoL8qEWGg0sfKSJ6BF24Db6Ms40KFen6N
dBPY21fJi+wwDEznsq2vv9yrQfy6pQ==
=RgA6
-----END PGP SIGNATURE-----

--Sig_/1OR5IY1NiBKGFC38Vf+v5vT--
