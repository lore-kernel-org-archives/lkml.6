Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87586C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EBC20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EBC20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbeLKUFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:05:30 -0500
Received: from sauhun.de ([88.99.104.3]:45364 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeLKUF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:05:29 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id BC5284C0E90;
        Tue, 11 Dec 2018 21:05:27 +0100 (CET)
Date:   Tue, 11 Dec 2018 21:05:27 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
Cc:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 2/3] i2c-axxia: check for error conditions first
Message-ID: <20181211200527.t42yj5xcv4ijuoaj@ninjato>
References: <cover.1544453688.git.krzysztof.adamski@nokia.com>
 <d9a8070357973b5078dc897a18f319cba1df5de0.1544453688.git.krzysztof.adamski@nokia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v2trzgsti2cxbi6h"
Content-Disposition: inline
In-Reply-To: <d9a8070357973b5078dc897a18f319cba1df5de0.1544453688.git.krzysztof.adamski@nokia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v2trzgsti2cxbi6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 03:01:27PM +0000, Adamski, Krzysztof (Nokia - PL/Wr=
oclaw) wrote:
> It was observed that when using seqentional mode contrary to the
> documentation, the SS bit (which is supposed to only be set if
> automatic/sequence command completed normally), is sometimes set
> together with NA (NAK in address phase) causing transfer to falsely be
> considered successful.
>=20
> My assumption is that this does not happen during manual mode since the
> controller is stopping its work the moment it sets NA/ND bit in status
> register. This is not the case in Automatic/Sequentional mode where it
> is still working to send STOP condition and the actual status we get
> depends on the time when the ISR is run.
>=20
> This patch changes the order of checking status bits in ISR - error
> conditions are checked first and only if none of them occurred, the
> transfer may be considered successful. This is required to introduce
> using of sequentional mode in next patch.
>=20
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>

Applied to for-next, thanks!


--v2trzgsti2cxbi6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQGIYACgkQFA3kzBSg
KbYrpA//cyXc4G0XUB9HpGQS645etLcUQTo3h0wf9DojLPegTXn2EiCm8SZ1eOvT
voMrmQ9mlkB46ewdn6u2UYZB/QZvVE/IZRP0Wwv5vARxpjcCpMYHK6gdomSwe1YH
Y6NyfW6JAopk+WOkB3zEWAjwo5Kaf329vbIWOLImBpIJGwrg36V8gD0qJRGTfz4E
Dmws4jAeAz0tH/2PhSHualquiObcHO4XWnmEgp9nf7Z4mhfpN7/LQ4R1u7P6wtuk
xiQS5w+jl1iBtBTsIirnNBxi8QlezuqUHqN8/XDM2tmBAFz2OC1wsKMTyWDtIhnZ
SB0Z58uj2zOCZF6fbv6A9C6rJw/umoV0qx41IqngGdCQS8mdICycLWIELz90nwZo
7JyT0Ec1yMvobHoOrrJaDbylyI33Bl4YPjdiEdoRxFHa/zUHIfWK5VmqdiWC/V+K
yJEbumyQc5OaV/T3J4HtCwFEjSZKDMguKmYdmJpIVKgK+Rx/13qiSBVjHdmdGqbj
PAA1OBEH0+VCZBX53WPRMaW/RBJuvN77uTgfuVLD2b2ET/WU0J0vee3yitvF+eTw
6gFDxfCoMyaPSdx2na6gFc5v/DOvi0bnjXiSQnj2wcDiSH5WwQYz+Kt6A84rIuZx
UUD/pj+G2gciiGYINS9UNibnpCmdQ2mK6Rz/QFbs5qpUTp9dVEg=
=jTOb
-----END PGP SIGNATURE-----

--v2trzgsti2cxbi6h--
