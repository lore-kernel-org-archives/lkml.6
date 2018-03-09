Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-186549-1520588701-2-17484572113977100488
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
    t=1520588701; b=WyHKNyNE0U7N+lcwMvgEpsiCpJBWAvHniieCginfdGxUKz9
    pqUlEsabd2i9tXK36akGTw7sR0FsfNbTLJ8GEqDYur4OUaza6gWLeAW424DFHoO7
    xgD39YVTIJHlC66ELOX00qZObpb8teiOMvVjB9cETiCF6KyjMvimmJu2CTe8ySsj
    Utm51BxeaKHigGiSiOI66gOXODauslYN7cFNzNasYkp07PxdlVFeyNhgXQSYPebn
    3ybKHiVUA1JXhx822LZ3rU4LN20Q419HnQIvcK7mZKXEgZw+lmcFFdho8lldZ32z
    9+xkkWoTa1YAPajV9deymrk2/sYnB1gGBTnHCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520588701; bh=41m6/J+yKx/BRoj7aM99buXVWq
    s+FxwjkRanobFmOwI=; b=E66qboBkq76jtk3q1XL9PXo/bnBpFXBE6Q3MlVzLe7
    cIj7x7lFozdz9LNrW/ELGbMvmSDUkMfklIQcyPL6U28C6dGOVcy9PrGNIKO8I0Vo
    neMh7az3+mKsC1J3ykkTW+cniorQ/wxdbHYzpbntOmto/wYq4TXh23lro46aU62b
    vI0LIsV++LMZGbsAa8ls/E4f+RMp2UIGKelNe6QGs3Muq08VIYg7a6BD9tajbCBS
    1By0pl9zG70XFKgCe1t8401ELEQO66nMGkthsVM/gMOiAe9bt6SsGYOJROAsT9c8
    6e4ucH19pukzz0uVHYK02eIU8dNsu9dC3Vjwpr79qAZQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=spam score=199 state=1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=spam score=199 state=1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750907AbeCIJor (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 04:44:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34239 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeCIJoq (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 9 Mar 2018 04:44:46 -0500
Date: Fri, 9 Mar 2018 10:44:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Message-ID: <20180309094417.GA5970@amd>
References: <20180309023750.108942-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20180309023750.108942-1-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Let's add support for the GPIO controlled USB PHY on the MDM6600 modem.
> It is used on some Motorola Mapphone series of phones and tablets such
> as Droid 4.
=2E..
> So it seems that MDM6600 is currently not yet idling even with it's
> radio turned off, but that's something that is beyond the control of
> this USB PHY driver. This patch does get us to the point where modem
> data and GPS are usable with libqmi and ModemManager for example.
> Voice calls need more audio driver work.

Thanks for the good work. Looks like I'll need to get droid
4... fortunately it is not available in czech republic so I don't get
excuse to get another toy.

Oh.. no. It is available in Czech republic. Is Motorola Droid 4 XT894
the right one? Hmm, and LTE modem is useless in Europe, while the GSM
one does not work, right?

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqiV3EACgkQMOfwapXb+vJWGgCeMrjB8AWDMCJrtuyMHoVPf082
g+AAnR6pEWfuVoBDuFqtYDwn2yOzK56r
=GM3i
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
