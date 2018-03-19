Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755166AbeCSBFO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 21:05:14 -0400
Received: from ozlabs.org ([103.22.144.67]:46925 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754258AbeCSBFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 21:05:10 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 19 Mar 2018 12:04:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Harsh Jain <harsh@chelsio.com>
Subject: linux-next: build warning after merge of the crypto tree
Message-ID: <20180319120433.24cc4be1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rvvOt6xsja+.U4n9.FFTr/X"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rvvOt6xsja+.U4n9.FFTr/X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

After merging the crypto tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

In file included from drivers/crypto/chelsio/chcr_ipsec.c:66:0:
drivers/crypto/chelsio/chcr_crypto.h:343:12: warning: 'chcr_ahash_continue'=
 declared 'static' but never defined [-Wunused-function]
 static int chcr_ahash_continue(struct ahash_request *req);
            ^~~~~~~~~~~~~~~~~~~

Introduced by commit

  5110e65536f3 ("crypto: chelsio -Split Hash requests for large scatter gat=
her list")

--=20
Cheers,
Stephen Rothwell

--Sig_/rvvOt6xsja+.U4n9.FFTr/X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqvDKIACgkQAVBC80lX
0GxosAf/Z4LngXkrYhHqp9Ilzv/yc+qjlyf+w+l+AUhHZh6MLU11Mm8wEqP8mUxA
gM29tdlsxL1XnardbXiTG+EjphAZGIP6g5uv+P8at+gtytOMi1vLzGXvL1ibEKAm
g3RLyBOjNGgC46O1yd7PW4FOFAaL7VFxboZA3GpLj8EdWOtfz6cnc0KtcAq8Z/XH
EWmhERAqMt8mUoY/iERj8FFSwnChBeBzNDPnkT41zPcV2TEXylROyljv3VTzZpVB
+H+SqNwiAlZzsdAbhnbh8xMNOsZLrjovLNR5d9yUJuQ+Mudt5PvoyOEeCniCjbpn
5yyBGiX/o8+p+7VRcjj2TNfYBNHdpg==
=Emsn
-----END PGP SIGNATURE-----

--Sig_/rvvOt6xsja+.U4n9.FFTr/X--
