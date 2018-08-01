Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC493C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5AF20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cR57ACM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5AF20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbeHBBPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:15:42 -0400
Received: from ozlabs.org ([203.11.71.1]:43609 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729616AbeHBBPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:15:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41gqGR5TTWz9rxx;
        Thu,  2 Aug 2018 09:27:27 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533166047;
        bh=pUjpedKNr8hGTJQrYFwm1UTQlZCpvuytOaiJGvplw/o=;
        h=Date:From:To:Cc:Subject:From;
        b=cR57ACM02LMLdVW1fZydRO1uUgdGNPo+CeU9TnVYhqCrhovQD/YCxOFsPu8LcqNUB
         cCRSUHGL+JL45/CLvHUiOQxrXdx/DpmIK5UleCvseb44rAuhyUoS9qiswzonn4SJ1C
         Y4kMwRRgCs6+HXcPLOcT8Jwdp4TsyQ6tODAJKQ50ex5lE0XLqc+wEbVRFMSRWlAkca
         /8ruB6zc8fDxHZfpl+O8qmFRcIU5hq4OWIfhcGH51dkzguHQ43k0r2U9zmnM2tXcfD
         oj1J8q/p7++Ic4i6TnmzZE2BhvFFy+XZHQbFBnuBJ577p/cINGiSXqwYn23mOVmwyy
         TJMI6yZgjwLEA==
Date:   Thu, 2 Aug 2018 09:27:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: linux-next: manual merge of the powerpc tree with the m68k tree
Message-ID: <20180802092708.10e1a71d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EC1hrN=C=vY6p+aOKx0Fx8S"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EC1hrN=C=vY6p+aOKx0Fx8S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  arch/m68k/mac/misc.c

between commit:

  5b9bfb8ec467 ("m68k: mac: Use time64_t in RTC handling")

from the m68k tree and commit:

  ebd722275f9c ("macintosh/via-pmu: Replace via-pmu68k driver with via-pmu =
driver")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/EC1hrN=C=vY6p+aOKx0Fx8S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltiQdgACgkQAVBC80lX
0GyAswgAigCIeYhR/Or4bRfmuchCPWtOPZTnVo2tMHxqchkY432i2UhwBgtU07B1
gwcS04uA2N9eSxdC3hUjrwIO8lpmVcN7K78plR+gXAAiDdDVu3x6N3JvUP67f7oK
YBp9PjhQt4fxAJFvq7bGTK8OrU6UBhOekIXHB1gizaxlX0KuL9ruqWtY6Z3WKnix
/ovssha1WwahddfE6E5/3LLWL+gFgMWAOlOYoQjkkxRGxn3F7CTuWV46HJR1slu1
wyTYGKk5zX7AD3bliDwJWjEN37YbO5VonG+kz5Pp4Kopfq7p3I7nDStm5l84hceZ
LN+47YmDKXWuNUtW0PXDemjp9sP5dg==
=kELf
-----END PGP SIGNATURE-----

--Sig_/EC1hrN=C=vY6p+aOKx0Fx8S--
