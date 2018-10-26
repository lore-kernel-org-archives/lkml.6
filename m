Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EDBC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4612085A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4612085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeJZRNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:13:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36135 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZRNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:13:15 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 34D3980728; Fri, 26 Oct 2018 10:37:03 +0200 (CEST)
Date:   Fri, 26 Oct 2018 10:37:04 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, lee.jones@linaro.org, tony@atomide.com
Subject: Re: [PATCH v4 2/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
Message-ID: <20181026083703.GB19434@amd>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181023170623.31820-2-dmurphy@ti.com>
 <20181024090421.GB24997@amd>
 <e8800c2e-8ada-7a0d-c1a6-14ddcbe1576d@ti.com>
 <20181024145434.GC9327@bogus>
 <beb1a6e1-8120-be94-b1a4-60ea6721765d@ti.com>
 <ade3121a-58ab-c0c3-6605-cf7d6a638da0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <ade3121a-58ab-c0c3-6605-cf7d6a638da0@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Do you have an opinion on this?
>=20
> This is this problem with the Device Tree's scope of responsibility.
> It is defined as a means for "describing the hardware", but often
> this rule is abused by the properties that fall into "configuration"
> category. E.g. default-state, retain-state-suspended from leds-gpio.txt
> or linux-default-trigger from common LED bindings.

"retain-state-suspended" is actually hardware property. On PCs,
(most?) LEDs will go off in suspend. On android phones, LEDs stay on
while suspended.

"linux-default-trigger" is actually kind-of hardware property, too. If
LED has an icon near it (or on it), you want to use that LED in that
meaning.

(Thinkpad X60 has "wifi", "bluetooth", "numlock", "capslock", "hdd",
"power", "battery", "ac" and "sleep" leds. Surely we should use them
in that meaning?)

Now, if someone has leds labeled "user 1..user 4" and uses
"linux-default-trigger" there, that is kind of "more interesting".

"default-state" is similar (subset of "linux-default-trigger"); you
don't want power LED to go off during kernel boot...

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvS0i8ACgkQMOfwapXb+vLjqACgjatlZKxvDsh7s57Ak6QfTOGa
VkUAn1MXdUw/FDBlf5gkAg9UxkandULr
=iBxY
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
