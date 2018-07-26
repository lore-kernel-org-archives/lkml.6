Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6EDC67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AE020852
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LfIQyISS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AE020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeGZDeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:34:15 -0400
Received: from ozlabs.org ([203.11.71.1]:39759 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728485AbeGZDeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:34:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41bbQQ49gdz9ryl;
        Thu, 26 Jul 2018 12:19:42 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532571582;
        bh=VEOFZIgbVQ6WIAtURJKeCguBpaA5+UqhLKUpkigr6JA=;
        h=Date:From:To:Cc:Subject:From;
        b=LfIQyISSHWstr5CeZRgmcSWwMS+nyldg/esznSyHPo4Hruqemy3O7pTADNiXgZE8+
         WmH6ZX7f7NcHl84hQZF4RKftlrpevTkdtPp+F2kXoaiargk0qtXWUU3+i2RMCH+/0Y
         K4ayRkUVJ3Hty0J3E9IXPK29AmgP1umgWya+eJgF7kPXgsTZcLhnVs/vfSZBjuzQZZ
         JD4/vj2keeSyRAa6mMpUfNdImAq5i1jzFeQyuTzjtGL8Il5iYGiTL4Q9xtryy+f3M7
         ul1mKIemjbzZgfVVBTVvpl4oqg8urCQJbrVG99PkCYtDpW74n6ZVDLo0+c4S/9rQNk
         /dRBhrAt+5Qaw==
Date:   Thu, 26 Jul 2018 12:19:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>
Subject: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20180726121942.0ab69aac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YjM7=yOaxRk=SNBTV.oS5t0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YjM7=yOaxRk=SNBTV.oS5t0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

sound/soc/amd/acp-da7219-max98357a.c: In function 'cz_probe':
sound/soc/amd/acp-da7219-max98357a.c:367:3: warning: 'ret' may be used unin=
itialized in this function [-Wmaybe-uninitialized]
   dev_err(&pdev->dev, "Failed to register regulator: %d\n",
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ret);
    ~~~~

Introduced by commit

  7b5317aa809f ("ASoC: AMD: Add a fix voltage regulator for DA7219 and ADAU=
7002")

This is a real bug.

--=20
Cheers,
Stephen Rothwell

--Sig_/YjM7=yOaxRk=SNBTV.oS5t0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltZL74ACgkQAVBC80lX
0Gx0Ygf+LvO5hWnIFXRM3Hb7izDlFAhQpjr8fHlPAkmHrTtm2QHAGHvdZ8fyMDsC
XKxGXlxbMFD+deMzL5uyfw0n+MyBd3C3KeAXHsqdZhyN+bBSSuG9VgO8ICOVsGOU
YqD02KZrTHWzZPCTWO/8el7dpeipkpXVyg4CLjFALWyRA8UaEtymIuZzA/MLGvzM
xwE8tLVVPCcpR5dRxnu82fDBGCYAQEWnBUM5HeXJQPk+A1BuIRjCOjURhxbhTOF7
Oa1Onvg8zDiUp9ny2wWr458lBPqIpyRN/7qk5QaaTrftoupuyqJEYAlINZ0ugOvn
A8u+7Fx/JjeI+WYswHOI8PIZ5rKBNg==
=yefy
-----END PGP SIGNATURE-----

--Sig_/YjM7=yOaxRk=SNBTV.oS5t0--
