Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE11C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0B8206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0B8206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeILB4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:56:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40715 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeILB4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:56:11 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7F37C80693; Tue, 11 Sep 2018 22:55:05 +0200 (CEST)
Date:   Tue, 11 Sep 2018 22:55:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: leds: Add bindings for lm3697 driver
Message-ID: <20180911205504.GA31219@amd>
References: <20180906135005.6718-1-dmurphy@ti.com>
 <20180906211617.GB16899@amd>
 <b8ac9d52-f16d-5fc4-0e9a-9246b9f984c5@ti.com>
 <20180907133228.GA16297@amd>
 <70f7506c-6a3d-3830-59a4-a246dc6163f7@ti.com>
 <226b8770-7041-39a4-5a06-6002a7c1225f@gmail.com>
 <20a814ce-a4c5-0649-6677-6b85a5fd2321@ti.com>
 <59561e0f-e3b9-7898-a300-90b198ad14e6@gmail.com>
 <20d9ea9e-bbb8-2240-97cc-615e3fbcef8c@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20d9ea9e-bbb8-2240-97cc-615e3fbcef8c@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>>>> And I think Jacek pointed out that the bindings references in this=
 bindings
> >>>>>> don't even exist.
> >>>>>>
> >>>>>> I am thinking we need to deprecate this MFD driver and consolidate=
 these drivers
> >>>>>> in the LED directory as we indicated before.  I did not find any t=
i-lmu support
> >>>>>> code.
> >>>>>>
> >>>>>> ti-lmu common core code and then the LED children appending the fe=
ature differentiation.
> >>>>>
> >>>>>> Need some maintainer weigh in here.
> >>>>>
> >>>>> Hehe. I'm maintnainer. Fun.
> >>>>
> >>>> I know.  I want to see if there was any other opinion.  Especially f=
or the LED driver.
> >>>>
> >>> [...]
> >>>
> >>> I have a question - is this lm3697 LED controller a cell of some MFD
> >>> device? Or is it a self-contained chip?
> >>>
> >>
> >> This is a self contained chip.  And the LM3697 only function is a LED =
driver.
> >> It does not have any other special functions like the LM363X drivers f=
or GPIO and Regulator support.
> >=20
> > This is an argument for merging it as a standalone LED class driver
> > then. It is even more justifiable, taking into account uncertainties
> > related to the proper way of adding the support for it to the existing
> > MFD driver, whereas the code reuse would be the only advantage of having
> > thus support in MFD subsystem.
>=20
> Does the argument carry over to the other devices?

We really need something reasonable, that works for stand-alone LEDs,
and also works for LEDs that are part of MFD when the hardware is similar.

> Like the LM3632 (part of the ti-lmu) has flash and torch and no other spe=
cial functions
> so it would look like the lm3601x family with different register mappings.
>=20
> The LM3631 seems to also be just a LED driver with no extra functionality
>=20
> I could go buy an EVM and put together a driver for that device as well u=
sing the lm3601x as
> reference.

I do have hardware with lm3532. I can test patches, and I guess I can
port driver easily if it is obvious how to do that.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluYK6gACgkQMOfwapXb+vJeLQCfWQ7anjcBVUXTC+aWZLaKUAsg
hEQAnjWTxChz1TwWcNQSsImAE80flgsJ
=El4Z
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
