Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DC7C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A28820850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma/Mce5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A28820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeLDU60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:58:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53484 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeLDU6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:58:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id y1so11004919wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 12:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yZWRNyBgXeyhQB9+b0SrHF1C/oTTqG8yy7FQUcMxbt4=;
        b=Ma/Mce5yvuO2vbGHBVBnYhzWsms0bJumA2unmHJhoeXF9XxMLTV0D+KcEcAuOgW+X3
         GtWqclTQT9bs/hbe4gbss9L0OZ1m9E630IJ9zXlrSbmzTQBEoVz85SoQUAyajWV7X5vd
         G5m7dW7Yes4nB4tg1siJ43gAL0Uls1BtiR3QjQWReWXq11IFYaXSSkVxsmRvf1c9A0iJ
         1t1sxAj9MHpqqL5vqJez6OZxU/sQbvYIw4tmrf8z3pEXvR8uNMjwoaLjUiJQ9RcpmJhP
         +oVx7N0iE2ItUmLmON/5Ov6MSeB+kljZqOKhHd9cGHSW4I6vbULNDCGjcX3FNQb2IN3u
         fPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yZWRNyBgXeyhQB9+b0SrHF1C/oTTqG8yy7FQUcMxbt4=;
        b=szkeW4Rif1CRpyZsvsJYY3iRGe8sxwHTaAkJ27/PIccCJ//Si/rEm/n/h88VYZv0Nd
         6QJ6cwUAj58oAvW80w/mO0Ajq0C5VdW+7sbs5ZBzd3gLIJ092xV8vur3QiIoipUGfnLE
         UTtmeS99b+I5NiGWerOGZDMICFgSluzm/+WaKx478EEJF9oHLDKGtiP1gEWW7hthdm01
         HP7uLtoeHWsqShK4L4aCITAM3/5fABxR2aR1k3VmEl1oXnOsx7EAAwZcYAgE7jJkX2+B
         IDCwcfb/3ltQ2iPYYfCnVzTa96Z4uVkIympLQ39KuR5TKmAmo31bTV+Vjiwww3n0eYcZ
         n4Zg==
X-Gm-Message-State: AA+aEWanzrXCWYoBN/KA7GLXhGMCkhRMmZTEZ9AUDd5CSNATi2DCeOp1
        x+ay24iI66ba7rmtdIGk318=
X-Google-Smtp-Source: AFSGD/VXlGS97CxDu9l2/XS3C7UbfbwX1BVuhI/DYNrhsmftkJwuvPngcB1E+yIPM5++ncMhyiQiHg==
X-Received: by 2002:a7b:c003:: with SMTP id c3-v6mr1389881wmb.133.1543957104021;
        Tue, 04 Dec 2018 12:58:24 -0800 (PST)
Received: from peano (host93-127-dynamic.50-79-r.retail.telecomitalia.it. [79.50.127.93])
        by smtp.gmail.com with ESMTPSA id e130sm26636976wmf.25.2018.12.04.12.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 12:58:23 -0800 (PST)
Date:   Tue, 4 Dec 2018 21:58:20 +0100
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Bryan O Donoghue <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bryan O Donoghue <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: greybus: Added space between string concatenated
Message-ID: <5b215b50d4da9a7730450a83fb5e3a167b65e03a.1543956271.git.sicilia.cristian@gmail.com>
References: <cover.1543956271.git.sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <cover.1543956271.git.sicilia.cristian@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some concatenated strings are now spaced.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/greybus/loopback.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/l=
oopback.c
index 1085e06..acfa392 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -141,7 +141,7 @@ static ssize_t name##_##field##_show(struct device *dev=
,	\
 	/* Report 0 for min and max if no transfer successed */		\
 	if (!gb->requests_completed)					\
 		return sprintf(buf, "0\n");				\
-	return sprintf(buf, "%"#type"\n", gb->name.field);	\
+	return sprintf(buf, "%" #type "\n", gb->name.field);		\
 }									\
 static DEVICE_ATTR_RO(name##_##field)
=20
@@ -176,7 +176,7 @@ static ssize_t field##_show(struct device *dev,				\
 			    char *buf)					\
 {									\
 	struct gb_loopback *gb =3D dev_get_drvdata(dev);			\
-	return sprintf(buf, "%"#type"\n", gb->field);			\
+	return sprintf(buf, "%" #type "\n", gb->field);			\
 }									\
 static ssize_t field##_store(struct device *dev,			\
 			    struct device_attribute *attr,		\
@@ -212,7 +212,7 @@ static ssize_t field##_show(struct device *dev,				\
 			    char *buf)					\
 {									\
 	struct gb_loopback *gb =3D dev_get_drvdata(dev);			\
-	return sprintf(buf, "%"#type"\n", gb->field);			\
+	return sprintf(buf, "%" #type "\n", gb->field);			\
 }									\
 static ssize_t field##_store(struct device *dev,			\
 			    struct device_attribute *attr,		\
--=20
2.7.4


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJcBuprAAoJEAnJ2Lo5pAXywhcQAIAqZ+NP3t2MKSrWAAFEXdUg
/pdzB9ukbDazOQ3XQY0ZQH4fHRov0rcQ/3EYxdCTY5QqOkt7GFOp/mIhuxVTKubj
9zdTA8SCaG0kQ413CJgkFm5h01Dc99u2BjK4ChfpOSbaYOPhuZK6B+TCfXhj3NyY
2G6BGH+6qYKMtaSPRcsaBPvr1po48a22bBf5Uw93E3lNOX0T2QhBMme4hMIVT8EO
pK/+3ahwXT/linnA89g17sCUChtPmmDfs5ALNbRMpOKuInIIemVFW5uu9RTZCSpy
RQgOZ0OdhPEmbfsgF+JtVe8A7xV4OsBNQkxEK+usGYoI7ceKwuSCfC2JKFTmhezK
Z4eArfvQiV9YedMtXlLGn1zrcSApOYv8am6nNK9iiqVlq7EzOOVgJSOJt2vh/ACm
8CJ0mfwcXTRbw+PIspXdNpsDca0B2/HK9aEOHdOb3cr/dX2dQwt6DTwZP8D/nKv/
cFixgf9ZpPtgdtdbpXvk+CPO95tV+fTL11zlZcgE5AQQ+lbwzI9ECd7JT3p58yZi
lg/rkdtuwdgbfRj+gLn2JFctzYb6ITYnbncsdOKqh3Bylc4aBZcNVq3oA3//tHdW
P7+zxiGwh9dJ+SioNr20Q2r2+862ld7mVfOc2zjaEbal5O/3eeuYOuMUBDMxPpKc
KT5wghff0eq0QO14U3Po
=Zc8f
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
