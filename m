Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1550609-1522352674-2-3180269861469094144
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522352673; b=E3ID7cXWE3bNKpz3rmJbh0D9iNr/YePmPHN8dxJIhqvAWEtEvv
    lV5ma7KxlAMnaHXG2jrNE1EoXyhij0hOQlwrJWpYdhDUexJSwd65RGvKihz/fxZf
    be6VO9mtySV9AHTRSw7CvIhCsLfhv+N1pg3P2+irLxeJwR1NkOwqVpgDD5hxI6kn
    CmNmX5Q9qpELt5ePZAXkjOi4kfwMgGhCCkHfBocx6C6U8K1MMaiHgOGA7CRzaVaN
    64cMoS4UJY0BRZqnuPTlrilbkYUgxkyVDm3ik7sFpntDmY/FjXzDNacNzsgwkAyR
    NyFiY3YSJ+9pclfIzUrLU4FHfhvAdWzLKHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522352673; bh=9hyFHEnuEnHJjlCNy2b0X3wqDusYHm
    4n+CoRhTRBy30=; b=ZvpovhxIod/ujmAV9s/K8V1vhF56YUho1zTAkUV8BHfNeX
    H3JeAtO7ykZmhcMXNmKG3m8pQVHxeFewhz06xHdIR1IabuFSZGfu9AYCOzvNacLg
    mlTdXbdaLvYcd4HIIoNDkFm7DbW7purSIToIkqJbE8FFvJeBZUxcJaQOblE/ZahH
    pFLIc4B3u9HLXp9vXrAYKsK2lL8K6O04z1zPJXgoTwQev8BW5aGlKyc9C9kBxGG0
    mmSwQtBfJ+mX+ImrGIHYFYcGfVZHUP4S2AnUtTt961VM/+GetNsSzgBSV+vMsg1n
    ScgzcCW+GdXxN67F7a8HIPe9wBCd2v1kU9AlW+7A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfObEqUrgRT/rf4bt7t51NtXUr3H4YRlHzMjthbxnsRIp/X6byYrhcOPKLLnwXR6qKLB/TwgI2+CH2OD46DNBp8ckfOMQ9Fb30gvgcTcx8vBqjGPjil48
    +VtbTKSul433k18afZhieS5bZuf8m/JuH6chK0laPO6ICTKRQIQJszaxx5NAYjApSy8s09sIH/ZyP3AFLisNPm1OEFoO7Ke2lfx5uwUdCk1ohPwPkmJXkIAV
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=wmNktwbe6l0UlekYo_wA:9 a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10
    a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=jYLOO-UKtdbnopVHBKMA:9 a=ONNS8QRKHyMA:10
    a=VwQbUJbxAAAA:8 a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeC2ToQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 15:44:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50176 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbeC2ToO (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 29 Mar 2018 15:44:14 -0400
Date: Thu, 29 Mar 2018 21:44:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dan Williams <dcbw@redhat.com>, ofono@ofono.org
Cc: Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Message-ID: <20180329194411.GD27688@amd>
References: <20180309023750.108942-1-tony@atomide.com>
 <20180322135553.GA27648@amd>
 <20180322164633.GF5799@atomide.com>
 <20180322192843.GA17189@amd>
 <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
 <20180323105455.GB21644@amd>
 <20180323113521.45va72bhzis6ym6m@earth.universe>
 <20180323201343.GC23658@amd>
 <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline
In-Reply-To: <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Does ofonod work for you? I could not get that one to work...
>=20
> Because it's looking for a Gobi modem but the MDM6600 isn't one and
> doesn't expose that layout (and doesn't really need to anyway).  I
> don't think ofono has a generic QMI driver, so you'd either need to for
> ce it to use the telitqmi or quectelqmi drivers, or write your own
> generic QMI one.

You are right, it is detected as gobi now:

user@devuan:/my/ofono$ sudo python2 test/list-modems
[ /gobi_0 ]
    SystemPath =3D
    /sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/usb=
2/2-1
 Features =3D
 Emergency =3D 0
 Powered =3D 0
 Lockdown =3D 0
 Interfaces =3D
 Online =3D 0
 Type =3D hardware

=2E..and nothing works.

commit db9b292f9290b97c87a8d4b4836af4763c06a39c
Author: Bassem Boubaker <bassem.boubaker@actia.fr>
Date:   Mon Mar 19 17:57:31 2018 +0100

I tried this:

diff --git a/plugins/udevng.c b/plugins/udevng.c
index ff5d41af..6b103254 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1578,8 +1578,6 @@ static struct {
 	{ "mbm",	"cdc_ether",	"0930"		},
 	{ "mbm",	"cdc_ncm",	"0930"		},
 	{ "hso",	"hso"				},
-	{ "gobi",	"qmi_wwan"			},
-	{ "gobi",	"qcserial"			},
 	{ "sierra",	"qmi_wwan",	"1199"		},
 	{ "sierra",	"qcserial",	"1199"		},
 	{ "sierra",	"sierra"			},
@@ -1602,6 +1600,8 @@ static struct {
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
 	{ "telitqmi",	"qmi_wwan",	"1bc7", "1201"	},
 	{ "telitqmi",	"option",	"1bc7", "1201"	},
+	{ "telitqmi",	"qmi_wwan",	"22b8", "2a70"	},
+	{ "telitqmi",	"option",	"22b8", "2a70"	},
 	{ "nokia",	"option",	"0421", "060e"	},
 	{ "nokia",	"option",	"0421", "0623"	},
 	{ "samsung",	"option",	"04e8", "6889"	},

But no luck:

ofonod[15879]: plugins/udevng.c:create_modem()
/sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/usb2/2-1
ofonod[15879]: plugins/udevng.c:create_modem() driver=3Dtelitqmi
ofonod[15879]: src/modem.c:ofono_modem_create() name: (null), type:
telitqmi
ofonod[15879]: plugins/udevng.c:setup_telitqmi()
/sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/usb2/2-1
ofonod[15879]: plugins/udevng.c:setup_telitqmi() /dev/cdc-wdm0
255/251/255 05 (null) usbmisc
ofonod[15879]: plugins/udevng.c:setup_telitqmi() wwan0 255/251/255 05
(null) net
ofonod[15879]: plugins/udevng.c:setup_telitqmi() /dev/cdc-wdm1
255/251/255 06 (null) usbmisc
ofonod[15879]: plugins/udevng.c:setup_telitqmi() wwan1 255/251/255 06
(null) net
ofonod[15879]: plugins/udevng.c:setup_telitqmi() /dev/cdc-wdm2
255/251/255 07 (null) usbmisc
ofonod[15879]: plugins/udevng.c:setup_telitqmi() wwan2 255/251/255 07
(null) net
ofonod[15879]: plugins/udevng.c:setup_telitqmi() /dev/cdc-wdm3
255/251/255 08 (null) usbmisc
ofonod[15879]: plugins/udevng.c:setup_telitqmi() wwan3 255/251/255 08
(null) net
ofonod[15879]: plugins/udevng.c:destroy_modem()
/sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/usb2/2-1
ofonod[15879]: src/modem.c:ofono_modem_remove() 0x596480
ofonod[15879]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm0
ofonod[15879]: plugins/udevng.c:destroy_modem() wwan0
ofonod[15879]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm1
ofonod[15879]: plugins/udevng.c:destroy_modem() wwan1
ofonod[15879]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm2
ofonod[15879]: plugins/udevng.c:destroy_modem() wwan2
ofonod[15879]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm3
ofonod[15879]: plugins/udevng.c:destroy_modem() wwan3
ofonod[15879]: plugins/upower.c:upower_connect() upower connect
ofonod[15879]: plugins/hfp_hf_bluez5.c:connect_handler() Registering
External Profile handler ...

With quectelqmi result was similar.

I know there are AT commands available at /dev/ttyUSB4. Is there easy
way to make ofonod connect to that?

Thanks,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq9QgsACgkQMOfwapXb+vIYRwCfaMPX3tG2WfokQSGnBgAuPcdh
GMQAoMEtLEciA7AIAasTmqdxmd/lV3Id
=B5XZ
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
