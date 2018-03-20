Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1923497-1521566779-2-2897455912184351253
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521566778; b=HCW7VfJiiuFVHmqaQh3wST8woMinUkg6ImC93sUXw8qOWGQ
    ktQ77wnRq57pgG9+7GnM3rPSmcLQhuU4oOpuqcS6mwYXX0gaXQiGc8uIcKJfoDFO
    ycj8lUCAoBvLx+cAHagonUwZ+/tGUI6MBMNbWFJctUfJddTxjX6e3R6wdwv8IIPE
    wvsdgg4gnXffZrhDyYBhSZ8M3xwBZJChfRfkyXIvcsR0wwW7gXjMqYeypc026v2W
    j3PQuWIiiWYKYGUC1OUREyqMEGEOfn1ODSRaTiLVk3jsk8JP2YmgOi9LpsRcVW3U
    sy5eNurUhuP6NJrMW0dYZFqvvWPtR0sTMqOouvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=arctest; t=1521566778; bh=oko4zAaudiS1UmypmQ6P0K+hnc
    HbZjS8T151BGMl8YA=; b=kHVz4NUiLILrD9ieiUBz+vV7eEwJcTBIfWl1R+jepF
    9U8fxxdHFb/fgqcCVMFFo46s87/7YwFGLVr4tcUOELNMHQGLZcUHZfTzRao9PzhI
    Iy2tc234d2piOpABK6yrtrYZmLQc85ulw8nDTstzRI2+ysWaql4jv3sChm72LcPh
    Q9L2lsXympNEa0oUqh8i3Egzbn77XS7GUaEpQ+NSruphjo+J9jZU7j2mgGUttoy1
    gQpkppMqoDNBlNiQFcfMgmhu9oZlNvBUCavTHz7naQ7Yj97p0wNl+0R/lWtg2g0+
    ftJSM/+Wa8DVrHz18E424fsFz910tCr9241o4xWZzwjQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeCTR0Q (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 13:26:16 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:59223 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751186AbeCTR0P (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 13:26:15 -0400
Message-ID: <1521566757.2495.208.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 00/76] 3.16.56-rc1 review
From: Ben Hutchings <ben@decadent.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        "Maciej W. Rozycki" <macro@mips.com>
Date: Tue, 20 Mar 2018 17:25:57 +0000
In-Reply-To: <20180312164512.GA9933@roeck-us.net>
References: <lsq.1520823971.5976735@decadent.org.uk>
         <20180312150053.GB3917@roeck-us.net> <20180312164512.GA9933@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-k3GGIAl9OaK+I1JxblmP"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-k3GGIAl9OaK+I1JxblmP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-03-12 at 09:45 -0700, Guenter Roeck wrote:
> On Mon, Mar 12, 2018 at 08:00:53AM -0700, Guenter Roeck wrote:
> > On Mon, Mar 12, 2018 at 03:06:11AM +0000, Ben Hutchings wrote:
> > > This is the start of the stable review cycle for the 3.16.56 release.
> > > There are 76 patches in this series, which will be posted as response=
s
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >=20
> > > Responses should be made by Wed Mar 14 12:00:00 UTC 2018.
> > > Anything received after that time might be too late.
> > >=20
> >=20
> > Build results:
> > 	total: 136 pass: 136 fail:0
> > Qemu test results:
> > 	total: 115 pass: 112 fail:3
> > Failed tests:
> > 	mipsel:24Kf:malta_defconfig:smp:rootfs
> > 	mipsel64:malta_defconfig:nosmp:rootfs
> > 	mipsel64:malta_defconfig:smp:rootfs
> >=20
> > The failures are due to newly added tests; the init process crashes.
> > v3.16 passes those tests, so the problem was introduced later.
> > I'll run a bisect later to see if I can find the culprit. If not,
> > I'll drop the new tests from this kernel version.
> >=20
>=20
> Turns out I did the bisect kalready. Attached. It does suggest that there
> may be a real problem.

Maciej W. Rozycki worked out that it depends on commit 27e28e8ec47a
("MIPS: Normalise code flow in the CpU exception handler") which I
mistakenly omitted.  I'll include that in the next update (3.16.57).

Ben.

--=20
Ben Hutchings
Time is nature's way of making sure that
everything doesn't happen at once.

--=-k3GGIAl9OaK+I1JxblmP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlqxRCUACgkQ57/I7JWG
EQlxYhAAwAJZuuvKkOLiuyid2xJnQp1nu0LOaoDbevJ4Znhqs8pdvJlGLjLM1JD3
7jd1sIB8Z4fb156beRVx31z8i0ijKtwV18Ce9rZG2iSeVtSFJ7eDFxSfGu0afNHT
5KACuwVLdNgeUe34liLb2QwLz/ZDR/f2P+1BXuAur4HtKOmQ1HGFHG5FKAzPMvKr
NhS/eoaCsZvrwqASc1PO10ovlP68i9Bo/x33tvsj8ngUu3lgjj+xGJZhLAX+hBqD
Ac+w4NuekE28V9wR7Xqg0XakVru4NvNycZ9Xf2egAAKuGaJuapOjFZI7LxP83DNa
Ej550zZ3TBVGKC80weMW8Q1r0KHtd4ghkRFhATC1tiSwe2G5wNv/Ja8UYCEBFIOg
nJowOzaFSSPkLYsfqMqlr803Mq3/TkhCRkt+3/znRTiAJO/KyNhLZPDWFJj/6HvM
Zad16GtGMSr9HjaDqY+fZtYZlDGMWmBAiuYaxGJpZcJ6fLnXAxsAvlbRZS73a7Nl
I1mqO/IT3sya5j9LeOiBXimfrjCbhPqPukaEI3sw6f1KtiSsEwUZJCjOTfUS4w3z
ODnFOLMdLwBzmdQi/AUU3/6q4y6Bwk5EvKmRBa/rQlZNEKjLTwlkxkCbVZ1398Wn
eRggM2F3Rzz7KKaaJY+r8q+TMzGvD9VYIT+P8wxIscpk97fJ5oU=
=9dqV
-----END PGP SIGNATURE-----

--=-k3GGIAl9OaK+I1JxblmP--
