Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EA1C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C212174D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C212174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeHXNpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 09:45:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36117 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeHXNpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 09:45:49 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 924EE83DF6; Fri, 24 Aug 2018 12:11:50 +0200 (CEST)
Date:   Fri, 24 Aug 2018 12:11:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20180824101145.GA1510@amd>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I think that it would be more flexible if software pattern fallback
> was applied in case of pattern_set failure. Otherwise, it would
> lead to the situation where LED class devices that support hardware
> blinking couldn't be applied the same set of patterns as LED class
> devices that don't implement pattern_set. The latter will always have to
> resort to using software pattern engine which will accept far greater
> amount of pattern combinations.
>=20
> In this case we need to discuss on what basis the decision will be
> made on whether hardware or software engine will be used.
>=20
> Possible options coming to mind:
> - an interface will be provided to determine max difference between
>   the settings supported by the hardware and the settings requested by
>   the user, that will result in aligning user's setting to the hardware
>   capabilities
> - the above alignment rate will be predefined instead
> - hardware engine will be used only if user requests supported settings
>   on the whole span of the requested pattern
> - in each of the above cases it would be worth to think of the
>   interface to show the scope of the settings supported by hardware

I'd recommend keeping it simple. We use hardware engine if driver
author thinks pattern is "close enough".

If human can not tell the difference, it probably is.

We may want to do something more formal later.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlt/2eEACgkQMOfwapXb+vKtBgCgp15fsv7FX679nW0h33YTmU70
KqwAoLsWGFNPvDCFIabrzTu9n1dvfmgM
=KBsf
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
