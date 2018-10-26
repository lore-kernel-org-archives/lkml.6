Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1346EECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A2A2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A2A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeJZRGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:06:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35926 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeJZRGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:06:46 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 93624808AF; Fri, 26 Oct 2018 10:30:36 +0200 (CEST)
Date:   Fri, 26 Oct 2018 10:30:37 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, lee.jones@linaro.org, tony@atomide.com
Subject: Re: [PATCH v4 2/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
Message-ID: <20181026083037.GA19434@amd>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181023170623.31820-2-dmurphy@ti.com>
 <20181024090421.GB24997@amd>
 <e8800c2e-8ada-7a0d-c1a6-14ddcbe1576d@ti.com>
 <20181024145434.GC9327@bogus>
 <beb1a6e1-8120-be94-b1a4-60ea6721765d@ti.com>
 <ade3121a-58ab-c0c3-6605-cf7d6a638da0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <ade3121a-58ab-c0c3-6605-cf7d6a638da0@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>>> +Optional child properties:
> >>>>> +	- runtime-ramp-up-msec: Current ramping from one brightness level=
 to
> >>>>> +				the a higher brightness level.
> >>>>> +				Range from 2048 us - 117.44 s

> This is this problem with the Device Tree's scope of responsibility.
> It is defined as a means for "describing the hardware", but often
> this rule is abused by the properties that fall into "configuration"
> category. E.g. default-state, retain-state-suspended from leds-gpio.txt
> or linux-default-trigger from common LED bindings.

I always assumed that ramp-up time is there because hardware (power
supply?) can not handle "too fast" switching. Missing capacitors or
something. If so, this needs to be in device tree.

If not, it indeed does not belong to device tree.

> In some cases this is justified. The question is whether it is something
> that necessarily needs to be configured on driver probing? If not, then
> I'd go for sysfs interface.

While this would be useful for hardware accelerated patterns, I doubt
we want to make it configurable without that support.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvS0K0ACgkQMOfwapXb+vIyNwCeK2RsHd75QVAKceaWGKzf+yBd
iaYAnjGeD0tqO06hau4IIW2z0QdfLLoD
=hzIb
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
