Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8413C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFB72086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="kp+PSyHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFB72086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbeIYSD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:03:57 -0400
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:54204 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeIYSD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:03:56 -0400
X-Greylist: delayed 1276 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Sep 2018 14:03:54 EDT
Received: from [129.217.43.49] (limnos.cs.uni-dortmund.de [129.217.43.49])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.0.29/8.16.0.29) with ESMTPSA id w8PBZTCW014506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 Sep 2018 13:35:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1537875330;
        bh=5gckrvGmOSp1fmzymczdnp/pKK8sewgPd7jlDPowcUw=;
        h=To:Cc:From:Subject:Date;
        b=kp+PSyHk5So8QKP+RJgLvt4Vj1da+xaZMEwCVgnWe1uUUnf37j5/Wm2pu3RCscIAr
         HsmzyjV6Nl1p7fKTADOmRK0G18xB2eP0jvTufL4hMTUB12QiG45goVgYpCJo7OOm88
         +KfS6Tz2lWB5QtEe4TShyt5AYfhI4CtfNVx6lGHk=
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Openpgp: preference=signencrypt
Autocrypt: addr=alexander.lochmann@tu-dortmund.de; prefer-encrypt=mutual;
 keydata=
 xsFNBFQIyUEBEADZ+x+Ssg/46SiU66zm2lPGYAdqYfmXVv+sf/23+/KSj0FQHZKywzWjsmgR
 vWZZVlGJolwcW3MJ/g6ctZeOpfYiZVpzbZwNgKU0ETGjUmqmlq5/o5KnENKOimZzaKSaNn9p
 IC+EIeWXvu7pQjW0w1bK/RVVNw0p1Iz82W4Z+vKtD8CS+YJLAcZ6YoZMvQEg84O9odlV2Ryp
 oVj9EzHH40TWEdtgd4pQkaOks01PEr19sJXUjnP0VxLfs91AZjRnmGJKnI4HcrOKwquoQEeL
 DtHCxK0VNeoXCWkz33uBxSL5cicQ7D09hxjWthMilUpDZT94x0K452q4nybQ1TSLTYC8mlW+
 xKUvJmqfHZbITJ10dTgjNvOe0kLbpXeQ1789lNmnA9bkQAK5Cefo55WbXmr1Mo3PV7y0XCib
 OaiijPlZo/Isc03EOK3lHPK8NuY8G+ftvphO4RyXCUWXw/o01cDnPaIEcTWkUbXvMhf/6ltP
 1QWEfkguzGVjTw7Xssm9YuokC+P+49JKRyZzyCJZ022OxMlsX6c1BNZ4+cWUNmn6xr1xRNse
 SglpMLL1m3K1KuLf1hdAor6PBzFLiLa33lUhsWtg1ACFhpfZZOQRVas2McXTYUUpmCzOYI5F
 +km5q6cZStr9m7O3Y3DDGotiaJDpLtATwZ4MIM4ADbg/xl6ZgwARAQABzS9BbGV4YW5kZXIg
 TG9jaG1hbm4gPGluZm9AYWxleGFuZGVyLWxvY2htYW5uLmRlPsLBfQQTAQgAJwUCV9SHSwIb
 IwUJCWYBgAULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRBZPu0FvD72/eZIEACxnxqYkDaE
 qI0jn/OJBde6t1uPeOytoWN8aRQVI0eZAkBfnDmF1qQF8p8eeaEu7ouhr8PQpBHDU8VNIlyg
 WhVcB9I/oXltFQZUHhUEFDd9xtXtjWPqGke4+ukiTiBUoLNSjejo6lGRqkXWklQbFG+jBd7w
 DEl6ad321QyPeXTOcO1YXeHoSGIYyCdObNBy1UV/r170H6a9H/AJxQWPifAwAairUA3bNVLt
 HSU7YFhon0OtJQy2CPhDHYkxIZEoNXZht934rTWuGHISGZ2MspMaupNromyoIMhLDK63Cz3n
 QfT9sjW+3u0ZoSAPz8bFLCALpPPtMRpMonOod3O1INQ9jQBLM690+eQRhkAIJQSX98S1ckNu
 ZK/bIV52piCkU48lYCLBOrtJ3mO4+SdIga+ZA/ArM3VBVt2NoVmi84+bJhmjYhVMEN73VmAc
 /xqGbhT8LQgjElE2YgQK9/e/J/Kxq1xvFW1pTg39CHNcGYcGbWOiz/kzcCbWFoen2yIr9cC0
 jvvHK39NvF14jI5xmiUPGPCBGXqPxlKMiZeBPzvweyKRkAYbQmeqUiI5o7nwyzPRgQBsYLKG
 0R8MbzbgOxSFbf+GVwCY4855r81fjokXNE1DRvKeg1TyNF7T812zfPAEKX8va45emHhwU8cy
 cchUdfOe9paUy8Ewr1LBDnh7q87BTQRUCMlBARAAnCFuEZ8V7Xh7/x5eP5fdurKMzgi/IsE/
 zg/ULy99e9WNTA1/G7fC53jKIeURuEnoLXVWgOIy5Hb/AU5kW2O6ma8yY2CV+D1Mr5rmW6qW
 vjxdXObqlHLocKV5UALqS9XQoDuadcW3QsRDgfS5vtoVBSctS7L4ncIniXRakZdPWvyMqSra
 ssCcWurEiafWTzwjzCZycSFcxqgMB1jvOC3yF+SOgUVG6gIcZYyZuNAZO/c/jx3crQ9Emk7l
 iIbFWERXISi8am16JFISWlrqRNb+MRXtkqrcvb0gqyWTEWUUy754EcWyVRyCSbCuvORzUt0C
 UqxbapfkhjJDx6V/dvmQpskx+gwEN2NDLYyU3KGCrt3yPCk/QUrC7rl1E6F+2JeEWxQebNK8
 GdlzMHiiXZMMqQuX0mZi7RMIIpjEOFXwQVDyQrx4Zrzhyl91pbPfQ+8WFj+y64op5o23bomj
 vwPmy4wHS6qhiaY0O098/r6sc6dyGnidzm0p55z6aXClQH+qmaruWH3N9avzmJ9fVshiIcCt
 zLrlZo2rcTJhoJEsc4E0z94xUNNPKspj3IK74DkfjBAgiKV4zjH3pzoYbCp4bhe4cVEv+ibW
 CrBDBMCV1TedPbDYSYhM0mPavlWJ/SAKx0gTJqYuZel7yNYsDw/R0Tbq7D8SlZX4vJULAu88
 bk0AEQEAAcLBZQQYAQIADwUCVAjJQQIbDAUJCWYBgAAKCRBZPu0FvD72/RJJD/9i8hlljqEw
 BgYc74ComM2q0t1kDWQrhR0nwf114OEkUl9zbMRlWVnS71VYM1qNfrQtUJOsDiFUEksNtMEF
 3vG6GfMogfHjOKIX0tJckjvYDpEC2C4o1oNySGME26sitl/C6WwrO3lE1zPTTuqZlbaHNywQ
 SF0BJV/Iq9AWWdfTgkgqJ05MlR2CuiGxCddT8YyRuWUu2pyOBULdJrs8pGa4ZG5n+SFdw7Sf
 ylH4UI5yWtgfyqE+xer6UwqMj7WgVB0FxAG9jWmVcBdOll7Kn1+MpXsptyZX8UX2uPgTieBn
 9hBXd8GArCG997pWlwS1mvMNwPxXUElvTQTOImJT8UYPuXl5/qGo6ciqjy3rR1kTTDeDUh1U
 qbviUakZUwztxwp/6XkNDgfyGn9xzdwy2XW47WWONMZdYkfUzIA9n59jJQBct3Uin43ggEGD
 /XGp9TIHmxO9vTCO0Ibc7lGHR8voiTvxDTZUoBaOQy8EarLBBqlmoNMVj4HJ4lABESE08xyX
 nr0nmYeU4R8g9e9z8J/rSIUeGyuURcv4J88Kh3JJfB8O6NOpudciOHVFXmrTU5gIja5lt4kJ
 73oYy2TmFzl8eKL7Fnb0J9NXVKN4Al3RFkOckCzkERkwnK6tYcwhHf/74svaE7KTa3GSX9aW
 6NxCpAsFDwJbauda2prWMzruCg==
Subject: [x86] BUG()/BUG_ON() macros cannot be disabled
Message-ID: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
Date:   Tue, 25 Sep 2018 13:35:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="beyh2CM9IKZjJUog9ZIi56j5rFrMc4SBz"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--beyh2CM9IKZjJUog9ZIi56j5rFrMc4SBz
Content-Type: multipart/mixed; boundary="ykzM58qJSbQVMj6jyweAtzezWrFi9csp4";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: arnd@arndb.de
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
Subject: [x86] BUG()/BUG_ON() macros cannot be disabled

--ykzM58qJSbQVMj6jyweAtzezWrFi9csp4
Content-Type: multipart/mixed;
 boundary="------------5E0CA33CC47A8D6B0687C66A"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------5E0CA33CC47A8D6B0687C66A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

I recently tried to disable the BUG macros on x86-32. I disabled the
config item in 'General Setup -> Configure standard kernel features
(expert users) -> BUG() support'.
However, BUG/BUG_ON is still defined. In the !CONFIG_BUG branch in
include/asm-generic/bug.h (line 181) the code checks for the existence
of architecture-specific variants of those macros.
Since x86 defines its own version of BUG(), line 182 is *not* used.
In the following, the x86 variant of BUG() is then used to define the
BUG_ON() macro.

I propose a patch that really disables both macros if the developer
wants it.
It undefines the respective x86 variants, and defines both macros as
'empty' macros.

Regards,
Alex

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al

--------------5E0CA33CC47A8D6B0687C66A
Content-Type: text/x-patch;
 name="disable-bug-macro.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="disable-bug-macro.patch"

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 20561a60db9c..1e7977582277 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -178,14 +178,17 @@ void __warn(const char *file, int line, void *calle=
r, unsigned taint,
 })
=20
 #else /* !CONFIG_BUG */
-#ifndef HAVE_ARCH_BUG
-#define BUG() do {} while (1)
+#ifdef HAVE_ARCH_BUG
+#undef BUG
 #endif
=20
-#ifndef HAVE_ARCH_BUG_ON
-#define BUG_ON(condition) do { if (condition) BUG(); } while (0)
+#ifdef HAVE_ARCH_BUG_ON
+#undef BUG_ON
 #endif
=20
+#define BUG_ON(condition) do { if (condition) BUG(); } while (0)
+#define BUG() do {} while (1)
+
 #ifndef HAVE_ARCH_WARN_ON
 #define WARN_ON(condition) ({						\
 	int __ret_warn_on =3D !!(condition);				\

--------------5E0CA33CC47A8D6B0687C66A--

--ykzM58qJSbQVMj6jyweAtzezWrFi9csp4--

--beyh2CM9IKZjJUog9ZIi56j5rFrMc4SBz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAluqHYEACgkQWT7tBbw+
9v0zChAAliYhce/UyYMlH6hVIcK8eoehFisYKEz8wK5Rd8VGWxsXMTvVVeWaj/j2
q+Gu+ixJvdZHqlgOYDvce6arXBDKQXS4Yzf975gXAlk170+UVREBrREpihaKOsFk
1bvAZ9cUTLI1Btc/VyNS98Pd83XOBzyas7PNDsppKlPG/Z4fJAWRWHr9C8nJm+Vt
lSBL6I7E2ytbBHNQLLMSeo/W5z3VMfvAHEMdaGp9PG0A90UQEAu1OyR8OgwzjJYd
XRxuYSXUk/C5oT8syuIEOoUdpW7HPoTNeRQBzwcThgsj39N+f1hgPrw2SB3iqdr+
iy9vMAJfsQvImk1OQ7vYk7+HO0sDhjccF71M/G8tSN6m0kzWm7bsya+xk5dA659C
Mldev/vYT84tLR1GMjaMbNb1YubNIDPXHhUgVfojT589e0FswuEvBpdt+mUCrJ1i
68dnpEm2NStc94oq/jya8pw3MNQofJc9MkDoiDMZZW1jcKx1R4XPZDrj/IKTsTiw
Z+lXNkrk/w97beu7h8vBB9VcGSxZQaNaWoDMvg92m5R9Ad/GeVBGnwHTQ5YoDQUQ
l3SpJUFXsJ1Ii6nhAxRW1OCoHNEXzuh9fBJZ2vd0vBOGAD/3Cs3kQDOf7SctF28/
VdcjlS9v6vs0i5PpF1DAtAdqX2YRRrLGvI4tF2vT8u7RxcF0U9A=
=2Kut
-----END PGP SIGNATURE-----

--beyh2CM9IKZjJUog9ZIi56j5rFrMc4SBz--
