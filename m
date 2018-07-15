Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3A0ECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0658F2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="orvkh7y5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0658F2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeGOXiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:38:15 -0400
Received: from ozlabs.org ([203.11.71.1]:41213 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbeGOXiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:38:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41TMmM1hvwz9s29;
        Mon, 16 Jul 2018 09:13:38 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531696419;
        bh=Hf0sRMpN42SCFa+yBugAOebjOpyMDrNZ7oVsmFW30qI=;
        h=Date:From:To:Cc:Subject:From;
        b=orvkh7y5xJvkPkXpqCv/yt/XYGtnIXdhEm8TZMOUnBlN0daiAJoMqYINg0xabCyiW
         vP/DxwDR2f3u8Yi+uexXI3ZtLGfySzkYKmJpCOgtWF0pUi5YqJcAEsO7DM6gY48v1+
         tlfNayDooxIymfXa8N36ZbT3HjoDn+gOQotihxD/Bj90AfdxnH+bP/zrZJ42GNXjfA
         lHEYNPahKz7Rbae3PVYN2vA3wHqm1Xdbe3sdPkEonzrJ1jqM9LxKBRGNJHkyoiBKTw
         zS2XMzfrEVRUx2GCKJsh77sCb5jFIzF3AItJuexLcgul8jITNsNIjZpM1BWwO5wXgM
         H7Ki5G1pzz66A==
Date:   Mon, 16 Jul 2018 09:13:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Vinod Koul <vkoul@kernel.org>
Subject: linux-next: build failure after merge of the arm-soc tree
Message-ID: <20180716091337.6c1b2a4d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/a1F+eL1_QBQ4gCyjhndOxb="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/a1F+eL1_QBQ4gCyjhndOxb=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm-soc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

sound/arm/pxa2xx-pcm-lib.c: In function '__pxa2xx_pcm_open':
sound/arm/pxa2xx-pcm-lib.c:129:6: error: 'pxad_filter_fn' undeclared (first=
 use in this function); did you mean 'dma_filter_fn'?
      pxad_filter_fn,
      ^~~~~~~~~~~~~~
      dma_filter_fn

Caused by commit

  0d0b16b8e008 ("dmaengine: pxa: make the filter function internal")

I have used the arm-soc tree from next-20180713 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/a1F+eL1_QBQ4gCyjhndOxb=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltL1SEACgkQAVBC80lX
0GzWigf/eMLNGMN+OdgLRMTlfU9xNuofVKdAb+wrlJ7YoHL1i1FVdD0My9RviQde
AugDCBGREsIdWaaU3jchA58RyWOf+NEuNAVmbWbZukJ8YH7Yf7OeWpZyS+jR8A0m
Lvg2HbwDjJ6M2lDBNLkPLFpFPbl0TAY0tn20Qawit5+ijP3WUIIH1npWSb9eEO5/
hogpQrGd/CIoNd2Gv6zLBv3HkSB9LKP8p0WQQ/xXqCovf6tco2KIFRP/kIPvEMHw
LA0ik8flj+nmFUrUF5d/wD2C9BiCG7TMHAV1QaDCurSiTChVoXx7sGJFPV0p/0dp
SeJpCaUxfTXN3X4Bsq8vf4xcXRKqoQ==
=prR7
-----END PGP SIGNATURE-----

--Sig_/a1F+eL1_QBQ4gCyjhndOxb=--
