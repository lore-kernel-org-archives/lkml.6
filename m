Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753265AbeCNE5z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 00:57:55 -0400
Received: from ozlabs.org ([103.22.144.67]:36101 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751983AbeCNE5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 00:57:53 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 14 Mar 2018 15:57:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the syscalls tree
Message-ID: <20180314155725.581ee5ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gU.G4dORfkS/3tOR+UOSJXT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gU.G4dORfkS/3tOR+UOSJXT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dominik,

After merging the syscalls tree, today's linux-next build (x86_64
allnoconfig) failed like this:


Caused by commit

  3e334170db85 ("mm: use do_futex() instead of sys_futex() in mm_release()")

CONFIG_FUTEX is not set for this build.  Normally sys_futex() would be
the one from kernel/sys_ni.c in this case ...

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/gU.G4dORfkS/3tOR+UOSJXT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqoq7UACgkQAVBC80lX
0GwuJAgAhwG3673bd5mc6+epyWlUSEaO4HVxJg/84JkfrjTcj+zrxq7qOCLvOITw
Tp788cH7/qez2wmF9AaI2eSLsWACaY0K921w/HH/3qF8a7CPs0AWxcI+d1+HE2p5
DILB+0Sae0JyRDpRRiGHu2NRbN+tvX64yWaY5UCWeEDOvOR32mGUBG2hNv53CLIz
SQJTzDgV5q9UnePlVYu+N6xyzuoMCDikqwnVygVOKN9SHLptdFVuMjJOAtln9hk7
s3JA7IUJRFSTGtVenPtfAYrWb8bCFl8LgBCEmshr4RQPjXGW+t0hwztyet6ryJe5
othpHvmfcW38hVOO8Dajbrd7PbB7Kw==
=iYWF
-----END PGP SIGNATURE-----

--Sig_/gU.G4dORfkS/3tOR+UOSJXT--
