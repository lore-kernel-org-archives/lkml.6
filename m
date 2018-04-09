Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932886AbeDIB0C (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 21:26:02 -0400
Received: from ozlabs.org ([103.22.144.67]:51479 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932872AbeDIBZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 21:25:56 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 9 Apr 2018 11:24:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the pm tree
Message-ID: <20180409112438.6832432f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QL=OZEguM./+7xhHdQruHaV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QL=OZEguM./+7xhHdQruHaV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

After merging the pm tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

kernel/time/tick-sched.c: In function 'tick_nohz_idle_exit':
kernel/time/tick-sched.c:1162:3: warning: 'now' may be used uninitialized i=
n this function [-Wmaybe-uninitialized]
   __tick_nohz_idle_restart_tick(ts, now);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/time/tick-sched.c:1146:10: note: 'now' was declared here
  ktime_t now;
          ^~~

This appears to be a false positive.

And another in the x86_64 allmodconfig build:

kernel/time/tick-sched.c: In function 'tick_nohz_idle_exit':
kernel/time/tick-sched.c:538:2: warning: 'now' may be used uninitialized in=
 this function [-Wmaybe-uninitialized]
  update_ts_time_stats(smp_processor_id(), ts, now, NULL);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/time/tick-sched.c:1146:10: note: 'now' was declared here
  ktime_t now;
          ^~~

also looks like a false positive.

--=20
Cheers,
Stephen Rothwell

--Sig_/QL=OZEguM./+7xhHdQruHaV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrKwNYACgkQAVBC80lX
0GzcsQgAkzWPq7Y+BoqL7G2sdak4okMWnvzc2OLN/ETSpfLMiKBR7ppx+pj2QxaC
IqVLEA8uwRloWtLzLAH4y0OQ/1EzsQhXeoUvH5EcEDi9mS9V+k6YXZVwxNOkxCmq
EzxcB5kgrWcPEYN5BGrpAZlD1kuHArQK01EWQFPe/BJfCS/EkNoV6Pu7VObKcUFK
rc0WMgpRPgr9iNJCBAPudFjqARUVA4zvj/XIdxMyvzXZR5lQAdGdEpw+xXPueRkS
B8GzyI+P/5lQtMFJOL9SYzyTubrIDOJGJGvls5IDk/ZYrm23MvNA0HTt5Q59j3pK
NEBCvnw5jntBqF4Job+Z8oEqp647Vw==
=adBk
-----END PGP SIGNATURE-----

--Sig_/QL=OZEguM./+7xhHdQruHaV--
