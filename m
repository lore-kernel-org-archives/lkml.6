Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA32C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4416B20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FZDvqLxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4416B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeJDK7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 06:59:07 -0400
Received: from ozlabs.org ([203.11.71.1]:44729 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbeJDK7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 06:59:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42QfVp60wnz9s55;
        Thu,  4 Oct 2018 14:07:45 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538626067;
        bh=eWWTlThW6PpcUQfhHWNR+0e1UG8+rReJXzJgIQqQXM0=;
        h=Date:From:To:Cc:Subject:From;
        b=FZDvqLxtz/1PUX6N9eawn8/dFtpnV7cZUQQrTw/oV1o4LkHpqi5z4Op5wtqsR3jOO
         KHfGnsVtliahV2/o0a4aaGwVG9x0XcyrsOOdWdn2PoKStkRtEyfHmqw3lYfm62D8CI
         Y0WdbM38x7Bu+TktvE+/wwO90pmDisZ1U73akqGhKzsr3erMG8N2XXu2jioQTdAdNC
         rYcy74RTtatMhDW1WRvxxHmp5kWKzanOO5gIYPJ6mWUU51kM/nX+iqe3wRFldN/3dt
         K7iZmVsa+C4iuUJOyJjdE5uxHToYqK+TXG8dw5Ufzn/62BMq7f+HZ8uU5OHrPzGLc6
         iVP9GJ2dCbtww==
Date:   Thu, 4 Oct 2018 14:07:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20181004140737.214df900@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/03S_PquRkNovGEDg+fb2OkM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/03S_PquRkNovGEDg+fb2OkM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/include/asm/cpufeature.h

between commit:

  520ad98871a0 ("arm64/cpufeatures: Factorize emulate_mrs()")

from the arm64 tree and commit:

  ce00e3cb4fb4 ("arm64: Add a helper for PARange to physical shift conversi=
on")

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

diff --cc arch/arm64/include/asm/cpufeature.h
index 6db48d90ad63,072cc1c970c2..000000000000
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@@ -536,7 -530,26 +536,28 @@@ void arm64_set_ssbd_mitigation(bool sta
  static inline void arm64_set_ssbd_mitigation(bool state) {}
  #endif
 =20
+ static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
+ {
+ 	switch (parange) {
+ 	case 0: return 32;
+ 	case 1: return 36;
+ 	case 2: return 40;
+ 	case 3: return 42;
+ 	case 4: return 44;
+ 	case 5: return 48;
+ 	case 6: return 52;
+ 	/*
+ 	 * A future PE could use a value unknown to the kernel.
+ 	 * However, by the "D10.1.4 Principles of the ID scheme
+ 	 * for fields in ID registers", ARM DDI 0487C.a, any new
+ 	 * value is guaranteed to be higher than what we know already.
+ 	 * As a safe limit, we return the limit supported by the kernel.
+ 	 */
+ 	default: return CONFIG_ARM64_PA_BITS;
+ 	}
+ }
++
 +extern int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
  #endif /* __ASSEMBLY__ */
 =20
  #endif

--Sig_/03S_PquRkNovGEDg+fb2OkM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu1kgkACgkQAVBC80lX
0GzllggAmWJr0gflzWrLVWaiyAcMDH6B86g4XbTMbvDb+UaM0hQbQBKwG5QeIHAv
YL3X4tFXLzMpNKBHIbBe6n6ETsxayeg7j6WDl8pWklL1EGx6YkcloERLFBF/171C
JPiFUshd+M217RWxw53D3YBq1uHE+I57gYaRvPJGGsTEuH2wdlesAuqhqXNBKP8s
oRE0j696SA59bYFdgNkdjTEgDuSRH9xgs7q0PRXwzeSYO2I1FpWud2r9RBU8P7j9
DQxCkgK7zwUKBU4G5kiyyTJtCKUoSRwl4LLYTVGEl+jT1wQAGtEhKhqrprW3od5L
Ew4rH24gX08hfentzAxsr6T6qsBaDQ==
=oYES
-----END PGP SIGNATURE-----

--Sig_/03S_PquRkNovGEDg+fb2OkM--
