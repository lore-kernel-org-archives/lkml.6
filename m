Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1992793-1525122546-2-6220807746309692229
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
    1525122545; b=E4IHP8bohSyqQrtJrez00Yup1s2XrSIWTxfm50RY6pgkwGsYx9
    TGD93DvBZeKo0wxv58Jc4jqTh1NLJhqmkkXPQANS/DDWARio+EAb7FJ/+gfrjMSQ
    krS8OgTMvrvqi3MEGsJqH9TSuUuAsKNKTSowDC6kgSlbEkMXc/KLr0QnJp030+e2
    ZTXNrfaNh0IKU4isSLh/Lyzx8PGl/ahsnVAxs3KNz6h5jRWvKTMDCIsdX7Sk9mnT
    yXLcT9bofx4zBQHKrSEe+aCd53/MxBFqeQ5Fd0gwdnjX8uWATtfu4N0oqKEYNd3J
    rkJ5FdkgRtDo3DJP915enDEaWIjnVqCvq0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=fm2; t=1525122545; bh=oyq46JAKd3/MroNElqI13HF832oM9n
    6QhvhXiHgu4bs=; b=ZIyMPFErNF8mt1k3oqy8F3pD9wmFBBugpDVrvpJ3pmNJp9
    ov0oXSy+wD5BJI7JRxlq6T2ryymeNnQulXncNNF+f51CnmgbXofA+Q+PVtOR7rn7
    ouWndG7cA0F33D3KaA2pkHqoqSZKBG/ZbwAATE/eYde120zywkQwH+n0LJS313IK
    GUchs3ddonPuZG/9sJLiiU/v6FY/B4lcC1QcMEAaWXb+tulr7WFDc0y0TuoO/Sl4
    chRHCETll9ng/Oea6Y45CcqHUSiKxEO6ZL853v8ov8KXh3dK5lDm51GWoS4phA0Z
    TEwNNcW170uHs6LdNjnm4l8h1hepW7DPQXFWXbUw==
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
X-CM-Envelope: MS4wfNJ8ki+DGbX7SPLM8Rc62wJ9mUa9CKVeeqE+xogj+saNfgc32mKZvX0YVCyDX+Oy4w9cJPdk8Pta85G2Dq/oS7yLMDFE0vze3ZFWSw4YfOCl6RuHtAWd
    EJoIESil7HzD0FHSzOEBmqR33g8ZchOe8mDh1ybBHBn/Ejf9psQxHKGdXV2gikwvxsNfx7bwHsHrKZAXVd9A3+H+iVTiqREopOnK8I27kElnnQLzn5gwLRMR
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=xjq4MWndAAAA:8
    a=0485AkorzmivJIJj8u4A:9 a=F28t9At1f71cnSMy:21 a=LLXO_2ajy6Nb4w8j:21
    a=QEXdDO2ut3YA:10 a=GvD6jnfTZE7iLDzLMSAA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10 a=LM-bNg79Vred_kxi5WFf:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755132AbeD3VIv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 17:08:51 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:42120 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753522AbeD3VIu (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 30 Apr 2018 17:08:50 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on gagarine.paulk.fr
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        autolearn=disabled version=3.4.1
Message-ID: <b24cf58d2f48519893a5051a98bee6579c5e0d98.camel@paulk.fr>
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
From: Paul Kocialkowski <contact@paulk.fr>
To: Bin Liu <b-liu@ti.com>
Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>
Date: Mon, 30 Apr 2018 23:08:42 +0200
In-Reply-To: <20180421143426.GA10632@LTA0271908.dhcp.ti.com>
References: <20180328215213.29538-1-contact@paulk.fr>
         <20180329092326.dayuccomq5zrywqo@flea>
         <1522324644.1746.19.camel@bootlin.com> <20180420142524.GB29011@uda0271908>
         <2db056d6f65ecbcdc4f31a37fe2e1b1ddfb93c87.camel@paulk.fr>
         <20180421143426.GA10632@LTA0271908.dhcp.ti.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5NtbenmJn7WABbHNuZ0P"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-5NtbenmJn7WABbHNuZ0P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le samedi 21 avril 2018 =C3=A0 09:34 -0500, Bin Liu a =C3=A9crit :
> Okay, this came down to an argument that whether we should require
> loading a gadget driver on a dual-role port to work in host mode,
> which is currently required on musb since a long long time ago.
>=20
> I understand the requirement is kinda unnecessary, but since it
> already
> exists on musb stack for a long time, I don't plan to change it.
> Because I
> cannot think of a use case in real products that doesn't automatically
> load a gadget function on the dual-role port.
>=20
> If you can explain a use case in real world (not a engineering lab)
> that the gadget driver will not be loaded at linux booting up, but
> later based on user's input, I will reconsider my decision. To remove
> this requirement from musb stack, the work is more than this patch.

My use case here is to support common GNU/Linux-based distributions, not
use-case-specific varieties of GNU/Linux-based rootfs. So my point here
would be that most distros will (and probably should) ship g_ether as a
module but without any particular reason to autoload it, or any other
gadget module in particular, since the system is general-purpose.

Then, imagine a user wants to plug a USB device through OTG (say,
because it's the only USB port available at all on the tablet they're
using), it simply won't work. It won't be obvious to that user that this
is because no gadget is loaded, since what they want to do does not
involve using gadget mode at any point.

Do you think this is a valid use case? It surely is a common one and
perfectly depicts my situation.

Note that in addition to Allwinner devices, I also have omap3/4/5
devices for testing things. I don't think I have other MUSB-enabled
devices in my collection though, but I would be willing to test fixes to
this issue on the ones I have.

Cheers,

--=20
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-5NtbenmJn7WABbHNuZ0P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlrnhdsACgkQhP3B6o/u
lQxOIA//flqKQ30a/MiSGkr4vZSWWEoJsfcgxCC0w7J2Z41vtVBHZXh5mD/36uDn
k1D9uV8+QeJ45kZRPg0auqgENlu9hK/5EszhTYZt+nIIlVR2/wRTslidJQ9T758j
IsyNsUkaiVHFVGs/h/GORIHd4Mes1V4y/wPg14eBj/JAm0JirQTFVaJ8Are262HR
+FFCMgW0lkAwNTpC2+MFIMkbEdHPy8LKr6wVLFqIJ0skziBE49GQvep31u/43PmO
CEgf4YLYb/DQjk/uKJUfDuUNRPlh/MPcEzErDwBW1gLjnbOh74UTeoFGrZwHv+mk
6ay52VefGcwnY2s81LA78GpVCPpU9hM1173BUDgtzHnD6VoQwz7AvELNDdg4iXbs
l+AXBmomfkQr/7dkk2GVtUwZxTHkwxSd6W2uzB2nPCxH5kYXDDElaLrDUU1ORszP
WJDb804pbXO7I/oDeO2mStfHhxV/6hY8vcSqik8ZOANrzyjeM1bXXcMxIr/ORsPc
jd0jioyI7e6BlbLCMmLWcCfjbrZp2wLuXVXGGx9DIMmDs2+IVXT6myx+k8WYflgB
VCmxWv77hAmHm+rUTyg0X9LiVAycGDvxGYNgG5RBYEvzHGrhnLo6Hna2iEP4j8X9
IUtEgmRpcLbQi6G2Qlp4heuYYRP+rX5XquZtHWkp1mQ6Cc6pHtE=
=rkAO
-----END PGP SIGNATURE-----

--=-5NtbenmJn7WABbHNuZ0P--

