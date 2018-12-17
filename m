Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CB2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D49421836
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="G8Q6ZTt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbeLQIR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:17:57 -0500
Received: from ozlabs.org ([203.11.71.1]:34693 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbeLQIR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:17:57 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43JDYG2v6nz9sBh;
        Mon, 17 Dec 2018 19:17:54 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545034674;
        bh=5Qbj8eSY6BK+H/tUVFNjmPy3YvUik7VE2iiT+3NDq68=;
        h=Date:From:To:Cc:Subject:From;
        b=G8Q6ZTt8Gf6xZnzwQFabOmMIw5OhBOABkgKED8LCFxfN8BBYgoxRPN2mYYsjVk/X5
         Jj99gCugf5cHsWmbKjpQOX6eVV8xIC+cxO7ioBfD/+UO/wrM0kYFS8OmW3CEfeZSE4
         1c1YEC4Tj0GMa4nbV7QLW2giDaTtGPxlqI0WMe6qy56qOproowtMsiyIniHvsfJd+e
         L3ZqvRyZobq2+Y4e+LB6VD6rTkzCbvOKoTZqtuL93SMxwmUiISP2U2HLz050pl1prN
         x9qwaSGf2zuAuixEz3B7Dnrp/jA65w7fVxrx6dSNARSAdgPX0HbHoJ20yfBRsZ2/Hn
         SbBbSD0YQ76tA==
Date:   Mon, 17 Dec 2018 19:17:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>
Subject: linux-next: manual merge of the gpio tree with the arm-soc tree
Message-ID: <20181217191753.172ca200@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CvY/7uXN8E.YOrGdwkkP4B1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CvY/7uXN8E.YOrGdwkkP4B1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the gpio tree got a conflict in:

  arch/arm/mach-omap1/board-ams-delta.c

between commit:

  19a2668a8ae3 ("ARM: OMAP1: ams-delta: Provide GPIO lookup table for LED d=
evice")

from the arm-soc tree and commit:

  21abf103818a ("gpio: Pass a flag to gpiochip_request_own_desc()")

from the gpio tree.

I fixed it up (the former removed the code updated by the latter, so
I used that) and can carry the fix as necessary. This is now fixed as
far as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/CvY/7uXN8E.YOrGdwkkP4B1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwXW7EACgkQAVBC80lX
0GxrnAf9Hudx1lEWXTwWV/OlWQv+f6TR21Eart36sf/jj2GPbpXVNvDNKSN9f2HO
Rhu6bU3St4uMWuKXAw+5W9F45A4gynKuHMrFZIu9XAlZpXCSschg16X83GOzuddf
wStMikfOsGpXbnM0oXD4/z6CO8iTa42flOcomwMujvAomG/+EJ39XCwVGFuuw3pN
u6wWuSrcDWqDjgzQTGjAJlkocOOgeJDutRAqLS/6Zf5hcML3QIIj8dt9yd6osWZf
Vf97/GoZvjNVqeBJUPz0zxgvzJwj6GH+brvU8LjqOA1/Mc4ZZuXFY2mOyZGm2dy+
79kihxZiRgSM6mT5QWa9l5mDkY6Abw==
=nITP
-----END PGP SIGNATURE-----

--Sig_/CvY/7uXN8E.YOrGdwkkP4B1--
