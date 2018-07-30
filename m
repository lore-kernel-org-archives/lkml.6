Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65549C46462
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 02:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E75C20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 02:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZprvXcPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E75C20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbeG3DeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 23:34:05 -0400
Received: from ozlabs.org ([203.11.71.1]:56483 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbeG3DeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 23:34:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41f2qS3dKgz9s0R;
        Mon, 30 Jul 2018 12:01:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532916085;
        bh=y0uKyK0oOxrxivM/yToP+kT6MjzYHr0Xmed2pY+zYfI=;
        h=Date:From:To:Cc:Subject:From;
        b=ZprvXcPzVabl9bNXsaidCSfTuE6CB4nt7nDuF3ZMf0iOZA07+ZiuVHeowhWq7Y9pc
         bIP9aIMd6y9T5ubBTX0XjhuT1mVeanDVmQzsdPVVg7XqEKCDt3+N8sZ4ftw4deXFZg
         nZaEx6XFbIGDXujIu3+c3HsZb4x4PP437TBDkWYtifagAXrkccwPtmuPNG/aEV+s5v
         vX4cLmQ8FfVtVacU0Rnpo3cC5Mx8IkufrdbIn9zEDuuOYY+0T7lmIyfCCk4KLaxUFk
         hMMJkjPehFJpqKyOqEZD93pZ8OMK9iCqI3ntdWGCnqm7H71sBVA+H7qlh+6g8XjOSP
         FvGred2zLjuEA==
Date:   Mon, 30 Jul 2018 12:00:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: linux-next: build warning after merge of the pm tree
Message-ID: <20180730120053.62732d27@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4GX83W.4ulaCHnjPxIlqjoD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4GX83W.4ulaCHnjPxIlqjoD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

drivers/media/i2c/mt9v111.c: In function 'mt9v111_set_format':
drivers/media/i2c/mt9v111.c:887:15: warning: 'idx' may be used uninitialize=
d in this function [-Wmaybe-uninitialized]
  unsigned int idx;
               ^~~

Introduced by commit

  aab7ed1c3927 ("media: i2c: Add driver for Aptina MT9V111")

Looks like a false positive, but not something that gcc can easily see.

--=20
Cheers,
Stephen Rothwell

--Sig_/4GX83W.4ulaCHnjPxIlqjoD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltecVUACgkQAVBC80lX
0GyGmAf/YnA1cpHCSACdOVYt/o32oVQBzSJIqlfdKBZ8+JUQ7OIpj/WbVZI/Mw4h
/Ek+RhkDH3aftLdL6xf3ou1xa+1VNR0G0x0gQc0B40hINfk0JxqeWB1zFRjqMXFv
z4k7W4GvaIFqV/83lemiihdO2UYcqFeoAffHUuT6Zt8njQ/Fn1OgSyu7XPiMPeSc
zYsiWLqb0YPUomV1A1ke7DVSkmBYBQ2oqs+72iVeqeAnlAd/pHM5th9Zp7qxQwgv
MbdnJg7M2rQ1p+AU/c8AY1tJ/WvCmX6LcT+fJZ6wwSLAhxbPxJIEZr22pYLcnDl4
ywyFTrHO+pSd19fBv6kQT8jZvxB9ZQ==
=/yfL
-----END PGP SIGNATURE-----

--Sig_/4GX83W.4ulaCHnjPxIlqjoD--
