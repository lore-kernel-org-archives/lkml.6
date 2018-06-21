Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E48C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE19208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE19208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933487AbeFUMPr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:15:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54914 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933066AbeFUMPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:15:45 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 683688058B; Thu, 21 Jun 2018 14:15:43 +0200 (CEST)
Date:   Thu, 21 Jun 2018 14:15:42 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: v4.18-rc1 on droid 4: very bad CPU performance
Message-ID: <20180621121542.GA4836@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

V4.18 is slower than it should be.

user@devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 -
| wc -c
10044291
52.73user 2.40system 61.53 (1m1.534s) elapsed 89.60%CPU
user@devuan:~$ uname -a
Linux devuan 4.18.0-rc1-87964-gfa19934-dirty #743 SMP Sun Jun 17
19:26:37 CEST 2018 armv7l GNU/Linux

That bzip should take 12 seconds, not minute.

Any ideas? Do you see it, too?

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsrlu4ACgkQMOfwapXb+vI+ZgCgjGoE/b39+ozezf6HIClfCRPR
XMEAoIORuNoXvcljvgv1WlK55Qe1+Oz7
=51ml
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
