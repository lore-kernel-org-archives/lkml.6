Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6266EC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1789B2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1AF/1g4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1789B2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeLDU6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:58:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35818 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLDU6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:58:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id c126so10742434wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uQ+eg6BkKvzr2ExA2DzdSn26LXGL1h5zerB1aicDLUI=;
        b=J1AF/1g4W+pclzeBr/oPaPZk59tWvE+a93rOc2Bi4R1yZQ/f0Q0KCDY3OPZ4TtcP8d
         X+TiP4BPbb1zZZTA/tgmIyZzcNa7XrQBWHNzz05IjfbuJQBMCgS/UTNN/9dsu4Hh22c3
         WgNqWeqKjkpW17O69AQDb/J3WAF0Z78rxAT5XsxDA/E9BVyJUhxc0o+Z1hN3QXKCU2FG
         g2RJFTOasewHofz4Ymko9IYmxq/w9zRgqFtKT9fTeLNA1dkTRC6C7FM6U2KT741iQM6o
         JEXtIktXO46fMG64OqmwVWE4vJ2J4RI47tNqU15DU8RFPD0CiiVpugp1Z5YaUWJBEdIZ
         WSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uQ+eg6BkKvzr2ExA2DzdSn26LXGL1h5zerB1aicDLUI=;
        b=hZidUzTgunQWtCkdkjf6mE9T8h4C3JoHSMpbrKOqG7LETzmi8l0QdxGJx4myT7hC7N
         OoxZY3/k7q7ykLmWAmT47iKFAZL0LvgIJFf4Pcfkid5GoHRjxTMNAMt51SOdcSndPzZS
         Y6/K692wwRjoNOFuz34WA2pawhJcC9NgNtGY2VaDYMm7alxqhdJ3cy65Dz7BNs4F/Itr
         63B4I1xue8ndTl+KP+U2gGMHe+Y1he1zrUZorvJ0Yj8wdq8aFBzaD/CvJ7HBWoUYSxhY
         xrN0OWUwqgU3yp2J+ZKhVmd2akEwq8VwSCA4dYA6b3WAwp8llY/m8JrgUM+LEpK3o21r
         TN5g==
X-Gm-Message-State: AA+aEWbKEFsKjccGXtinliSIXwR4QQDbSehUjEyiwJL9pJjhO8MADs9L
        H6KvWOHvFHE+NSCx4GdJTHc=
X-Google-Smtp-Source: AFSGD/VXq2PFncIO7gysdFt/pVyF/yR6rzAr+FWsiNC/bH6uh3FkEv309lLyX7l2hKTgrNJZgothkg==
X-Received: by 2002:a1c:709:: with SMTP id 9mr12730650wmh.39.1543957097402;
        Tue, 04 Dec 2018 12:58:17 -0800 (PST)
Received: from peano (host93-127-dynamic.50-79-r.retail.telecomitalia.it. [79.50.127.93])
        by smtp.gmail.com with ESMTPSA id r69sm4791660wmd.4.2018.12.04.12.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 12:58:16 -0800 (PST)
Date:   Tue, 4 Dec 2018 21:58:14 +0100
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Bryan O Donoghue <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bryan O Donoghue <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: greybus: Align function call parameters to
 parenthesis
Message-ID: <6087f45a8a4544fa6c671d8b42928fb48194e66e.1543956271.git.sicilia.cristian@gmail.com>
References: <cover.1543956271.git.sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <cover.1543956271.git.sicilia.cristian@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Aligned some parameters to the previous parenthesis.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/greybus/loopback.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/l=
oopback.c
index e4d42c1..1085e06 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -638,7 +638,8 @@ static int gb_loopback_async_transfer(struct gb_loopbac=
k *gb, u32 len)
 	retval =3D gb_loopback_async_operation(gb, GB_LOOPBACK_TYPE_TRANSFER,
 					     request, len + sizeof(*request),
 					     len + response_len,
-					     gb_loopback_async_transfer_complete);
+					     gb_loopback_async_transfer_complete
+					     );
 	if (retval)
 		goto gb_error;
=20
@@ -682,7 +683,8 @@ static int gb_loopback_request_handler(struct gb_operat=
ion *operation)
 		}
=20
 		if (!gb_operation_response_alloc(operation,
-				len + sizeof(*response), GFP_KERNEL)) {
+						 len + sizeof(*response),
+						 GFP_KERNEL)) {
 			dev_err(dev, "error allocating response\n");
 			return -ENOMEM;
 		}
@@ -882,7 +884,7 @@ static int gb_loopback_fn(void *data)
 				gb->type =3D 0;
 				gb->send_count =3D 0;
 				sysfs_notify(&gb->dev->kobj,  NULL,
-						"iteration_count");
+					     "iteration_count");
 				dev_dbg(&bundle->dev, "load test complete\n");
 			} else {
 				dev_dbg(&bundle->dev,
@@ -1066,7 +1068,7 @@ static int gb_loopback_probe(struct gb_bundle *bundle,
=20
 	/* Allocate kfifo */
 	if (kfifo_alloc(&gb->kfifo_lat, kfifo_depth * sizeof(u32),
-			  GFP_KERNEL)) {
+			GFP_KERNEL)) {
 		retval =3D -ENOMEM;
 		goto out_conn;
 	}
--=20
2.7.4


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJcBuplAAoJEAnJ2Lo5pAXyiGYP/0nS3+OrBl56PVrAecBb0XI9
vREZVJAwxGgPKLl98eYnDpQk0DJMKHH7uU/LOcQkSrlcT3es0eL9O5aksT3eBel2
SUpzdUN1PhY+4Am5rpmQtMGrZr3UOHbUKeuMzN4ae3hd5DCBQlM9wFO9039BHd5M
8DBV0wDgDBbYYl6Bs2i+SgXSVlSKmeSqIhnGYwVYaR1SWEme00Cvmt4uzRtrtuB/
5AeoSiYV/49oYonuExTVF7j2dbVeyWBeZFoierQyTIsrDNg/MZx4yk4TEFBsOpKP
NoBG/lgcXqFFpy1SGlKgyHybNnSEQSwCkc7PbwYFduJfPH+aTWQNWA/cnOmFoqV6
OJoh4Wi9iCdvNQQP1l2ipTTLDj5tiwHFCaIdzQqHYQIM4dh9LdJCYTlw/oWecKnw
D4mXb2sVLVy5uiC0FMN7vvK9DC2tiEJp/w+KgvnJtsWeO/OLkpnjomlmMIevUP+a
ljatEqkHEXWLwuBaPsSmhL6F8UKRAI0x6Cn0UImG4gHEm8pFdZMeBi/RTdVAopxN
UlC5pJX8zz7aFwAkAXnJ/Nt6DU5jCFjiMLDa7ze3XQuXXLr4fJDTDFVp28i9wr67
BFTe1fZ4HTssmz9TQZhVt5Uo2iHFu7fSSuemF6PVuPIMWNZ30SskDSuuDFv2VVTL
gJPYONeA9RUWUjxqHqoW
=LevI
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
