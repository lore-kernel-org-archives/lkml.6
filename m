Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3104BC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A48520878
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="moY8ReOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A48520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeKUKgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:36:44 -0500
Received: from ozlabs.org ([203.11.71.1]:34113 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbeKUKgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 05:36:44 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4302rL5M5jz9s9G;
        Wed, 21 Nov 2018 11:04:50 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542758692;
        bh=hFs8dtz4LxZ8J09pwxV9v9VGheb58zKqDk0Atnz1nAQ=;
        h=Date:From:To:Cc:Subject:From;
        b=moY8ReOppDU6bGcxSwXeXjyV8vkpjIjyzl8VKPmsfH9iL8WSy6cy7D8UIGA1M9cVW
         YZfwHmhrviUIL1CRLD3FjULQdeSK67E94A08ctozUdQJ4seT5wHxrEA8Df7m/I0YH/
         D2T7j1+q/pfKRNWQeo1owNmugCmo09HYDbH1U+ABFfZZUWFM/XqYV7cBWxZw3Mm2+e
         dPRXrUC8IT9WWkd9FhYcJRAO8HtIuu63KB04GroKGDh/jA6abuZIfAjap2WXbIbGjJ
         V5sZ3cQHQHV55mzy1eG4lD8QN/qRzBarlZ5UpCp9YaARMU8loBvYeDXp7i7yVFazR+
         KPP4AyxH2VzOw==
Date:   Wed, 21 Nov 2018 11:04:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: linux-next: manual merge of the mlx5-next tree with the rdma tree
Message-ID: <20181121110432.64a379f7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pyprHO/yPcGEeMMfy9gn7bV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pyprHO/yPcGEeMMfy9gn7bV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Leon,

Today's linux-next merge of the mlx5-next tree got a conflict in:

  drivers/infiniband/hw/mlx5/main.c

between commit:

  9afc97c29b03 ("mlx5: remove support for ib_get_vector_affinity")

from the rdma tree and commit:

  f2f3df550139 ("net/mlx5: EQ, Privatize eq_table and friends")

from the mlx5-next tree.

I fixed it up (the former removed some of the code modified by the latter)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/pyprHO/yPcGEeMMfy9gn7bV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv0oRAACgkQAVBC80lX
0GwuGgf9EYSEx4Fk+Bpntuv8KPmtiRVqrfLMZMtKiHEyYR+9VqOLEDE0HQI2/Av7
aY4s7dnf0QJdlKIg9V51Qfzj1q14CLwuHb8NRJ5QqTtuK3OzwgvbuC9O3qX06L+c
ji2gtsfQqMmtE0rFAsoo11pvSLoc23jc2JdtgjOeq8NHr1iVWy5CbpabOChqTO7G
4nBkpzM2dLDKISIssHGa1+n9si/+duG5z3KomdJWEBmEeEK8mnytLBoC8WDYvpXW
IJGLCy1WEFFffvoJdVAVMXxm9LoRxNdMVghdJooqHZCUzevIibkrxsNJ0gsKAOFz
AzmvGW41/v/SCQEh0weKLsGLY8nDBw==
=HQhg
-----END PGP SIGNATURE-----

--Sig_/pyprHO/yPcGEeMMfy9gn7bV--
