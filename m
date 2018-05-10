Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935651AbeEJAmT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 20:42:19 -0400
Received: from ozlabs.org ([203.11.71.1]:47809 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934395AbeEJAmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 20:42:17 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 10 May 2018 10:42:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: linux-next: build warning after merge of the nfsd tree
Message-ID: <20180510104213.31c41377@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EI2vkTHmtZh4SCfG5nYd4vQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EI2vkTHmtZh4SCfG5nYd4vQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nfsd tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

net/sunrpc/xprtrdma/svc_rdma_transport.c: In function 'rdma_listen_handler':
net/sunrpc/xprtrdma/svc_rdma_transport.c:299:23: warning: unused variable '=
rdma' [-Wunused-variable]
  struct svcxprt_rdma *rdma =3D cma_id->context;
                       ^~~~

Introduced by commit

  d1ab72afe681 ("svcrdma: Trace key RDMA API events")

--=20
Cheers,
Stephen Rothwell

--Sig_/EI2vkTHmtZh4SCfG5nYd4vQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrzlWUACgkQAVBC80lX
0GwZiQf9HhEUdw0ZKG5710DeXUv4T3J5J7Jzo39XyWEnvxf8ydlcpjUS500nY4fj
Nb+JEmu1Rz0nDZqcN+21exEeGONHfnToHPlIA/IsQF7NLE9ubfxmDJEQTXHwxqhN
/w0vQm6Na/Un8/Nh/u74vnUvN5BYUTdn05KokfILo0rme5hDxGJ0ZQGCaCR1CdVu
HzqQSb3RGt7ODi/DnZCyGmDk6zlwcLkoegex5MfLz3DswKOrrdoaFxoxqhmAwLC/
18Y4C2ag4w0nAyHhXN66Uk0+9TzcuG8B3yBBy9JkiCQqPkI4UNgs8pCIBiFnajyw
OjiyjyGb/OPehO0kRwR45tqzCH6nbQ==
=qebK
-----END PGP SIGNATURE-----

--Sig_/EI2vkTHmtZh4SCfG5nYd4vQ--
