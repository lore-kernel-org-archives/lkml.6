Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2713CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7622083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Lgik+Nmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbfBYVWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:22:21 -0500
Received: from ozlabs.org ([203.11.71.1]:42995 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730326AbfBYVWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:14 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 447Zds1mz2z9sNH;
        Tue, 26 Feb 2019 08:22:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551129730;
        bh=6imDoW5th8HumlYvT9GL8w+Rb/KWrriLjVEaQtaEZEA=;
        h=Date:From:To:Cc:Subject:From;
        b=Lgik+NmcaYnte3oOTM6aBm5nUx4wQDfgHla1hkoRId3UssB/ZsoWLgUYWJ+bRPktS
         uIYkh2/l0QF1z4QIffMY5kYoUSidDk6lCY0HPPJQhValoi2glaXFb8nNML2TtOZKB6
         VmXIEo16XdMHwAJEL5AoGq9RZSA8osxrvymw60NeXqHqipc9hvhI9ZBp6yOWAI2Rxr
         uFDH6HtEEgZrYD8T0FTwbvaaGbjP3S3lZjXw4RsNBZfiHuizlyVJu9bNwjdjG3XZQt
         0DXmPAUIW2MZ9jesNi/hM06bsgqf3eeyPYv8wEu0quxRCipn8cv9eRHF0m4PRUhwxk
         NIekXHmxYCZZQ==
Date:   Tue, 26 Feb 2019 08:22:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takeshi Saito <takeshi.saito.xv@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: linux-next: build failure after merge of the mmc-fixes tree
Message-ID: <20190226082200.4f7aa469@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HsmC5+H8BGJg6XR3Y=16OJp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HsmC5+H8BGJg6XR3Y=16OJp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

After merging the mmc-fixes tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/mmc/host/tmio_mmc_core.c: In function 'tmio_mmc_start_data':
drivers/mmc/host/tmio_mmc_core.c:706:34: error: 'SZ_64K' undeclared (first =
use in this function); did you mean 'EM_68K'?
  if (host->mmc->max_blk_count >=3D SZ_64K)
                                  ^~~~~~
                                  EM_68K
drivers/mmc/host/tmio_mmc_core.c:706:34: note: each undeclared identifier i=
s reported only once for each function it appears in

Caused by commit

  063f8fee9927 ("mmc: tmio: fix access width of Block Count Register")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/HsmC5+H8BGJg6XR3Y=16OJp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx0XHgACgkQAVBC80lX
0Gy7OAf/cT6Hlz+ghJ1ym3d25eF+1tCidaPkMIzPTfdZs7B+jKiILoehFNQqPvqc
7rjFL5a/7vZd5JDeH9kXADKRBRUKFTOMGeNtleIfZO5hewkfRYDDtLU4r77A9NtS
RATn3uo1JwfHUUsi2YC2dNvzc8UiNKlsKLSNSnUmA9heVHmkl0xqvIdekd15JEKI
mpKqkRg2aITc+5SleFqzTguifd+mJARhqt5m9X4GgWHbQqa5jpI8yQgw8VnJGrCN
G7J0DMpvUzWYXmji8lCDn848t74uqvT7y+MAFdNN4QyN/SGKcqzZREN2zghbOyAV
X5JwnHUJqqW8Y12KkgMWjPTx3FZvBQ==
=8Idg
-----END PGP SIGNATURE-----

--Sig_/HsmC5+H8BGJg6XR3Y=16OJp--
