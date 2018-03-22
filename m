Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2859500-1521727007-2-18379171196068638633
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
    t=1521727006; b=uZcMFgWrnuGTJkPP6XGiQiwQCbxMFprItqiHzADr2+vz6gq
    DubGmlydINg5StJLYysADYmIcJEEaMA/Jhm9ysL0GNyfRHr+A+WGTuTpdC+uY1kW
    dl2qMryNwt/N+Ym0kVxgwBx0U+Fs2/iaehOQgOOCUncKHyd6HDUHIXNSIQ2IiXZs
    B0LeJkx/Lof7F/HEo9xi5B/6fd7dylBkhlVBTT+GkKkFQSee3/MT+L8Ium8lk2Ol
    WOj7YCI8b5c2wZQWYzbrE9sLo/GikMJ4o+96sx6yJvJRucpoJC0kxrUb+pb16t3d
    eim9HTLzyfFXTtquvKfIttvw2GHusMnMkYnoBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521727006; bh=fD5OTy+psCydMfeg10Q71YfwBa
    fwS5d560OE+j21hGo=; b=Mjg1oUFQO6X3XPupplM0S5qb9JJu7TXT/Q85+IHGap
    JY73RDaQjDq4KNYXxN5+03X7GUtdMdAybXtCsZ7e+kFb/B15M9/GxVo3di4l7XAm
    EKLj4apT5bY2Gqqe2Br4nKshVhxjdjl0NOhd9BGeOzm0Uuxc5/zR7Qv1qlPuLT08
    ob8C+X1qAcrl+agtMWUWA8bh+HrW3cgukBIzriKe8icBud2f4ffBPPsGfXFDdER8
    AynDBtPt5jNfjDwm1pYKaPwjrZb+qVTU4mwZfGGrQLDjV/Fa49clHLnvxTpN+gcD
    UuYvypDMsn8pRyo+ZcxWbqjC0NpbeGtSyuEHLVVxX2hA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S1755739AbeCVNz5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 09:55:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53626 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755719AbeCVNzz (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 09:55:55 -0400
Date: Thu, 22 Mar 2018 14:55:53 +0100
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
Message-ID: <20180322135553.GA27648@amd>
References: <20180309023750.108942-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20180309023750.108942-1-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> idle lcd off	phy-mapphone-mdm6600	ohci-platform
> 153mW		284mW			344mW
>=20
> So it seems that MDM6600 is currently not yet idling even with it's
> radio turned off, but that's something that is beyond the control of
> this USB PHY driver. This patch does get us to the point where modem
> data and GPS are usable with libqmi and ModemManager for example.
> Voice calls need more audio driver work.

Ok, let me try. I believe I should see the modem device on lsusb, but
I don't.

user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
sudo lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
zcat /proc/config.gz | grep MAPPH
CONFIG_PHY_MAPPHONE_MDM6600=3Dy
user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
zcat /proc/config.gz | grep OHCI_
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_OHCI_HCD=3Dy
CONFIG_USB_OHCI_HCD_OMAP3=3Dy
CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$

As far as I can tell,

+CONFIG_USB_WDM=3Dy
+CONFIG_USB_SERIAL=3Dy
+CONFIG_USB_SERIAL_QUALCOMM=3Dy
+CONFIG_USB_SERIAL_WWAN=3Dy

should be enabled to enable the drivers (and I did that), but without
device showing on the bus...

Any ideas?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqztegACgkQMOfwapXb+vIqfQCfarnENvRNJy/2ZqTZSAKuiD8V
3tEAoIUsdOYhKl1971CiW7Z+SIInnO3T
=/46F
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
