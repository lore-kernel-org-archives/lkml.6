Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A17C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC5420C0F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rsqI/ghQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC5420C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbeHPDJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 23:09:59 -0400
Received: from ozlabs.org ([203.11.71.1]:45625 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbeHPDJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 23:09:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41rRgB0Cm8z9s8f;
        Thu, 16 Aug 2018 10:15:17 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534378518;
        bh=GztpzWTZK7wFGG1fISM6OBLpT5sq05uPGY8cniC4HnY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rsqI/ghQSX6SJFk4bh84EVYz4ysFhx1ATkz8tuPX9RiSLC3e9SNhIZ9Z5UKdFNTu7
         dvUhShr7WbL3cKOSZH3V7Fac7Li+rCzqWisYCwEvtTaOdwcDg0ENXfLXEDYLWax9gB
         2T0EerMloLiLqWU5NDzsSco4TmpzD2rdMKT0FMUAVyUurjlLecd1TNF97LeRukS7EY
         upSSL8gdIGQ6RYfRzd1PYx9M3oBz6Bvujm/rWQxMgyyz7J5LDjLV6eWN6ew7OKRU6z
         Od/qZMz40DiikD4AQmZ/HnHzoEJThlthLiOtOPqM1SSS4fXjIgqisJT8UqTb4X5MJo
         y7douRPB5binQ==
Date:   Thu, 16 Aug 2018 10:15:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64
 tree
Message-ID: <20180816101515.24d0b49f@canb.auug.org.au>
In-Reply-To: <20180723144641.62b2b226@canb.auug.org.au>
References: <20180723144641.62b2b226@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_drNc1zMIutlJWBHBs63jx2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_drNc1zMIutlJWBHBs63jx2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 23 Jul 2018 14:46:41 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the kvm-arm tree got a conflict in:
>=20
>   arch/arm64/include/asm/cpucaps.h
>=20
> between commit:
>=20
>   314d53d29798 ("arm64: Handle mismatched cache type")
>=20
> from the arm64 tree and commit:
>=20
>   e48d53a91f6e ("arm64: KVM: Add support for Stage-2 control of memory ty=
pes and cacheability")
>=20
> from the kvm-arm tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/arm64/include/asm/cpucaps.h
> index be3bf3d08916,ed84d6536830..000000000000
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@@ -49,8 -49,8 +49,9 @@@
>   #define ARM64_HAS_CACHE_DIC			28
>   #define ARM64_HW_DBM				29
>   #define ARM64_SSBD				30
>  -#define ARM64_HAS_STAGE2_FWB			31
>  +#define ARM64_MISMATCHED_CACHE_TYPE		31
> ++#define ARM64_HAS_STAGE2_FWB			32
>  =20
> --#define ARM64_NCAPS				32
> ++#define ARM64_NCAPS				33
>  =20
>   #endif /* __ASM_CPUCAPS_H */

This is now a conflict between Linus' tree and the kvm-arm tree (and
presumably soon the kvm tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/_drNc1zMIutlJWBHBs63jx2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt0whMACgkQAVBC80lX
0GywpAf/Xr+5TKHad/aBC+S0xL1NjioQRkIccxPgha+z3hOACtzgnsqCwCkLOHLw
vq6ZtVwhzvCRhy0ra6jmKEgb+8RnvlkKtRxTNU67mj8oKMfaSofWqz50o0qKlUlQ
QllYc9Fn/jkuSrKyW2ZiSdEYLuLyXcim1KdURSiw7hwzDfMdfjcx2kcG2UeYOXu6
EcghEchmbMqnNhh7DeK3cx0JE9uWXLpVuUuyb1ojvFgSx6XN7CYgkJkNVz8QI7/y
OFd2JXYyjq4KyQ5j6Q0KhQcWYrhRDHh1CUY/NJ62ur69fmjA/WnxZQh+lMlCRIdw
20NbnJZ6zHdcqx4RoMWWDW51X7nI/A==
=rVg/
-----END PGP SIGNATURE-----

--Sig_/_drNc1zMIutlJWBHBs63jx2--
