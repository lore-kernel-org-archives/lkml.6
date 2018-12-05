Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A04DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288F6206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288F6206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbeLEPre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:47:34 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50112 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeLEPrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:47:33 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A0879260732
Received: by earth.universe (Postfix, from userid 1000)
        id F0E7A3C08D6; Wed,  5 Dec 2018 16:47:28 +0100 (CET)
Date:   Wed, 5 Dec 2018 16:47:28 +0100
From:   Sebastian Reichel <sre@collabora.com>
To:     Benson Leung <bleung@google.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pm@vger.kernel.org, Sameer Nanda <snanda@chromium.org>,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        groeck@chromium.org, Adam.Thomson.Opensource@diasemi.com,
        kernel@collabora.com, bleung@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v2 1/2] power: supply: add input voltage limit property.
Message-ID: <20181205154728.3yhxhov5iltb3ncl@earth.universe>
References: <20181122101119.29194-1-enric.balletbo@collabora.com>
 <20181123232203.GA3852@amd>
 <c122a1f9-70d7-7129-f139-4a0449c366a5@collabora.com>
 <20181201150934.GA7052@amd>
 <20181203195845.GA120704@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ba4s4b6eedhcf5xy"
Content-Disposition: inline
In-Reply-To: <20181203195845.GA120704@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ba4s4b6eedhcf5xy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 03, 2018 at 11:58:45AM -0800, Benson Leung wrote:
> On Sat, Dec 01, 2018 at 04:09:34PM +0100, Pavel Machek wrote:
> > > I think that handle this via dt / ACPI is not possible for our use ca=
se. It can
> > > be a hardware bug or a hardware/user constrain, let me try to explain=
 better
> > > with an example.
> > >=20
> > > On Pixel C's devices, userspace uses this to set a USB input limit of=
 5V when
> > > the screen is on for thermal reasons, but those go away when the scre=
en is
> > > off/system is sleeping, so we allow 9V and 12V levels when sleeping.
> >=20
> > So, on pixel C, what happens if userland ignores the constraint, keeps
> > display on and sets charger to 12V?
>=20
> I was the software tech lead for the Google Pixel C and was involved in t=
his
> particular code change in 2015 before the release of the product.
>=20
> So there's nothing fundamentally broken about the hardware that would cau=
se
> the Pixel C to malfunction if we were charging at 9V or 12V instead of 5V
> when the screen is on, ie if userspace doesn't change this.
>=20
> This is part of the Pixel C's thermal management strategy to effectively
> limit the input power to 5V 3A when the screen is on. When the screen is =
on,
> the display, the CPU, and the GPU all contribute more heat to the system
> than while the screen is off, and we made a tradeoff to throttle the char=
ger
> in order to give more of the thermal budget to those other components.
>=20
> What would happen is that you wouldn't meet Google's skin temperature tar=
gets
> on the system if the charger was allowed to run at 9V or 12V with the scr=
een
> on.
>=20
> For folks hacking on Pixel Cs (which is now outside of Google's official =
support
> window for Android) and customizing their own kernel and userspace
> this would be acceptable, but we wanted to expose this feature in the pow=
er
> supply properties because the feature does exist in the Emedded Controller
> firmware of the Pixel C and all of Google's Chromebooks with USB-C made s=
ince
> 2015 in case someone running an up to date kernel wanted to limit the cha=
rging
> power for thermal or other reasons.

I'm fine with merging this with the above description. I hope
vendors never decide to move safety relevant decisions to userspace.
Enric, can you please integrate the great description from Benson
into the patch description?

Thanks,

-- Sebastian

--ba4s4b6eedhcf5xy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwH8xAACgkQ2O7X88g7
+pojMhAAk7jbNNu6VQwLLFqMCVKFpwlmIvbK1h6T0nhkcTZelrxfroZNDBCOxn7j
QVfeN0URhtBXXtWtzC1GyYw8is/TypE4SJurz0p5q67pUZ+AYvvzTFNiR2Uwadj/
OxJcMSF6+IdANyKG8BIbEhw+P2MYP9J8PyMGMHCa8Qdzaor3leT17qHMhDiVYISF
2gchnoTxUQWoHSMpcsBx/h/RxsSwLWANTFbPiuhv8pq6gUu+IPpBTx+oRV2XXbyR
6L3TWg0w7mY3vyn1Cc7IeQfk/WBP8XQl8HnoVT557rf5r955NXOVwr8ePKQCJCkb
+Zg3UTMIk+N+9EdzMREjdMc41y4M8LhlS6IgcLvG1wiOygkgBECSiuEO7s7xPROM
YlRuIDUxUQFvj40k06fQPiCepkCOokH1mlnPpxSmG2BzYMaqfT9Z+tfn2DOKed4I
bTWGDUmwf95ovV59f6Fa3dXAaf5yWV8X85a2O2o5poXYFjI3BIYenW7pkHcoQ2Pe
jX8oB4KxayMiGPFGLwM7u8OOFwbJ8KBVB1saHOA43Z+/4mHdJv+H0uCDUXuewo3+
pekSTcpsWno0pzfmJNgh9oFswjjv3un+3XIS53WbDCVEOKuyJPCcPNkoCeFCMYSy
u6C091g0U0LR06glW1Vz5naal2H9b7sL6SMvLsZ8X69l4ANfrx8=
=izEY
-----END PGP SIGNATURE-----

--ba4s4b6eedhcf5xy--
