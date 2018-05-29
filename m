Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937517AbeE2DZy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 23:25:54 -0400
Received: from ozlabs.org ([203.11.71.1]:41143 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932463AbeE2DZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 23:25:52 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 29 May 2018 13:25:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20180529132548.7f71c2ff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0tK3ll5x8Ha1Nll4mTtSUBw"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0tK3ll5x8Ha1Nll4mTtSUBw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

x86_64-linux-ld: unknown architecture of input file `net/bpfilter/bpfilter_=
umh.o' is incompatible with i386:x86-64 output

Caused by commit

  d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")

In my builds, the host is PowerPC 64 LE ...

I have reverted that commit along with

  61a552eb487f ("bpfilter: fix build dependency")
  13405468f49d ("bpfilter: don't pass O_CREAT when opening console for debu=
g")

for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/0tK3ll5x8Ha1Nll4mTtSUBw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsMyDwACgkQAVBC80lX
0GxKdAf/UMaaj2S350stVP/Rpt4Y9DGTKl8D/EQpZSpfZ+eUnIsutZTCVEjo6yYW
LB237YXsHQUMr28YpN8F2std5nPgUuFRtWdLHzUoqpzvcRmoXlJn9hZj7wu3DK24
8CFVvPwG1a/gu9Zg8qsfTHIPWHU/I0tNXB+joY+0jYfzn//nGjn3S5CQCsoAnZGM
spEYiZ1M5CnLLfgFqD2XmhmsNv5JazsbEPETgHrWvsdXTK2v6iJ5xo6iGUMqmel/
K5dJjJWufZhnLf7amlVthptCfNfjdMGO2t9EyIS/iLygg462xLNWPcN1FV5ysuQR
XynQvyVsuChTo2m/6SX7qXD+Smc6hQ==
=r6JH
-----END PGP SIGNATURE-----

--Sig_/0tK3ll5x8Ha1Nll4mTtSUBw--
