Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2656133-1521855265-2-5521421352944727944
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521855264; b=Jue3xUc6b7bzL6DMoujLhcinKV+R4JyCAkoDcDt6rocdr5s
    iZN89w8a1MbUmTEI45Xx7yUMTpAZKEzTudU6gz4u/RBvA9j7CEAhzy/t0f8w0+sR
    lT2UyUJBd7bz6y9T0OfM8QlNs2ewGhzJcFCbNJFwEQI3KqlrQhbTdp8pI/EvyQlG
    HFYTU7NolB7F/LkuzhtTN5wMqfgt680ok1K8m8oOBN0Ejr8VMEJt63VyA3TDaQlO
    hB3SMLDT1rheQj/3O6XwW+9xNTlcElZ5v0UalRyt4lmwPxtteS35GsTCmnBFLBux
    SSVhmuEqya35SGSiB+3eEuBKEBS+LlLhvRTCMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521855264; bh=p3OJMii8L9Rvfjvinaav7zGkKR
    dTsyrCZujh0BIjQFg=; b=wVdQ5Kzben9g3Oo1XdfKeSi3vb/kEaP1s3XUhjaWOw
    vKTiUfAwX4oCEiwtcnHOKosOBigHk/fD5P8FSNd1kZZh+v/4Atx0k2wgEMX3QmM9
    7le9RSkCae55fBOSOk51+EUxt2iy4Bj8+wG80qWZTUp5emP9Xx9phJyxHrLiEKYr
    Bdhqe5ZM2+HVdGG4yZBUAS0uheQpAWr1XpCFCx7htHSqYvlW/zPmK+NAT62TEhZV
    vxcSJph0j44q3aL4km0JVpjxl+YN0SxkcwQsq+991NGgdpFLNFSRVzyK6xwaEiPe
    yIgQzINSjF4E+x5hLgg+eRhAUV1x/HGZNPRiSjhY6Jew==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=RSEYS2Nw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DCEDZSLH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=spam score=140 state=1
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=RSEYS2Nw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DCEDZSLH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=spam score=140 state=1
X-ME-VSCategory: spam
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeCXBeL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 21:34:11 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39191 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbeCXBeJ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 23 Mar 2018 21:34:09 -0400
X-Google-Smtp-Source: AG47ELsK83W6Pu4k7Iue+Jy3nyoJ+jevRudBTS7Yn+o9NymghP9TeP3lxAHluveVYWRrXQDv6WvG/A==
Date: Fri, 23 Mar 2018 18:34:05 -0700
From: Benson Leung <bleung@chromium.org>
To: Andrew Chant <achant@google.com>
Cc: Benson Leung <bleung@chromium.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        bleung@google.com
Subject: Re: [PATCH] USB: announce bcdDevice as well as idVendor, idProduct.
Message-ID: <20180324013405.GA230543@decatoncale.mtv.corp.google.com>
References: <20180324003330.180726-1-bleung@chromium.org>
 <CANVWZtHTuU-_zjvj8gjXXA-2VUU2zxsu=afcqZC8Oen_bFmk6A@mail.gmail.com>
 <CANVWZtGS9x-zLAgtV0rkgnBR0kLHTT0LYjKEreNy6qjkcC75PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <CANVWZtGS9x-zLAgtV0rkgnBR0kLHTT0LYjKEreNy6qjkcC75PA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2018 at 06:08:07PM -0700, Andrew Chant wrote:
> >> +                "New USB device found, idVendor=3D%04x, idProduct=3D%=
04x, bcdDevice=3D%04x\n",
> > Can you please decode bcdDevice into a decimal string?
> >
> > lsusb -v does this (bcdDevice: 0.03 for example) and in my experience
> > it has generally matched up with how hardware manufacturers refer
> > to their firmware.
>=20
> Nevermind, %x should show bcd properly.  looks fine.

I like the way lsusb -v does it better. Take a look at v2.

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlq1qw0ACgkQHwn1ewov
5ljayxAAqnXJ3JAqzsr/FRzoT9h9mnKR8Z6DDbb32Vm63J2+UITtvNfzxAPsmf2X
tfpiCo9nmg2tZB9LuCpPNdfAEdk5NIulPwcKf/xo2smakBWhM/mF+hQ3mjB1BkB4
dZBHihMsk7e5vAdAuAoDyfdxhEjaGPi+fBsc9+4TMEZKanuq/UYBma6aZ/ljJStQ
Ujc16UxXnh+oKwhW5NEW3SGKBUtqRhuLh19/6ZNmcpJTT37/ewUGvoJc+1VNo9mC
HWDJk4uykQ/c13ctIkULsMU3JSLcxYhQfMzyV+aw4HQg0t94MbWWRgGqJu63QQeV
BDH1Sa1dpowGepy4ZX4aUFYLbwSdDPNGODlemhDpPMTSXheNN0a4lTOgY54EXZP8
ncn3uInBM+QpRgOCF+cEupLeFVEyYQSbxOhV+c5l+AkiHrYjUaN8o9qH7SfES24K
qmGGSEOqXBwFjbhzxhZtdI2RG1tWEY17d1naJJZ81gKKkImQsWD2MXFpQUFsvPgb
GDBhsGiHy4w/k+v/0+d9MsRMtCYuHMkUMw5slJ/8063SGgViTlSPGS9ot9NRJWcj
IQT3Y4CF7VfLW9dehIw7eOI2rT4Y0nU6SHdseOnxx7ksfSRXllqjqndITos0lsFS
tcXKAPMEwqu5m+KoPqx2LaLIB532XIR0/+u+7BSoGtla4ixcU/c=
=nRSr
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
