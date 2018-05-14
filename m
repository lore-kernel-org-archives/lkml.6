Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeENFgP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 01:36:15 -0400
Received: from ozlabs.org ([203.11.71.1]:50251 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750760AbeENFgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 01:36:13 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 14 May 2018 15:36:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the kselftest tree with the kvm-fixes
 tree
Message-ID: <20180514153610.37d0a458@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+yblz34.BS4w.Gk=FzewM2/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+yblz34.BS4w.Gk=FzewM2/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

Today's linux-next merge of the kselftest tree got a conflict in:

  tools/testing/selftests/kvm/vmx_tsc_adjust_test.c

between commit:

  bcb2b94ae010 ("KVM: selftests: exit with 0 status code when tests cannot =
be run")

from the kvm-fixes tree and commit:

  13911360966d ("selftests: kvm: return Kselftest Skip code for skipped tes=
ts")

from the kselftest tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
index aaa633263b2c,62fb73699eb6..000000000000
--- a/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
@@@ -189,8 -191,8 +191,8 @@@ int main(int argc, char *argv[]
  	struct kvm_cpuid_entry2 *entry =3D kvm_get_supported_cpuid_entry(1);
 =20
  	if (!(entry->ecx & CPUID_VMX)) {
 -		printf("nested VMX not enabled, skipping test");
 +		fprintf(stderr, "nested VMX not enabled, skipping test\n");
- 		exit(KSFT_SKIP);
+ 		return KSFT_SKIP;
  	}
 =20
  	vm =3D vm_create_default_vmx(VCPU_ID, (void *) l1_guest_code);

--Sig_/+yblz34.BS4w.Gk=FzewM2/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr5IEoACgkQAVBC80lX
0GysCQf9Ft+UykX1jerJYzvh5B7OnrUSHlniBk1GE6w5V2e9bZkFEOhNPX3QkF3E
bX9keMzyxmJS+e14TglmlIHK4+r7tOltWNbPRi5hIST8ewpqbq4Pj2G85rpqmLNU
CQWyKGmVkPmmq0SgqhjazU4t/68GmIg1/C4hBNV8pKPruO5uy3aOdd1hqY1ZNMCq
5D29irqA+ZHMXoFmHJu9TzqT18w49xG3TUnarACUuApgdRsPcAFPNwRowHdzGI2K
eHYqCpgfUQrwLvw2bUV4ex5f2zEePhn6/VL59G8dAJEQwJzOXWj5legtwp7sY9v/
r9I6LWlaPej4KcqzLBM+EeGqBsxy3A==
=18fp
-----END PGP SIGNATURE-----

--Sig_/+yblz34.BS4w.Gk=FzewM2/--
