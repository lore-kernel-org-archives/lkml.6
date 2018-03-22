Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3127530-1521737215-5-13306769227123057038
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521737214; b=ocOGFVeAaTikAqyFBMz3MZkEs1px30nfl3jWYOW/tKDUmtn
    GxGNDRFyNkpJNJmbp27WWRbMQgpPQjAr1+ch6YMk/uBJINk+U2wumnLj2RIOvpdv
    BI5nH4LLvEK6960hTRXhlmCfR1jHVIrI+l+gFOhBmSql3c8ZoWd3WYiaxp3r6Zr2
    yDWekXVWT1WA7VkqlLGZdmC6of1Njw6J4TIesuSfHb8aK0TyMbH5PQuU146XvY6s
    DZBgKIMidBRaue42kz9t6AfsZx0qEfMXhimGe6ZY+RXiqtg6ThNiZUjFtiwJBw16
    BEqbQ6Wu+Nz9m3uSzZYw+9IsUJ7f0Fx5Y/jRGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521737214; bh=LdBJ8ZYENymlpQQdvcWd62iNDN
    x1EAi/9SeacHBJpjU=; b=qGxQ5Iq9GN1bIu7wwq2iUaAfPkYNhuueJlDDwaZYOt
    5ITkfX0xp5EZHMENJWJ6J2Oz08THSwtOBG49ddqybwVHNGB5ck4Fh1IFmL73iQpm
    t7EVwQmdGysd/zcYHQHNqrA9ot3MuCwpK1c+WlIsJAx7xxma2pKlhMANQljf1yOP
    +3xQ877ztJqrneCeGFDLCpbBbWfhkRksc6oajJVLnxa5RXB9SbWMnEaGobmJXqgk
    sNSm726M46a9xyI/tt7R34HhCKzFyvkmbEmbwY3S+dMDEulqxcQcm6uMbkAfhp/9
    Nq4r8SnHPdDW3Mkzz0PxIUOt6kphORodn5EfcYC9LsTg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeCVQqk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 12:46:40 -0400
Received: from muru.com ([72.249.23.125]:33280 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751923AbeCVQqi (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 22 Mar 2018 12:46:38 -0400
Date: Thu, 22 Mar 2018 09:46:33 -0700
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Message-ID: <20180322164633.GF5799@atomide.com>
References: <20180309023750.108942-1-tony@atomide.com>
 <20180322135553.GA27648@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
In-Reply-To: <20180322135553.GA27648@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Pavel Machek <pavel@ucw.cz> [180322 13:57]:
> Hi!
>=20
> > idle lcd off	phy-mapphone-mdm6600	ohci-platform
> > 153mW		284mW			344mW
> >=20
> > So it seems that MDM6600 is currently not yet idling even with it's
> > radio turned off, but that's something that is beyond the control of
> > this USB PHY driver. This patch does get us to the point where modem
> > data and GPS are usable with libqmi and ModemManager for example.
> > Voice calls need more audio driver work.
>=20
> Ok, let me try. I believe I should see the modem device on lsusb, but
> I don't.
>=20
> user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
> sudo lsusb
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
> zcat /proc/config.gz | grep MAPPH
> CONFIG_PHY_MAPPHONE_MDM6600=3Dy
> user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
> zcat /proc/config.gz | grep OHCI_
> CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
> CONFIG_USB_OHCI_HCD=3Dy
> CONFIG_USB_OHCI_HCD_OMAP3=3Dy
> CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
> user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
>=20
> As far as I can tell,
>=20
> +CONFIG_USB_WDM=3Dy
> +CONFIG_USB_SERIAL=3Dy
> +CONFIG_USB_SERIAL_QUALCOMM=3Dy
> +CONFIG_USB_SERIAL_WWAN=3Dy
>=20
> should be enabled to enable the drivers (and I did that), but without
> device showing on the bus...
>=20
> Any ideas?

Do you have the related dts patches picked from next?

fdd192037fce ("ARM: dts: omap4-droid4: Fix USB PHY port naming")
e5b9fd7bdeb5 ("ARM: dts: omap4-droid4: Configure MDM6600 USB PHY")

But yeah all you need to do is have phy-mapphone-mdm6600 and
ohci-platform loaded and then ifconfig should show four wwan
interfaces being added.

Regards,

Tony


--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkgNvrZJU/QSQYIcQG9Q+yVyrpXMFAlqz3ekACgkQG9Q+yVyr
pXMyYg/9GEq0/SBSu5yR5kx1UrhkK5c/fyL9li145JlFob6VY2wEpBWSUqU3Mr/C
D1pB+3H11j30Q9HwsHAK0GWKznYQUlf50sc9NZjuldfgqbp27q2LLq9VeNA+RpnE
6zTjPSVV9iG11eYWJAR1NsajFBjgxnCleI8KFLuZE/BSKk0EwpyVqdc6fFLJ6Ap9
0F/dkhb6OJzo1ElfPKlLK4gjmxa1OIS0086WlKvxtLrhVWhjEJrxBPNicDiD8FyZ
HYbhC6aBbmwpzqWJKZbUVBjtbNAXMD+gfPGhzxq2aflHa/Ey26Wj0ITfyjCaCHZY
Nz7SwgUVxpLzrpmmRAA/sSnId/vshobYs8Uki+QJpbbkxhyDmjZpZpJc6i4b85EU
VTQ0B6Hz8efURW1LwQsk7J/TYrZqVlUIOBOyHzUUa4p996Epjs88ynXwJ1pXspem
v8vwlFtRnzaEsMw29YppxQ/GxPMa1NkIHS/uDH04ZP5napXMMWek9GVqv2EmXjXC
E8hwFPZ+Es1YsrzlH4+Va0x60DoL8uUadLIn8QQDyB3juxHbItW56rt5e5EQYCOb
N18kfURYLfBzwCcLvKYT4YCs+xt9C3T0QuVU+6HkMpFO5VgrQipxiJeBcJasAve4
h7PYWp+NTt6bI10RftBLQtm5fncWnlp5Hj5xsvbPAm88kzc61z0=
=uw8G
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
