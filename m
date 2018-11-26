Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010BAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA223208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aVAXpFoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA223208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeKZNuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 08:50:50 -0500
Received: from ozlabs.org ([203.11.71.1]:41667 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbeKZNut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 08:50:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 433BRz1CgMz9s29;
        Mon, 26 Nov 2018 13:58:07 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543201087;
        bh=gwj5OfgYAqecbN4E4IntrPbJFLPTeCbyZTamhrHYU8U=;
        h=Date:From:To:Cc:Subject:From;
        b=aVAXpFoeZytggxSVvo5tIh56XrglFKwcSyX6PcIbAsgRkEDcF/FaHd2jMHcljlsUv
         jbo+1Jti32+A/djZg6Mjsoxmxvo1ygpqEUL1blYeZ1HMjaS12DNXhYdbnlY7bLmcoa
         3UCaZdewbrf5lggyFjpb3r6Cj0KCvQVSlhKSQBe/NkdSX54c/wDlpC28jkLc4/bJU8
         oJraCe4ptv9ZZXaBs+w66ORVZswUqRxavFF49fwK5HDuepcN++X5zlLGFP43gJ537d
         f40XHfj3J2UHObZZkz9QV2jnBZQFvtMzbxVxT8ufcAaqsRvu4KbxY1LxQorsEYsx1r
         fbfC+uVAJTzpA==
Date:   Mon, 26 Nov 2018 13:58:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fernando Ramos <greenfoo@gluegarage.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the etnaviv tree with the drm-misc tree
Message-ID: <20181126135806.22f4ce78@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AwU8QGKYH6YqgLMvrOcdeEz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AwU8QGKYH6YqgLMvrOcdeEz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

Today's linux-next merge of the etnaviv tree got a conflict in:

  drivers/gpu/drm/etnaviv/etnaviv_drv.c

between commit:

  808bad32ea42 ("drm: replace "drm_dev_unref" function with "drm_dev_put"")

from the drm-misc tree and commit:

  99e294492ef9 ("drm/etnaviv: Replace drm_dev_unref with drm_dev_put")

from the etnaviv tree.

I fixed it up (I used the latter which also renamed a label
appropriatedly) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/AwU8QGKYH6YqgLMvrOcdeEz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv7YT4ACgkQAVBC80lX
0GxNVQgAln0putbeCP7FR646d1MrjqPMR88/dTMrBbu6gRrRVDwLucOfAlHi00U2
xjvwP/VXuL7qI9Xr4erdSTohXKjQIZXY8rG8qeEqM2AR0O6M8jYMllUW130H0Gyr
tJ0F3N3JWKQBLZ87NAOYxGEys83WDzhbN+oGeN8UviDc+hFItlOu69uZedbvMxte
3ZmApoWDEp9HWVdQLHXkcJgrEKnZZOMKUvFuP8Xu5+uPEm35h2BJCJQ6gMGfmx3m
25BPa0AXhppySVksPLTRB+BBXLcrffjljbiQLvW2s6WHcDIADHb4G2Q0nAfL7eU2
vNBjUrjkhlLpBkGIYlr92Y9B9XemBw==
=4Ent
-----END PGP SIGNATURE-----

--Sig_/AwU8QGKYH6YqgLMvrOcdeEz--
