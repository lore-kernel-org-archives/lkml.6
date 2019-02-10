Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B1AC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF961213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="utgU3lva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfBJUYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:24:49 -0500
Received: from ozlabs.org ([203.11.71.1]:54493 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfBJUYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:24:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43yL4Y4PKZz9sBZ;
        Mon, 11 Feb 2019 07:24:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549830287;
        bh=pUn343piUDzEpjT2ya6R4v8Tg/CCCIX338MU4PckrWU=;
        h=Date:From:To:Cc:Subject:From;
        b=utgU3lvabmrLVW6qmEsl7gXQHdu7y3iwgy/ah1JOBMRuCNmYIbKmjSqOXt9EOPZDh
         UHuea+2rFCNjsKAm+ge8hW5muU+gO6jTnk1fyTfCfLJ3DFp/Zgn1JnjmTwB71dWwI4
         6kucjuws7/6xFjrQq85d2MHouNkoTN1XJ8GRLT48cDDGyonHD+SSwBdiAehiXH4bDl
         Ln/T33U5zXIo6Y7eZEvH3X7a0n5ERZT4mOismvebWbGrBdQVdwtqHj2FtMP0SL9vml
         0vwp1U44AgjqdoILqb/Jyhg8pg67EVMpwGVFU9dYYVCeE2mOzdcg+ZxJbUlN+Wt5MG
         eEW6XVVsvzkuQ==
Date:   Mon, 11 Feb 2019 07:24:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal =?UTF-8?B?Vm9rw6E=?= =?UTF-8?B?xI0=?= 
        <michal.vokac@ysoft.com>
Subject: linux-next: Fixes tag needs some work in the fbdev tree
Message-ID: <20190211072443.1cbedb29@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0jbvx2uDb=JZ6mlzAEZVh6q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0jbvx2uDb=JZ6mlzAEZVh6q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bartlomiej,

In commit

  7d7e58d30e04 ("dt-bindings: display: ssd1307fb: Remove reset-active-low f=
rom examples")

Fixes tag

  Fixes: 519b4db ("fbdev: ssd1307fb: Remove reset-active-low from the DT bi=
nding document")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/0jbvx2uDb=JZ6mlzAEZVh6q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxgiIsACgkQAVBC80lX
0Gx8Owf/ef1b6SjQ6j0R8Pi+vN3kshSml97kMXbIWa4NNhcS1+7NuQ5kbNfFEl9O
rR2nQWdUTsmgcm2b0E0CrySJvv4rmBdC7oNkz7BcuYs78GxXjhgpyrzBU0W3iADH
vbDO3Lxn62d7ZMS7+Hb8S+WBWHB+Ei/yA7c3HLOZA7rRyUdFQoekuvbi9wKnmY3w
NtLgIUokp61sCafaKpfXmld3R7jhHtvzlWXWrhHn1HZEuqredwp26AlX4Cqz5bgZ
QCVK5ph7nrP/rN3KChV4dKKIl3VLOB93+T1M8qlvm8QP+9HX63P2iElEKBf43za6
F3JikrgLYUemqNsNImPnthcbcXDSdQ==
=d/FZ
-----END PGP SIGNATURE-----

--Sig_/0jbvx2uDb=JZ6mlzAEZVh6q--
