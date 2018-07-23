Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117FBECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F4620875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SOnu12/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F4620875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387778AbeGWFqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:46:04 -0400
Received: from ozlabs.org ([203.11.71.1]:43497 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeGWFqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:46:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41YpqR6LcKz9rxs;
        Mon, 23 Jul 2018 14:46:42 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532321204;
        bh=33aV+8SV8jBE406WXjiJpYlVjpK8QPB7l+jPZ+UEG1o=;
        h=Date:From:To:Cc:Subject:From;
        b=SOnu12/i2V3aeT0zrhw+TB4OIpGFCPPslomubvkagesM6Tb1rISTwX88R/LMbs8bl
         V/LcEOXQ3eGnztlls/dgjFjZrmomDHW3AKCuVLN/m3ZmNziPxksDKzhCrFFUTiZIrB
         QlqVg67ExVR+hpXB1oB1pa5NIAtVUuxnXV/5N/Z/55bmxYEQus7N8CN6hpzs297ZST
         zkli3ZatSTV9dC0/CdVFRGQriVEEWgin7OmQYZ45s0+bgRBjtOYesPYy/s0XG2tt4c
         rtE48u6j+VT/vWcCnHjMGBOQym2DvIsoeNshOtN/D/OEgCs3SbChRcHTmgF3H2PQAS
         XGw07ZB2M/ggQ==
Date:   Mon, 23 Jul 2018 14:46:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20180723144641.62b2b226@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0WPm=Aqjwvk1Mj=Z27khy9a"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0WPm=Aqjwvk1Mj=Z27khy9a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/include/asm/cpucaps.h

between commit:

  314d53d29798 ("arm64: Handle mismatched cache type")

from the arm64 tree and commit:

  e48d53a91f6e ("arm64: KVM: Add support for Stage-2 control of memory type=
s and cacheability")

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

diff --cc arch/arm64/include/asm/cpucaps.h
index be3bf3d08916,ed84d6536830..000000000000
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@@ -49,8 -49,8 +49,9 @@@
  #define ARM64_HAS_CACHE_DIC			28
  #define ARM64_HW_DBM				29
  #define ARM64_SSBD				30
 -#define ARM64_HAS_STAGE2_FWB			31
 +#define ARM64_MISMATCHED_CACHE_TYPE		31
++#define ARM64_HAS_STAGE2_FWB			32
 =20
--#define ARM64_NCAPS				32
++#define ARM64_NCAPS				33
 =20
  #endif /* __ASM_CPUCAPS_H */

--Sig_/0WPm=Aqjwvk1Mj=Z27khy9a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltVXbIACgkQAVBC80lX
0GxHZwf+OdwXgHSo9R6xNtzRCERmDtbHyxrkkQz4aYRqO+jpW5d+rFR0SEFfWntx
ddERQo7nOqPnmBW9ytnjjIsk0SmbS5adiozNf8Wn95rMQhcccLmm1ymAbAhI92mW
MsubBfzIR0ZORB6v3mARXXjwlmY6Y/52PCinuFIut2miTnHNBaooDgHlWQOAlZhJ
Y6u5qzNopik6AAgWidyKBEjslP+7ayZ7Lyu2AuTBA+fOkYBHnGTdGXbpdbJ/mS7c
giWQTcBR8QpENAxIfHD5ARknZkceqsUsjkFXP8Qt9fpMFUF67/YT9scBvH7BEo6I
qEqsVuo76jZ9t/ErgJmHC3XPcNJ+JA==
=FtT+
-----END PGP SIGNATURE-----

--Sig_/0WPm=Aqjwvk1Mj=Z27khy9a--
