Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79895C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3663D2080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Oxt8ByE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeLSA4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 19:56:05 -0500
Received: from ozlabs.org ([203.11.71.1]:45359 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbeLSA4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 19:56:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43KGfS3J6Cz9s3Z;
        Wed, 19 Dec 2018 11:56:00 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545180962;
        bh=GK9JU+GT9dQX6VNbzykSrUhHt7AhgFJF/H1VV2qT37Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oxt8ByE8+/CdeI62LZy2E+5X047N40FDZ6lU7GBWNFFlit+b+HkbmmN6Z8gDRBi+9
         4VdwlhbAUCgczzO10J0GQRXp7zAruWAwbMl9QBsqtnOo8SiHbaYVp8MwOqhUdK/Zt8
         i3mDN8J6EeApRiz9t3RH2qfmoXSwJGgv0WkOOoZmFIlLB3a0xEfkYnET2qyL4Hzmwh
         sMuJIWxg51npC2z593SjefzLsmCmARihxlC52GZBHJ6fevwvsUvGrDVkERxHY7R6dk
         aGIK1SezxuTJZJxPOvyyHclmDqfLtp5p6LSPo3lk6B0/t1EsZXdtkS7JwXKtlBWdnD
         VMQzwKCt8cQDA==
Date:   Wed, 19 Dec 2018 11:55:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: linux-next: build warning after merge of the tip tree
Message-ID: <20181219115544.2b18def3@canb.auug.org.au>
In-Reply-To: <20181106114612.7de37ce1@canb.auug.org.au>
References: <20181106114612.7de37ce1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RSeBU+aNVGBUlGdN8D9Fs6T"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RSeBU+aNVGBUlGdN8D9Fs6T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 6 Nov 2018 11:46:12 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the tip tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>=20
> warning: include/asm-generic/atomic-instrumented.h is out-of-date.
> warning: include/asm-generic/atomic-long.h is out-of-date.
> warning: include/linux/atomic-fallback.h is out-of-date.
>=20
> Exposed by commit
>=20
>   8d32588077bd ("locking/atomics: Check generated headers are up-to-date")

I am still getting these.  Are they expected?  To be ignored?

--=20
Cheers,
Stephen Rothwell

--Sig_/RSeBU+aNVGBUlGdN8D9Fs6T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwZlxAACgkQAVBC80lX
0Gxttgf+KJCuK1sKyNoMeUSaklzmlPUfEeK5V9yJpYb7rA3QvB2yB6gTUqoraEPG
j8v//uGtCGw288fJoq6QgON6twUytxuv4CvX3pkoyvrRvYS2bWzuDhI9bHjIXafg
cAnDZkP6x4qjpHCnGquvB3PVfht69eVf/VXkC0PnJhRFYJiovvjnB7ydT+EeTfyR
lJuwKm+7B89XTMAQm9Hea+vipjX9hPQ/cmb2X4Uv6GA/eibmd4rOpHs2Mz+n1eJw
VaeiHYt3+iYZ6sY64JqkFBtDCYybIuWJjae7dlL4Xl613d2Oh5UFUOWDh3JhxnYP
/6i9nH+09ehSY1QljYJ0ycSd5LqbtA==
=Q9SE
-----END PGP SIGNATURE-----

--Sig_/RSeBU+aNVGBUlGdN8D9Fs6T--
