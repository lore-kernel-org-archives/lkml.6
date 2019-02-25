Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF96CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0C521871
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mHa6juf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfBYX4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:56:03 -0500
Received: from ozlabs.org ([203.11.71.1]:53111 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727516AbfBYX4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:56:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 447f3N10B6z9s1B;
        Tue, 26 Feb 2019 10:55:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551138960;
        bh=oDWWWRH9GxHlVxG5CxicpmMH7itWknqDpT7+TPvmsxc=;
        h=Date:From:To:Cc:Subject:From;
        b=mHa6juf2Fi+HUmkeYsKIg6BcDGUCVSS4CddnLBkc02Ag6d6+fAhIAqJ7JO4Vgro2y
         CysUiPSEjZTmOO3LZt47rtaNzD7jx6+BQOg4QXr2srn1pDKe2rUImd5xskTza+jPA0
         3lcsbgw36f9AKL/k9+qT+fIxU6mkD7WvwWVYK6NEH3UyoGK6MwalUeU0yQ52zWQAvh
         wbdtZVDktRjF39VWwfGVXmj2MpD8Jq/fYLWJT3iqTKJwyGVBJ96J7bJstOQdZLpvnG
         I8DUTYP/5emHBZFhnjBy6ARPW14wImZOXMM7fIr5O+8QR9J5cQhoOlO9mMMdVvkoxH
         /RzHiS5H0VdhA==
Date:   Tue, 26 Feb 2019 10:55:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: linux-next: build failure after merge of the hwmon-staging tree
Message-ID: <20190226105547.7343cf8c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/o05=A/bh3XSY4oJOmcMSpY/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o05=A/bh3XSY4oJOmcMSpY/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

After merging the hwmon-staging tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/hwmon/ad7418: struct of_device_id is 200 bytes.  The last of 3 is:
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x61 0x64 0x69 0x2c 0x61 0x64 0x37 0x34 0x31 0x38 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x02 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00=20
FATAL: drivers/hwmon/ad7418: struct of_device_id is not terminated with a N=
ULL entry!

Caused by commit

  08c95c6f6f95 ("hwmon: (ad7418) Add device tree probing")

--=20
Cheers,
Stephen Rothwell

--Sig_/o05=A/bh3XSY4oJOmcMSpY/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx0gIMACgkQAVBC80lX
0Gx4Qwf+LUVgwUImJgFE2+OLSSFZXsGeTo/KzRNfab83NXhBjOPXOiRQGfhrNelK
fd7v+8dmwbn9GLpDzvbhW/dRIQwJiRelIYoWnFsgah42WmR9zTHOR2DmjtFtN4gh
g1mJER9bt0gEwbF4qT4uLDxScJuQXXhGzEVzZbYNwMIri6szI1z8oAGvL/hVbaM8
dwAQShvZI3H1jsATrU6gOm1DL2bul/jkxeoKxIo4fiOV1xnBcdqoKOCzrKQ+3fZK
FKbeAjFu0UusJNlRSelI3H2Pj6b4Kpvvn4STPRI9pVnOlXIM5V4vyxGFJGXgzKeB
/0Ni4BEDfEtURi9OFF8H7C4uoAZRRQ==
=Qevw
-----END PGP SIGNATURE-----

--Sig_/o05=A/bh3XSY4oJOmcMSpY/--
