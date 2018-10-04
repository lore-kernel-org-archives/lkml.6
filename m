Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77297C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3162098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lzVSjq5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3162098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeJDLOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 07:14:04 -0400
Received: from ozlabs.org ([203.11.71.1]:58433 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbeJDLOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 07:14:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Qfqz3VSzz9s5c;
        Thu,  4 Oct 2018 14:22:39 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538626960;
        bh=t6ZZiof1eISXVLcuHd5pBgBKZgsQHvG4vc17gvskbOs=;
        h=Date:From:To:Cc:Subject:From;
        b=lzVSjq5jPFmUP+/JN3uyL9npTBlHvLCuk3zcOoe9+tXElL+rIgXB7ZHVmPIKjxNkW
         ZoU0MZ2nQHPPZMrVu4QntA9yZwSWH/SYD0tImeBT2nfw2EBXBgaQYu8GiPX7ydFh/6
         ZjkwPZK8m7w8Y2lALy11sP1zeppGLaSNA1JJHSMH+jPNy6D0Q31qHp+W2mcc0GC6cV
         lfpKRo/m44TrYpfpwMfOiFNJyJ/fFrek1n9dkiED0I+0krAt2UTAkfMVOtOowGaLXI
         LiqouZeS2w3StcQI9Jho1kQntGJiOQx9lE0cPvPXocT0mMHftyjFaFb3m5nbsGuLCY
         EyeD7JLpXqyMg==
Date:   Thu, 4 Oct 2018 14:22:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20181004142238.06c80b6a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NtYu5eHvLWP/5WmU_hBgeT."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NtYu5eHvLWP/5WmU_hBgeT.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got conflicts in:

  arch/arm/include/asm/kvm_mmu.h
  arch/arm64/include/asm/kvm_arm.h
  arch/arm64/include/asm/kvm_mmu.h

between commit:

  ab510027dc4d ("arm64: KVM: Enable Common Not Private translations")

from the arm64 tree and commit:

  0f62f0e95be2 ("kvm: arm64: Set a limit on the IPA size")
  595583306434 ("kvm: arm64: Dynamic configuration of VTTBR mask")

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

diff --cc arch/arm/include/asm/kvm_mmu.h
index 847f01fa429d,5ad1a54f98dc..000000000000
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@@ -355,11 -358,8 +358,13 @@@ static inline int hyp_map_aux_data(void
 =20
  #define kvm_phys_to_vttbr(addr)		(addr)
 =20
 +static inline bool kvm_cpu_has_cnp(void)
 +{
 +	return false;
 +}
 +
+ static inline void kvm_set_ipa_limit(void) {}
+=20
  #endif	/* !__ASSEMBLY__ */
 =20
  #endif /* __ARM_KVM_MMU_H__ */
diff --cc arch/arm64/include/asm/kvm_arm.h
index b476bc46f0ab,6e324d1f1231..000000000000
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@@ -145,38 -143,127 +143,128 @@@
  #define VTCR_EL2_COMMON_BITS	(VTCR_EL2_SH0_INNER | VTCR_EL2_ORGN0_WBWA | \
  				 VTCR_EL2_IRGN0_WBWA | VTCR_EL2_RES1)
 =20
- #ifdef CONFIG_ARM64_64K_PAGES
  /*
-  * Stage2 translation configuration:
-  * 64kB pages (TG0 =3D 1)
-  * 2 level page tables (SL =3D 1)
+  * VTCR_EL2:SL0 indicates the entry level for Stage2 translation.
+  * Interestingly, it depends on the page size.
+  * See D.10.2.121, VTCR_EL2, in ARM DDI 0487C.a
+  *
+  *	-----------------------------------------
+  *	| Entry level		|  4K  | 16K/64K |
+  *	------------------------------------------
+  *	| Level: 0		|  2   |   -     |
+  *	------------------------------------------
+  *	| Level: 1		|  1   |   2     |
+  *	------------------------------------------
+  *	| Level: 2		|  0   |   1     |
+  *	------------------------------------------
+  *	| Level: 3		|  -   |   0     |
+  *	------------------------------------------
+  *
+  * The table roughly translates to :
+  *
+  *	SL0(PAGE_SIZE, Entry_level) =3D TGRAN_SL0_BASE - Entry_Level
+  *
+  * Where TGRAN_SL0_BASE is a magic number depending on the page size:
+  * 	TGRAN_SL0_BASE(4K) =3D 2
+  *	TGRAN_SL0_BASE(16K) =3D 3
+  *	TGRAN_SL0_BASE(64K) =3D 3
+  * provided we take care of ruling out the unsupported cases and
+  * Entry_Level =3D 4 - Number_of_levels.
+  *
   */
- #define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_64K | VTCR_EL2_SL0_LVL1)
- #define VTTBR_X_TGRAN_MAGIC		38
+ #ifdef CONFIG_ARM64_64K_PAGES
+=20
+ #define VTCR_EL2_TGRAN			VTCR_EL2_TG0_64K
+ #define VTCR_EL2_TGRAN_SL0_BASE		3UL
+=20
  #elif defined(CONFIG_ARM64_16K_PAGES)
- /*
-  * Stage2 translation configuration:
-  * 16kB pages (TG0 =3D 2)
-  * 2 level page tables (SL =3D 1)
-  */
- #define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_16K | VTCR_EL2_SL0_LVL1)
- #define VTTBR_X_TGRAN_MAGIC		42
+=20
+ #define VTCR_EL2_TGRAN			VTCR_EL2_TG0_16K
+ #define VTCR_EL2_TGRAN_SL0_BASE		3UL
+=20
  #else	/* 4K */
- /*
-  * Stage2 translation configuration:
-  * 4kB pages (TG0 =3D 0)
-  * 3 level page tables (SL =3D 1)
-  */
- #define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SL0_LVL1)
- #define VTTBR_X_TGRAN_MAGIC		37
+=20
+ #define VTCR_EL2_TGRAN			VTCR_EL2_TG0_4K
+ #define VTCR_EL2_TGRAN_SL0_BASE		2UL
+=20
  #endif
 =20
- #define VTCR_EL2_FLAGS			(VTCR_EL2_COMMON_BITS | VTCR_EL2_TGRAN_FLAGS)
- #define VTTBR_X				(VTTBR_X_TGRAN_MAGIC - VTCR_EL2_T0SZ_IPA)
+ #define VTCR_EL2_LVLS_TO_SL0(levels)	\
+ 	((VTCR_EL2_TGRAN_SL0_BASE - (4 - (levels))) << VTCR_EL2_SL0_SHIFT)
+ #define VTCR_EL2_SL0_TO_LVLS(sl0)	\
+ 	((sl0) + 4 - VTCR_EL2_TGRAN_SL0_BASE)
+ #define VTCR_EL2_LVLS(vtcr)		\
+ 	VTCR_EL2_SL0_TO_LVLS(((vtcr) & VTCR_EL2_SL0_MASK) >> VTCR_EL2_SL0_SHIFT)
+=20
+ #define VTCR_EL2_FLAGS			(VTCR_EL2_COMMON_BITS | VTCR_EL2_TGRAN)
+ #define VTCR_EL2_IPA(vtcr)		(64 - ((vtcr) & VTCR_EL2_T0SZ_MASK))
+=20
+ /*
+  * ARM VMSAv8-64 defines an algorithm for finding the translation table
+  * descriptors in section D4.2.8 in ARM DDI 0487C.a.
+  *
+  * The algorithm defines the expectations on the translation table
+  * addresses for each level, based on PAGE_SIZE, entry level
+  * and the translation table size (T0SZ). The variable "x" in the
+  * algorithm determines the alignment of a table base address at a given
+  * level and thus determines the alignment of VTTBR:BADDR for stage2
+  * page table entry level.
+  * Since the number of bits resolved at the entry level could vary
+  * depending on the T0SZ, the value of "x" is defined based on a
+  * Magic constant for a given PAGE_SIZE and Entry Level. The
+  * intermediate levels must be always aligned to the PAGE_SIZE (i.e,
+  * x =3D PAGE_SHIFT).
+  *
+  * The value of "x" for entry level is calculated as :
+  *    x =3D Magic_N - T0SZ
+  *
+  * where Magic_N is an integer depending on the page size and the entry
+  * level of the page table as below:
+  *
+  *	--------------------------------------------
+  *	| Entry level		|  4K    16K   64K |
+  *	--------------------------------------------
+  *	| Level: 0 (4 levels)	| 28   |  -  |  -  |
+  *	--------------------------------------------
+  *	| Level: 1 (3 levels)	| 37   | 31  | 25  |
+  *	--------------------------------------------
+  *	| Level: 2 (2 levels)	| 46   | 42  | 38  |
+  *	--------------------------------------------
+  *	| Level: 3 (1 level)	| -    | 53  | 51  |
+  *	--------------------------------------------
+  *
+  * We have a magic formula for the Magic_N below:
+  *
+  *  Magic_N(PAGE_SIZE, Level) =3D 64 - ((PAGE_SHIFT - 3) * Number_of_leve=
ls)
+  *
+  * where Number_of_levels =3D (4 - Level). We are only interested in the
+  * value for Entry_Level for the stage2 page table.
+  *
+  * So, given that T0SZ =3D (64 - IPA_SHIFT), we can compute 'x' as follow=
s:
+  *
+  *	x =3D (64 - ((PAGE_SHIFT - 3) * Number_of_levels)) - (64 - IPA_SHIFT)
+  *	  =3D IPA_SHIFT - ((PAGE_SHIFT - 3) * Number of levels)
+  *
+  * Here is one way to explain the Magic Formula:
+  *
+  *  x =3D log2(Size_of_Entry_Level_Table)
+  *
+  * Since, we can resolve (PAGE_SHIFT - 3) bits at each level, and another
+  * PAGE_SHIFT bits in the PTE, we have :
+  *
+  *  Bits_Entry_level =3D IPA_SHIFT - ((PAGE_SHIFT - 3) * (n - 1) + PAGE_S=
HIFT)
+  *		     =3D IPA_SHIFT - (PAGE_SHIFT - 3) * n - 3
+  *  where n =3D number of levels, and since each pointer is 8bytes, we ha=
ve:
+  *
+  *  x =3D Bits_Entry_Level + 3
+  *    =3D IPA_SHIFT - (PAGE_SHIFT - 3) * n
+  *
+  * The only constraint here is that, we have to find the number of page t=
able
+  * levels for a given IPA size (which we do, see stage2_pt_levels())
+  */
+ #define ARM64_VTTBR_X(ipa, levels)	((ipa) - ((levels) * (PAGE_SHIFT - 3)))
 =20
 +#define VTTBR_CNP_BIT     (UL(1))
- #define VTTBR_BADDR_MASK  (((UL(1) << (PHYS_MASK_SHIFT - VTTBR_X)) - 1) <=
< VTTBR_X)
  #define VTTBR_VMID_SHIFT  (UL(48))
  #define VTTBR_VMID_MASK(size) (_AT(u64, (1 << size) - 1) << VTTBR_VMID_SH=
IFT)
 =20
diff --cc arch/arm64/include/asm/kvm_mmu.h
index 64337afbf124,77b1af9e64db..000000000000
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@@ -517,10 -519,29 +519,34 @@@ static inline int hyp_map_aux_data(void
 =20
  #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
 =20
 +static inline bool kvm_cpu_has_cnp(void)
 +{
 +	return system_supports_cnp();
 +}
 +
+ /*
+  * Get the magic number 'x' for VTTBR:BADDR of this KVM instance.
+  * With v8.2 LVA extensions, 'x' should be a minimum of 6 with
+  * 52bit IPS.
+  */
+ static inline int arm64_vttbr_x(u32 ipa_shift, u32 levels)
+ {
+ 	int x =3D ARM64_VTTBR_X(ipa_shift, levels);
+=20
+ 	return (IS_ENABLED(CONFIG_ARM64_PA_BITS_52) && x < 6) ? 6 : x;
+ }
+=20
+ static inline u64 vttbr_baddr_mask(u32 ipa_shift, u32 levels)
+ {
+ 	unsigned int x =3D arm64_vttbr_x(ipa_shift, levels);
+=20
+ 	return GENMASK_ULL(PHYS_MASK_SHIFT - 1, x);
+ }
+=20
+ static inline u64 kvm_vttbr_baddr_mask(struct kvm *kvm)
+ {
+ 	return vttbr_baddr_mask(kvm_phys_shift(kvm), kvm_stage2_levels(kvm));
+ }
+=20
  #endif /* __ASSEMBLY__ */
  #endif /* __ARM64_KVM_MMU_H__ */

--Sig_/NtYu5eHvLWP/5WmU_hBgeT.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu1lY4ACgkQAVBC80lX
0GwcEAgAnYmbTVHVNSmDE3sv7WpiRGG/qD1WLa++KIQrVLnGj8H39hrn5ydN+3H/
iLw0HaUVwsrQ7pwCrbJ+twZJxMQS8TN9OB7XibJ0VUfdXoeTyq/B1JiT0fra4G7s
XPzkEbdMHIk2Qyv3Af21qNH7UB4UGOseUvaCLv2GMv3/mgxCGI/uJexv0FSbMQcY
GVTvx4y1FvA5Vr34sR1yaQRyciIwzCtNp7g5VumTCn8zYqKeXMRHPosHju5suGO8
pby+TS/W0crLOxWEh+LU9vKLY4SAsvGgO/+HpsRHKIuTUK3+EjpQgNN1umEWaw3C
P5XoCsly/dcBQbaVlb1jWwoNIT+i5g==
=PYgO
-----END PGP SIGNATURE-----

--Sig_/NtYu5eHvLWP/5WmU_hBgeT.--
