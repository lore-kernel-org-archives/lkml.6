Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2024708-1521836057-2-10029523184562583582
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
    t=1521836057; b=iEXpyvmBp5bdue7xFDEkciz/RP6ac+1X3McW2u6o7+X+QmF
    gysdA97uA9DPqPLshOM0/qppXBgEs27NNv1+0WvhUQEeW6hLxOdvLAtOMCFeptsT
    Ok3Qxs4Gy0W+lYbJFPHv0RI8Hq2txegBlPIteL/3tVa8TZUhBgdqag8ccAexdw38
    broAV5WQRUbYH7XCRWvnMzwNG6qOVcDDkBoS3HeMDKs74mSCBt9ZW2mybeF1e/Te
    PrV8DHb0dHKncPvgB23POLktucsn3aJxbG52b5EaS5R66/8ew1VSKBGtYz+dx4yC
    1z7D67Hn0D1ZcTwZ63d2sHdgyoIxnS32mq5wDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521836057; bh=eZ5Mdm16hMMIQ+wtjnrqak1eCx
    9bWh0NqA4hW1Rqm2w=; b=AU9igSmwHeWnt6kVyBMbnpRWnH+r3YHUmzT/UlQ0sG
    1USHyxuEqnPvbr+YNiLpgXoA1zqp37mOl6pNHs31GHis4I6FRuGM+HUf5wF+zPJq
    RGvh1RT+/5tDJhjH/ahFuotSgPW4AK6Fknr1GqKyNM0OYxSStOpExCTpgiAbtrOU
    MUeKOVePEgUPN8mZsu8zqC6M/ZwLPWAOYO7mrRzskO8J5vJXe923xmo53EVK7rzN
    FWDFHUg4lROqnRjh/plLSQ72La2rXx5yI0DP/UMICKXp12uBdRpvpNJI9Z/x8Zen
    8LAJ6WTFfkoSDd4FRJxAz8gKDDRy4JFqYKFVBS39ICvg==
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
        id S1752575AbeCWUNt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 16:13:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42809 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeCWUNr (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 23 Mar 2018 16:13:47 -0400
Date: Fri, 23 Mar 2018 21:13:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sre@kernel.org>
Cc: Dan Williams <dcbw@redhat.com>, Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Message-ID: <20180323201343.GC23658@amd>
References: <20180309023750.108942-1-tony@atomide.com>
 <20180322135553.GA27648@amd>
 <20180322164633.GF5799@atomide.com>
 <20180322192843.GA17189@amd>
 <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
 <20180323105455.GB21644@amd>
 <20180323113521.45va72bhzis6ym6m@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
In-Reply-To: <20180323113521.45va72bhzis6ym6m@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-23 12:35:21, Sebastian Reichel wrote:
> Hi,
>=20
> On Fri, Mar 23, 2018 at 11:54:55AM +0100, Pavel Machek wrote:
> > Hi!
> >=20
> > > > > Do you have the related dts patches picked from next?
> > > > >=20
> > > > > fdd192037fce ("ARM: dts: omap4-droid4: Fix USB PHY port naming")
> > > > > e5b9fd7bdeb5 ("ARM: dts: omap4-droid4: Configure MDM6600 USB PHY")
> > > > >=20
> > > > > But yeah all you need to do is have phy-mapphone-mdm6600 and
> > > > > ohci-platform loaded and then ifconfig should show four wwan
> > > > > interfaces being added.
> > > >=20
> > > > ifconfig? I thought I should get /dev/ttyUSB0..3?
> > >=20
> > > I believe they are QMI via qmi_wwan, not TTYs.
> >=20
> > Well, qmicli expects device path... and I see nothing on ifconfig. Any
> > idea how the device would be named?
> >=20
> > But I believe it just does not work, see the qcserial experiment with
> > new_id below.
>=20
> Dan is right, you need qmi_wwan driver. qmicli expects
> /dev/cdc-wdm<num> device. I use this on Droid 4:
>=20
> qmicli -d /dev/cdc-wdm0 --some-other-option

Aha, there's ./drivers/usb/serial/usb_wwan.c and there's
=2E/drivers/net/usb/qmi_wwan.o . That confused me.

qmicli now works for me, thanks!

Tested-by: Pavel Machek <pavel@ucw.cz>

Does ofonod work for you? I could not get that one to work...

ofonod[4083]: plugins/udevng.c:create_modem()
/sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/usb2/2-1
ofonod[4083]: plugins/udevng.c:create_modem() driver=3Dgobi
ofonod[4083]: src/modem.c:ofono_modem_create() name: (null), type:
gobi
ofonod[4083]: plugins/udevng.c:setup_gobi()
/sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/usb2/2-1
ofonod[4083]: plugins/udevng.c:setup_gobi() /dev/cdc-wdm0 255/251/255
05 (null) (null) usbmisc
ofonod[4083]: plugins/udevng.c:setup_gobi() wwan0 255/251/255 05
(null) (null) net
ofonod[4083]: plugins/udevng.c:setup_gobi() /dev/cdc-wdm1 255/251/255
06 (null) (null) usbmisc
ofonod[4083]: plugins/udevng.c:setup_gobi() wwan1 255/251/255 06
(null) (null) net
ofonod[4083]: plugins/udevng.c:setup_gobi() /dev/cdc-wdm2 255/251/255
07 (null) (null) usbmisc
ofonod[4083]: plugins/udevng.c:setup_gobi() wwan2 255/251/255 07
(null) (null) net
ofonod[4083]: plugins/udevng.c:setup_gobi() /dev/cdc-wdm3 255/251/255
08 (null) (null) usbmisc
ofonod[4083]: plugins/udevng.c:setup_gobi() wwan3 255/251/255 08
(null) (null) net
ofonod[4083]: plugins/udevng.c:destroy_modem()
/sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/usb2/2-1
ofonod[4083]: src/modem.c:ofono_modem_remove() 0x5eb380
ofonod[4083]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm0
ofonod[4083]: plugins/udevng.c:destroy_modem() wwan0
ofonod[4083]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm1
ofonod[4083]: plugins/udevng.c:destroy_modem() wwan1
ofonod[4083]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm2
ofonod[4083]: plugins/udevng.c:destroy_modem() wwan2
ofonod[4083]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm3
ofonod[4083]: plugins/udevng.c:destroy_modem() wwan3
ofonod[4083]: plugins/upower.c:upower_connect() upower connect
ofonod[4083]: plugins/hfp_hf_bluez5.c:connect_handler() Registering
External Profile handler ...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq1X/cACgkQMOfwapXb+vIbcwCgivIAngwiUQOVnKt6eFB5BSuk
IzEAnA+JUc0uloOKnfZijU76/HFBzaj5
=3ybB
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
