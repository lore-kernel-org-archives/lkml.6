Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEF8C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 20:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348DC2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 20:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfAZUAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 15:00:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52746 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfAZUAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 15:00:08 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 37D27806A4; Sat, 26 Jan 2019 20:59:59 +0100 (CET)
Date:   Sat, 26 Jan 2019 21:00:05 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, aarcange@redhat.com,
        rientjes@google.com, mhocko@kernel.org, zi.yan@cs.rutgers.edu,
        hannes@cmpxchg.org
Subject: [regression -next0117] What is kcompactd and why is he eating 100%
 of my cpu?
Message-ID: <20190126200005.GB27513@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

With modern web, 100% CPU load is no longer uncommon, but this time
chromium is not to blame:

pavel@amd:/data/l/linux-next-32$ uname -a
Linux amd 5.0.0-rc2-next-20190117 #214 SMP Fri Jan 18 09:47:18 CET
2019 i686 GNU/Linux

top - 13:38:51 up  1:42, 16 users,  load average: 1.41, 1.93, 1.62
Tasks: 182 total,   3 running, 138 sleeping,   0 stopped,   0 zombie
%Cpu(s):  2.3 us, 57.8 sy,  0.0 ni, 39.9 id,  0.0 wa,  0.0 hi,  0.0 si,  0.=
0 st
KiB Mem:   3020044 total,  2429420 used,   590624 free,    27468 buffers
KiB Swap:  2097148 total,        0 used,  2097148 free.  1924268 cached Mem

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND=
    =20
  608 root      20   0       0      0      0 R  99.6  0.0  11:34.38 kcompac=
td0 =20
 9782 root      20   0       0      0      0 I   7.9  0.0   0:59.02 kworker=
/0:+=20
 2971 root      20   0   46624  23076  13576 S   4.3  0.8   2:50.22 Xorg   =
    =20



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxMvEUACgkQMOfwapXb+vLv5wCgjfsg3TwUQr5iPZOrTadrfScE
Zq8AoKP6Vkqll/8NR34+7Qe3fyMakhDX
=OH2y
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
