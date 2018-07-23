Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FF7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0E020852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tPrxpQ+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0E020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388253AbeGWXyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:54:09 -0400
Received: from ozlabs.org ([203.11.71.1]:44433 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388088AbeGWXyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:54:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41ZGt66MHLz9s29;
        Tue, 24 Jul 2018 08:50:38 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532386241;
        bh=icVMHVgx12/LZ5B6k06NAx5L1Iyv2znCQ+4375cTOMA=;
        h=Date:From:To:Cc:Subject:From;
        b=tPrxpQ+8HJunm51mS703aFn7aj2uBrqmcQrkpTnxxDDHqOSgVmaxtT8HOVO1aJPDO
         Ao/c6tGI3ddhFPmoJJ146yoclres5MAmhu6mY/jacoBXweqUlHauld06uwNFkQBvwB
         8yf0gacHpvYHe6t7C1ILagTUVReIpYtCk6bF9IzfWq+6D239FrSo3f8HCkJ+FdVkNt
         xG5YfY+ZHxjCi68dgjOjbQQKIAzpq6+WSUgh1Wh7/8rJRWTrUTZI5C/W6OePY33vOw
         xaGW5v9I6bL1BVNsp93omr02mMikllPTEEmJ/0U2Eunf+isvKmf6AxElHenwX0M4oB
         EJpVSYrwHIUfw==
Date:   Tue, 24 Jul 2018 08:50:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Paul Kocialkowski <contact@paulk.fr>,
        Laura Abbott <labbott@redhat.com>,
        Greg Hackmann <ghackmann@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: linux-next: manual merge of the arm64 tree with Linus' tree
Message-ID: <20180724085015.029efd54@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/p7_ied2/1DM2Hs/LiWVGBwZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/p7_ied2/1DM2Hs/LiWVGBwZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm64 tree got a conflict in:

  arch/arm64/Makefile

between commits:

  38fc42486775 ("arm64: Use aarch64elf and aarch64elfb emulation mode varia=
nts")
  2893af07e507 ("arm64: add endianness option to LDFLAGS instead of LD")
  96f95a17c1cf ("Revert "arm64: Use aarch64elf and aarch64elfb emulation mo=
de variants"")

from Linus' tree and commit:

  c931d34ea085 ("arm64: build with baremetal linker target instead of Linux=
 when available")

from the arm64 tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/p7_ied2/1DM2Hs/LiWVGBwZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltWW6cACgkQAVBC80lX
0GyAwwf/RD8Hr7QkeYFpIzBdmyqPiNUndF3umskSD0zcju51nXvuk5CizLtczUc1
sWv1Kumdyf6wm6J8knJu0pEPle0j16Yx61eOvY+Z8T9hVfpOk7gDhqINGa7UFI7v
Uupkdh8Z5p2ff9jwzvSCRsrzUMbQnUERtEwOXEf+94nW1//fiBGv1Vs59XB8qRSH
v2ECtsBHwwrxvVeSd0q7qcR3liAK3fTZp1h8q22NW8jiwumwhyB/sqfg8ESdDHxl
Biaw8I/uqyoU9BH8YIImUbBiv3uq9Z7IhtygPO8Fx4QnWL4rCwbKCNQj8ifmf9XS
PYmmaIfWYf9bZSTebyzmEIQs1kYOww==
=Onrj
-----END PGP SIGNATURE-----

--Sig_/p7_ied2/1DM2Hs/LiWVGBwZ--
