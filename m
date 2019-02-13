Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFABEC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C009C222C7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LMdFF7Jm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733090AbfBMBbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 20:31:36 -0500
Received: from ozlabs.org ([203.11.71.1]:34417 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbfBMBbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 20:31:36 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43zhnc2CJ6z9s4Z;
        Wed, 13 Feb 2019 12:31:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550021493;
        bh=IxIsfIlEWyVU10hLIyp0UZGr0KrvgH4Koj3iz9EWs/M=;
        h=Date:From:To:Cc:Subject:From;
        b=LMdFF7JmjhFIkp+TJbG2CI+3bXySjLBuCsjfv+QMP4g43Mo6Bic3sd/t7Yoem6o3O
         IJcIPUL31xySU9FS/wWQHuXAK0a7mwJMvOGEnJnjVtU+Jg4XXSubSiVakYyeQdiy1K
         kyXtRRZS2GOynypENRsiJXokunkEBX+A+ocHIugkvePKF/1VbrgOToFud1S0rLm/R3
         D8m+9Itz+uwCKuGdGwMmRKiiEPp3VpNTJri8MLIMIr7nO2obP/2pufaAClWZyHsEDN
         8cAIUrMkk9anLi2zevxupLmf80gN1wyciWIedu6a3xjnSaR976AVd73fYwaju4788p
         ECRUsxrHZNLAQ==
Date:   Wed, 13 Feb 2019 12:31:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20190213123129.2961c236@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SES/Uk8Zq=n8IQY6xaCHmr6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SES/Uk8Zq=n8IQY6xaCHmr6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

sound/soc/samsung/i2s.c: In function 'samsung_i2s_remove':
sound/soc/samsung/i2s.c:1469:27: warning: unused variable 'priv' [-Wunused-=
variable]
  struct samsung_i2s_priv *priv =3D dev_get_drvdata(&pdev->dev);
                           ^~~~

Introduced by commit

  a404b72d2bdd ("ASoC: samsung: i2s: Convert to single component with multi=
ple DAIs")

--=20
Cheers,
Stephen Rothwell

--Sig_/SES/Uk8Zq=n8IQY6xaCHmr6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxjc3EACgkQAVBC80lX
0GxTDwf/S2h2/y6jfYGlw1Xos8AxugZtWyWGhOFelbPkIXovmRuwRbr8xdHMQq7/
QHIsHjhMkgL/faf7DvXa1tm5nBaCkulm9nt61Wev2/pXb86tvdb0sLbYSXy8RTcB
+pKlRTIVmk4cN4zg02kELUHjHV4CrJZQWJacOZB2LTBm+UCgU+P6ejy8D0UrM/ck
+R1QTTn9QAHuCc+8PQYFsimKS7pl6jYknzkTKHr96/wTAGv9JjvhYBodq0QkdcGP
0Cw4GgNiKsUGLY1sR238WuIH70Osi09SydhpL6I/miWgQXzVXQihstc5NPY5j6kN
ruOTLbaCD8eePWg2hRUE7zs/blhC7A==
=Sbqi
-----END PGP SIGNATURE-----

--Sig_/SES/Uk8Zq=n8IQY6xaCHmr6--
