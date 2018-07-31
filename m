Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E33C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CDC208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rRrL5k6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CDC208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeGaEpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 00:45:07 -0400
Received: from ozlabs.org ([203.11.71.1]:52563 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbeGaEpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 00:45:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41fhDk4bYFz9ryn;
        Tue, 31 Jul 2018 13:07:00 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533006422;
        bh=gd2kYnldNDevXBnUcGrUXFFFW504uK1ezx76RMDT1HM=;
        h=Date:From:To:Cc:Subject:From;
        b=rRrL5k6F8MOK7V7goal0XMtqhBnPGycsN4JpwV136X2f+7XwWx2L6AqY1dwIdN3Uh
         b7XL+Q8hRoHQEJHwfTMHW1DdF1XVwedUnk+8Q3jl8MCaPVEGHlOmdZ/pjapYQkT523
         fhxDFXXsMXOhVugpN1kb7Un4K5UrI0g7uJa4xpTR4MDYL7gcqrVB5EZdZa/LUipm7y
         s/EBKcM6dI5RFBQMFHVuT8G4Qm6VZZnWgpilZUT2WVvKMSjDZDlQm7sl+C710xe14s
         04I764hC0yZJlpa/6MC3sgD11DE/nEROeNci9WxCFPsqvpV/tIhfK06rD5i3PDq9Be
         fxmcdAQDkVAYw==
Date:   Tue, 31 Jul 2018 13:07:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20180731130700.3ff50dce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.jhLpF1cCZWW_8sMHa+0.c+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.jhLpF1cCZWW_8sMHa+0.c+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

After merging the block tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/scsi/sd.o: In function `sd_done':
sd.c:(.text+0x1050): undefined reference to `t10_pi_complete'

Presuably caused by commit

  10c41ddd6132 ("block: move dif_prepare/dif_complete functions to block la=
yer")

# CONFIG_BLK_DEV_INTEGRITY is not set
CONFIG_BLK_DEV_SD=3Dy

I have used the block tree from next-20180730 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/.jhLpF1cCZWW_8sMHa+0.c+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltf0lQACgkQAVBC80lX
0Gwzpwf/X1pEYcETqY2fL0QFgQAhpmOPUON7wZpj6z13jGvyYZxnBNtcRbO27xzC
VQDdXosoalPiBbV9eEaAVZ+AH939rXbdiNExxswEaGki6Www3oPhu2JfaulgMZv9
Lw1Y1/RplTLqKLWo9RkyNwc1CoSL0ajP8+uRLwdVxpvNxa38wpWsb5Ejxo+omZfc
riXmy82x9mSyS7D4FadRugMJTQiUixNgvy490PGvuZuDvzs88LYsF4D0vo2KXtin
ZKBErWxcj9ewsUO5L/gXv8HCgBaEkpyJWLXwfXKAV8oUd9HypjEXQNEUKOWX8YT2
JVDWxh4F/RU0FpZV8VMHRvkTZmLRlg==
=7edz
-----END PGP SIGNATURE-----

--Sig_/.jhLpF1cCZWW_8sMHa+0.c+--
