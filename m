Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C070ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 16:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56F0208E9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 16:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56F0208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeGORV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 13:21:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41725 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeGORV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 13:21:26 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 53F9380562; Sun, 15 Jul 2018 18:57:50 +0200 (CEST)
Date:   Sun, 15 Jul 2018 18:57:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] regulator: bd9571mwv: Add support for toggle
 power switches
Message-ID: <20180715165749.GA10023@amd>
References: <20180713154720.18316-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20180713154720.18316-1-geert+renesas@glider.be>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The ROHM BD9571MWV PMIC on the Renesas Salvator-X(S) and ULCB
> development boards supports DDR Backup Power, which means that the DDR
> power rails can be kept powered while the main SoC is powered down.
>=20
> This patch series extends the support for DDR backup mode (see commit
> 6eb0bfae6973eb6a ("regulator: bd9571mwv: Add support for backup mode"))
> to systems with toggle instead of momentary power switches.
>=20
> With a toggle power switch (or level signal), the following steps must
> be followed exactly:
>    1. Configure PMIC for backup mode, which changes the role of the
>       power switch to a wake-up switch,=20
>    2. Switch accessory power switch off, to prepare for system suspend,
>       which is a manual step not controlled by software,
>    3. Suspend system,
>    4. Switch accessory power switch on, to resume.
>=20
> Unlike on systems with a momentary toggle switch, an additional step 2
> must be performed in between step 1 and step 3.  Hence step 1 can no
> longer be handled in the PMIC's suspend callback.
>=20
> This patch series allows performing step 1 when the user writes
> "on" to the PMIC's "backup_mode" virtual file in sysfs, e.g.
>=20
>     echo on > /sys/bus/i2c/drivers/bd9571mwv/*/bd9571mwv-regulator*/backu=
p_mode

Do you expect more boards to have similar design?

If so, we may want to have standard place in /sys/ not depending on
i2c paths and driver names, but I believe such design is so... awkward
that it is not going to appear anywhere else...?

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltLfQ0ACgkQMOfwapXb+vILOgCbBFGjbwH2cufstj+Q+5TXiYPW
+OcAn27r+67d8CbVJRQrRJLTuI0tcHyA
=OScm
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
