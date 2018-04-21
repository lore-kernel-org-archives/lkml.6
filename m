Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4064957-1524308385-2-2668058089099768810
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
    1524308385; b=bEAuioMQV1IVvX/1l2h7+0jidxSQT3lGSkD1Jt+Ye+QsfmeG+M
    usHdg9tRu/7gzamloUNbu+lm9TmUr1GBcURNrAxwFJzfkKIZY3lR85QuN82BKbp1
    ENJpviuT9xZq9ZIptYffyfkcGPocZwTwh9HJHzL63UsPN0e1uwZvTbhWoZ9j9vET
    JoVQVhjeP7w0VvazmMCMscwZv00gFR0yib7VfySlYU+EMJpdjwSzeHfkKagoo1ET
    hH3clrD7PpNnlVbj6N705kck/LkKH9f0xRBT0v9bey1fq7nVYow88iWfLFEQB11R
    cze70YVhmuaqJ+IpEdI6USYzyPFB1X81PNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=fm2; t=1524308385; bh=mZMjwt6gIPX0+J9S87P9sieoRHCPAI
    gTnN0Ue8FwUF8=; b=w/i1RVhKv1+zwskIug4y0kKPAyeUFYc8/IkakcBuuMGqOX
    n1nEs+mpZEWwRqy90OVIUKlrzuvU2DpPH3C0DAhIwqBU/X1NdbwbVpD93vZm2oTY
    QLhgK7xeldXJw+q6heoUa1z8pb8TMlk/WexAopmHnA/2sJKt/DQ2am4aINkB6Kth
    DsJJCh+xVopQprVtt8l1kea7tx9PuOrke5MeFcTaPdsKJG3HC1tvPyXhSjV4kx5A
    jMDDygdXbXx8dqWRPedfyPm0TFKKBdgSDGRTe7zECt3sDpAlz1xmIs/HSBF38J6a
    mDApJP72rkCHloJpGSWJWqMOJemnRnU5szRfVv1Q==
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
X-CM-Envelope: MS4wfPB8HCmBnm7GJp9BdMcJm5kOdROmh17aThd2Lw5InchMzbbP0Pf5JOOkX7TfgXoGTVm5FbNanjEv72X6yb7jBD0kTnw5TMKW64HcTkSUj7+ZrmaeIdWL
    BbNZG0oGOX4a7qAnclmQeIWG9Nu/9/YK02E1JAa16PCyuXCEbqOibOHeFXzIC+dARqjVf/R9PuIJUSs2FvM58bEOmpXzMdDmawYS392LMu0t1Sxjqe0PDF2U
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=xjq4MWndAAAA:8
    a=V_NtlVLY-9adrzQp84MA:9 a=QEXdDO2ut3YA:10 a=jxETerfdmEhfcG8mGd0A:9
    a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8 a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10
    a=LM-bNg79Vred_kxi5WFf:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeDUK7a (ORCPT <rfc822;greg@kroah.com>);
        Sat, 21 Apr 2018 06:59:30 -0400
Received: from vpn-0-22.aquilenet.fr ([185.233.101.22]:59130 "EHLO
        leonov.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbeDUK73 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sat, 21 Apr 2018 06:59:29 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on gagarine.paulk.fr
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        autolearn=disabled version=3.4.1
Message-ID: <2db056d6f65ecbcdc4f31a37fe2e1b1ddfb93c87.camel@paulk.fr>
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
From: Paul Kocialkowski <contact@paulk.fr>
To: Bin Liu <b-liu@ti.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>
Date: Sat, 21 Apr 2018 12:59:23 +0200
In-Reply-To: <20180420142524.GB29011@uda0271908>
References: <20180328215213.29538-1-contact@paulk.fr>
         <20180329092326.dayuccomq5zrywqo@flea>
         <1522324644.1746.19.camel@bootlin.com> <20180420142524.GB29011@uda0271908>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-8DiKZ71yBmb+gr2Xl35R"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-8DiKZ71yBmb+gr2Xl35R
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le vendredi 20 avril 2018 =C3=A0 09:25 -0500, Bin Liu a =C3=A9crit :
> On Thu, Mar 29, 2018 at 01:57:24PM +0200, Paul Kocialkowski wrote:
> > Hi,
> >=20
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
>=20
> I don't think it is correct that udc_start() is triggered by ID/VBUS
> events, but I don't have an Allwinner platform to verify the callflow.

Yes you're right, I didn't make myself very clear here. I didn't
investigate the udc_start call path much since it was apparently not the
culprit.

> Have you tried to load with a gadget driver? When a gadget function is
> bound to UDC, udc_start() is triggered, which in turn calls
> musb_start().

It does work under that scenario, although my used case here is using
musb with DUAL_ROLE but no gadget driver loaded. That it, I want the
musb_start call to originate from the virtual hub, not from the gadget
side.

> > In the former case, musb_start is called in the root controller hub
> > control, when setting the USB_PORT_FEAT_POWER feature. This looks
> > perfectly legit and IMO this is where it should be initially calling
> > musb_start in the dual role case. The kernel is indeed setting the
>=20
> No actually. A dual-role port should be in b_idle state by default, so
> logically all actions should go to the gadget path until the port
> switches to host mode.

It makes sense that the port should be in b_idle state by default, but
here it fails to switch to host mode when the ID pin detects that it
should. Or does b_idle state entail that a gadget must be loaded (per
the USB spec), and thus nothing should (ever) happen until that happens?

I find it really odd to need a gadget device to trigger host mode.
This patch does fix the issue, but I am puzzled as to why it is needed
in the first place. The comment above it mentions that "In OTG mode we
have to wait until we loaded a gadget. We don't really need a gadget if
we operate as a host but we should not start a session as a device
without a gadget or else we explode.", which is apparently compatible
with my use case: a gadget is not really needed and I'm not trying to
start a session as a device without a gadget loaded.

What do you think?

> > feature, only that it fails to enable musb without this patch.
> >=20
> > First, I'd like to make sure that this understanding of the flow is
> > correct as I may have missed something here. Does it make sense?
>=20
> I am guessing you didn't load a gadget driver when testing?

Correct.

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
> >=20
> > Cheers,
>=20
> Regards,
> -Bin.

Cheers,

--=20
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-8DiKZ71yBmb+gr2Xl35R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlrbGYsACgkQhP3B6o/u
lQxbbQ/5AYON/svk2ym7lwLpAUn6EVpIRT+ZG7JxLKvCD4BfdQAiRNYaYnVKcxPQ
NuF3jYP8gACdtOnZrskMmSS+Zw0tlW/w1fWSrEONypy1ZryZSPrPugDqk0O6YKjr
/1Q/tdCO4uK+10Zv771JLHAXD+rC38bHzjVMm7d4yheb+jY4WMVwoEhJP/oKw34W
9iWX9KEg7SdnevJynwe/QGNnj4kRstsROvrs1CugdBiX33kG8vOXRvDVpuuODDSD
6tImTk60kX9OU2G1G6ILdPnOYrf+qd7jfqbebpI+HkKuFA5S+xDUMK2PEeag6Ajn
czi97IhijombUZLsK4IRw9WLAcZ8vaf61BcDyS3wzPuFJMKAJ7yt1PzqndNqwbUA
LFnsOdWIfyuNQSQk0YAHrGTd7pt5wauzqV6iHXZvoNvBPCS7/PthgrKcKYsFvUsw
wIIHVfXPP4o1dguRgR01q3cjauY9N9poRrI82b0UjsUN2BFoSLsiBmqFfEZLXUh+
IIf0BjVntb/PVBkd44qOqFVcYR2+MC1Mk96seeiViKiNmAVfrRHLR0O3GBiLL4IT
sOyOAFdIWPKjLgial/qTNqwNaGkgIffBep9xf5fZ7l5Lug7pN/T09yqfxaCTBXH6
17OMeoKHgsJiD5UWUOT/YipgLiRyJqFB63bJOmV5MyUSdKr7nc0=
=2jtG
-----END PGP SIGNATURE-----

--=-8DiKZ71yBmb+gr2Xl35R--

