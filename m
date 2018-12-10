Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A2BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9932082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NYyjKQ6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9932082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeLJFxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 00:53:55 -0500
Received: from ozlabs.org ([203.11.71.1]:53899 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbeLJFxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 00:53:55 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43CshJ2r4nz9s2P;
        Mon, 10 Dec 2018 16:53:52 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544421232;
        bh=vQR6kZHj+umKZpKMQnXseUo6Fxca4xW8RRbWdL6h30I=;
        h=Date:From:To:Cc:Subject:From;
        b=NYyjKQ6xq1SQURr2pn74wSDG4v/bmoWogJszm+cu2wEtMZ3MUiDAceOcbTz0blMC8
         xb6DY0gIiMZuctUxJZ+Jtua+3BgUToc93h8fqiRrdV/WXfZzk2BGXumRYINgBlcErB
         KpcZwN04YdC+90R7zVBT7PvVbDH6z/MCFGKQ1FYboI+cUgMjSR/sYEgNenp8FWuTDF
         EQcfUIrPrpYw81I86SgVdCBGiZs78Laf93EphxeUHR7UyeIAFclnOsyW3kA+qUgrC7
         3ReoWXgmnVO0c+A05zivYemWTkL2h16nJPVhXqTZa7bV38xWj5Nnkmo+OchVLwFh1c
         Wwc/6Zr5Y3rig==
Date:   Mon, 10 Dec 2018 16:53:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: linux-next: manual merge of the staging tree with the v4l-dvb tree
Message-ID: <20181210165351.0976c1f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mt+iqN82aymKltl3QQK8+IE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mt+iqN82aymKltl3QQK8+IE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/media/tegra-vde/tegra-vde.c

between commit:

  91dc5e91edf7 ("media: staging: tegra-vde: Replace debug messages with tra=
ce points")

from the v4l-dvb tree and commit:

  9483804a725a ("media: staging: tegra-vde: print long unsigned using %lu f=
ormat specifier")

from the staging tree.

I fixed it up (the former removed the code updated by the latter, so I
did that) and can carry the fix as necessary. This is now fixed as far
as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/mt+iqN82aymKltl3QQK8+IE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwN/28ACgkQAVBC80lX
0GwU5ggAoJPT0uHIP4eu2lYmOFyhI7q+GZtNz8JZr7FHY0pdGclpF/Qzd1NPko5w
XaktE9coLcwRKOyzDE8MXQ9nSghVDVghK3y2FHmd+W6AhnDm5Q3AAiRX6bgc+0Er
YJZjk/kdPJE/4E5aQGWqDjzWUsqyIUfU3s4SCY6xpNIKjbJRcQ8EnS6Rm8vQjsnn
Uo2ah41mSZphMjSBd0zFzfg5FpQrCX90PwVNu40WIeAbVZfE9jJDtz7yvvVf9FGY
tZC+4+rKSzEG0r7Q90hqXr8eu8iXP7CS23hwBj9zHbBX2VJhcjAuJkf2Sl67MVMd
9CEW8xmOIlrFxp8x+FIBV1uJaeiL/A==
=uGek
-----END PGP SIGNATURE-----

--Sig_/mt+iqN82aymKltl3QQK8+IE--
