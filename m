Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8A1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E972089F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fafaEV+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E972089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbeKTLP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:15:58 -0500
Received: from ozlabs.org ([203.11.71.1]:56781 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbeKTLP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:15:57 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42zRtN1rdVz9s1x;
        Tue, 20 Nov 2018 11:49:32 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542674972;
        bh=xFg+Kq3oMbogFmttCZC+r4GYxrIMhhOMPjL4mhoXj3c=;
        h=Date:From:To:Cc:Subject:From;
        b=fafaEV+lcCYUfTdP0W49u4iLUR1gljv/u4x9fsosxlVSlQv+CvElAH2TWuuMgrecR
         IY/SyTZaf7BSgUg+DL4sYHwCMxU5d2ZnpUMww7dZ6wH8qSRzLh2Sn/SLO382H6gDa4
         1smnXBIwTsGKEBdsAO6omU+F0GyZixYTdmoKk6Mp6//5wLBKnbudCqiWTAZycDTT5d
         gfZDTIkUWm2eOfiK7nsMCys95tNuM8hZR4gHEbjX+EUdRnf7pfdaOVxNDcN/8Xdzur
         XLwD0hFpW8vImF28bvKStV5SVCK5s+d8TvPfy4HxoibEy3Cdtyo9hpquQS6HL10uaS
         15IBRUtEZQ4Ng==
Date:   Tue, 20 Nov 2018 11:49:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: linux-next: build failure after merge of the regulator tree
Message-ID: <20181120114904.10ef0573@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/X1cY5X_AX8RQn72FrFZW0m."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X1cY5X_AX8RQn72FrFZW0m.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the regulator tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: "regulator_lock" [drivers/regulator/wm8350-regulator.ko] undefined!
ERROR: "regulator_unlock" [drivers/regulator/wm8350-regulator.ko] undefined!
ERROR: "regulator_unlock" [drivers/regulator/da9210-regulator.ko] undefined!
ERROR: "regulator_lock" [drivers/regulator/da9210-regulator.ko] undefined!

Caused by commit

  f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")

I have used the regulator tree from next-20181119 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/X1cY5X_AX8RQn72FrFZW0m.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvzWgAACgkQAVBC80lX
0GxYuAgAm9jNAru0Hzh/iIvdvsVVHHnMJ5nc40fsTEzlRW25XF9jX0R0D1P0gn8m
8AV/9u6eJOXhlN/rL1akeS4dusLUZyFVaj7DivyrdX7XFJXzAErqaZsjc9q0kAat
D2KPxhy43B4qMrVD9Fi4gxVwAnAJPept8jxt+yLxXLuta+Vz0J2Kt0+rQOsCz7am
l3g4SaoPSd2Z0Ceg7FS/vnyScoooGnUR6DvcPyxk7hYAtGtKKnxxjBg5wzM0Sjb0
6eVXJDPEpqDyJickqrYEyCp5yGEGf4a0++fMq29igGRnTQW0mdaA2nGagqQYhAvf
tZQ4F+YRv28s6BL2dfSYmA3ZxVOQJA==
=Epmi
-----END PGP SIGNATURE-----

--Sig_/X1cY5X_AX8RQn72FrFZW0m.--
