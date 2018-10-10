Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAB3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CA421502
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RmmUdi0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CA421502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJJJmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 05:42:23 -0400
Received: from ozlabs.org ([203.11.71.1]:45253 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbeJJJmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 05:42:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42VHtV0x7pz9s89;
        Wed, 10 Oct 2018 13:22:26 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539138147;
        bh=IGjkAzQrxl+6QHtXSFigLg0x2DBvHXfXgfRmwzJ48CY=;
        h=Date:From:To:Cc:Subject:From;
        b=RmmUdi0Hzqll5eJiYmE+f468ARGy+WJ0ea34kry2ch5a3Qyq9qIWuRvfUKL63VVnE
         RVQBPBe1s43OGpd5apL0H5UFZpMNIAHM7lYGja8ulECJFiL6vZrcCDXgBfQeAhuMu2
         EHObfVAs2sgZSnTwPac2iLM04IDDADetbA5vFaCFFH8vyeDWXHAkTNeA/O36WBLtgj
         bxWuu23JmPrSJMAhM7bG51l60Zr5eaQaRsGqtnR8VJp1+D/JnhrgTmoWGR/Nb11/t/
         6XAE8UtYZsjXUTc1Mwij2TYDaJQs0wzYp3LzLymhcku7DVk1gDFvbBGUoHXMSLxnNg
         tUyqJYXgqshZw==
Date:   Wed, 10 Oct 2018 13:22:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Mackerras <paulus@ozlabs.org>,
        Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: linux-next: manual merge of the kvm-ppc tree with the kvm-arm tree
Message-ID: <20181010132224.3bee4dfd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jUZNyJW=i.M6Y78wRuxKMWM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jUZNyJW=i.M6Y78wRuxKMWM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Today's linux-next merge of the kvm-ppc tree got a conflict in:

  include/uapi/linux/kvm.h

between commit:

  233a7cb23531 ("kvm: arm64: Allow tuning the physical address size for VM")

from the kvm-arm tree and commit:

  aa069a996951 ("KVM: PPC: Book3S HV: Add a VM capability to enable nested =
virtualization")

from the kvm-ppc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/uapi/linux/kvm.h
index 95aa73ca65dc,7f2ff3a76995..000000000000
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@@ -962,7 -954,7 +963,8 @@@ struct kvm_ppc_resize_hpt=20
  #define KVM_CAP_NESTED_STATE 157
  #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
  #define KVM_CAP_MSR_PLATFORM_INFO 159
 -#define KVM_CAP_PPC_NESTED_HV 160
 +#define KVM_CAP_ARM_VM_IPA_SIZE 160 /* returns maximum IPA bits for a VM =
*/
++#define KVM_CAP_PPC_NESTED_HV 161
 =20
  #ifdef KVM_CAP_IRQ_ROUTING
 =20

--Sig_/jUZNyJW=i.M6Y78wRuxKMWM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu9YmAACgkQAVBC80lX
0GzPUwf/beJrwh6ID6KINY9Diqed8gPTXuPQcBdCrnkkBNF6CMbq/nAQdqXtPnmQ
Zz2WDzdPTLyhrEzecJTdBdjIGmdoGJLrfMrwoGsEINrM7M9LoB3uuXLiThtRrH4o
2szKSOn+dcld0kruRihAfXRjm2J/pqzONqnt3GCF6v3ce3HnqNhgY7xMaO5lnbde
btFkAHBshrE0JbaTujmzBxTMUreCYl3l4Lptcw09lF3NznEimciZpCTTlpwKRwyx
2mq2nUsBdCx5kW4Cm/NG2SKp+5NE5nB9vTRI/1Qyn0apF3yeO8un22mPJV4sL2UY
sskWz7y/Tv8tb61cI6YbajpVbo926Q==
=PevZ
-----END PGP SIGNATURE-----

--Sig_/jUZNyJW=i.M6Y78wRuxKMWM--
