Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-729697-1522324743-2-15965144406903463570
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522324743; b=E+6Tc1o4zjg68GjhYop026aYBLZAC3lk4IH2T0y73+ko9efb2g
    gk8OawwjCq6DtmTG+xhOKTQktpe8wyGncny/f16n/3rOdnqPz+gjPpkVl5HFREc0
    5bVzNqK9DSl11wstFqKfTYVu+m71UkVKJ40JICKOTY0j1CSPOI6zzwbmcz+4nvfg
    d5KIqEUoO5pcTc4jqyw00hLDsafrR3Bk68rh6Px/hnh9CUY/ZCLdpeYiM2aFjje0
    BVvb9ZMNq/18xnHmPtC17jN2MXPzgHDg0MhsKH3Tdd9cviNU1Rgdrolb/6sEU+U6
    L3SH0ITHDDCUz5WVwfPobO9VY3m2KpSkzvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=fm2; t=1522324743; bh=gfi6E3XKvldUm1KQhUfMNaweD5qAqU
    srK1gdzpDRFsI=; b=hHJ2/27hEhLHSV1OFeu7XQGH9hY88+Lj7+h17wVe/LEmGV
    gkkeomSZENE6FoudTWE7cQpjqjGK25cGfjBmOWYUVl6qkw+Ywr2XyhUYeHyjzPoO
    7eNvcvI4H8Fy0SJwb3pPEYjkyBQqJ1RfDM2QM72rTSM6P62+mJfcg2ecsvjnMqGm
    npdM3b1OW8mNanlhfw+Ax66weSgdJ9NZgQQpmexnkxTA5UsShsrfmfB5HbtiJQCN
    sPidhvRgZ0+5Zc0isus2VHSeZAoyFqRl5LF0+HU6N8OHNcCMa6fTH3DSmsaEck2u
    JGNgs1H+gchsKs3Fre7wjO/ceEGYczbain37x8ug==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMEtldMJ1IC7K/HPRbi80OF7CGYm+bJTUGC2Brqm5eM3uvH1CV4q6rk+hiYKbekSjkFLBW+8+gidJiPD+LJxhyVF4i/4GQ7Nv3pZJZXtLptzIBlTQkMm
    z4pb+a2/iTds5v+kRyr7dUFZRW6kuYdMQG9C7DyO7vEpG+XDKagx0RQjdAEmIv5QCbJThnynx9Mj6BEJjZ/5x654Ck28nqwU+h/poZ2hj3ga/g4KtiAykE7e
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=IdJFWWI85r74tdz4cSsA:9
    a=QEXdDO2ut3YA:10 a=rAv8AF94x66OHheUBdgA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeC2L6d (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 07:58:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38492 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751896AbeC2L6a (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 29 Mar 2018 07:58:30 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        shortcircuit=ham autolearn=disabled version=3.4.0
Message-ID: <1522324644.1746.19.camel@bootlin.com>
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bin Liu <b-liu@ti.com>, Chen-Yu Tsai <wens@csie.org>,
        Paul Kocialkowski <contact@paulk.fr>
Date: Thu, 29 Mar 2018 13:57:24 +0200
In-Reply-To: <20180329092326.dayuccomq5zrywqo@flea>
References: <20180328215213.29538-1-contact@paulk.fr>
         <20180329092326.dayuccomq5zrywqo@flea>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-KcNAmPIYuaVfct/gmWzv"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-KcNAmPIYuaVfct/gmWzv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2018-03-29 at 11:23 +0200, Maxime Ripard wrote:
> On Wed, Mar 28, 2018 at 11:52:13PM +0200, Paul Kocialkowski wrote:
> > This allows dual-role ports to be reported as having gadget mode by
> > the
> > musb_has_gadget helper. This is required to enable MUSB at all with
> > MUSB
> > glue layers that set the port mode to MUSB_PORT_MODE_DUAL_ROLE at
> > init.
> >=20
> > Most notably, this allows calling musb_start when needed in the
> > virtual
> > MUSB root HUB, regardless of whether the current mode should be
> > gadget
> > or host.
> >=20
> > This fixes USB OTG on Allwinner devices that I could test it with,
> > mainly A20 devices.
> >=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>=20
> Surely there's more to it than that. The gadget mode of A20 boards
> have been working in the past, including when compiling with mUSB
> setup as dual role.
>
> Is this a regression since a particular commit? Or is there another,
> deeper issue overlooked in the commit log?

The root of the issue here is that musb_start is not called at any point
without this patch. My understanding of the flow is the following: when
the PHY detects that there was a VBUS/ID change, it will notify its
listeners (mainly the musb sunxi glue layer). This will then schedule
the driver's work (sunxi_musb_work), which does nothing since the
SUNXI_MUSB_FL_ENABLED bit was never set. This bit is only set after
calling sunxi_musb_enable, which is called from musb_platform_enable,
that originates from musb_start.

Currently I see two places where musb_start is called:
* musb_virthub
* musb_gadget

In the latter case, it is in turn called from udc_start, which should
probably (correct me if I'm wrong) happen later in the call chain than
ID/VBUS change notification time.

In the former case, musb_start is called in the root controller hub
control, when setting the USB_PORT_FEAT_POWER feature. This looks
perfectly legit and IMO this is where it should be initially calling
musb_start in the dual role case. The kernel is indeed setting the
feature, only that it fails to enable musb without this patch.

First, I'd like to make sure that this understanding of the flow is
correct as I may have missed something here. Does it make sense?

Then, it seems that the offending commit is: be9d39881fc4f
("usb: musb: host: rely on port_mode to call musb_start()")

That itself fixed: ae44df2e21b5
("usb: musb: call musb_start() only once in OTG mode")

Still, this commit was authored in June 2015, so almost 3 years ago.
In the meantime, the sunxi driver has received feature improvements, so
it seems hard to believe that it was broken all this time...

Cheers,
--=-KcNAmPIYuaVfct/gmWzv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlq81KQACgkQ3cLmz3+f
v9FG7wf/VJuW12NwGOEyikbF5OZwdaANUeHk2zHL+Zqx6b4qGIGIC9beqWsmXilk
disH1wNFb6VA3D4iAQRuvqke4euBlofR+yOyhw+cdMaFglpgeBzI0yG+zsvHsXzj
SxV34r7/pMLIv/6B6PFLZz9KprOu2+W7hWH2vYX49yo1EWrxb4IwKMbzjxCVQXWQ
+IUZ3S28I79N+bHjU0E8XUh86tVrnw7zxN3m5h+8DcOslaUTTAcXiM2H1V952iNG
tCC0ysdoAOSCNik39lW3N8LnDaQguViAElQkJZwqA43fJJEGyPUds6s3L0M8Ygrh
HC+/cI6jbQR56hlDhqUEe3kizt7lAg==
=KyHK
-----END PGP SIGNATURE-----

--=-KcNAmPIYuaVfct/gmWzv--

