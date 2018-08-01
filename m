Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E954DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA2320894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Tld6o5S4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA2320894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbeHBBaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:30:18 -0400
Received: from ozlabs.org ([203.11.71.1]:49113 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbeHBBaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:30:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41gqbD2GgLz9s5K;
        Thu,  2 Aug 2018 09:42:00 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533166920;
        bh=1UpyzH367ocmZE4UffN6HgTuHahxQSBcILTEnPtu9PQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tld6o5S4Al2k077z4XTIfUL8tw9rEVJEdrxYU6X5o6lmYdB4+Yj2xpdf81VyMe4MA
         zwWoIL/GzKnaMDkt5gsO7RsU3Pq/88TW0BQqX/GWsQYLvorrfy1q/4sg3gVHDJp2GP
         ih3aQ+nzlEIsNl0ShYUk9EHkDJsuCYZHYcvVqo7gZBTFISdzeVQte7R7B2bKI2XHsj
         OoobLhezMQcYw0HIvupkXrLRULWLG+zhkyzD8E5UTNyiXLj2hvwEteEItXJT6i2jlm
         +k9iF6Nj7ABB8IjqqMjA7SQNsV1MhOTW2NG6L1yjB01l7JkLB4cqx4zWNKDo4U1A3L
         dwzMwCCZc4ecw==
Date:   Thu, 2 Aug 2018 09:41:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: Re: linux-next: manual merge of the powerpc tree with the m68k tree
Message-ID: <20180802094154.6d88f03c@canb.auug.org.au>
In-Reply-To: <20180802092708.10e1a71d@canb.auug.org.au>
References: <20180802092708.10e1a71d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ueoUXmnaVYBQFrUPw1y_OhP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ueoUXmnaVYBQFrUPw1y_OhP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[forgot the conflict resolution ...]

On Thu, 2 Aug 2018 09:27:20 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the powerpc tree got a conflict in:
>=20
>   arch/m68k/mac/misc.c
>=20
> between commit:
>=20
>   5b9bfb8ec467 ("m68k: mac: Use time64_t in RTC handling")
>=20
> from the m68k tree and commit:
>=20
>   ebd722275f9c ("macintosh/via-pmu: Replace via-pmu68k driver with via-pm=
u driver")
>=20
> from the powerpc tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/m68k/mac/misc.c
index 19e9d8eef1f2,28090a44fa09..3534aa6a4dc2
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@@ -90,11 -85,11 +90,11 @@@ static void cuda_write_pram(int offset
  }
  #endif /* CONFIG_ADB_CUDA */
 =20
- #ifdef CONFIG_ADB_PMU68K
+ #ifdef CONFIG_ADB_PMU
 -static long pmu_read_time(void)
 +static time64_t pmu_read_time(void)
  {
  	struct adb_request req;
 -	long time;
 +	time64_t time;
 =20
  	if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
  		return 0;

--Sig_/ueoUXmnaVYBQFrUPw1y_OhP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltiRUIACgkQAVBC80lX
0GwP5QgAjLqv9cJbv3AFS8UVchlz4SN09xP6c10N8MShtoFvWAQgAanD3vfMexCl
MzRRU9Ovm2n5IgW1kQik2ZiYmZQ8VaxEq+QNRiB0sPx5ibLm45coFHkRXftvyS7J
rJVm0BUwF+zCz/hhAIbe1w1CHfHW6HUbM636GeH8fdrkPF9pcsNb/5S3pUp7Xy26
Du43W6HCGUWmIBRKxF+BxVHmTe16HfMXmR9VRG0zR4rxUbZFToq4pf+vzEw7DkQM
UdWg70jWN205VnVUQNdoCiDtwBjD84JUIfSlkZqs2c4HI1ZqbNOnDS4XaVjO7xLt
RRgMPQQaiue5JeIcMhcecb2KxpwJlw==
=7H9a
-----END PGP SIGNATURE-----

--Sig_/ueoUXmnaVYBQFrUPw1y_OhP--
