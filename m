Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F86FC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 03:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8D621476
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 03:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dXmj4k/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8D621476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbeHOGDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 02:03:02 -0400
Received: from ozlabs.org ([203.11.71.1]:59443 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbeHOGDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 02:03:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qvfR44nsz9ryt;
        Wed, 15 Aug 2018 13:12:47 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534302767;
        bh=K9LHLV9QR4T1WKBEPMo33rr+sB9dVefK0xH5xxsGXmc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dXmj4k/+IcCE3pakqUgqams3067tVjy+q+9lp/T7Ij1fFhOPeI8/A7ObtVZOo+5zi
         ADW0cR85t89NVNqCU6dfGoB0Z4kDmmKM97VXZGCVIY+tHCHozSsYP4XOv4iIvPXhb9
         zH2IPC2fc3RZjSW2Q8MzG0HKIrkwVGSiJKhYPIypJ6eVjzSJNNnH++N9vUVSUNPy4a
         PMubI4qVfbSbcTZ4lohqGgcr3moMpdIxweZLsW6oHx+KrGbhhpz/yPhDZ1PVXKnw9j
         yTxkRfPs2wzdr8o431Xuov4Q0Mjlntrb32i93opfOMxbmVLp7N4KYj+Y40WnuRkU/A
         2tAUA5/UBBhLQ==
Date:   Wed, 15 Aug 2018 13:12:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: linux-next: manual merge of the crypto tree with the net-next
 tree
Message-ID: <20180815131246.67214bdf@canb.auug.org.au>
In-Reply-To: <20180730132253.33633f56@canb.auug.org.au>
References: <20180730132253.33633f56@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5o8nAnh_Uqd79A_ANVWGtV_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5o8nAnh_Uqd79A_ANVWGtV_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 30 Jul 2018 13:22:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the crypto tree got conflicts in:
>=20
>   drivers/net/ethernet/freescale/fec_main.c
>   drivers/net/ethernet/freescale/fs_enet/mac-fec.c
>=20
> between commits:
>=20
>   16f6e9835bcd ("net: ethernet: freescale: Use generic CRC32 implementati=
on")
>   d805f6a86829 ("net: ethernet: fs-enet: Use generic CRC32 implementation=
")
>=20
> from the net-next tree and commit:
>=20
>   5d258b48efbd ("net: ethernet: Use existing define with polynomial")
>=20
> from the crypto tree.
>=20
> I fixed it up (I used the net-next tree versions (but kept the rmeoval
> of the CRC32_POLY and FEC_CRC_POLY defines) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the crypto-current tree and the net-next
tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/5o8nAnh_Uqd79A_ANVWGtV_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltzmi4ACgkQAVBC80lX
0GxORQf4xlZJYAR0z3mo8Vs/gRo6knlmBG5iT9REqwMU5anuxA2VrDU6OST2/C5f
PMP1Kc5aBf5jyw3stH6ggP1uSP+YUBKR8V0fAY8iBTSbdprhWWI4oOCnyo1F6QPp
V14BSULMMEUaVsLmddio82NUhWQjNPg0YIs4LSUmrsKBTD19LeZZBGeK9O3R1Uht
VoDCf2fSsj+bIpj8KCZiTLhMWesJtbpDO7nauEw1rLHIdSzVray6isgRcRcrk4DU
Q+wl1t8iymPt5+X7UV1KJJV4idh1EMa3C4cL1xnWQm58+VGG8WG92HmqFfmeySq9
4a/lcKJholUVLzOwKSVRY5U//xyG
=xFcW
-----END PGP SIGNATURE-----

--Sig_/5o8nAnh_Uqd79A_ANVWGtV_--
