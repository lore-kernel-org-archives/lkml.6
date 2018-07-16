Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6190CECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0272086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="t7Baourk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0272086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeGPGRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:17:51 -0400
Received: from ozlabs.org ([203.11.71.1]:48283 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbeGPGRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:17:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41TXc83Q6yz9s29;
        Mon, 16 Jul 2018 15:52:08 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531720328;
        bh=SoGxvLRU04CJ8kAFZeZljpu1rMMF5OSGjdOBG59c/OA=;
        h=Date:From:To:Cc:Subject:From;
        b=t7BaourkyHvk6wAX9pUOFSVTT675VfFo/SpmIQfGXGzv9L+8Mc7hPPMRqsKpD2wuC
         ZHp5GEItdk1v+AbnU+iThmB7cr7Ln2Hzk2jHtJ2RT5MV3Mb2O9DI2VZCcAQL2WEsmR
         BZJBf+2PTT9LZBKeicI+eUxCrjI70FWqixm5vVHhB7Qok+md19bwCF6SleEQFIEVnd
         C6JlYZL14Th9V3mjv1vY4IOCf5Gvw+mvBY011B3mbiHpQoqw1yT2ndz6+bQ6Zuk9q0
         8mXwhjZPgbHPp9tiSmpcbpRGzoepmLtAWipZ7ZeAf5F3YeAXEov92lhCiTRTFOI9hI
         JR3ayPUh2yI3Q==
Date:   Mon, 16 Jul 2018 15:52:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the random tree
Message-ID: <20180716155207.09fc752f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5PZ+fWbZrxkOjg9w2AfWn7B"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5PZ+fWbZrxkOjg9w2AfWn7B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ted,

After merging the random tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/char/random.c: In function 'write_pool.constprop':
drivers/char/random.c:1912:11: warning: 't' may be used uninitialized in th=
is function [-Wmaybe-uninitialized]
    buf[i] ^=3D t;
           ^~

Introduced by commit

  349ddb707fb7 ("random: mix rdrand with entropy sent in from userspace")

--=20
Cheers,
Stephen Rothwell

--Sig_/5PZ+fWbZrxkOjg9w2AfWn7B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltMMocACgkQAVBC80lX
0Gz9KggAmFSVNwv17rtO9QrZGAkRxn8m6Vb1GFqAHE4E/EAOh7iGHrJnab1/vHHL
ibfT+qpj0nj90ZuW4+NkBRLcIBFmybNu5gn0b97jQbetigZW+7KT6LUoyUMz5ylb
o8yrvHo9PW5/vJMrkp0AqmzsD/Hd+sEdEWV6+tPcC8WsqlzymafV80HBT2WtRsbV
8IAGp4+8BUl/LzEa5GsLQA60KNFmDZ6sIfKBSrtOdJqTMRFF0fckhdCZQw6tbl/m
BYfkga8IkaqV+dbrSD18pkxVn8TzScGpT+fA8RQHuEU2PTfi06zN51JRTEnxNHkY
7/dGWW7xWyOfMz1KJvUorw12M1KZsQ==
=96qE
-----END PGP SIGNATURE-----

--Sig_/5PZ+fWbZrxkOjg9w2AfWn7B--
