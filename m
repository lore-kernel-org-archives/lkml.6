Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3658833-1522018566-2-15018339251449636833
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522018566; b=BR1nkZ+hEOGrssrVfoAQ0w6cM0jRhskw9rvVNLhqQv6rP9a
    56zO+PE6c5SEq0dJCsB+9Df2h62hkU/qKr9FPVrRkS9jcPvU3n6xNMTbKPJYhdmJ
    j8uc2bN0h1TgFxqCVXFxaFNVdYlr4bVGqZYH9PQGzz+SZ0ZFyDnfX0fu512bUq3e
    ez9zhaIXIOsYqP/vNU9yUqV3Grw8caga5M6LhZrYMjdm/uIpCa+O9lN0nEjtA7gx
    8ZmeSXMU0tepQV12aSdjfy3fg9tPmGzT+YPSOk4Aq00BZKe9IxkNG3lSNJTRwdM7
    tNtAwtOcccb+HqYcKLFtgxYn85tT+yptIf/24wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522018566; bh=8wBuO5IGHs2gf9vYT6X8CqipgY
    WbEYRqsAKkzNFaGJo=; b=OVyATwY8LfG1lRusHuWepP/EFH7YftJOR7OvOSnNki
    MX5VcNAvNjAktCOOV11ujRpNNnQFVp9d292E3/skohBn1OSxBnNS9KEvL/ohwHKF
    w2poyEGee/sPzHyOk58sjSoZBTi1MBnohaUvKoj/wliLkgc85VDT+wpD7O5fFLuN
    gDChynqCwztRoYk491g04AZLueU7GpHrUPpPy7ykZ356d+ovQV58NfqugIh+Av+y
    t6Wrap9nGUn+GePli6vrsSDH7ryzKLH+We05YecaOAS6FWnYJWM9/a6nPDMLaEqs
    t/06NUf8BUIIalp5pqDo67U5aPEIugNCffKQKrvM44kQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeCYW4A (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Mar 2018 18:56:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49190 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeCYWz6 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 25 Mar 2018 18:55:58 -0400
Date: Mon, 26 Mar 2018 00:55:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Dan Williams <dcbw@redhat.com>, Sebastian Reichel <sre@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Message-ID: <20180325225556.GA18141@amd>
References: <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
 <20180323105455.GB21644@amd>
 <20180323113521.45va72bhzis6ym6m@earth.universe>
 <20180323201343.GC23658@amd>
 <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
 <20180324142517.GA94954@atomide.com>
 <20180324200224.GA17857@amd>
 <20180325154512.GC5700@atomide.com>
 <20180325185857.GA7582@amd>
 <20180325205232.GD5700@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20180325205232.GD5700@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Hmm. Interesting. Anyway, for me ttyUSB4 is interesting, as it seems
> > > > to react to AT commands, and in particular reacts to ADT123; (; is
> > > > important).
> > >=20
> > > Is that to dial a voice call?
> >=20
> > Yes. And it is ATD123; not ATD.
>=20
> Strange, no semicolon is needed when using /dev/gsmtty to
> dial a voice call with my current pile of pending changes,
> just doing ATD123 dials..

Interesting. Maybe I made some mistake in experiment.

> Anyways, looks like qmi_wwan needs to be loaded before
> qcserial module, otherwise we get nine ttyUSB instances
> and ModemManager can't find any modems.
>=20
> With qcserial module loaded after qmi_wwan, it still takes
> a long time for ModemManager to find the modem.
>=20
> Then unrelated to the qcserial module, also looks like I can
> no longer use the GPS with ModemManager:
>=20
> $ mmcli -m 0 --enable
> $ mmcli -m 0 --location-enable-gps-raw
>=20
> And then chmod a+r /dev/cdc-wdm0 and pointing gpsd to use
> /dev/cdc-wdm0 used to work, but now it seems that gpsd
> can no longer read it. Trying to start gpsd manually produces:

Thanks for hints, it would not be bad to get gps working. But .. voice
calls. Those are important :-).

> # gpsd -b -n -N /dev/cdc-wdm0
> gpsd:ERROR: SER: /dev/cdc-wdm0 already opened by another process
> gpsd:ERROR: initial GPS device /dev/cdc-wdm0 open failed
> gpsd:ERROR: can't run with neither control socket nor devices open
>=20
> And lsof shows /usr/libexec/qmi-proxy having it open.
>=20
> Anybody know what I might be doing wrong? Sounds like something
> now needs to be done with qmi-proxy to get access to GPS?

Maybe kill the proxy and then look at cdc-wdm0 by hand? NMEA can be
parsed by hand... quite easily.

Good night,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq4KPwACgkQMOfwapXb+vLlXQCfW69Yooxx1KfGR/ikR+B4U4Rr
KHAAnjdk+rTRZRKE4r7qSkPmUV9MZpI8
=U8HG
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
