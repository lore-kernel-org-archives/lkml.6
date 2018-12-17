Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4CEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 00:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230D52086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 00:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cdxi8MBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbeLQAIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 19:08:15 -0500
Received: from ozlabs.org ([203.11.71.1]:41785 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730719AbeLQAIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 19:08:15 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43J1hC3PW2z9sD4;
        Mon, 17 Dec 2018 11:08:11 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545005292;
        bh=tmi8sJ4TPoSn4DaxF2sjIHWhesK5yRK5jBTyjhsaEBE=;
        h=Date:From:To:Cc:Subject:From;
        b=cdxi8MBvAj6tx5F625b5543arftJZK6uG1DMc//GYgcB20jPyvKWN5iO5S3kVu405
         /7Pm2yXGdpy2EqhW0D7qBt6DaNjhn3nVqgddX2JgR8VjwD6rHaVZ0rzPKbYrlCcjmD
         4jViFcIcdEWEKTpw2M2DZnbE1JfeWzSxkMXPrgBy17A8OFAGlvBWf7bPDl2FIWSUU3
         Uc4o7YRxOuv6E/npfyfZzcaFyQLbAx+oHWzZsmpWf1qewoxCKpR2kFPIqzB/Mh5spY
         8iovLOFdWk0AaHyqRE+ZaFkGcigRgHTaslDjWNsSMiiQ+Ju1XcvYI+r/Vhn3anGHfa
         jtRdWfM1ipMpQ==
Date:   Mon, 17 Dec 2018 11:08:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vu Pham <vu@mellanox.com>, Gal Pressman <pressmangal@gmail.com>
Subject: linux-next: manual merge of the rdma tree with the net tree
Message-ID: <20181217110810.64c69fb7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1zq4QKW_k7lZNhobxfgsABJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1zq4QKW_k7lZNhobxfgsABJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rdma tree got a conflict in:

  include/linux/mlx5/mlx5_ifc.h

between commit:

  663f146f2ecf ("net/mlx5: E-Switch, Fix fdb cap bits swap")

from the net tree and commit:

  c74d90c11c05 ("net/mlx5: Fix offsets of ifc reserved fields")

from the rdma tree.

I fixed it up (I just used the net tree version) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/1zq4QKW_k7lZNhobxfgsABJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwW6OoACgkQAVBC80lX
0Gw/swf/d/04P60KdIOunQvtylL1V3DmxsWUxaiQ2U75eV+9LwDVZROrDgCxT9Hz
KwjN1Nb2G8unM9s7lExVolkr/mrgWcalYo5QaDxpACEv15G1rDCwg9wUgQ8UPwWG
Wp/MVTsT8DyGGOd5x8JjmbXANC731SGA3EjzgVhOfTvKgXc6FaBpAKgNcwB6i29f
HVFM7be/JAu0oxRA/2leOZe2lChxdREoHlPE/ek8Q0ylYB+LCT6vI72PESnGnBtY
kdi6hErmOE8FHik2XN9CHjZmi/DKsY7pdxoYhEJSRJ0YfrvuAadY6ZutrnTb/8W2
1JZUba2gLH109jqOfmo+M1cBPGizUQ==
=1cch
-----END PGP SIGNATURE-----

--Sig_/1zq4QKW_k7lZNhobxfgsABJ--
