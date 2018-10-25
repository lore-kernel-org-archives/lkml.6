Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE7BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B6820831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B6820831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeJYVlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:41:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36105 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeJYVlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:41:04 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C055F80848; Thu, 25 Oct 2018 15:08:19 +0200 (CEST)
Date:   Thu, 25 Oct 2018 15:08:20 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] leds: gpio: set led_dat->gpiod pointer for OF defined
 GPIO leds
Message-ID: <20181025130820.GA10294@amd>
References: <20181018001432.710-1-liviu@dudau.co.uk>
 <20181023111842.GA29083@bart.dudau.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20181023111842.GA29083@bart.dudau.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-10-23 12:18:44, Liviu Dudau wrote:
> On Thu, Oct 18, 2018 at 01:14:32AM +0100, Liviu Dudau wrote:
> > Commit 45d4c6de4e49 ("leds: gpio: Try to lookup gpiod from device")
> > removed the common code path that set the led_dat->gpiod pointer in
> > create_gpio_led(), but only added it back for the devices that have
> > a valid gpio_led_platform_data structure. Calling gpio_leds_create()
> > in gpio_led_probe() is not enough to get a valid gpiod pointer.
> >=20
> > Fortunately enough, gpio_leds_create() already gets the needed pointer,
> > we just need to assign it to the relevant gpio_led_data structure.
> >=20
> > Fixes: 45d4c6de4e49 ("leds: gpio: Try to lookup gpiod from device")
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> > Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvRwEQACgkQMOfwapXb+vLnlQCfVuN9x6W44LTDBA8LOvC3ydfe
PGEAn114L8PUMDo1fD6c3sbODcP4JeA/
=8K2O
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
