Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072F0C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 22:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9341520895
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 22:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9341520895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756898AbeFPWFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 18:05:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49183 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753755AbeFPWFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 18:05:33 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fUJK7-00054j-TL; Sat, 16 Jun 2018 23:05:32 +0100
Date:   Sat, 16 Jun 2018 23:05:31 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Julius Werner <jwerner@chromium.org>,
        Thierry Escande <thierry.escande@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Paul Menzel <pm.debian@googlemail.com>
Message-ID: <20180616220531.GB14131@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH] firmware: Update Kconfig help text for Google firmware
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The help text for GOOGLE_FIRMWARE states that it should only be
enabled when building a kernel for Google's own servers.  However, it
is now also a dependency for various Chromebook firmware drivers.

Update the help text to reflect this double duty.  Add the qualifier
"server" to the help text for GOOGLE_SMI, which doesn't appear to be
useful on Chromebooks.

Fixes: d384d6f43d1e ("firmware: google memconsole: Add coreboot support")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/firmware/google/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kcon=
fig
index f16b381a569c..6fda2c5c69e4 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -2,9 +2,8 @@ menuconfig GOOGLE_FIRMWARE
 	bool "Google Firmware Drivers"
 	default n
 	help
-	  These firmware drivers are used by Google's servers.  They are
-	  only useful if you are working directly on one of their
-	  proprietary servers.  If in doubt, say "N".
+	  These firmware drivers are used by Google servers and
+	  Chromebooks.  If in doubt, say "N".
=20
 if GOOGLE_FIRMWARE
=20
@@ -14,8 +13,8 @@ config GOOGLE_SMI
 	select EFI_VARS
 	help
 	  Say Y here if you want to enable SMI callbacks for Google
-	  platforms.  This provides an interface for writing to and
-	  clearing the EFI event log and reading and writing NVRAM
+	  server platforms.  This provides an interface for writing to
+	  and clearing the EFI event log and reading and writing NVRAM
 	  variables.
=20
 config GOOGLE_COREBOOT_TABLE

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWyWJq+e/yOyVhhEJAQoW5xAAwjjDATRkFIn/TBjtEdswvmYS2cY6KJW1
Gpcl+DMAsslQRm3nZ8RWTeiRxPtqW3Svcgz4MIpnK8umXJER9tQ84Mq+zYdupTvJ
Q2yBYcKmaHXMgP506F8oW7xcsL9tkzSyFhB+XVLvdKvAyULE52f37V1cM7O2Kw20
XD+C1q9Qx+i4mhXix+ieWlA3Fw8oryQe0zUV/G4YgQuHen38DhlnHzOIJbN8g2FI
mkSGP1Q1+zYZAtO9QPQalz9Mzui+GoBCKs+RaJJMP5sd1xSH1ORHE2nFYLgfpjo6
+2CA929M+jZh8gXq9002K7rs4eGyDpUfAPWMHZlPjHgkw20Nkkf2zorKEXO8XuYO
2Li5E4PO8E/SS05XvgaDfiX92p87PIIbzhTSAG3CPukeCK2Cu8W9le1f1QGzNNBT
fggkdpiLhE8vtslk7HRXKqEYW5HaEcGYhzZaE8dsrexiACkhMp0bOBJNnMg114RO
SmGVBw/5SVkVuH0URQOTVG4CZFKP+hoCzWaAIywEpr9mzxAwGGf/5qwD7eXszkBS
6kG5WM4VsMJrco6P8Hdlwcer0Ekp38g+EvgNMmVU8ODs6+WwKDkQqUpBj0k2vQBN
KNY5bIc7d5vf/rNU+4nKUeDnQdoEzn1mATvcyyzrL154/71C/O0HRQflbT3KmZDV
jcZvG0xLQb4=
=0lv0
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
