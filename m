Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB0AC2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 23:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1DA20672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 23:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HA9jmS17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1DA20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeJ2Hyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:54:40 -0400
Received: from ozlabs.org ([203.11.71.1]:55393 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeJ2Hyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:54:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42jth02K3Bz9s9m;
        Mon, 29 Oct 2018 10:08:32 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540768112;
        bh=vsUlzxveGGb5eo0emhEZjLROtpgUrXJNYMUqaP7IzV0=;
        h=Date:From:To:Cc:Subject:From;
        b=HA9jmS17+GN0KWKrCG/2g1C5QxMqXcPzEwb8P+/o2rkURegCUJkHjoGPwTMLzSdbP
         Ry2lRAQbmhysGzRmnLMk8szpPmV7uNA9ZVzk+YKMCUn9QXLy4nBtDj6ob6Lk1K+38P
         gHpCxG5gHGsYQtLlbcesuSelCoRzmXonTebw5JBHtuDy4La+BCFZ44K9T0ue8fWYiF
         BVmw2ex3qgQyVvjyiI23q6IrArayfEQZr7t76L55CioDCNa2Sd2p6Q1i7bklgWUN+B
         /LCBmz5WoexuLy3XlbiDK+AqAqgKhjygYtBrSehyoiErm78RApuDKLPHhCWZZFLBI7
         9T3n9uWu93IGg==
Date:   Mon, 29 Oct 2018 10:08:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20181029100831.73b12672@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=_L/wC4xwxrC/ekk9rJ.mvS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=_L/wC4xwxrC/ekk9rJ.mvS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  drivers/soc/qcom/Kconfig

between commit:

  a978a5b8d83f ("net/kconfig: Make QCOM_QMI_HELPERS available when COMPILE_=
TEST")

from Linus' tree and commit:

  ccfb464cd106 ("soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs")

from the arm-soc tree.

I fixed it up (I just used the version in Linus' tree) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/=_L/wC4xwxrC/ekk9rJ.mvS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvWQW8ACgkQAVBC80lX
0GycAQf/bAeaq8482QIDfTMaSVUId/AcgetXEXQqiqek1NffGeh3s13ZLo9vlH4/
Fg8iZ6JBLNfqam4H4T8n2tE9aaY/GSFsge2+NfaQaJR6T3k4SIh4CHuTWUR/p16B
oOveCZMlTk80IGuCBLSJwmiVj/fyIqXNV7/rXysTOj2xO4JqFt5wXIUD/KyeI6gL
8RL4atS+OcRSktfDnj6jyOw0ast4ubJ6OxzH22tFTpHSadSLakjoEj4++KnxpAGg
rlLGEXvLGw6WCFgDf/WrSAhSCjiWRImWkLzjFQxLR+CPkLFX0Xtgy6XB+ICK6S12
6lTPuvOcPPOyAvA2aWMwDD40ibfK7w==
=LPtz
-----END PGP SIGNATURE-----

--Sig_/=_L/wC4xwxrC/ekk9rJ.mvS--
