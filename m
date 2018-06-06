Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gjRPsk4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 429EA6070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932656AbeFFKlV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:41:21 -0400
Received: from ozlabs.org ([203.11.71.1]:59589 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932382AbeFFKlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:41:20 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 6 Jun 2018 20:41:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: linux-next: build warning after merge of the y2038 tree
Message-ID: <20180606204116.5b01ed36@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rn0CUU1CZg6eHov=kShUIc8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rn0CUU1CZg6eHov=kShUIc8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the y2038 tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

fs/pstore/ram.c: In function 'ramoops_read_kmsg_hdr':
fs/pstore/ram.c:39:29: warning: format '%ld' expects argument of type 'long=
 int *', but argument 3 has type 'time64_t * {aka long long int *}' [-Wform=
at=3D]
 #define RAMOOPS_KERNMSG_HDR "=3D=3D=3D=3D"
                             ^
fs/pstore/ram.c:167:21: note: in expansion of macro 'RAMOOPS_KERNMSG_HDR'
  if (sscanf(buffer, RAMOOPS_KERNMSG_HDR TVSEC_FMT ".%lu-%c\n%n",
                     ^~~~~~~~~~~~~~~~~~~
fs/pstore/ram.c:42:23: note: format string is defined here
 # define TVSEC_FMT "%ld"
                     ~~^
                     %lld
fs/pstore/ram.c:39:29: warning: format '%ld' expects argument of type 'long=
 int *', but argument 3 has type 'time64_t * {aka long long int *}' [-Wform=
at=3D]
 #define RAMOOPS_KERNMSG_HDR "=3D=3D=3D=3D"
                             ^
fs/pstore/ram.c:174:28: note: in expansion of macro 'RAMOOPS_KERNMSG_HDR'
  } else if (sscanf(buffer, RAMOOPS_KERNMSG_HDR TVSEC_FMT ".%lu\n%n",
                            ^~~~~~~~~~~~~~~~~~~
fs/pstore/ram.c:42:23: note: format string is defined here
 # define TVSEC_FMT "%ld"
                     ~~^
                     %lld
fs/pstore/ram.c: In function 'ramoops_write_kmsg_hdr':
fs/pstore/ram.c:39:29: warning: format '%ld' expects argument of type 'long=
 int', but argument 3 has type 'time64_t {aka long long int}' [-Wformat=3D]
 #define RAMOOPS_KERNMSG_HDR "=3D=3D=3D=3D"
                             ^
fs/pstore/ram.c:370:30: note: in expansion of macro 'RAMOOPS_KERNMSG_HDR'
  hdr =3D kasprintf(GFP_ATOMIC, RAMOOPS_KERNMSG_HDR TVSEC_FMT ".%lu-%c\n",
                              ^~~~~~~~~~~~~~~~~~~
fs/pstore/ram.c:42:23: note: format string is defined here
 # define TVSEC_FMT "%ld"
                     ~~^
                     %lld

Introduced by commit

  0f0d83b99ef7 ("pstore: Convert internal records to timespec64")

--=20
Cheers,
Stephen Rothwell

--Sig_/rn0CUU1CZg6eHov=kShUIc8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsXukwACgkQAVBC80lX
0GwZrAf/cE9QCaKaCqo3FM+r2m8R8Tm8EFUNkT3MBkudHS3jSWkwcMXJuGjls2pw
uiLO2LeJgvffMu5b/MxFuhfkSTCZGqUuh57mzQOlk3mohrr5D/5C2/INLpb1ONrJ
cN0I3ChF6y6lza4MDGV96lw91jKaAKAeTFCzEfLB465cVRxsIdVStkeO+epL1Toa
dnHE+5kAnlMPRf6/1NfiQKeeSA9wNb2fbKCWevzN8mdv/zdMnARUoOYZi3CZmZVv
+kgy84TuRxdcwoKJkubepdltSVT8OPG9R9M33cg/xX7JW9FuH/ZKGDz7LQYJa5hu
THQb09hdFVCgbKcGLvFZmwj7rKhgRw==
=zD9H
-----END PGP SIGNATURE-----

--Sig_/rn0CUU1CZg6eHov=kShUIc8--
