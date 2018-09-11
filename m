Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AA9C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D67B20881
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ujSCQ2WL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D67B20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeIKH4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 03:56:03 -0400
Received: from ozlabs.org ([203.11.71.1]:53183 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbeIKH4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 03:56:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 428V421yDWz9s7T;
        Tue, 11 Sep 2018 12:58:58 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536634738;
        bh=/sF7r7ZJYtHEJjA54D5ClHmzjuC28CJmXk/tdzPMbHg=;
        h=Date:From:To:Cc:Subject:From;
        b=ujSCQ2WLZ+1lXXZDfQK/knyVcln43ymoyZPwa6AU9diwx6Dh271rF85kNmY1FhPst
         x/oX14xXlOFoqfSpmlmdZ83O7ikAL0KcE/M/m+C18YoC55aQmkElssVoC5Mx2pesNw
         YdQDn5GU8/AsDRwswKaDXm/T24YdJP+x78gl/j0n5q8odq2OXJ5yWCqqUnLOGAI8pW
         9xvWal1SzLtBGXizFj0UTWmbS1+PNiJ3K6caHeR1t4DeXhCHdlhwaJYfV5SJcRrLzD
         +0196o9q6soFfpfUZnrlmGVluFiVvv3RZrJC/2UyEwMiKh/nBgtf9JrY7dIhWhVVU9
         Vq79oDur+mH/g==
Date:   Tue, 11 Sep 2018 12:58:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: linux-next: build failure after merge of the tty tree
Message-ID: <20180911125857.5e5c34f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/foV0iHJk4HzcDLCu3i1sJD="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/foV0iHJk4HzcDLCu3i1sJD=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

After merging the tty tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/mfd/at91-usart.c:51:34: error: array type has incomplete element ty=
pe 'struct of_device_id'
 static const struct of_device_id at91_usart_mode_of_match[] =3D {
                                  ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/mfd/at91-usart.c:52:4: error: field name not in record or union ini=
tializer
  { .compatible =3D "atmel,at91rm9200-usart" },
    ^
drivers/mfd/at91-usart.c:52:4: note: (near initialization for 'at91_usart_m=
ode_of_match')
drivers/mfd/at91-usart.c:53:4: error: field name not in record or union ini=
tializer
  { .compatible =3D "atmel,at91sam9260-usart" },
    ^
drivers/mfd/at91-usart.c:53:4: note: (near initialization for 'at91_usart_m=
ode_of_match')
drivers/mfd/at91-usart.c:51:34: warning: 'at91_usart_mode_of_match' defined=
 but not used [-Wunused-variable]
 static const struct of_device_id at91_usart_mode_of_match[] =3D {
                                  ^~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  7d3aa342cef7 ("mfd: at91-usart: Add MFD driver for USART")

Forgot to include <linux/mod_devicetable.h>?

I used the version of the tty tree from next-20180910 for today.



--=20
Cheers,
Stephen Rothwell

--Sig_/foV0iHJk4HzcDLCu3i1sJD=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluXL3EACgkQAVBC80lX
0Gy2YAgAgxXwbxfVK8DH4mWYZxJxwtGqwFh3ThCeR12IRkYr6NYT3IjfkpUimcS3
hYQ2tBG+FG2o4Q/i3UZUTOTdIKJqkT6d+PjrlpyrshRhfk6EU4J76mJ0CmYLcs1y
Yd6zPeRP+pPt6J788KmcQv/BfsQupMoB2OwvqbkZWWu7DUIDKCnwY81seRCCeze7
kiu+V5GPGf0bPDix003i8hsgM4XpDQbUjdQ5/t+vBxy5iZ4mPVKcW5MY8QTybetc
5q+Jl3nHoZ93Vf7xkLuLbULUgzinbdDvVE3m5aA2TsYCrZXGqsA3bmnlB8AcoohZ
3M7ZifxgenTYd6+fgE/6mkDtqTBOuw==
=zqln
-----END PGP SIGNATURE-----

--Sig_/foV0iHJk4HzcDLCu3i1sJD=--
