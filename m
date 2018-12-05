Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49559C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B8E20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="j8xZij13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B8E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeLEAdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:33:40 -0500
Received: from ozlabs.org ([203.11.71.1]:44769 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbeLEAdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:33:39 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 438fq26ffSz9s8J;
        Wed,  5 Dec 2018 11:33:34 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543970016;
        bh=ss8rtipyzD21OCRKv3wE8N7vDYhyGPqyCWEsnO3dpkY=;
        h=Date:From:To:Cc:Subject:From;
        b=j8xZij13C3tmXunnMwFSmfTzDNAn8NRvRMiAB1rbpRsmnJ8j3SPo1PdFyCdWwjd3p
         wPDeTNwwkP9jbX+dGr7IZvemqaU2TjJx0tc5epVw8UeHSa+Vk6d+6yAJtJW6LvCON2
         xkw2F8P0i/JKLC4IWUq9CMWsr2ChNxidU1CbMOsBovPfjwQmd3dB0y/vgfQ7oLc+MQ
         sFIFVL77FSIDxtZc5mKMg8BaD23Q1POflEdTY28cffwqcySNATX0wvI+ILxl6zBlyJ
         A5jsLGS2eV0CtHqticTYlTGI7cFd7pNVC0crPd3u4KfijRvGiINgiEPZgYcMzHIN6c
         2y/vHQ6KysnZg==
Date:   Wed, 5 Dec 2018 11:33:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20181205113333.20f50e15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mi8K.qA=cKa3=9.u9HgMqZ8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mi8K.qA=cKa3=9.u9HgMqZ8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/phy/phy_device.c

between commit:

  d2a36971ef59 ("net: phy: don't allow __set_phy_supported to add unsupport=
ed modes")

from the net tree and commits:

  3c1bcc8614db ("net: ethernet: Convert phydev advertize and supported from=
 u32 to link mode")
  6915bf3b002b ("net: phy: don't allow __set_phy_supported to add unsupport=
ed modes")

from the net-next tree.

I fixed it up (I just used the net-next tree version) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/mi8K.qA=cKa3=9.u9HgMqZ8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwHHN0ACgkQAVBC80lX
0GyOwAf9GVsbv9hqRcz7DQg2IjyDk/L7HF2lRGRyuqrdDBB1AIxUgakT1ov8V3Fh
Xhn3nDnUqgZ2JsDPBrWOoMZaZziNpQrHfvqSEygbcLbC7b5ZJtJwEuwsWZIfUfXS
wTGBAYhtpSPQ0oEruOowMHn0JH3XioJKGZKcasmjSDRwNLsTePMDFDbNKQi49aky
K5Ah92LCTZf4D6KMVFQk/Bbb40De2rTPBhsmkfWM5lIYa/FrcSi+IitR5c/ecpMS
aMTAf8uHABG91/fNSoEXGnbSNcYB75Wtmp0kiAE0lPzDeGFvWnqbWx1pJttnXUbg
rIgzzRywuK18174+5lkhc16pwoY00A==
=BWvI
-----END PGP SIGNATURE-----

--Sig_/mi8K.qA=cKa3=9.u9HgMqZ8--
