Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9FBC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F02216FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jTgWS24h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F02216FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732652AbeHOCQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:16:00 -0400
Received: from ozlabs.org ([203.11.71.1]:40521 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729705AbeHOCQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:16:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qpdG401Cz9sDT;
        Wed, 15 Aug 2018 09:26:26 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534289187;
        bh=QOmc1BM/lHs1lcVaua7IdnKtMDhm/bauPOWobH7vkA8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jTgWS24hosa7nTtw2OTxfYjgqlT9UG4YYgxUyuh8NNeq2Xsw+uoIInlq+ihkmNvwi
         Zn/kShM/O0J0+Db3Ra6ltKl2GlzWBYhjzRxKYEkMge9qGMw0PM0xvL+rZXt50AlI1n
         prFk66EKk2hJ6ZHRYadq1TshfcbsrC6ONYg14n0XbsxTbDlkiCUlQzxpzn1yEHVcKS
         SNba9ErUJ+8SA8QdOZsvDCktAILR56tbHSCAYomQ/nlRogn0mNPnCCxZZxPxFkUwMn
         4uF0LghnCAc5Xjm4TAKi//sWRa/euHIJ6NDecpJMB94yTrngapEaq/fjJb3t6FhdrM
         XqlEEkz6TAHBw==
Date:   Wed, 15 Aug 2018 09:26:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the tip tree with the kbuild tree
Message-ID: <20180815092625.1ab4109d@canb.auug.org.au>
In-Reply-To: <20180806144736.4fbe1e51@canb.auug.org.au>
References: <20180806144736.4fbe1e51@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Sx7AvN6uXHHlExj_ZxsOT3g"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Sx7AvN6uXHHlExj_ZxsOT3g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 6 Aug 2018 14:47:36 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the tip tree got conflicts in:
>=20
>   arch/arm64/Kconfig
>   arch/openrisc/Kconfig
>=20
> between commit:
>=20
>   1572497cb0e6 ("kconfig: include common Kconfig files from top-level Kco=
nfig")
>=20
> from the kbuild tree and commits:
>=20
>   78ae2e1cd845 ("arm64: Use the new GENERIC_IRQ_MULTI_HANDLER")
>   c5ca4560de0f ("openrisc: Use the new GENERIC_IRQ_MULTI_HANDLER")
>=20
> from the tip tree.
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
> diff --cc arch/arm64/Kconfig
> index a3de6ad666d4,3d1011957823..000000000000
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@@ -278,9 -265,10 +279,6 @@@ config ARCH_SUPPORTS_UPROBE
>   config ARCH_PROC_KCORE_TEXT
>   	def_bool y
>  =20
> - config MULTI_IRQ_HANDLER
> - 	def_bool y
>  -source "init/Kconfig"
>  -
>  -source "kernel/Kconfig.freezer"
> --
>   source "arch/arm64/Kconfig.platforms"
>  =20
>   menu "Bus support"
> diff --cc arch/openrisc/Kconfig
> index fee9d91a66e6,dfb6a79ba7ff..000000000000
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@@ -71,9 -69,10 +71,6 @@@ config STACKTRACE_SUPPOR
>   config LOCKDEP_SUPPORT
>   	def_bool  y
>  =20
> - config MULTI_IRQ_HANDLER
> - 	def_bool y
>  -source "init/Kconfig"
>  -
>  -source "kernel/Kconfig.freezer"
> --
>   menu "Processor type and features"
>  =20
>   choice

This is now a conflict between Linus' tree and the kbuild tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Sx7AvN6uXHHlExj_ZxsOT3g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltzZSEACgkQAVBC80lX
0GzY4Af9HAwRUFzDMQdV+ZCtuXNmW+PUqsqm5TxM+uKleg6M8ZpQyR8MIMkd2zhL
ZxdSKWwewLWUXaJKG8cNW3Qno2aitUhILJXU6flUsTft2ovGwvWVZ8S5XkD+rhiS
kc2k9UJQWXgDYc1RS5AB7H2Qm6jcEpAHqcmFSFvQvxhsdq59lhJlpciLP4Fd2Wd/
xe7oL6IxHaTUDBsx/ZSuvNqaoqQF2JvPdZAEoSVSm4vnWo21drgtH+5c4GpC+UcA
7UHWMAXSfw9vpOiC0oqHnUwjgp3ZaNv824gBYf8rVWngGPj3y5TrMg6DhEE1aCPa
x/SaP/OQBTuH7sBxLMgz6yMaYEMc1g==
=EqXl
-----END PGP SIGNATURE-----

--Sig_/Sx7AvN6uXHHlExj_ZxsOT3g--
