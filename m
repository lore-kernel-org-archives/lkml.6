Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644B8C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350B221924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Gf+VhSs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfBHHdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 02:33:44 -0500
Received: from ozlabs.org ([203.11.71.1]:42107 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfBHHdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 02:33:44 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wn3n0pqMz9sLw;
        Fri,  8 Feb 2019 18:33:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549611221;
        bh=dJw8QvCG+hjAVGedbgsVA0Wf9FW34xRnIv295tt0hto=;
        h=Date:From:To:Cc:Subject:From;
        b=Gf+VhSs9gj/5sYhR9gKWlJbH8eQFz1/meJUWNcudiDQWgIrd2ChEhrSextitmNuv1
         /B7+cp7rlfrfn8fihfPtT2hWXTZYgtwwGOV6TwTiWt9YCeMvyazVjbRFWN6WXl6y9X
         8Pdv0DceE9yQ9UmdLy+uOw+Hfi5kx1CtUNQBTSjSqJVJZrruGm2V1MomwfE+IYQPYK
         S2oXGJwVY3UKgjHs85aON/R+3uJyGXYSVDDSkTreOkE9Edyb3+guu7p4XhSB8wBTcG
         7shUljLRQOGH1u5p/btlwHynlccR+Gx1kHS3OHOfSEzCf0K9Wj8qF/3+BBpfhHqApi
         81xld1nNsUGWw==
Date:   Fri, 8 Feb 2019 18:33:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Coulson <chris.coulson@canonical.com>
Subject: linux-next: build failure after merge of the apparmor tree
Message-ID: <20190208183332.47dc655a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uS4PLsnuHLrdg_ZH0=xgX/4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uS4PLsnuHLrdg_ZH0=xgX/4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the apparmor tree, today's linux-next build (powerpc
allyesconfig) failed like this:

security/apparmor/policy_unpack.c: In function 'deflate_compress':
security/apparmor/policy_unpack.c:1064:4: error: implicit declaration of fu=
nction 'vfree'; did you mean 'kfree'? [-Werror=3Dimplicit-function-declarat=
ion]
    vfree(stgbuf);
    ^~~~~
    kfree

Caused by commit

  876dd866c084 ("apparmor: Initial implementation of raw policy blob compre=
ssion")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/uS4PLsnuHLrdg_ZH0=xgX/4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxdMMwACgkQAVBC80lX
0Gwzjwf/ZCSuAYz/zQuV2+5MzeQ2oW0vmlnjdR3sRRRm9e+HoGeD3//cFeKWsNPL
JWus6w8GoJ+SifTg5Pplgc0uhHHPuNcTCEO0dxvRwf4jSWw46VSEv92BST2q9BV6
BnfxXx0x5NIDGIVspOiLtbwQ+hn/7P7jF+F0nmGSnwxxHJEfaDIWCruOYGGrrSso
NhsUCxpMMJQUSS27YSzmHMzR07ypgQRqTDyRV6h/vQJb5m1+3J5mGLE9EdPuerMe
FZYR5FKugUcnvrLySbnZuxCrJfb1Re53sew5dESyrPcveiUgBq9a1OK7uz5AQcfi
5QLxH6WAbBBi8fG7LGARuFBOsEQiUA==
=efXZ
-----END PGP SIGNATURE-----

--Sig_/uS4PLsnuHLrdg_ZH0=xgX/4--
