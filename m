Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F559C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB5E2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="N4PTA2V6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbeLRFlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 00:41:35 -0500
Received: from ozlabs.org ([203.11.71.1]:55591 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbeLRFlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 00:41:35 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Jn2N2jwDz9s3q;
        Tue, 18 Dec 2018 16:41:32 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545111692;
        bh=IzomdpwKv3BWFu1k4oWKMpFDAXk9EqpTydMJ28ExBrs=;
        h=Date:From:To:Cc:Subject:From;
        b=N4PTA2V6JCz8tamKed4Yz4cHRchUq4bmsXUhOcLjJ4lDgK/8tbRWLnRKidLwW08j1
         TqcL9hCH5SwXMQ2/dHFXLKCreJ+bcf0ev+HnTfG8N0cMqQiMddKJohMANc0/R7LznW
         +OcTKld3uiXdoJAx8NQhHXltX7mp7jI5NGtKheuWSgsyROZX2H81uRSUhJ2SUBrAtV
         pUi3vR3nRyQkDolzIcdTZvl23sCR8QiWLqslTyb6uiFCTUNYWqszKzKC+ZF74r8asi
         RmBMAVO84AvRw7dz9Y8JU4s436HZO+HbcQLXJJQhTP5QmhaXijtb/ohBTwIsAb5gki
         J5jxTz+52pGog==
Date:   Tue, 18 Dec 2018 16:41:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the gpio tree
Message-ID: <20181218164131.7ecf23f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eLkytpj4ogzcuNbXQvkiUZl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eLkytpj4ogzcuNbXQvkiUZl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

After merging the gpio tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/gpio/gpiolib-acpi.c: In function 'acpi_gpio_adr_space_handler':
drivers/gpio/gpiolib-acpi.c:911:8: warning: unused variable 'err' [-Wunused=
-variable]
    int err;
        ^~~

Introduced by commit

  21abf103818a ("gpio: Pass a flag to gpiochip_request_own_desc()")

--=20
Cheers,
Stephen Rothwell

--Sig_/eLkytpj4ogzcuNbXQvkiUZl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwYiIsACgkQAVBC80lX
0Gy9HQf/SKxwy/zpdCkX7IxHQ/7YlkjrwLeqQmtrQLNuA4h2K551MxyCPG/ZZu6K
M0g7NfixRXLFLyW3HZzZH6qeobgF8wJ4Sbr96n38Q7+/KJDnDcc/Tv+1c3RFHz/b
ddWV6y+h5TZ1X9yQLJhdCDDIK+Sn9OPUurYn8hm5njKWtPj4RW4tCTNWO82mCkIZ
NLxHaZd+jlZvXOErCWWXUnrjeLAx2n7LlPRu5AAf3kZPVo6KoTSZNBg7rMP3Ef6I
ptL5JRuGWIvfK9sSGGJRllyHB/GXR4rf5Al6iPrS13SAl/tPBWQsNwEEp+7nlot2
lM1HEy1o/bVVk6/Awe/HWhddAb63uw==
=iS+D
-----END PGP SIGNATURE-----

--Sig_/eLkytpj4ogzcuNbXQvkiUZl--
