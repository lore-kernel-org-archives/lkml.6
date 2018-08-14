Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1341C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C539216FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ON48XGKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C539216FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732672AbeHOCRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:17:25 -0400
Received: from ozlabs.org ([203.11.71.1]:33361 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729705AbeHOCRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:17:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qpfy2fNmz9s4V;
        Wed, 15 Aug 2018 09:27:54 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534289274;
        bh=eXXLZ9HCYLFSuoMphdKgZvgVkXG8aAzdAJUT803Oc5c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ON48XGKhvO8kCWj56Paw0wO9W7HjG4CRBJ+Zrh6OLhIodD7iqCJD+MAu2uXt48u/O
         5YF3/evdhGAcHO/J3QCzufLu7EaQRYlZJpqqjUpzvF+IMLHKiao+8+HMG0YS9KFThj
         +m3Ch8ugaPAloUjO/YPtozSOOcNptqpnN0cSzuOVbl1jVkFQ5jzTPQ0jyKCW313Hfa
         DO6uQwam1Qlk3Hs13XJTYZrGsYMlYAmwC58Hn5Ox5ua1Um8kj0dx64YD0EVRRRygdh
         IQWVm9i5dgoOlqHy16PhiPcYyEsZepvN2BjEfn7i8y91UAj324HbUKMqjW6XHJm83m
         qGATVLEjCHeiw==
Date:   Wed, 15 Aug 2018 09:27:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the dma-mapping tree with the
 kbuild tree
Message-ID: <20180815092753.5a14f14f@canb.auug.org.au>
In-Reply-To: <20180803080856.3de8af38@canb.auug.org.au>
References: <20180803080856.3de8af38@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fBpBRoyY02p_TT22tjA22Fa"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fBpBRoyY02p_TT22tjA22Fa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 3 Aug 2018 08:08:56 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the dma-mapping tree got a conflict in:
>=20
>   arch/nios2/Kconfig
>=20
> between commit:
>=20
>   17c46a6aff5c ("kconfig: remove duplicate SWAP symbol defintions")
>=20
> from the kbuild tree and commit:
>=20
>   25622e045a6a ("nios2: use generic dma_noncoherent_ops")
>=20
> from the dma-mapping tree.
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
> diff --cc arch/nios2/Kconfig
> index cbe1844b0657,92035042cf62..000000000000
> --- a/arch/nios2/Kconfig
> +++ b/arch/nios2/Kconfig
> @@@ -1,7 -1,9 +1,10 @@@
>   # SPDX-License-Identifier: GPL-2.0
>   config NIOS2
>   	def_bool y
>  +	select ARCH_NO_SWAP
> + 	select ARCH_HAS_SYNC_DMA_FOR_CPU
> + 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> + 	select DMA_NONCOHERENT_OPS
>   	select TIMER_OF
>   	select GENERIC_ATOMIC64
>   	select GENERIC_CLOCKEVENTS

This is now a conflict between Linus' tree and the kbuild tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/fBpBRoyY02p_TT22tjA22Fa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltzZXkACgkQAVBC80lX
0GzGbAf/YMGZ6XVviuobSbRD/J84SoMxRBAuKbshB5RxVpe56GUwsP2SJplPtKGU
nRVXr3f3Hv/4ZbDlC1lAM4kTveBFPJWSNzs7qJDG+oBTgi3DyFl9ffSTI+tYCq2/
n/bF5BadHWXXPWzsqnsjMFDTX5U4mR+AWEGh1tO9VSjEGYyT7XDEhtkhTx6r3VMb
TtNewmgRQILaYOxd7eQVSxPY4bPQr50hOqQfMgCcr5KEniUMwUwdDs41hIohIb14
sX8BeG3Nfu5X45ygg7/NN+NmqQCoZunccr8aBz/Bn/5qE2hwfFo/QeJjqF56MMIT
fsfph5ZCEVH9aDnVjSEwB/Vk+x3LKg==
=diiZ
-----END PGP SIGNATURE-----

--Sig_/fBpBRoyY02p_TT22tjA22Fa--
