Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055DDC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD96D20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MrmLOXAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfA3X7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:59:41 -0500
Received: from ozlabs.org ([203.11.71.1]:44473 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfA3X7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:59:40 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43qgMZ2436z9s3q;
        Thu, 31 Jan 2019 10:59:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548892778;
        bh=pT+xd8mOxwfKhIVAMm0i3vGJTjRL0vJIVGUjQCFS0TQ=;
        h=Date:From:To:Cc:Subject:From;
        b=MrmLOXAOVqrpnSGDaEyqOvSmXldzQRMiRRQATOLDf/Hx3r6q1c8+tZKVUj7CHEDDj
         j1yl7PJ3XQSTQV8F0U0nb8+fgCanWm+gitwCx4sj2SAvMzkELO1zaMzGx3MwQ9A4Ei
         S6tAXQW0gyT0q7X/gLjQx3FZyi9l61Mo+5KVDOESeBcczjXhNF+jCsDmwkJXCgkYtg
         7NfgJHUB8NOGGyehUqTJjQuqA3HrQKMrOWWPBauvSEp4pY9Wo4QI5kcZz7ZmP9i6vI
         nPT2imYZxGxnR2QIEGkjW4nWtrq3mcqg1Nk/a5VHMQyL6VGsaClOMaOi57b6aeaQCP
         mSzhSQdPijS1w==
Date:   Thu, 31 Jan 2019 10:59:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: linux-next: Fixes tag needs some work in the akpm tree
Message-ID: <20190131105937.62023ef1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4/qwh/OMSLP_RdrmrC7MTMf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4/qwh/OMSLP_RdrmrC7MTMf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In patch

  "include/linux/relay.h: fix percpu annotation in struct rchan"

Fixes tag

  Fixes: 017c59c04 ("relay: Use per CPU constructs for the relay channel bu=
ffer pointers")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/4/qwh/OMSLP_RdrmrC7MTMf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxSOmkACgkQAVBC80lX
0GyuBgf/YOlmDAPUXTrmbX0wj4VBDgQemZtMhCN3pDtxmnnBHnsIDRo8xLGCBuMY
dT4fxTr8JTBxfkDaL/kj95SsQNOI8EZ4s8kHChS0WZwTb8+MXgmCnirMwwXbNHTv
eRRsmNRpZ+FDznBambn6k39EAI9Qq1iF+NuXygGbvc/SZBxGwcakrb1a5wMCYZ/N
fYp83aMvG7m8QdtwUSpwP1jY52nzpALsGjPPXtaZxYYlwmqKhqPyB2uI2xTctMBd
YFAsqZ10EhMzh3jDsMy3fqe5gdVNIf6ksM1wY7IvWctGAJ2Vhzr1y6Do7leD3xJQ
WbdBBb2Y17+23lv/uaG9a4m/K5j4CQ==
=bZSZ
-----END PGP SIGNATURE-----

--Sig_/4/qwh/OMSLP_RdrmrC7MTMf--
