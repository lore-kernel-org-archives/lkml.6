Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B9FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 23:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A488213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 23:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A488213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeKXKIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 05:08:19 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40720 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeKXKIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 05:08:19 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A367B8080F; Sat, 24 Nov 2018 00:22:02 +0100 (CET)
Date:   Sat, 24 Nov 2018 00:22:04 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-pm@vger.kernel.org, sre@kernel.org,
        Sameer Nanda <snanda@chromium.org>, gwendal@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        Adam.Thomson.Opensource@diasemi.com, kernel@collabora.com,
        bleung@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v2 1/2] power: supply: add input voltage limit property.
Message-ID: <20181123232203.GA3852@amd>
References: <20181122101119.29194-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20181122101119.29194-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> We have a problem with USBPD chargers which under certain conditions
> can result in system overheating if the voltage provided by the USBPD
> port is too high. While the preferred means to control this would be
> through devicetree or ACPI settings, this is not always possible, and
> we need to have a means to set a voltage limit.
>=20
> This patch exposes a new property, similar to input current limit, to
> re-configure the maximum voltage from the external supply at runtime
> based on system-level knowledge or user input.

First, this should really be handled by dt / ACPI. If it is broken,
that's a hardware bug, and we can do DMI-based blacklists in kernel.

How are you supposed to fsck a system, for example?

> +What:		/sys/class/power_supply/<supply_name>/input_voltage_limit
> +Date:		Nov 2018
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Details the incoming VBUS voltage limit currently set in the
> +		supply. Normally this is configured based on the type of
> +		connection made.

"Details"?

Who can write to this value and when? What is the limit? If USB
charger is plugged in, should it show 5.0V (because that's nominal on
the USB) or 5.25V (because that is the real limit)?

Who can write to this and when. And what happens on write? What
happens if I write value that charger can't provide there?

Does it set the voltage power supply should produce? Or maximal it can
choose to produce?

This really needs better documentation.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv4i5sACgkQMOfwapXb+vLmQACfX+ba61v27dkM11pVow8bPETy
A+QAnjhSC4iTF6CvFqR/AUcL8p7j1D8i
=fgBu
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
