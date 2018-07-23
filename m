Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFDEC6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7613D2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SpWR9vaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7613D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbeGWDjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 23:39:42 -0400
Received: from ozlabs.org ([203.11.71.1]:45903 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387718AbeGWDjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 23:39:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Ym255ClJz9s2g;
        Mon, 23 Jul 2018 12:40:45 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532313646;
        bh=Vk+3/X6NYL/YWaq+vjlglxAYFcQIKABCtgnhhDCB25E=;
        h=Date:From:To:Cc:Subject:From;
        b=SpWR9vaDSpalBXsjgT5beWCtmWsDhODnp7SRJvERu5RfjLYb4TJZ5mYYdCEoMb28a
         kjp2/k5Ax5a0IRJF0UQL8QonoybXS3x5GUX/TszO36XCt0IcXuw82zZ2czfoaZuf4Q
         idZy5EJqCPwHzY5E39al1BGa+7pfY2VoFMmgegO9zPKUKBxx848EeQauFcZWvEyW4J
         jPFbDH3ribtkOAFZiquMk4rqGHHQQRvGy3K+oiFzKMxdhvRy6pNbhPypduNNOifGsk
         zQ1GjpuuJTx4gOFaZcPbjU4GBZrqg0kGQvnO+lYplI/db9Ojl0xf52v1DBffREnvrJ
         /e1ZjqhJVkAMQ==
Date:   Mon, 23 Jul 2018 12:40:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>, Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: linux-next: manual merge of the drm-msm tree with the drm tree
Message-ID: <20180723124045.4346df97@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HZpJu.gVwwxp2NbzE+ak6U+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HZpJu.gVwwxp2NbzE+ak6U+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Today's linux-next merge of the drm-msm tree got a conflict in:

  drivers/gpu/drm/msm/dsi/dsi_manager.c

between commit:

  97e14fbeb53f ("drm: drop _mode_ from remaining connector functions")

from the drm tree and commit:

  b6a221993e7c ("drm/msm/dsi: Use one connector for dual DSI mode")

from the drm-msm tree.

I fixed it up (the latter removed code modified by the former) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/HZpJu.gVwwxp2NbzE+ak6U+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltVQC0ACgkQAVBC80lX
0GysoAf/V7o/x8dLL3R6jz/dW1bqr8cF64YWI/S+GCSNxCkANNsYv1YHq9VElXWN
0OyugJBRtQBM3Fr6UFtCetZOqVaxhetd90YJE8wrIK9ydOW4mJyN9SaetGCNeM9u
6rLbZsDJ8jeH+9J2XSyOknTNcUcFOAN75KQc1AGdJfiJ3/JkIomn4ZumIhN5J6VL
5k+3NgeIVeX3BgCuF8lPOnYeu8/XV3SYD0M0RoGBHdj2Y/da4OUYIMdZkz36pL2V
Wh4d6hziMhTTi+keDyizDvEaB5OKGzEFx8LJU3jvH/4LBuUXdeqmf4LGKKVo+etT
J8lkCj1OQu6pR4/3NhzcbsQrkErj8A==
=c25I
-----END PGP SIGNATURE-----

--Sig_/HZpJu.gVwwxp2NbzE+ak6U+--
