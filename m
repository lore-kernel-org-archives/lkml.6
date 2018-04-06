Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeDFEy2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 00:54:28 -0400
Received: from ozlabs.org ([103.22.144.67]:37799 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbeDFEy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 00:54:27 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 6 Apr 2018 14:53:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20180406145330.4d166464@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ctQPjiRKiPFJsYi2Cd4A+.g"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ctQPjiRKiPFJsYi2Cd4A+.g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm-current tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

mm/memcontrol.c: In function 'memory_events_show':
mm/memcontrol.c:5453:23: warning: array subscript is above array bounds [-W=
array-bounds]
      atomic_long_read(&memcg->memory_events[OOM_KILL]));
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  725844c87a0d ("mm: memcg: make sure memory.events is uptodate when waking=
 pollers")

--=20
Cheers,
Stephen Rothwell

--Sig_/ctQPjiRKiPFJsYi2Cd4A+.g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrG/UoACgkQAVBC80lX
0Gwg2gf/Z98pjfzrbxJvbgiKawrdotf4VcrznHNkqjgHzpVdW3HIscyhmWYnxe13
CHr++tZiS9TmT0vime8/QvbIdh17pW/ignYl/TajpXXZqBTKGri5bPRZHZBAAcP1
iQGlaa0DQfcaYiTWg1UyyeksKpU43zh97SEUCUclKQpx72Z/9i7ZX3/Y4QlGCt1i
3Ux+959DClQtNiWe82p4TlCBZMXxaJRS7FRUG+SZOG/4uEIwKW035vsFcVgMZ9Ge
bWRazLfAuXq37JcUCsqnxKqOA5YUvL3X5+fwJW45ZM1ummP5+NJwHAhEV7Bevt21
jN70TO37p29zZpYnNYFz7aHscqFAaA==
=eT3e
-----END PGP SIGNATURE-----

--Sig_/ctQPjiRKiPFJsYi2Cd4A+.g--
