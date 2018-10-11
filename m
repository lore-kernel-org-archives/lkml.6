Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804FFC28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CAA20644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hWjGC38R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CAA20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeJLHOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 03:14:40 -0400
Received: from ozlabs.org ([203.11.71.1]:36909 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeJLHOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 03:14:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42WSHy2fG9z9s8J;
        Fri, 12 Oct 2018 10:45:01 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539301502;
        bh=EWvEQtX7e2SqwjqkAvR4VCZ+gmnAqgCv4hloMnkx+t8=;
        h=Date:From:To:Cc:Subject:From;
        b=hWjGC38RBaH4Bn38+gTnGwsGHDx3NsOAf6/blmfOwwyZMEKoS8z1GVdqQkR6O1QDP
         4SaBqyl+SkRQcYeN/MeJLUyOEqQdYWfcslL0YsIeTmNMP+WokgYhn2GR/2DzD3V08a
         Dr6GtZEzqi1tJm6pAqyNawhGVk3pn4z24laoGWMAWijT5Ppkk1f3W7r+y9X0OXyNJ5
         4LOTr/lfuE/KODr14MANpLlVGM3OoW+qqelo2h4MR3JiWE4EvDk101253bUgZhiXw6
         VJFW19Iof25xmeU2JpByqxPRfuXXVw0alfleMB1Gm3kQHWAY87iP5RGId7XqMW4cIL
         bqWIRyCX6mimg==
Date:   Fri, 12 Oct 2018 10:45:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arthur Kiyanovski <akiyano@amazon.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20181012104501.063dcc4a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0DFU4xM79nqYEe4lM7o4//4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0DFU4xM79nqYEe4lM7o4//4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/amazon/ena/ena_eth_com.c

between commit:

  248ab77342d0 ("net: ena: fix auto casting to boolean")

from the net tree and commit:

  cb36bb36e1f1 ("net: ena: use CSUM_CHECKED device indication to report skb=
's checksum status")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/ethernet/amazon/ena/ena_eth_com.c
index 2b3ff0c20155,6f8e15b9b3cf..000000000000
--- a/drivers/net/ethernet/amazon/ena/ena_eth_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
@@@ -245,11 -349,14 +349,14 @@@ static inline void ena_com_rx_set_flags
  		(cdesc->status & ENA_ETH_IO_RX_CDESC_BASE_L4_PROTO_IDX_MASK) >>
  		ENA_ETH_IO_RX_CDESC_BASE_L4_PROTO_IDX_SHIFT;
  	ena_rx_ctx->l3_csum_err =3D
 -		(cdesc->status & ENA_ETH_IO_RX_CDESC_BASE_L3_CSUM_ERR_MASK) >>
 -		ENA_ETH_IO_RX_CDESC_BASE_L3_CSUM_ERR_SHIFT;
 +		!!((cdesc->status & ENA_ETH_IO_RX_CDESC_BASE_L3_CSUM_ERR_MASK) >>
 +		ENA_ETH_IO_RX_CDESC_BASE_L3_CSUM_ERR_SHIFT);
  	ena_rx_ctx->l4_csum_err =3D
 -		(cdesc->status & ENA_ETH_IO_RX_CDESC_BASE_L4_CSUM_ERR_MASK) >>
 -		ENA_ETH_IO_RX_CDESC_BASE_L4_CSUM_ERR_SHIFT;
 +		!!((cdesc->status & ENA_ETH_IO_RX_CDESC_BASE_L4_CSUM_ERR_MASK) >>
 +		ENA_ETH_IO_RX_CDESC_BASE_L4_CSUM_ERR_SHIFT);
+ 	ena_rx_ctx->l4_csum_checked =3D
+ 		!!((cdesc->status & ENA_ETH_IO_RX_CDESC_BASE_L4_CSUM_CHECKED_MASK) >>
+ 		ENA_ETH_IO_RX_CDESC_BASE_L4_CSUM_CHECKED_SHIFT);
  	ena_rx_ctx->hash =3D cdesc->hash;
  	ena_rx_ctx->frag =3D
  		(cdesc->status & ENA_ETH_IO_RX_CDESC_BASE_IPV4_FRAG_MASK) >>

--Sig_/0DFU4xM79nqYEe4lM7o4//4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu/4H0ACgkQAVBC80lX
0GykpAf/a6LXMoIH0u5WKc6AlljvaZ+VCJzRrsYeRAZXiw95LHgL6UXYbjKcQEZR
nDpAk1i7NTyauY97uQZ29tcOjBTnNZyxvwh7wTu9LNhDF0HvNT0IDvgiH0XM6wiy
eiRQLjvKIRzR2IBHgdawBGeGdJS3WXXsFDhBanT6ojAnJ/mr8N5HX8lPwP6CC/Am
ykuibzW4TfaeEO/IsaixwR9XoZEsOaZG7+5MsKmb1QlUADVfZAwe3/lz8ER1QT6F
KzMWUwYvdl5F3YHPj17EBjCtIAv0sSB1tavHDVvPFE2hgp8JJjWIHdjZWCYX7/o3
OOmmEgMKHHlQ4n+AlFftiWUnprjbtg==
=7hS8
-----END PGP SIGNATURE-----

--Sig_/0DFU4xM79nqYEe4lM7o4//4--
