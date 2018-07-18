Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D50ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3139B2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3139B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbeGRIdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:33:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42505 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeGRIdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:33:19 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 09CC980558; Wed, 18 Jul 2018 09:56:37 +0200 (CEST)
Date:   Wed, 18 Jul 2018 09:56:37 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     David Lechner <david@lechnology.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
Message-ID: <20180718075637.GA10279@amd>
References: <CAMz4kuJfPKykB6G-8C25mmMCfQgefv-Y=k2OQYZR_e0Tvg3guQ@mail.gmail.com>
 <8da1b769-8aa3-9698-467a-2e7b0707fecf@gmail.com>
 <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
 <20180714212033.GA31950@amd>
 <00fa2693-9308-8d74-0124-04066a76c35a@gmail.com>
 <20180714222924.GA2776@amd>
 <20180714223907.GB2776@amd>
 <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
 <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
 <68996338-a902-2b57-0bb9-df274a496b06@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <68996338-a902-2b57-0bb9-df274a496b06@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>>I believe I meant "changing patterns from kernel in response to events
> >>>>is probably overkill"... or something like that.
> >>>
> >>>Anyway -- to clean up the confusion -- I'd like to see
> >>>
> >>>echo pattern > trigger
> >>>echo "1 2 3 4 5 6 7 8" > somewhere
> >>
> >>s/somewhere/pattern/
> >>
> >>pattern trigger should create "pattern" file similarly how ledtrig-timer
> >>creates delay_{on|off} files.

Yes, that sounds reasonable. v5 still says

+               Writing non-empty string to this file will activate the pat=
tern,
+               and empty string will disable the pattern.

I'd deactivate the pattern by simply writing something else to the
trigger file.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltO8rUACgkQMOfwapXb+vLjKACfW012LpW5uoDBam3r2Qm2oF5E
gvkAn0KKqm3gCQfLbptNBNf5B4nOoEv3
=uDUf
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
