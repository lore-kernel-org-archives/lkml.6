Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3492523-1521746943-2-10303763515633725770
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
    t=1521746942; b=eEafcukt2AqUrb+0RqxfJcMpW/Fs1JGZ4iJyODmyd+7mcIj
    UigfNhHGEB9hmxWrE4xqyiJQlpteXRqOAejUzs9w3KyTFrSXMgc42rg2/t/PKM+y
    Z7SMTSINWmcZwliJojOINCAA+3rBLKwWLiO3jwP4qWub+EkqqIKBXKqwP1YEeCXX
    Olts8KLaa3cfQDjWV30EpKFSh5d9P16izQC8m8DQjiJhFQLrfQ5JQ73whQ3YaN5N
    aL1UVlrfgB0AN6FLVxISBUQOh59tCpaTLJOVxCNUG9f8aHzrxj2UqzrlTXppJOqv
    gDHu4bRNUy2EEgZkS1EIGLZybHIPe7zCnEhAZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521746942; bh=Vpww+J4wxkIFXi62fxqwcHQ7GE
    mC799vtDHBSbRBWNg=; b=RfweONF2InA5x11yKjsJ8vIv1ysARZS2H8E7U6j9ai
    F9kZClFzWgX/fi9e3IrXc4/w1f+q+JmKCnSZOUV9RR9wPj9ulczbqMOWaNc/nkp8
    BVK/H65rhVQPQ5qeanT3joPdnIVquxDEoeZYStCIATAGaaLK6MUaq0H2hTApC1FU
    z5XxyBMRlVWuXZw7+4vBswqjSEGayOJffC5yB5UHvivK1oDBT83vWyrRNLi3F7Y3
    RJv0GwZZQi7WY8/p2smmqLrfqoCrjn/dQATSiqKbJoBTFDHYfoPaIdmQKPCWpWll
    Kl5v1ucO8J+kSQqLHvlLt9/1Zsh0PSnJr6/aslVd6v3g==
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
        id S1751739AbeCVT2s (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 15:28:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34803 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeCVT2r (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 15:28:47 -0400
Date: Thu, 22 Mar 2018 20:28:43 +0100
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
Message-ID: <20180322192843.GA17189@amd>
References: <20180309023750.108942-1-tony@atomide.com>
 <20180322135553.GA27648@amd>
 <20180322164633.GF5799@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20180322164633.GF5799@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
> > sudo lsusb
> > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> > user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
> > zcat /proc/config.gz | grep MAPPH
> > CONFIG_PHY_MAPPHONE_MDM6600=3Dy
> > user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
> > zcat /proc/config.gz | grep OHCI_
> > CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
> > CONFIG_USB_OHCI_HCD=3Dy
> > CONFIG_USB_OHCI_HCD_OMAP3=3Dy
> > CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
> > user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
> >=20
> > As far as I can tell,
> >=20
> > +CONFIG_USB_WDM=3Dy
> > +CONFIG_USB_SERIAL=3Dy
> > +CONFIG_USB_SERIAL_QUALCOMM=3Dy
> > +CONFIG_USB_SERIAL_WWAN=3Dy
> >=20
> > should be enabled to enable the drivers (and I did that), but without
> > device showing on the bus...
> >=20
> > Any ideas?
>=20
> Do you have the related dts patches picked from next?
>=20
> fdd192037fce ("ARM: dts: omap4-droid4: Fix USB PHY port naming")
> e5b9fd7bdeb5 ("ARM: dts: omap4-droid4: Configure MDM6600 USB PHY")
>=20
> But yeah all you need to do is have phy-mapphone-mdm6600 and
> ohci-platform loaded and then ifconfig should show four wwan
> interfaces being added.

ifconfig? I thought I should get /dev/ttyUSB0..3?

Anyway, that does not seem to work. Something is detected now:

[   10.819549] ALSA device list:
[   10.831787]   #0: HDMI 58006000.encoder
[   10.841186] Waiting 10 sec before mounting root device...
[   10.887573] usb 2-1: New USB device found, idVendor=3D22b8,
idProduct=3D2a70
[   10.897521] usb 2-1: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D0
[   10.907684] usb 2-1: Product: Flash MZ600
[   10.914611] usb 2-1: Manufacturer: Motorola, Incorporated
[   20.967193] EXT4-fs (mmcblk0p2): couldn't mount as ext3 due to
feature incompatibilities

But qcserial driver does not bind to that. If I attempt to force it:

root@devuan:/sys/bus/usb-serial/drivers/qcserial# lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 002: ID 22b8:2a70 Motorola PCS
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
root@devuan:/sys/bus/usb-serial/drivers/qcserial# echo "22b8 2a70" >
new_id
[ 2059.267730] usb 2-1: unknown number of interfaces: 9
[ 2059.272949] usb 2-1: unknown number of interfaces: 9
[ 2059.278045] usb 2-1: unknown number of interfaces: 9
[ 2059.283233] usb 2-1: unknown number of interfaces: 9
[ 2059.288330] usb 2-1: unknown number of interfaces: 9
[ 2059.293457] usb 2-1: unknown number of interfaces: 9
[ 2059.298553] usb 2-1: unknown number of interfaces: 9
[ 2059.303680] usb 2-1: unknown number of interfaces: 9
[ 2059.308776] usb 2-1: unknown number of interfaces: 9

I don't get anything useful. Do I need to boot android before booting
Linux or something? How does your lsusb look like?

Thanks,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAlq0A+sACgkQMOfwapXb+vJp7ACWO1qp5KahtXRtn8mQTZIEJqNo
VQCggIZ/PMnCO4+9IY9B0ej/gDsVIJE=
=CfL7
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
