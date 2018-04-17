Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeDQC0y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 22:26:54 -0400
Received: from ozlabs.org ([203.11.71.1]:37447 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751206AbeDQC0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 22:26:52 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 17 Apr 2018 12:25:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: linux-next: build warning after merge of the scsi tree
Message-ID: <20180417122540.1c0a3fee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nUewiLCP1OyDtWn/KeIPAp4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nUewiLCP1OyDtWn/KeIPAp4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi James,

After merging the scsi tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/scsi/storvsc_drv.c: In function 'storvsc_do_io':
drivers/scsi/storvsc_drv.c:1402:1: warning: the frame size of 2216 bytes is=
 larger than 2048 bytes [-Wframe-larger-than=3D]
 }
 ^

Introduced by commit

  0b9bc24b8304 ("csi: storvsc: Select channel based on available percentage=
 of ring buffer to write")

--=20
Cheers,
Stephen Rothwell

--Sig_/nUewiLCP1OyDtWn/KeIPAp4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrVWyQACgkQAVBC80lX
0GyQJgf/dtALnzIauOrC3rekB49szfvR34WNakITPxvFhwhLX7hCuO8DoSsAD3ek
saXO1qPs7007H45Q3JO2ATxbS7WQsE65cd15/+GPivz9QiRi8iwQ4mYn9pAkoifP
s21/dSaX9USNkgimRC+cVa96KlIfBSxrxliqn5XR+rrZBBiJNXT3aIJ/9qE1Qj7C
4suA7eNyZRAy6tvDUU7fJEYkvEXoYW5NcTu4N5zJsSxXKzUfb0YJonDUyMr9h31B
fraW0sLO7YSJB2kycoD/8bgsUKZ9CZgYQHfGUf5bCxmIjBaheWTEaKlW52NsEGP2
liTqr6Tu7j1dI6jc7ZyQPp7pAfiP4A==
=7Okp
-----END PGP SIGNATURE-----

--Sig_/nUewiLCP1OyDtWn/KeIPAp4--
