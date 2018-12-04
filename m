Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80093C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE1C214DE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bFmQb4Jw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE1C214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeLDArn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:47:43 -0500
Received: from ozlabs.org ([203.11.71.1]:49989 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeLDArm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:47:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43839l5wBjz9s9h;
        Tue,  4 Dec 2018 11:47:39 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543884459;
        bh=UQ4WRufUzZ+0V6Q4DunWt0RB3iWmH5wTcRL/bEJE6BA=;
        h=Date:From:To:Cc:Subject:From;
        b=bFmQb4JwsM6Vcw6NuGzQThOARif9SR86WWYAZhRPifZHapdmXU0GG7H37x6zENDAy
         Ee4riHDg/zeE21K4cjAOJyckmjuJxligPn+zrc3ztHRhWwWkTdGIBludAQIpzRZdol
         WtaiG8Q5Ay5MQp9Mz46vCSxRwjqXRsxNldrMUpgSX4uWEPfSKaFM46ESRkRH6ZaoeG
         oBpLzFWruLIGsHSsrhysyMHZplU6649fIeUVdiWOYIPok1REg1+n/oKg6TYekYPkbM
         Qm+7jhvavlUoStogTv1wUG2StbJI6VNY13jI6ofFJu7FRzL5p9ZR7jeD8PY4QuLKb7
         EIRO2RkCe64Hw==
Date:   Tue, 4 Dec 2018 11:47:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: linux-next: build failure after merge of the rdma tree
Message-ID: <20181204114731.48b18bfc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xT9q_Q6rWNleqRZwtBWTjr5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xT9q_Q6rWNleqRZwtBWTjr5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rdma tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: "mlx5_get_send_wqe" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefine=
d!

Caused by commit

  34f4c9554d8b ("IB/mlx5: Use fragmented QP's buffer for in-kernel users")

mlx5_get_send_wqe() is still used in drivers/infiniband/hw/mlx5/cq.c
and declared in drivers/infiniband/hw/mlx5/mlx5_ib.h ...

I have used the version of the rdma tree from next-20181203 for today.



--=20
Cheers,
Stephen Rothwell

--Sig_/xT9q_Q6rWNleqRZwtBWTjr5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwFzqMACgkQAVBC80lX
0Gx1hQf9HxgOjGsua2OpeJXMq7Ksh2/X+0k8wmmpTwilR8xwTB3cPEJrD38oeIwW
V71K2jiHKOj5manN+S7SJbqJuOyP0pXMg3MzNlrBa69TElsV2cmvJCJrHBpEsZN7
P3HJgiC5ql+vhQ5w9TpzkjwdMo1DG4Qgo7ctMF3wnioCFz3CpGdTo83qDkG2JtUZ
lHReeLBlsMPXDh5mrrHMwaBOylMJbc1zvORK5yTQz+9jxZi701MQNOXSZaGbTxdD
c/1fVGIgis41TO8SC/f1WyPG3VGilGK2GIjS/I0OGDeOSX/xBr4SPsHYCftWkVSN
aPCfUPnt5TJcK6RwlSbIm2HbBIpRAg==
=TjaF
-----END PGP SIGNATURE-----

--Sig_/xT9q_Q6rWNleqRZwtBWTjr5--
