Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E51C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461A42087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461A42087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeH2Dbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:31:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39533 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727162AbeH2Dbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:31:52 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1funYW-0008Cw-PS; Wed, 29 Aug 2018 00:37:53 +0100
Date:   Wed, 29 Aug 2018 00:37:52 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Sasha Levin <alexander.levin@verizon.com>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <20180828233752.GG18030@decadent.org.uk>
References: <20180828233606.GE18030@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kjpMrWxdCilgNbo1"
Content-Disposition: inline
In-Reply-To: <20180828233606.GE18030@decadent.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH 2/2] liblockdep: Stub task_struct::state
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kjpMrWxdCilgNbo1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

lockdep_print_held_locks() now checks task_struct::state.  Define it
so that all tasks are assumed to be running, since we have no
reasonble way to tell in user-space.

Fixes: 8cc05c71ba5f ("locking/lockdep: Move sanity check to inside ...")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/include/linux/lockdep.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/linux/lockdep.h b/tools/include/linux/lockdep.h
index 6b0c36a58fcb..8e84609afb04 100644
--- a/tools/include/linux/lockdep.h
+++ b/tools/include/linux/lockdep.h
@@ -31,12 +31,16 @@ struct task_struct {
 	gfp_t lockdep_reclaim_gfp;
 	int pid;
 	char comm[17];
+	long state;
 };
=20
 extern struct task_struct *__curr(void);
=20
 #define current (__curr())
=20
+/* lockdep checks task_struct::state =3D=3D TASK_RUNNING */
+#define TASK_RUNNING 0
+
 static inline int debug_locks_off(void)
 {
 	return 1;

--kjpMrWxdCilgNbo1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBW4Xc0Oe/yOyVhhEJAQq08w//UraKqboKTMCHCkDe6ZQ1HnOSvYZ1hsq8
xbxuEAjN+5cc7jTcmu4kp6G+iuoXNKlJyPPrF7tvOauQYizUzMieI2meYWG2kWfM
TVUMk0gNf2OwQoR+MjDeY66QOUg/4qzSL3qzX39U0ccqdS3kApBLJTpQ6+UXyIiO
jludDZBezM32kDXRnSOhkd6OuhYG/Wr6a4htfB2XAaPeHVD4fHylQyR23HEXDl3p
0Lnv+CkQ211LpCEuA1fkdjvuKLlBUakkUde3iLAUfI5ZLXRZzIbrtfhbireWrGTt
41bYOihoxNvZ555XGmdRRhqMI9NUT9LU9wqhzB26OFHrNVqiljpAr9T0B3IS4xFU
nyVjSCyUDola3g/TA0Kxp6bdk54erY7v30sHPUPy6BdoEiwrJpxy5muZAHYDvTQK
8II+tYKvoXhvIRYYDp9FTC0LDA2sG76rBXTacGHj7K2Rre0DjeYE7PkN6ANLGeyU
lCWu2mHg96WOPmGC8UH/0nk86G64NYSsXt7zWNA9HXgaNUzMVXJv6u7y/ycgwPSq
MhVTRlzwS5o9L/hJQZl4vA60Ktx1q5UlfAXLA7OGGC32A8vb6UaabTpBuUUO5zQD
BZ8ny+l7roVFCJRdh6vP4Mq3sUM5kfarXGZdexqmxS3O/f16/CULDB/WEIX2xk4+
K6NFzbgk5bs=
=v+pC
-----END PGP SIGNATURE-----

--kjpMrWxdCilgNbo1--
