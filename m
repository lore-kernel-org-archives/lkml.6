Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FA2C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2442170F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CzMezISl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2442170F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbeHOCVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:21:35 -0400
Received: from ozlabs.org ([203.11.71.1]:36205 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729286AbeHOCVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:21:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qplj2KZ9z9s4V;
        Wed, 15 Aug 2018 09:32:00 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534289523;
        bh=aHZA+Yh6rXblLMDXOXnQMePXZ7jFVqbtG1vmc8USN7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CzMezISlby1PfJLryfim1/6PKo3iPwBNzq3TMDTtiACV+Nyt1A5o1PTTQP7OP06GU
         pYfTK7Nyd0FJqCIkZDf9VcUFjyCfZeMdaKS9O0YzsxVqMh3X2o7so2FXewNTy6E43P
         +NpL6oOWFqCYcksmDULPG1HLplETqMwIrz9GRc54i8A61qSABeYvSBUoFTMwpR3pRb
         +FnPvL9phL7tn/xK78+k9h7rLCQ7huRKDjghYYx/uozgFx+nNLJ8kFcM1TqVxNXySz
         NGGRV8kcIyPxLrKxThrMu03qBwBKGixFpXITl/QHBKn04TxC+L6cAn8Trh3etdbmTd
         WFQY9+8/bQpNg==
Date:   Wed, 15 Aug 2018 09:31:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the mips tree with the kbuild tree
Message-ID: <20180815093159.55c5588f@canb.auug.org.au>
In-Reply-To: <20180803092100.7d0fda13@canb.auug.org.au>
References: <20180803092100.7d0fda13@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/e9yn65TKcxkhbAzjCqKKUgT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e9yn65TKcxkhbAzjCqKKUgT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 3 Aug 2018 09:21:00 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the mips tree got a conflict in:
>=20
>   arch/mips/Kconfig
>=20
> between commit:
>=20
>   1572497cb0e6 ("kconfig: include common Kconfig files from top-level Kco=
nfig")
>=20
> from the kbuild tree and commit:
>=20
>   6c359eb1dcdb ("MIPS: Allow auto-dection of ARCH_PFN_OFFSET & PHYS_OFFSE=
T")
>=20
> from the mips tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

> fdd83c534b114febc41ec115449cb25f421e1719
> diff --cc arch/mips/Kconfig
> index 06a633eb9777,642a56e2a1ea..2af13b162e5e
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@@ -2990,6 -2988,13 +2984,9 @@@ config PGTABLE_LEVEL
>   	default 3 if 64BIT && !PAGE_SIZE_64KB
>   	default 2
>  =20
> + config MIPS_AUTO_PFN_OFFSET
> + 	bool
> +=20
>  -source "init/Kconfig"
>  -
>  -source "kernel/Kconfig.freezer"
>  -
>   menu "Bus options (PCI, PCMCIA, EISA, ISA, TC)"
>  =20
>   config HW_HAS_EISA

This is now a conflict between Linus' tree and the kbuild tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/e9yn65TKcxkhbAzjCqKKUgT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltzZm8ACgkQAVBC80lX
0GxOrQf5AaoxVW/CLFq46GzKU5iTB4rd4ATgqLU/dDhcfhYVY1YK6tG/bVyiX/Gg
Rt+32HH5/qeeqqtzIbbb0d2aBcwQICjb5WYm3ju61oDi8h2PSYfj8bfr3EUHymdn
XyLhjcAce/mTSCASW22v6DKnt3l0B9dabaT9mFMm6SXWAQkvyuXvkUBNegfwhhVl
PHyuMafgjlE2o979dH0fV8XxAcdpvqFcsB9ucIyBWAeb25yB+u9oIt/8YWhSHQVb
q8q1Zs2iOG/MQ5uqh4AMo9MstSt1YODbssT7gNOVPjgJrJoU9Y6US0Yt6VF0sQ/P
7wF1m5vp8SqeO9uVjU+Plu53OEOoPQ==
=DgsD
-----END PGP SIGNATURE-----

--Sig_/e9yn65TKcxkhbAzjCqKKUgT--
