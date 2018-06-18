Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B640CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764D720693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764D720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755474AbeFRWzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:55:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:56272 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755329AbeFRWzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:55:42 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fV33k-0006Ca-JR; Mon, 18 Jun 2018 23:55:40 +0100
Date:   Mon, 18 Jun 2018 23:55:40 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Julius Werner <jwerner@chromium.org>,
        Thierry Escande <thierry.escande@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Paul Menzel <pm.debian@googlemail.com>
Message-ID: <20180618225540.GD14131@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TeJTyD9hb8KJN2Jy"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH v2] firmware: Update Kconfig help text for Google firmware
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The help text for GOOGLE_FIRMWARE states that it should only be
enabled when building a kernel for Google's own servers.  However,
many of the drivers dependent on it are also useful on Chromebooks or
on any platform using coreboot.

Update the help text to reflect this double duty.

Fixes: d384d6f43d1e ("firmware: google memconsole: Add coreboot support")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
v2: Mention coreboot, and don't touch GSMI help text

 drivers/firmware/google/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kcon=
fig
index f16b381a569c..ca049ecf5cfd 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -2,9 +2,9 @@ menuconfig GOOGLE_FIRMWARE
 	bool "Google Firmware Drivers"
 	default n
 	help
-	  These firmware drivers are used by Google's servers.  They are
-	  only useful if you are working directly on one of their
-	  proprietary servers.  If in doubt, say "N".
+	  These firmware drivers are used by Google servers,
+	  Chromebooks and other devices using coreboot firmware.
+	  If in doubt, say "N".
=20
 if GOOGLE_FIRMWARE
=20

--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWyg4bOe/yOyVhhEJAQqkyg/8CeECZPQ2v6XVnYUBrgXdLSeIK08dcxed
R3qAx+tDpiSj0dvMsA7f5yABtOW7Xb91iMK/Oc4J5xe184DhbCW3n+5cO7ywHEyS
3PDXZfLZbCOm9Z/7dI5zUTsXgMsjLi16kpmerN5z9ueXbCfVE1jbGYJJHdHxXj/a
UjfkZXc621NzNlBC7wtrDwTS0Y6hfGposg2WZXAtBMugseNTJNdUAUc0U7PfwKN9
p97DeX2iMaEVDHAhWEZXu3nNBbE11QUStY8rK4wmTefJMmOCR5L4t/gInZxLKXv+
w9ZHdGI5CajVEJr29couRiKygna3Z/vvRwu93D++7uWt0cmpp9veeTpHXsK9hnry
vQ2UTqEQgVqGGw3RQxECdKk49Z3Q+fCAy3WLRQtLJ9/Wi69JTOjb6ZgDpeq4pHuv
7XOWhqx89IlCPJ61TJWlR6VfsmKvlA2RHuPGAkxVQ+PByWRmE4QzVswWYzkTCG1k
aV+afvNUxXqEtoKzhUnikTq5vimWHrGWU3RZQUf3fiqSm9IINKK6BBWqRHHtHUMw
UzyMB9BP0TxZUnLqx4Uavjv6a18mTOMQi8MJb8OadW8n5iDyfTskDcWx3ApmewRh
ggCspOFztqFK37AhNrR9WmomOW1wuls0LLWU9kQ08JibMkJ4FfSa3R/ZZfWTjluK
/E5Rj4QsSKs=
=/wOI
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--
