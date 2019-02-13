Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F12C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750A6222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RJlI4cGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbfBMAvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:51:47 -0500
Received: from ozlabs.org ([203.11.71.1]:43599 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbfBMAvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:51:46 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43zgvg6334z9s4Z;
        Wed, 13 Feb 2019 11:51:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550019103;
        bh=G9j1T1XiL0WumQzgy99XGHMoenT2XivcE+Bf3y/yReQ=;
        h=Date:From:To:Cc:Subject:From;
        b=RJlI4cGFGAQdPwTDyc0sB3A+SLyX4hqkXsJk9KCj8StXg0sCkk8ovrshK88PgSO5z
         nJh9+Cfo4coJjrNt2ZbdTk7uCg5/q1G5mPCy47qPTcExqqpB83JWqezJ9tLX70Ij65
         3igch7KSQ3z/cA9Mz6DhZKRFMtGIBOdwV6e4WTKgq6RcUuZBKT46fA3nRRHRDgUtCn
         4OqOsKoSpODbPcUJNMIc7tR2diLt0EsGtntZC2fZPcP17gTCpOsUOlLperl6u8HlaD
         E3s0/9KkP1KPwrS5V1J53jnr1v0XKODwAmGqTelRSG6VV4ns+3irlJk2mx7ggpfxFz
         K5NkFRWJ4eeTA==
Date:   Wed, 13 Feb 2019 11:51:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20190213115141.376058e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xu6E6NX+b2SRJkS85Er./tR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xu6E6NX+b2SRJkS85Er./tR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/staging/fsl-dpaa2/ethsw/ethsw.c: In function 'swdev_port_attr_get':
drivers/staging/fsl-dpaa2/ethsw/ethsw.c:646:26: warning: unused variable 'p=
ort_priv' [-Wunused-variable]
  struct ethsw_port_priv *port_priv =3D netdev_priv(netdev);
                          ^~~~~~~~~

Introduced by commit

  1b8b589d9103 ("staging: fsl-dpaa2: ethsw: Remove getting PORT_BRIDGE_FLAG=
S")

--=20
Cheers,
Stephen Rothwell

--Sig_/xu6E6NX+b2SRJkS85Er./tR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxjah0ACgkQAVBC80lX
0GyI2QgAh+9v6JDBdVvFgaJH5sP+a7J47MNSqoNj7083aW7nAMldhBI53zJTEt/U
iq6+Ag6Jh584HRmfOiihGC0NQFm/LvUm/s1zGX9G94aIuVdZIR3543252bqjWz/L
uX2HRLQBYmgUptTGI38+4BqsCuTX7AE0HTNoN74GiOrhRr25oTBgnklGr80Ql2rU
hhMQzStvgZI4dabtydYPjs3zwJFLYKYWSMZOCaMxia7oNNwxiurfMYr50LRuCjpX
H/pBphegJYV2EqnAw3+0rzRtbXNGg3qU9KLatzIUp4KJk+2u/psu2mRAsnHOvPE7
4ZEE37dMS2kDPnt9opw82Nhc/5r7QA==
=+H4O
-----END PGP SIGNATURE-----

--Sig_/xu6E6NX+b2SRJkS85Er./tR--
