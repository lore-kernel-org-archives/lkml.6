Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A57C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEA82082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fKmS+1qY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEA82082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeJ2Kr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 06:47:59 -0400
Received: from ozlabs.org ([203.11.71.1]:40901 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbeJ2Kr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 06:47:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42jyWT1Z4mz9s3q;
        Mon, 29 Oct 2018 13:01:24 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540778487;
        bh=6uCnyjjOCP0DWh0EmolmNwohYDkvC3E4VHKdS1Nv7vc=;
        h=Date:From:To:Cc:Subject:From;
        b=fKmS+1qYOjR94fRe/spe0XyRgH76/5IAf7kTafPXr+4efMbHmxEq+my1xmoa+BIZS
         HUb/VyWTaef7TNkGYoNj4omJcl8NzsxOZEajZqnJyn0m9B8hfkwKKgUGN5A/reiVnq
         i+y6C8qMmOjQVeucu0SrlIrOcw/EZCidGrdZ3VrysYwAcEXk140kXTw8PbH856sLlM
         wEVZ4j+VJgzCjn1PgNDYc2DpM639HNQk/WCf8HZIeywjcWnW0X9IzhzcSRdVd0Ye9z
         W2xJSW79ke4wLpWFw7ds1g5Yx6T2XVzpNqOTYltJcu6/+CwzSx+IG2TBM3nrcbAj+M
         Xggcs7Shl6v8g==
Date:   Mon, 29 Oct 2018 13:01:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: linux-next: manual merge of the pm tree with Linus' tree
Message-ID: <20181029130124.290346e9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/X_/swfdki+BZTJ8afk_lQqW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X_/swfdki+BZTJ8afk_lQqW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

Today's linux-next merge of the pm tree got a conflict in:

  drivers/cpuidle/governors/menu.c

between commit:

  8508cf3ffad4 ("sched: loadavg: consolidate LOAD_INT, LOAD_FRAC, CALC_LOAD=
")

from Linus' tree and commit:

  a7fe5190c03f ("cpuidle: menu: Remove get_loadavg() from the performance m=
ultiplier")

from the pm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/cpuidle/governors/menu.c
index 71979605246e,76df4f947f07..000000000000
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@@ -130,11 -130,10 +130,6 @@@ struct menu_device=20
  	int		interval_ptr;
  };
 =20
- static inline int get_loadavg(unsigned long load)
- {
- 	return LOAD_INT(load) * 10 + LOAD_FRAC(load) / 10;
- }
 -
 -#define LOAD_INT(x) ((x) >> FSHIFT)
 -#define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
--
  static inline int which_bucket(unsigned int duration, unsigned long nr_io=
waiters)
  {
  	int bucket =3D 0;

--Sig_/X_/swfdki+BZTJ8afk_lQqW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvWafQACgkQAVBC80lX
0Gz/ygf9F78MzY9YDkx3+GE4g9YtmmyWE+ngodELWEa9NqzFSdczjjuBdXWw7jXV
93YDuYQF6jljE+p/dSnyfL+V5NQ77TQBDXscUp76iaFqqBAaCnpEX+amZH8WN85C
LtT43ieMnpS9UL/kQOCnvW8/BGFEaD4/fNSjmEkyDyZ7c9Qake6ZiV4Ig7lqnHPJ
tDWEu13AGEg/I4Oi3Rp4AzgVG+0D8pt+DYKk1XLbqQ+qGXlg/yYm4oGDpxmKZFcr
StBRamwapag9OCBlt6Ml7hWT2Hf3auDOmG1cRg6jTQJj9+nMb4jqpfhjfD/vXgHf
JkzWmCw+k1I8WKp8ryrJOKMWRYgGgg==
=MBnX
-----END PGP SIGNATURE-----

--Sig_/X_/swfdki+BZTJ8afk_lQqW--
