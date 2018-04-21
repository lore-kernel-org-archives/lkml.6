Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4064957-1524308329-2-9800823030200146201
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='fr',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524308328; b=pzqmUGBPmAgPy/jCgaiPANhs33bF7D+ch9/Kyp2eaT+R+NjfsL
    M43cjCs/Rgxchy0HRLP6fd5OBjONGa/cvE4AMsfXdiOrrLS26HRPsr5EgnI0lhq4
    1rOoWt/NchDJEcA7U+Hp2VchoJ0GRHKlm4e/1ablWBAxPOP4Nef0jZKGiWQJAAof
    br/DD2frTVBCMk12gGMbGHME3fsb3L5xBgu17rx8CK0PmP81Vdc515XVXurU9jWQ
    HW2wLtmYVF8ME4AEllG2gKGPWLKWC/uIagu2F0zH0RnxFeWJSs6Un1x94120y5Sn
    ou+34ua+jrTICMHMgONpAoHJZ79i7ok1QchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=fm2; t=1524308328; bh=Q86eqwJW7ra/pQixcOoSIplP4/nuVa
    LDuMoWyDxluZI=; b=chw29zdfrERXN1nAMZu1gZNHoS6bVMfXrOF+Je+4N3q3Rl
    EqyPQx7MtmgCPgNdktq9QFhPMZJhhu1PpzrEhvnC6bERsqqKobEssxgZBv6RXWTe
    7GX1Na6YA3+soQ+J1UkGoSnR/Job4g9UuR5GtiCkgbOEQXDA5unKuP/JDOwO3w3M
    3TVzhylPJmgn5d1X2f4aSHOLDOTtiFTXnuziJRwU2Lt86sHSjjXvjcr+YGup61p0
    pADgBCEG1yT+275vcOodBdEdjVU/ZieLlpwWbPnYwvKGau/6yXSfx+uD2sbZzFOJ
    9UTvAKfBl2Y1k61KrpJ3dyXf03K0KXl/rzJj4MSg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paulk.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paulk.fr header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paulk.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paulk.fr header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK72KkBvJIcNm8/RKSaXYe2qWfr++H8p18D8kbCSOncBvM4IwDAUwXDYz4mt8w3O6aPa74kTresDcFtYr+rrvDtJnrvq02pMozDZCXgi2v8RpKdOAIDn
    aiPH39XpaUvVrA/kU3r9n3ueRjsyxR7QLphGOVYUlA2xwlFnWKs7Tt+7kq213S7YTd3Qiu51WgQMh0LyM5Dddb7SnDQLAyR56TmjoCGjhYi43tWxRomuFuuY
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=xjq4MWndAAAA:8
    a=yMRzqdxUuN5pRK9a1FkA:9 a=QEXdDO2ut3YA:10 a=o1G95OMBQ-6L5bWjZ9QA:9
    a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8 a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10
    a=LM-bNg79Vred_kxi5WFf:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752388AbeDUK6e (ORCPT <rfc822;greg@kroah.com>);
        Sat, 21 Apr 2018 06:58:34 -0400
Received: from vpn-0-22.aquilenet.fr ([185.233.101.22]:59084 "EHLO
        leonov.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbeDUK6d (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sat, 21 Apr 2018 06:58:33 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on gagarine.paulk.fr
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        autolearn=disabled version=3.4.1
Message-ID: <6fb699194c10db9ff1e9b730435a785b71032840.camel@paulk.fr>
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
From: Paul Kocialkowski <contact@paulk.fr>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bin Liu <b-liu@ti.com>, Chen-Yu Tsai <wens@csie.org>
Date: Sat, 21 Apr 2018 12:51:20 +0200
In-Reply-To: <20180403092910.wcgjn3r4job5y5pb@flea>
References: <20180328215213.29538-1-contact@paulk.fr>
         <20180329092326.dayuccomq5zrywqo@flea>
         <1522324644.1746.19.camel@bootlin.com>
         <20180403092910.wcgjn3r4job5y5pb@flea>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-KB68J9My6tN8mRSJFXHf"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-KB68J9My6tN8mRSJFXHf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 03 avril 2018 =C3=A0 11:29 +0200, Maxime Ripard a =C3=A9crit :
> Hi,
>=20
> On Thu, Mar 29, 2018 at 01:57:24PM +0200, Paul Kocialkowski wrote:
> > On Thu, 2018-03-29 at 11:23 +0200, Maxime Ripard wrote:
> > > On Wed, Mar 28, 2018 at 11:52:13PM +0200, Paul Kocialkowski wrote:
> > > > This allows dual-role ports to be reported as having gadget mode
> > > > by
> > > > the
> > > > musb_has_gadget helper. This is required to enable MUSB at all
> > > > with
> > > > MUSB
> > > > glue layers that set the port mode to MUSB_PORT_MODE_DUAL_ROLE
> > > > at
> > > > init.
> > > >=20
> > > > Most notably, this allows calling musb_start when needed in the
> > > > virtual
> > > > MUSB root HUB, regardless of whether the current mode should be
> > > > gadget
> > > > or host.
> > > >=20
> > > > This fixes USB OTG on Allwinner devices that I could test it
> > > > with,
> > > > mainly A20 devices.
> > > >=20
> > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > >=20
> > > Surely there's more to it than that. The gadget mode of A20 boards
> > > have been working in the past, including when compiling with mUSB
> > > setup as dual role.
> > >=20
> > > Is this a regression since a particular commit? Or is there
> > > another,
> > > deeper issue overlooked in the commit log?
> >=20
> > The root of the issue here is that musb_start is not called at any
> > point
> > without this patch. My understanding of the flow is the following:
> > when
> > the PHY detects that there was a VBUS/ID change, it will notify its
> > listeners (mainly the musb sunxi glue layer). This will then
> > schedule
> > the driver's work (sunxi_musb_work), which does nothing since the
> > SUNXI_MUSB_FL_ENABLED bit was never set. This bit is only set after
> > calling sunxi_musb_enable, which is called from
> > musb_platform_enable,
> > that originates from musb_start.
> >=20
> > Currently I see two places where musb_start is called:
> > * musb_virthub
> > * musb_gadget
> >=20
> > In the latter case, it is in turn called from udc_start, which
> > should
> > probably (correct me if I'm wrong) happen later in the call chain
> > than
> > ID/VBUS change notification time.
> >=20
> > In the former case, musb_start is called in the root controller hub
> > control, when setting the USB_PORT_FEAT_POWER feature. This looks
> > perfectly legit and IMO this is where it should be initially calling
> > musb_start in the dual role case. The kernel is indeed setting the
> > feature, only that it fails to enable musb without this patch.
> >=20
> > First, I'd like to make sure that this understanding of the flow is
> > correct as I may have missed something here. Does it make sense?
> >=20
> > Then, it seems that the offending commit is: be9d39881fc4f
> > ("usb: musb: host: rely on port_mode to call musb_start()")
> >=20
> > That itself fixed: ae44df2e21b5
> > ("usb: musb: call musb_start() only once in OTG mode")
> >=20
> > Still, this commit was authored in June 2015, so almost 3 years ago.
> > In the meantime, the sunxi driver has received feature improvements,
> > so
> > it seems hard to believe that it was broken all this time...
>=20
> I'm not that knowlegdeable about the musb driver, so I can't really
> comment on whether what you're saying actually makes sense, but from
> what you seem to say, the issue is just happening upon VBUS / ID
> notification.
>=20
> Have you tested without the role switching? For example, trying to
> boot while acting as a gadget?

In the end, the issue here was that I did not have a gadget (e.g.
g_ether) driver loaded, and this prevented host mode form working
(according to my initial explanation).

With a gadget loaded, things work normally. Still, I don't think this is
the right behavior here: one should definitely be able to use USB OTG in
host mode without any gadget loaded.

My initial patch fixes this, but I am not confident that it doesn't
break other platforms, for which this assumption was added in the first
place.

Cheers!

--=20
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-KB68J9My6tN8mRSJFXHf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlrbF6gACgkQhP3B6o/u
lQyQvw//RbV4GzB2flSTEwVJ3hIKBAgp7MN5mE9fPx4qMAoC/13SZJmaPPmurmxV
PCXVVQcLg5pV7knLkUeurj0cBWMNACPppp5YEBxZGm0OgnNf/nvhqkmOW3gcJGxz
oOiu+7J2KGX7ZQZ6CUIQWNLjOqC0Sn7pQPnxBX3Hv4eRqLiz236+znahpGWyA+sC
xf80kJtFEjd8on5fwB+X5AurU9THlLQFIpPu+uAvPDKlwj/LaUKB7ZrdZM0nOFnh
3qOzmicGGUPzXmGq7espHtbA7h9urqbpBandchBKsuPWt3PewsWzmydOhlr5t2N+
vsAjQ25brQQvn2Pm2jYAMDw/7r8+UJL90h/ugbx2UVY3K51HUaQfLzJ4PQ3txXMH
ADHZ4LUZFwDcXEMVMFmh2T6CuhkIusCuNdAAgrXPYeF2N7cGBog7mxfYbjY04p1G
xZu0S7VSsLjXsR2wHuSR76p2Z0m2qr+1d8yE66b33XwSLYIHujehrH5EwF2nMKGe
Yu5MhJHihmKGRnAk2BAeuxiKEeKjEsIbDz49pZSLBABaj/Ts7+7igF1XJl48ay5H
vADrfKG8v+FCeYk9wtXBD+pzE7qbIJ7z7bas0huHuSuV9f9jZqcC97wRmcHr5Kr4
/5MyGRNSN1dGC6FKcWrxmPWqu/fAoY/REBTP/c2LU0GbmjPhwqg=
=29pS
-----END PGP SIGNATURE-----

--=-KB68J9My6tN8mRSJFXHf--

