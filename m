Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT,WEIRD_QUOTING autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC77BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA2A2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNM4wrWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA2A2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbeLEVAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:00:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39685 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbeLEVAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:00:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id f81so11877065wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BysOpIzocHTTKy0zsrOe6ngzD9Zx8K2KAtWoT01ykeU=;
        b=HNM4wrWbq4FqBI5Axhq0rTZ2bWaN+7rvAoYxJAQqivjSvDxxYCVxcx6pkZIIX0mhJx
         zuUYOEErQsRf831RO57pwX60dDDee3YItqFmWaMFrvXsN2aRD8ct769gFnZA581Jrk8d
         AyKBrmioMecWflDJyHHDEjtK2gGYP/QS2m6VBlKotDXagxv0zNENg9tVya/vvyOevfse
         HAJzuLTi9HkofYOwkRV+TG7j3yGjRj8hbZqkB26/Jb+sjf2vluOFda8SSkdIqrigF1ri
         iph4l97ra117iWjppfYzY/EqaMG0Pjqnf8YqNqgdPEYODk2fLoPx824xw+QFMspILxnu
         ogWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BysOpIzocHTTKy0zsrOe6ngzD9Zx8K2KAtWoT01ykeU=;
        b=Bji/TKHLq9FbT0yYVpzzZLmmqsmjRk1OImrO1mTR5S+C+FSUlqY4IViVyJMbRSDbZx
         vEJwZuB0tE44JR88wWFC7l5L4XvRFmkzEHo++RkDAFkYftUTVKgNQ87MV7q7YquvG3Xx
         RI5f+UkkTbROfR5KfACop71B4upy/Kfp2Fe8g1fsaiCFCyrSOSyz3rldK2+lm5w0eKkx
         FhSerZ7Km1TdVOrp+jdqel72lCU1Zh8wUM0TV0Ro9GaR3QFKJPbFvdSFdUkkP2sVdGT5
         SIrgwQ2cL0Jb2kYVvWVjv/dLaJemK6e22+hnMcEVkug9gD8oQ16kCWZpM2g3aO4qfOcH
         H5iw==
X-Gm-Message-State: AA+aEWbIVCq+J3kGAeoXfEOZolVaZEXPqa/lgxAvgHa1SaRvmyxEJS3B
        27w42URZpkGMN0UksLWYPTsg+JELIuY=
X-Google-Smtp-Source: AFSGD/W1Bt0MsZ7qULUOrpE8My2MYmYavjYLo0YKBNx7EHiQKeTLnJCpD8MTsKFaO8AepF9yZhectw==
X-Received: by 2002:a1c:cbca:: with SMTP id b193mr15610200wmg.64.1544043639098;
        Wed, 05 Dec 2018 13:00:39 -0800 (PST)
Received: from peano (host93-127-dynamic.50-79-r.retail.telecomitalia.it. [79.50.127.93])
        by smtp.gmail.com with ESMTPSA id t70sm17182982wmd.36.2018.12.05.13.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 13:00:37 -0800 (PST)
Date:   Wed, 5 Dec 2018 22:00:34 +0100
From:   Sicilia Cristian <sicilia.cristian@gmail.com>
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: greybus: Added space between string
 concatenated
Message-ID: <20181205210034.GA24054@peano>
References: <cover.1543956271.git.sicilia.cristian@gmail.com>
 <5b215b50d4da9a7730450a83fb5e3a167b65e03a.1543956271.git.sicilia.cristian@gmail.com>
 <42632636-9b08-bd75-b789-88ef82f52c2c@nexus-software.ie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <42632636-9b08-bd75-b789-88ef82f52c2c@nexus-software.ie>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 10:12:24AM +0000, Bryan O'Donoghue wrote:
> On 04/12/2018 20:58, Cristian Sicilia wrote:
> >Some concatenated strings are now spaced.
> >
> >Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
> >---
> >  drivers/staging/greybus/loopback.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybu=
s/loopback.c
> >index 1085e06..acfa392 100644
> >--- a/drivers/staging/greybus/loopback.c
> >+++ b/drivers/staging/greybus/loopback.c
> >@@ -141,7 +141,7 @@ static ssize_t name##_##field##_show(struct device *=
dev,	\
> >  	/* Report 0 for min and max if no transfer successed */		\
> >  	if (!gb->requests_completed)					\
> >  		return sprintf(buf, "0\n");				\
> >-	return sprintf(buf, "%"#type"\n", gb->name.field);	\
> >+	return sprintf(buf, "%" #type "\n", gb->name.field);		\
> >  }									\
> >  static DEVICE_ATTR_RO(name##_##field)
> >@@ -176,7 +176,7 @@ static ssize_t field##_show(struct device *dev,				\
> >  			    char *buf)					\
> >  {									\
> >  	struct gb_loopback *gb =3D dev_get_drvdata(dev);			\
> >-	return sprintf(buf, "%"#type"\n", gb->field);			\
> >+	return sprintf(buf, "%" #type "\n", gb->field);			\
> >  }									\
> >  static ssize_t field##_store(struct device *dev,			\
> >  			    struct device_attribute *attr,		\
> >@@ -212,7 +212,7 @@ static ssize_t field##_show(struct device *dev,				\
> >  			    char *buf)					\
> >  {									\
> >  	struct gb_loopback *gb =3D dev_get_drvdata(dev);			\
> >-	return sprintf(buf, "%"#type"\n", gb->field);			\
> >+	return sprintf(buf, "%" #type "\n", gb->field);			\
> >  }									\
> >  static ssize_t field##_store(struct device *dev,			\
> >  			    struct device_attribute *attr,		\
> >
> Eh.
>=20
> But doesn't all of this add an extra two space to the resultant string ?
>=20
> Not what we want.

It doesn't change the result string, if I well understand the question your
doubt is if there are some space between % and type or between type and
end of line:

This (supposing type=3Du and field=3Dmin):
 return sprintf(buf, "%"#type"\n", gb->field);
Will expanded in this
 return sprintf(buf, "%""u""\n", gb->min);
That's is like:
 return sprintf(buf, "%u\n", gb->min);

This (supposing type=3Du and field=3Dmin):
return sprintf(buf, "%" #type "\n", gb->field);
Will expanded in this
 return sprintf(buf, "%" "u" "\n", gb->min);
That's is like:
 return sprintf(buf, "%u\n", gb->min);

>=20
> ---
> bod

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJcCDxuAAoJEAnJ2Lo5pAXyE7kQAI9hw/akm2KI6P37qIEWhcHe
H4dsIjB7/uMB79462NZ6dbgktuhRxCqWvXmfRHgHzV3khGmQ+PXH8kj5LoknTOOV
I8TpT/vPzxjQuXsDSesvXhLKYeRyCXIIKMFTVzpVnpl57qUQnZZieyixFpGn5Q91
k9iiZPjpLvcZaS4hltsG/makwSdLbzd6xHrnO9TUet8KErd8UCsHUczGpFFL6Awq
pCk9Yy+oImIVoRNklJciUF6qeZs4+gBHrEhCX2H36SPfCS2GnCec7ugv/WX4HDtQ
rHes5lx/f8PIsG7zkneay5f8Jgp0+WvnJzqZM/sQRLJDznEio66rdVs3oGl8YSyD
3zLRkvmS6q1aXZetKOStwqkF9ntb/l/FMPR9qjIPlL4KHdOfv45k6W3QnAADO66j
QTfYU++6cRZfuOsLEbfDDmZWB1Ik/UDKyDS4dU7mGnnmfrh1HyUdMjIVMmcL/BoR
WfbGoZOdsGlc4GC8V3JgilzkvRcRwHFshsR2gAGcp5vr9Ot/El69hm8ZzVKTgiKX
Ub4utnXit5hsUL9O8RiJHaLHw0V9Z5b/RKJYXQEG7m+HMiSQ1JiL6ZSsNqNqkSW5
+huP39+CnjHcleGMnkqXgNQdkq7QsBXwzsvbbBCa8mdycmCAaOPLPQb6Hwd7Lsg1
TK74teYQGQBt04DLkVn6
=mbVF
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
