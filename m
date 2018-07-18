Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F579ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509FB2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509FB2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbeGRW5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:57:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35173 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbeGRW5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:57:22 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1CCF780498; Thu, 19 Jul 2018 00:17:23 +0200 (CEST)
Date:   Thu, 19 Jul 2018 00:17:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     David Lechner <david@lechnology.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
Message-ID: <20180718221717.GA5451@amd>
References: <20180714212033.GA31950@amd>
 <00fa2693-9308-8d74-0124-04066a76c35a@gmail.com>
 <20180714222924.GA2776@amd>
 <20180714223907.GB2776@amd>
 <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
 <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
 <68996338-a902-2b57-0bb9-df274a496b06@gmail.com>
 <20180718075637.GA10279@amd>
 <913151e4-c19f-9a22-697c-52a9fb48cb32@gmail.com>
 <0e0cd8f7-dc73-6733-65f2-9a14506b0f0e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <0e0cd8f7-dc73-6733-65f2-9a14506b0f0e@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >Please keep in mind that this is ABI documentation for the pattern file
> >to be exposed by LED core, and not by the pattern trigger, that, as we
> >agreed, will be implemented later. In this case, I'd go for
>=20
> Gosh, I got completely distracted by the recent discussion about
> pattern synchronization.
>=20
> So, to recap, we need to decide if we are taking Baolin's solution
> or we're opting for implementing pattern trigger.
>=20
> If we choose the latter, then we will also need some software
> pattern engine in the trigger, to be applied as a software pattern
> fallback for the devices without hardware pattern support.
> It will certainly delay the contribution process, provided that Baolin
> would find time for this work at all.

I'd recommend the latter. Yes, software pattern as a fallback would be
nice, but I have that code already... let me get it back to running
state, and figure out where to add interface for "hardware
acceleration". I'd like to have same interface to userland, whether
pattern can be done by hardware or by software.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltPvG0ACgkQMOfwapXb+vLXtACfTKHNaRLxjr+WDpk/1nmcemfr
p4AAoI0XSXo2xJH9nrjOkmt2Vmgs9ACb
=kDS4
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
