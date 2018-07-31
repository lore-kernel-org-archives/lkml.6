Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F01BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C534A208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OtSruYGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C534A208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeGaGCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 02:02:03 -0400
Received: from ozlabs.org ([203.11.71.1]:34961 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbeGaGCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 02:02:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41fjx82rXkz9s1x;
        Tue, 31 Jul 2018 14:23:40 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533011024;
        bh=mg4xmd5/3NYDeT9FF7cpkaYmtLsdZn7hntsND+HDFQw=;
        h=Date:From:To:Cc:Subject:From;
        b=OtSruYGGf0DmKUM13cLKHGENO6nN3/JQqY2V61DXUZ58yGvhpXDk/f8ztDSYK2pNx
         +VJRw/LPVZ8hdqBbQ7e0pwidMKFRNAG/a7OPt9VsH4SBrBsw8JSMmVQluPv9MuYaBB
         H/irb4HxkGoSFIu9yIBrLkeB8tLGD9eKJE7TeIkrRwogYpns1q7su75A1HY03Tp0B9
         Tu/LivUwZLsxrfICujhwwDn9pt0z3PQ40ia4soa2DnBZqW6cCM2G9aKjqVOM6tQc9S
         Ub0fWAOZUVsaYY/A1IR3B4m9sITswo7eegepN8j25tXGbCxEy4nAvbCtphI2C39mbV
         MpwYGilhFsBAg==
Date:   Tue, 31 Jul 2018 14:23:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>, Dongjiu Geng <gengdongjiu@huawei.com>,
        Janosch Frank <frankja@linux.ibm.com>
Subject: linux-next: manual merge of the kvms390 tree with the kvm-arm tree
Message-ID: <20180731142339.19b52ce0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nEZ6t2b+ZEPlWeO82bQubcz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nEZ6t2b+ZEPlWeO82bQubcz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvms390 tree got a conflict in:

  include/uapi/linux/kvm.h

between commit:

  be26b3a73413 ("arm64: KVM: export the capability to set guest SError synd=
rome")

from the kvm-arm tree and commit:

  a449938297e5 ("KVM: s390: Add huge page enablement control")

from the kvms390 tree.

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
index a7d9bc4e4068,b955b986b341..000000000000
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@@ -949,7 -949,7 +949,8 @@@ struct kvm_ppc_resize_hpt=20
  #define KVM_CAP_GET_MSR_FEATURES 153
  #define KVM_CAP_HYPERV_EVENTFD 154
  #define KVM_CAP_HYPERV_TLBFLUSH 155
 -#define KVM_CAP_S390_HPAGE_1M 156
 +#define KVM_CAP_ARM_INJECT_SERROR_ESR 156
++#define KVM_CAP_S390_HPAGE_1M 157
 =20
  #ifdef KVM_CAP_IRQ_ROUTING
 =20

--Sig_/nEZ6t2b+ZEPlWeO82bQubcz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltf5EsACgkQAVBC80lX
0GxisAf6AtkO+NzX7TVrH3tcMfNfJH5uUQ+76ApOnE6kER19CTw8qBLvYZnFXksT
66Pr/p7yLlvTnabRx9e4lF9IdHzK2KmdnCxglE+mBmPMoLsGVQvIV1E64cNzk2oe
0vDIAD6Y1MO0i8jkOI1oVHoCcJyZXTVFQepRY1+sLz0mvwtqT0U++w+FEkCkiYS2
Fc3KSf1Q1TpzOJL/MXlybC+IYaPPEiMW1JBeSHMezjJ16yXeN8R8KzDoOt7HVHlt
xNr3YJXESvOnxp4PI0QluBj2xZ5cj/SW4JqEyyEAkZP1tQNYmlyV6yL1uQhvP8tw
qhdqmqVEYAzc8zNzpPod8ePRVgIhIw==
=j+MJ
-----END PGP SIGNATURE-----

--Sig_/nEZ6t2b+ZEPlWeO82bQubcz--
