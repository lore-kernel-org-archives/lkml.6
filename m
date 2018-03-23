Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521804943-2-16283318734581975763
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804943; b=LcFM1uL2Y3Q/HSZuApAj4bTekPHIb9Q1/GdfilMUNZBcXOm
    /Farfv0CfvxepIpc5GoLCv5OpE24oBby1wgIMm3PHzMgGbpMt8pojk+3UHPRttSJ
    fqgM5PAQBfFlzYLRxkYO7RwSnYtBfPP5iymdoWrTtWSAE7OpUE0bB8gsfvyIJcz1
    YHp3aC0fpeVqVdZ8GK2d/EikwbLT+qVTky0rTM+NvuaOQj6h7QFPrjbG9dcbPGTd
    5CdzR2o0eTX+w0AKccx8oOF5vzmvbqMxzVi31gYhjD/ix09YtsRmCfws8zcLYejB
    pMAKDyLHfVplP0IsoN1s7z2vpC2FeIVxDTNjflA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521804943; bh=5TkRMHusS56jN3CEBm3FluixWu
    hWhvZEQdghKLO6eQU=; b=B57jen5t1SkvOnnKebM0VAqNFEj3porvgNmwUhlwlg
    xDwqA0KoSaFfgk6OlWc6lCEp5zMdORoxBS7i09NDsLpjrbn3JwBm9JzPqRYnN56m
    NSYNZhL9QubLh32GDJ1TLBFb4XUI8OvFeZFPRMSOclliYZHXdc69DvYsvCTf0656
    XntKpO00DuUKIwjrtET0Zj1w2RWr9Cv2jWNDHMRP47JQBGgd9X44YD4mdk/eoIHU
    LA1tYPtrLwkNRcMcCD7jPPTygnWNrOTa1ULe01yZBzsMENYtT5MZzWkI5m3+0RRY
    9mwMe1WOFZ9jz5xnMppj+lj52fDsvXHXogttmNu9Scrw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755073AbeCWLf2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754983AbeCWLfZ (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 23 Mar 2018 07:35:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DE221736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Fri, 23 Mar 2018 12:35:21 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
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
Message-ID: <20180323113521.45va72bhzis6ym6m@earth.universe>
References: <20180309023750.108942-1-tony@atomide.com>
 <20180322135553.GA27648@amd>
 <20180322164633.GF5799@atomide.com>
 <20180322192843.GA17189@amd>
 <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
 <20180323105455.GB21644@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="egdy33ftvvn6ue4v"
Content-Disposition: inline
In-Reply-To: <20180323105455.GB21644@amd>
User-Agent: NeoMutt/20180223
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--egdy33ftvvn6ue4v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 23, 2018 at 11:54:55AM +0100, Pavel Machek wrote:
> Hi!
>=20
> > > > Do you have the related dts patches picked from next?
> > > >=20
> > > > fdd192037fce ("ARM: dts: omap4-droid4: Fix USB PHY port naming")
> > > > e5b9fd7bdeb5 ("ARM: dts: omap4-droid4: Configure MDM6600 USB PHY")
> > > >=20
> > > > But yeah all you need to do is have phy-mapphone-mdm6600 and
> > > > ohci-platform loaded and then ifconfig should show four wwan
> > > > interfaces being added.
> > >=20
> > > ifconfig? I thought I should get /dev/ttyUSB0..3?
> >=20
> > I believe they are QMI via qmi_wwan, not TTYs.
>=20
> Well, qmicli expects device path... and I see nothing on ifconfig. Any
> idea how the device would be named?
>=20
> But I believe it just does not work, see the qcserial experiment with
> new_id below.

Dan is right, you need qmi_wwan driver. qmicli expects
/dev/cdc-wdm<num> device. I use this on Droid 4:

qmicli -d /dev/cdc-wdm0 --some-other-option

-- Sebastian

>=20
> Best regards,
> 								Pavel
> 							=09
> > > But qcserial driver does not bind to that. If I attempt to force it:
> > >=20
> > > root@devuan:/sys/bus/usb-serial/drivers/qcserial# lsusb
> > > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > > Bus 002 Device 002: ID 22b8:2a70 Motorola PCS
> > > Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> > > root@devuan:/sys/bus/usb-serial/drivers/qcserial# echo "22b8 2a70" >
> > > new_id
> > > [ 2059.267730] usb 2-1: unknown number of interfaces: 9
> > > [ 2059.272949] usb 2-1: unknown number of interfaces: 9
> > > [ 2059.278045] usb 2-1: unknown number of interfaces: 9
> > > [ 2059.283233] usb 2-1: unknown number of interfaces: 9
> > > [ 2059.288330] usb 2-1: unknown number of interfaces: 9
> > > [ 2059.293457] usb 2-1: unknown number of interfaces: 9
> > > [ 2059.298553] usb 2-1: unknown number of interfaces: 9
> > > [ 2059.303680] usb 2-1: unknown number of interfaces: 9
> > > [ 2059.308776] usb 2-1: unknown number of interfaces: 9
> > >=20
> > > I don't get anything useful. Do I need to boot android before booting
> > > Linux or something? How does your lsusb look like?
> > >=20
> > > Thanks,
> > > 								Pavel
>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html



--egdy33ftvvn6ue4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlq05nUACgkQ2O7X88g7
+pp6cw/+MJ6Q4nClh6k9sbefxreQ68LZQlQ8I4/nn9FFVtp++CYIJ/39kK4YvT1s
H6zFkb5feWY/9Yp9qg3rB96hDjRSdTnHfz1Aszk7PhUIGMjowEZ5XV37YKfF+Unl
UET7ZMnueehwNVeoVlwsvdX/gb4p4jY7HTr7rd3+oJFCBIIrAOrBjfhDAVlZt2/Q
cWNkSMC3IuFpGpxjlkLnsd8YX4AxYEmOec2oqJPWog+SKiFKWmcGm/0YpDl1KzlZ
9i0Tv8ZRhCuUdu9zdc/IkR1OMxFHccHApZDq1RLDbDH3TcZIpMEt9OKB3YA9rvO7
qhcvsACECnZPQQBpscm3oUKqx6qc0ootao6k8pi+oXXgyfipXVasO6G+yCgb7c0C
e2spyUpiW057C/o4536R+sKJR0TI5FCS4+TS/Lqeo+rHpSwQ0oMX/C7i7SAnVe+W
Ds1ZM8sBQu2ZzshsRSxKg68TpDO7k8j6i5lBxahdHHYy1P3KWr0ajgTl+Kw4SPL4
xXUJp6xbmi+6R5uaJqCzSpq64ZXK8Y1xFWeiWMICwXVqcNQBAscYoznayPtXdqso
Rj9paIPd82qCo98pQthUXcz1XkaFDvHTSK6onTUD/77Yyc0ncON2g87Acu3yw3IC
G/5D7+zWyrrZGn6Lim3cQGUPL+oTWYOmuBYlrzgfGqVA2eZGjUQ=
=Vo6X
-----END PGP SIGNATURE-----

--egdy33ftvvn6ue4v--
