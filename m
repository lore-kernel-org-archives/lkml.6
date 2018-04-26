Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2417162-1524740087-2-7417078644327304456
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_TVD_MIME_EPI 0.01, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524740087; b=g+uhE1LNrJI+U8HoUoiIrIwL05lvz/HAIp8ev97xYe6ANLe/91
    jsQApix+AR+nrqMNanhOotHtw4LWPREFeSEFPvhI84sft6OcYunumnB4RLt5zGp7
    RxB7anbaQaQLd5KTgfb7es+ZQdNXZ8nRaHMfElReYD/W2yPPF1IsO6HjYUkDk4wQ
    rPdwJUqFli3bwYD5482qzaw9hTGmMoSHZNdqektVUGCIMWdWSyiJwQ9bugYadkjL
    y0jsfKnwHEFXoOj6OzaCiasPM59jev9G4eyX/ddQ7R8x8aECcl2ShHYQpi9se2Id
    SN4yITH8z+4kPsqa0ATfDG40/BV1anuz6vUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524740087; bh=w0TM6+71w/JMgC+EyctX7q+U5/MKcp
    H5uRzZ5+VIhN0=; b=hu/LWniY09aeSocLdpL4ojbUcglhA2L4xbSdB2Vxnn4iUh
    bN8PVSUxTrfzk8FI8iJ13V45IGk71OXK20rmFmdKXUBY5kf3Dm3GZ8WtdsvAzvzv
    Uj+Ekcr9SM2CLASV2hpe/B+wveiZt4MDyGv89nCS79W5SsFJ6/wHE5jtuFY8HaO3
    gNADt9kxDbaduIAKgIocylVeDvq6sKJPjykF5VLhS1QpcxzvtO2p1J3I4AfjvtGN
    8Zo0YbJ1QHTc+XUYHIZkvN/P5sazCyzzqvfUn2e2cxuUh0LZICbjW1+tGnB/GqIx
    Xyfk7/cI1A9/bQR7O7rkh3o1kjdRM5YbcvvVUSJA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA6PJsa2eC44lw/Ezl2D6fXgn3hjVfwuuSuTIUxkTpdA+PqtjgXB1vY72pHeTaoW3YTQNg3mfD9Ah/PAs+6CFfZP3+RgoMPfWbTo2iXU8cuSNkISdcd6
    OoxJgnyPn4e78ofm/F5yRx5iTuXi1Hy9NjGjWPKFk/M9PrUGKNdIqbzAc0UII47bgX0qRZeZEzXS470DiaMXSzdMqctEM7BMehK6OKHDnlp9w5Re0wqpsvu4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=gvl4HP8tAAAA:8
    a=ppAfqJejCxitmuOOGrcA:9 a=CjuIK1q_8ugA:10 a=6RYOFZuqM6K_toELEoEA:9
    a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8 a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10
    a=tRkgsvjveJ3YVe9fnr1q:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754661AbeDZKyc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 06:54:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754081AbeDZKyb (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 26 Apr 2018 06:54:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07860214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Thu, 26 Apr 2018 12:54:27 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH v8 0/6] typec: tcpm: Add sink side support for PPS
Message-ID: <20180426105427.kewn6s4kmnzuwtn6@earth.universe>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
 <20180424135749.GA21610@kroah.com>
 <20180424232633.s475bsccxjhm7lpy@earth.universe>
 <20180425123045.GA22950@kroah.com>
 <20180426073326.GA12261@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7loneb5mrk3j6aec"
Content-Disposition: inline
In-Reply-To: <20180426073326.GA12261@kroah.com>
User-Agent: NeoMutt/20180323
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--7loneb5mrk3j6aec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 26, 2018 at 09:33:26AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 25, 2018 at 02:30:45PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 25, 2018 at 01:26:33AM +0200, Sebastian Reichel wrote:
> > > Hi Greg,
> > >=20
> > > On Tue, Apr 24, 2018 at 03:57:49PM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Apr 23, 2018 at 03:10:55PM +0100, Adam Thomson wrote:
> > > > > This patch set adds sink side support for the PPS feature introdu=
ced in the
> > > > > USB PD 3.0 specification.
> > > > >=20
> > > > > The source PPS supply is represented using the Power Supply frame=
work to provide
> > > > > access and control APIs for dealing with it's operating voltage a=
nd current,
> > > > > and switching between a standard PDO and PPS APDO operation. Duri=
ng standard PDO
> > > > > operation the voltage and current is read-only, but for APDO PPS =
these are
> > > > > writable as well to allow for control.
> > > > >=20
> > > > > It should be noted that the keepalive for PPS is not handled with=
in TCPM. The
> > > > > expectation is that the external user will be required to ensure =
re-requests
> > > > > occur regularly to ensure PPS remains and the source does not har=
d reset.
> > > >=20
> > > > Sebastian, any objection from me taking this series through my USB =
tree?
> > >=20
> > > I currently have the power-supply bits in a local branch for
> > > testing. I would like to have this in the power-supply
> > > tree, since there is at least one pending driver which could
> > > directly use the newly introduced usb_type.
> > >=20
> > > I can either provide an immutable branch with a signed tag, or
> > > you can merged it and provide me an immutable branch.
> > >=20
> > > If you merge it via the USB tree patch 2-4 are
> > >=20
> > > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >=20
> > I've applied these to a testing branch in my usb tree, and if they
> > survive the 0-day bot, I'll move them to a branch that you can pull from
> > that will not change.
> >=20
> > Oh, I had to add a follow-on patch to fix up a gcc warning that really
> > wasn't a warning, but it saves us problems of people complaining about
> > it.
>=20
> All looks good now.
>=20
> Here's the signed tag you can pull from, with the full information of
> all of the other USB patches that you are going to be getting here
> (sorry about that).

Thanks, merged.

-- Sebastian

--7loneb5mrk3j6aec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrhr+EACgkQ2O7X88g7
+po0nxAAh5JHbqs4WFnbr0TSQH+y/cBcOFv9SHvCPekhiK93DEujAhF4WvqjYAMW
3LukRNDJd/D7UtcBTHJqDsP6p2AXCPCZ+AuX2Qt95fniOQUEKXH6sC9MakAYQU4G
+3CVzrx4K8Q1voXAn4N6RT9Y2BEEs3Ma74h25gZuQe4e1Ms0pvMRcPbqTmwCE0Du
ZGLIUQtaXhebkHNkxglAekbW2Lw2rGztwLoA+q+TATZG4bGWOCqHEgbGnnysiMee
yW5YJ9D16+zzolM02QF8Th29T2Qa0gGMpLUZc6D/npG0Elhdd3v+xF0ZrUY6Zcsb
GBmAXlcbwsINSItSXm0a9P+S1CqFAgawGJWpL84x8yCgH/rFxRy6p9Em5r1ESlzC
C5GIhaC1UMqdS37dL/CE9RjQdWhYbKfo6E2xePICBgUo3EciihmgD7psdFp38dN1
Po/W/U5gPa78AM/Uj2r7fmzll+zVp0foaOsdZs29apLfQFNEyG51J8lfrxenpsTs
3m/ZxeZoT9nMni3ZxuhhhPfvnyTa5XnDKa/QG9A3SnzIrkE4BHWbwsI8ny9VVlys
J5jwT/we0FuZ2/WtfIJ/7gskALBng7DFvLTIxWAdZ+tpDd4UXtr0/KGJGAh5yeAT
B7IcJf8Ct3o+3+rPahiXTcJ40Z5c0UB+Wqa3SiPaGekmgYT+kqM=
=+2Tj
-----END PGP SIGNATURE-----

--7loneb5mrk3j6aec--
