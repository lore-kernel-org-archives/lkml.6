Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2087FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF98E2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FFI5Lkks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF98E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeLJHAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:00:54 -0500
Received: from ozlabs.org ([203.11.71.1]:52337 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbeLJHAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:00:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Cv9b6wbtz9s47;
        Mon, 10 Dec 2018 18:00:51 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544425252;
        bh=rZgqStAivzKjfpwunFK3mv0C8iCQw3Y1tZ8naAVncH0=;
        h=Date:From:To:Cc:Subject:From;
        b=FFI5LkksZOdD4zOQWRb1Etf0pcSc+IOh8+KE3hoKktHXZ7y56qf436O20J769KfDN
         zI+rTR3yC0ig0e3RYopqgm+QpZwW1RHjTVCuqbPrtG3Nvclr5WN7zLYPt9toLU4vqL
         6knsArq4khxmT9qAxWMLMhYu38ndU2qI2r0qQi/0P2d2n0NnUnxe/+C/RaHCoGG1ub
         jvsxhodkKasbWs0CwtZX2gkgc/oGgw2Gc+du710IMfFTB90Vh2naDtgazOL8ligXLO
         gLoSXkE61z05ZOl3Fz5r9cQ/u52G0sV/f9dmS5zvlj9Z2xwttfuZm/G462JEadwQIW
         xx8ErICZJOhaA==
Date:   Mon, 10 Dec 2018 18:00:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: linux-next: build failure after merge of the gpio tree
Message-ID: <20181210180022.0c78ad5a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YpuvXW0_4+PuRGoAsHwMDxi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YpuvXW0_4+PuRGoAsHwMDxi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

After merging the gpio tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: "irq_chip_retrigger_hierarchy" [drivers/gpio/gpio-lpc18xx.ko] undefi=
ned!

Caused by commit

  5ddabfe8d3de ("gpio: lpc18xx: add GPIO pin interrupt controller support")

I have used the gpio tree from next-20181207 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/YpuvXW0_4+PuRGoAsHwMDxi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwODwYACgkQAVBC80lX
0Gy7jQgAnXFUhHY/EojI3ykFwgz/U5dcKvARyDN+vG3T7aqMG+3cPhD7xg9PEdXm
ap8dZMiwsS8ocJLEq2G8uaX98V7Ur3Nj48/95ogzxJL3tUH7+eZrsAJRK0qyIJuZ
tKgyKMMmPCFp6aVuIQkKSg3Zx2mLxyr4QshsQ0b0O0okYqMxUTVsiiTpqb3m/+B8
20geVZKEBMWNbhlvpsAqzc6xuajdnwSzIfMqYqGUJQAUxXSAX5m0j8dawQKobZTA
vs9p0lotlI8UyUByzL51qxN+S54lBzCbMbL3WyQkIsBOmZcE0WQ/sGv3+ywiJpbz
SyEFRIiAsObYgBcnvI2rEq153aRMwQ==
=8O8E
-----END PGP SIGNATURE-----

--Sig_/YpuvXW0_4+PuRGoAsHwMDxi--
