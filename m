Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7BAC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 06:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4904B217C1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 06:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4904B217C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeHEJCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 05:02:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49113 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeHEJCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 05:02:54 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A17548064C; Sun,  5 Aug 2018 08:59:21 +0200 (CEST)
Date:   Sun, 5 Aug 2018 08:59:21 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     ka-cheong.poon@oracle.com, santosh.shilimkar@oracle.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>
Cc:     Netdev list <netdev@vger.kernel.org>
Subject: [PATCH] RDS is not Radio Data System
Message-ID: <20180805065920.GA8968@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Getting prompt "The RDS Protocol" (RDS) is not too helpful, and it is
easily confused with Radio Data System (which we may want to support
in kernel, too).

I wonder if option should be named NET_RDS, instead?

And this sounds like a good idea:

(Plus, we normally have "module will be called foobar" and if unsure
say X. What happened to those?)

diff --git a/net/rds/Kconfig b/net/rds/Kconfig
index 41f7556..2738f14 100644
--- a/net/rds/Kconfig
+++ b/net/rds/Kconfig
@@ -1,6 +1,6 @@
=20
 config RDS
-	tristate "The RDS Protocol"
+	tristate "The Reliable Datagram Sockets (RDS) Protocol"
 	depends on INET
 	---help---
 	  The RDS (Reliable Datagram Sockets) protocol provides reliable,



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltmoEgACgkQMOfwapXb+vKTVACgthcMj86QoZHXuIFQSWSQh5GK
sDAAmwe6rN3GP1s8UFewrOtWpQok/Y+6
=jUVb
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
