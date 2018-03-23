Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1061450-1521802514-2-15106852732431467127
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
    t=1521802513; b=k16ufkln1JaG+yLNIJjBsmd88xpFWYP+fQq9/O6vmJVKPM+
    Dke/u0ZMy5AoqwGLMDn/2Xd1DgF8rFfC/uxYSa0B+aOFkVGhOONMC7kvxkz1iwiw
    NUcaPQs5eGqRwB68e9eIdMviT3ubw3IJHVVfashXdTwpcvZ9WwS+7inLrsCLk44W
    P0gBaPztikh03jw0mx8P/MmM44ZcNhqg7zTrfVE+PYGSOTPGTI7fkxD4lWVjL7+0
    LDu29SQIkIUFmn4YnrFZIqJvXy5Fo2HDAfUYquHQYSPH54SP+Q8m8lbafUdc96aT
    WjDeblb8w6iWabu6Doi8lMGi7B+aK6Y9ZH0Df8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521802513; bh=0M1AObNcwn1T0OoUNZYnovCnkA
    7g1dHlCR9cMbOtNhc=; b=qHtRiklLm8nq7oRmIaxRKiHkJIpFs0ySmG41BK9ry+
    VBJmadb/NP8snFH3lyr5j8y+6/OQMT1pNjFAfjEXH0pwFGXesP2iESMTWQeBVq6D
    sUTEejD2SUtaM2YR5gDAzCZc9qlsVuErR1csbqh8bfhetc86f0bPg4uWEHaBwvIg
    6t2T/EHLVWrTvuZg6bMmrg/pwcRgReJB4ATrK/jBRXunDJWgRd00yGyIgeLf/SnK
    pi38DBLlO2R2rWKvCOI+FPKMEu9W5H13xsHvtuR2JyFwavJt4afkzpu6lPrnfl0c
    SnYfDgJ43hA2/NPM+jeMw6kraSTZMSw3tPvZwFYQLPzA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1752288AbeCWKy7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:54:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54787 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeCWKy5 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 23 Mar 2018 06:54:57 -0400
Date: Fri, 23 Mar 2018 11:54:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dan Williams <dcbw@redhat.com>
Cc: Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Message-ID: <20180323105455.GB21644@amd>
References: <20180309023750.108942-1-tony@atomide.com>
 <20180322135553.GA27648@amd>
 <20180322164633.GF5799@atomide.com>
 <20180322192843.GA17189@amd>
 <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Do you have the related dts patches picked from next?
> > >=20
> > > fdd192037fce ("ARM: dts: omap4-droid4: Fix USB PHY port naming")
> > > e5b9fd7bdeb5 ("ARM: dts: omap4-droid4: Configure MDM6600 USB PHY")
> > >=20
> > > But yeah all you need to do is have phy-mapphone-mdm6600 and
> > > ohci-platform loaded and then ifconfig should show four wwan
> > > interfaces being added.
> >=20
> > ifconfig? I thought I should get /dev/ttyUSB0..3?
>=20
> I believe they are QMI via qmi_wwan, not TTYs.

Well, qmicli expects device path... and I see nothing on ifconfig. Any
idea how the device would be named?

But I believe it just does not work, see the qcserial experiment with
new_id below.

Best regards,
								Pavel
							=09
> > But qcserial driver does not bind to that. If I attempt to force it:
> >=20
> > root@devuan:/sys/bus/usb-serial/drivers/qcserial# lsusb
> > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > Bus 002 Device 002: ID 22b8:2a70 Motorola PCS
> > Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> > root@devuan:/sys/bus/usb-serial/drivers/qcserial# echo "22b8 2a70" >
> > new_id
> > [ 2059.267730] usb 2-1: unknown number of interfaces: 9
> > [ 2059.272949] usb 2-1: unknown number of interfaces: 9
> > [ 2059.278045] usb 2-1: unknown number of interfaces: 9
> > [ 2059.283233] usb 2-1: unknown number of interfaces: 9
> > [ 2059.288330] usb 2-1: unknown number of interfaces: 9
> > [ 2059.293457] usb 2-1: unknown number of interfaces: 9
> > [ 2059.298553] usb 2-1: unknown number of interfaces: 9
> > [ 2059.303680] usb 2-1: unknown number of interfaces: 9
> > [ 2059.308776] usb 2-1: unknown number of interfaces: 9
> >=20
> > I don't get anything useful. Do I need to boot android before booting
> > Linux or something? How does your lsusb look like?
> >=20
> > Thanks,
> > 								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq03P8ACgkQMOfwapXb+vJcvgCeP0bx8pM7K9J2CNFCx3PPxeCK
P6YAni1zNMq2ONQ/mltLRMv+NGKNx80r
=hW6w
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
