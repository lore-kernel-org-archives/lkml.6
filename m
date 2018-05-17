Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeEQGvO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:51:14 -0400
Received: from ozlabs.org ([203.11.71.1]:56695 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751698AbeEQGvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:51:13 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 17 May 2018 16:51:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Vorel <pvorel@suse.cz>
Subject: linux-next: build warning after merge of the integrity tree
Message-ID: <20180517165110.6a014e12@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wiM8keOEQv5.dp58dGNfUTz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wiM8keOEQv5.dp58dGNfUTz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the integrity tree, today's linux-next build (powerpc
allyesconfig) produced this warning:

security/integrity/ima/ima_kexec.c:18:0: warning: "pr_fmt" redefined
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

In file included from include/linux/kernel.h:14:0,
                 from include/asm-generic/bug.h:18,
                 from arch/powerpc/include/asm/bug.h:128,
                 from include/linux/bug.h:5,
                 from include/linux/seq_file.h:7,
                 from security/integrity/ima/ima_kexec.c:13:
include/linux/printk.h:288:0: note: this is the location of the previous de=
finition
 #define pr_fmt(fmt) fmt

Introduced by commit

  3dea0d93d257 ("ima: Unify logging")

--=20
Cheers,
Stephen Rothwell

--Sig_/wiM8keOEQv5.dp58dGNfUTz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr9Jl4ACgkQAVBC80lX
0GxGsQf/TScM5JgDHnr/o2YfzYeXwgN58KIpcApjma/mgKp9GdVUD/AdNf9tfU9l
KahOOYcrO+3JFP3GRYNqoa25H5QFE6MDGpOvcj3chM/iXsJ9ULhAOxbI/kyVvyka
fXqB+M7tJAjn20CQAL3FdZCyn3Y2zh5gfIlZl9oicl9NLiLtPuGwXEFsaFW5h1Bi
+OHt8I7IFRayNzfD01Qf7wlVMzB7Ccf6ymwH0/2ptbgoPcmWdvNvn18MJDVVOgQO
zTMs35ozRhl1wIM4Oi2z3JxAU64/fhUmb2RFyFI0baktxruussaNc3n3apCt6cj+
TPqA3qKTxtdQo6kxITXAuq6hHEtnqg==
=TTqO
-----END PGP SIGNATURE-----

--Sig_/wiM8keOEQv5.dp58dGNfUTz--
