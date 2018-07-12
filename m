Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F0BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0311920BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UKrq/yei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0311920BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391113AbeGLB7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 21:59:06 -0400
Received: from ozlabs.org ([203.11.71.1]:56559 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389527AbeGLB7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 21:59:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41QzSr2YQqz9s19;
        Thu, 12 Jul 2018 11:51:55 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531360317;
        bh=d3EOyiX8aGsynM7UmwH6R3a8DMFRbdu67eCM9RdQyzw=;
        h=Date:From:To:Cc:Subject:From;
        b=UKrq/yei83EKfhXe8jJL/9o05vOffdgC0sM8U57KhlGl0T8FhnIi75bzMFtR5rp4D
         atJoJboZkTT+f7bqMfrYD17v2/o14wv0HH74bJwIG0KZRrNMzTLpzFhwbmbbP5pX5F
         qPqEKIuJJ9o9NgBNnIz7kxpy3ebGdX5wb6kaZ3iIr5TLtsWOnkeC4dlS3h4Z4lxL7h
         e6Ltk/BKLCz71hI/J8qDheBIKvezN/shRsQ97VvhD8CX7j7cZljp6OG37Tv7chpq8O
         Vg6YK/9IpDdgTjcU87aBrjtDOgIMnIUfecLrxyv2m7GPgPflvr4pouXYGXk1maWFWj
         vPweUU17Jxkgg==
Date:   Thu, 12 Jul 2018 11:51:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20180712115153.25646b70@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LxKTHVZGBc1PGzxHdTLhpoC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LxKTHVZGBc1PGzxHdTLhpoC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/gpu/drm/sun4i/sun8i_tcon_top.c: In function 'sun8i_tcon_top_registe=
r_gate':
drivers/gpu/drm/sun4i/sun8i_tcon_top.c:102:10: warning: return makes pointe=
r from integer without a cast [-Wint-conversion]
   return index;
          ^~~~~

Introduced by commit

  af11942ee44e ("drm/sun4i: tcon-top: Cleanup clock handling")

--=20
Cheers,
Stephen Rothwell

--Sig_/LxKTHVZGBc1PGzxHdTLhpoC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltGtDkACgkQAVBC80lX
0GxIAAgAnkyoRzoaT98zVQquKPvy+kedJfs54phZyKtyiA6kGexY3nqNRGJmDUDQ
wC97FZ5UesAZP2P8mFdoX4krd7yfR3CIa0kjPHRhDEzLmihBepn7BQ5RHrSX2QMd
TlXZPToVcpF46B0BubcEMVSdlVf2JKZSxp7gR8i08OaND8KLYA/OMAKCTq7lMSdt
KurosoAAoOMcDo3osf4QWafqymhERWymlLsxRE2nmGHAaMSyHymceFlPHEYfaqHK
/sGhF2XfFkzXLUNJ4EOrW03BCuxE+gTBjz1CjUVlXm05fphHUlqNF1LOK9yjk/gF
Qb+9TlVMj84yEdqVAsXp9sOZeIKw4Q==
=3tx/
-----END PGP SIGNATURE-----

--Sig_/LxKTHVZGBc1PGzxHdTLhpoC--
