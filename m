Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3947FECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D915421473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oddMjk+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D915421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeJRKpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 06:45:14 -0400
Received: from ozlabs.org ([203.11.71.1]:48679 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeJRKpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 06:45:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42bD2X5C7Cz9sBN;
        Thu, 18 Oct 2018 13:46:28 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539830789;
        bh=3XJ+ZbbI8l0BWC+9PKEhvmklCiaCYONf5OYbclRca4w=;
        h=Date:From:To:Cc:Subject:From;
        b=oddMjk+lrtli0R2hdABLlffGXafhGkjx8U0USuK9rcAtcHmqqQX8rXV/GGd2WHL7T
         KFGZX2btwzZ7ADCovKf4cjlex9fqIL6IghCpA4M+VYde5SdHHUV7ll7xo7f2DbgnjA
         kNGniTR89Sr+RCPED39S4XuzGv8IWERzvhwQo144XBX92zgnixoIe+9EO/MyvO4HJY
         L6f2XX5FU4nHARzDKY5xR/bT0sPqEknfB+Yg4FjNMZMN6bRuQ/ygAJi5PdCjWT2lds
         mAty4ccxgTsGGlxoU+GjNoOwu1JzsHSVbh/N0F4WvR0YnXJg8fowr4EOKgAaBZJ24J
         I4uvcrIPRAX2Q==
Date:   Thu, 18 Oct 2018 13:46:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Jim Mattson <jmattson@google.com>
Subject: linux-next: manual merge of the kvm-arm tree with the kvm tree
Message-ID: <20181018134627.15bbcea9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iAIPVQb_jJjqO91tszIqSfC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iAIPVQb_jJjqO91tszIqSfC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  include/uapi/linux/kvm.h

between commits:

  214ff83d4473 ("KVM: x86: hyperv: implement PV IPI send hypercalls")
  0804c849f1df ("kvm/x86 : add coalesced pio support")
  57b119da3594 ("KVM: nVMX: add KVM_CAP_HYPERV_ENLIGHTENED_VMCS capability")
  c4f55198c7c2 ("kvm: x86: Introduce KVM_CAP_EXCEPTION_PAYLOAD")

from the kvm tree and commit:

  233a7cb23531 ("kvm: arm64: Allow tuning the physical address size for VM")

from the kvm-arm tree.

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
index cb6d44e1fe02,95aa73ca65dc..000000000000
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@@ -960,11 -962,7 +969,12 @@@ struct kvm_ppc_resize_hpt=20
  #define KVM_CAP_NESTED_STATE 157
  #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
  #define KVM_CAP_MSR_PLATFORM_INFO 159
 -#define KVM_CAP_ARM_VM_IPA_SIZE 160 /* returns maximum IPA bits for a VM =
*/
 +#define KVM_CAP_PPC_NESTED_HV 160
 +#define KVM_CAP_HYPERV_SEND_IPI 161
 +#define KVM_CAP_COALESCED_PIO 162
 +#define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
 +#define KVM_CAP_EXCEPTION_PAYLOAD 164
++#define KVM_CAP_ARM_VM_IPA_SIZE 165 /* returns maximum IPA bits for a VM =
*/
 =20
  #ifdef KVM_CAP_IRQ_ROUTING
 =20

--Sig_/iAIPVQb_jJjqO91tszIqSfC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvH9AMACgkQAVBC80lX
0GxVmAgApLdNQ8MhS+ddZSSSxLiNSbXCfXdHnPSUGJYLIjXjdtpKsvg+QzaQlEXP
HqqLuJ/kWa+cw0FXmyos9xXVJMg1K1ObRwq+ya0J0dLy1BiSTMAIrpA/RibppuWt
mI58WmgqD7kjNdgMZ+Adk6sz3CyT69iC1zQnCIUBZ6/FJYMBZcRKf0CV4jX4ctCe
Sv2+6UqQ1IYx5YjXmxnvj02EmO5fIbgF4l5r3Tu5FcBuP74AvFFVBumWY9Rftggj
oicAoXspn+2d06wO0txIfyCUkTaKyJCQ4d2ywlAsjy5SV3VMQO/XEHpgKnb3jDy7
TXGmXYLTf1KXtRwSfoSRuQcm1RdMgQ==
=gk0p
-----END PGP SIGNATURE-----

--Sig_/iAIPVQb_jJjqO91tszIqSfC--
