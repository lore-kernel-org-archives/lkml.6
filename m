Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753938AbeFDHJa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:09:30 -0400
Received: from ozlabs.org ([203.11.71.1]:60391 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753725AbeFDHEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:04:12 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 4 Jun 2018 17:04:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: linux-next: manual merge of the kvm tree with Linus' tree
Message-ID: <20180604170409.63d31d4a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IsUaLI=0/xwAw9a.+df.kfR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IsUaLI=0/xwAw9a.+df.kfR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/x86/kvm/hyperv.c

between commit:

  696ca779a928 ("KVM: x86: fix #UD address of failed Hyper-V hypercalls")

from Linus' tree and commit:

  56b9ae78303a ("KVM: x86: hyperv: do rep check for each hypercall separate=
ly")

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

diff --cc arch/x86/kvm/hyperv.c
index 46ff64da44ca,14e0d0ae4e0a..000000000000
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@@ -1385,8 -1527,8 +1531,7 @@@ int kvm_hv_hypercall(struct kvm_vcpu *v
  		break;
  	}
 =20
- out:
 -	kvm_hv_hypercall_set_result(vcpu, ret);
 -	return 1;
 +	return kvm_hv_hypercall_complete(vcpu, ret);
  }
 =20
  void kvm_hv_init_vm(struct kvm *kvm)

--Sig_/IsUaLI=0/xwAw9a.+df.kfR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsU5GkACgkQAVBC80lX
0GzteAf9GIbXfSUdUu8YupnBf8WlYp25aURas/wVjpX3dldpQqv6T46GBIKm2B7/
CkPp24IioqG1xNndJ/KRSbeqlsVLXY1Q7knAgbMBB0PdFfkYt7YCDsGv4P/5auLN
n1b5vkJbqYZP8TAtE6vbhCrmaVRv/HyDh08Xn+VXngQc3esUIY0Y4WcEveMlOAo9
R2U0aLEya+J7na6ELX5Jje6Lzj1V6gKFQy9rlpyd14gLW/cJIRufxxlZKsiQHCuk
LsmKSy4nzRtZIq7ZZMlsxnZmr6PGq830ZEoppLuaA/E+U7nqGF2VAW4lklDZOZdM
92511XIg0qr4yUEMDC6KRcRskZYiag==
=tHmv
-----END PGP SIGNATURE-----

--Sig_/IsUaLI=0/xwAw9a.+df.kfR--
