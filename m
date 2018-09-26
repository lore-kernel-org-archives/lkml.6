Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58712C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010DE206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fabLs1MQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010DE206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeIZS6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:58:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbeIZS6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:58:06 -0400
Received: from earth.universe (guest-nat.fw1.untrust.par1.mozilla.net [185.155.181.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBE682083A;
        Wed, 26 Sep 2018 12:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537965916;
        bh=mjC4n+5OfD84aMTgqfy9a9aQBH2twpOTJ4FlpVVYRDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fabLs1MQ8jPBI+/VL2pNh+blPVpHvA1q9cFsRVxhJTbyAhuUT2zOnCY1AmsEOS3gt
         usZdNtIE0yDQBfZ1WsYsAH/ikRj9FCkIBY2V+aaKzJ7yK+h9FOLk2lEd2YyseNiUII
         T7UHT8folKvwH0jczDiRhDheyjgEEoTyAMJlLrBw=
Received: by earth.universe (Postfix, from userid 1000)
        id BEBD73C09D6; Wed, 26 Sep 2018 14:45:10 +0200 (CEST)
Date:   Wed, 26 Sep 2018 14:45:10 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>,
        Craig Tatlor <ctatlor97@gmail.com>
Subject: Re: [PATCH v2 1/4] power: supply: core: Introduce one property to
 present the battery internal resistance
Message-ID: <20180926124510.2ewnaw3jyzm3qkbm@earth.universe>
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
 <CACRpkdY3YsXsJy0OwGYLuB+x32hbkAHum4w5KQTCGoi-OXt-QA@mail.gmail.com>
 <CAMz4ku+H5Z_W5rE0b3GDz2E0YSZshEerufZ41yeh_E5omD6KLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5sdzrxlcfxsqscbx"
Content-Disposition: inline
In-Reply-To: <CAMz4ku+H5Z_W5rE0b3GDz2E0YSZshEerufZ41yeh_E5omD6KLA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5sdzrxlcfxsqscbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 26, 2018 at 04:30:39PM +0800, Baolin Wang wrote:
> Hi Linus,
>=20
> On 26 September 2018 at 16:00, Linus Walleij <linus.walleij@linaro.org> w=
rote:
> > On Wed, Sep 26, 2018 at 4:59 AM Baolin Wang <baolin.wang@linaro.org> wr=
ote:
> >
> >> Introduce one property to present the battery internal resistance for =
battery
> >> information.
> >>
> >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> >> ---
> >> Changes from v1:
> >>  - New patch in v2.
> >
> > I'm a bit confused by the physics in this patch.
> >
> > The internal resistance of a battery is not a constant in its life cycl=
e,
> > this varies over the age of the battery, and the reason I thing is
> > chemical residuals accumulating on the anode and cathode inside
> > the battery and the energy storage medium aging. (Plus/minus my
> > ignorance about how batteries actually work.)
>=20
> Yes, you are right. The internal resistance can be affected by
> temperature or battery age or other factors. But our solution just
> uses one constant internal resistance to calculate OCV value to look
> up the capacity table when system boots on, in this case we do not
> need one more accuracy OCV, since we will calculate the battery
> capacity in future. So we just introduce one estimation constant
> internal resistance.
>=20
> >
> > AFAIK the fact that the internal resistance varies is of high
> > importance for people developing algorithms of battery capacity
> > and longevity. Such that some (hardware) capacity monitors go
> > to great lengths to measure with high precision the current
> > internal resistance of the battery for their algorithms.
> >
> > Sorry for making things more complex, but should it be named
> > "factory-internal-resistance-micro-ohms" or
> > "typical-internal-resistance-micro-ohms"?
>=20
> I am fine with this change. If Sebastian also agree with this change,
> I will fix. Thanks for your reviewing and comments.

Ack.

FWIW for proper battery status you need to collect battery specific
statistics, that is the reason fuel gauge chip providers recommend to
combine the chip with the battery cells into a "smart battery".

-- Sebastian

--5sdzrxlcfxsqscbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlurf1MACgkQ2O7X88g7
+prdag/9HpJdthcFfUo/R15YTEMK4hm97zOgcj0ea5Ouhl9/h6C8Zwwgj4FdJQmG
IyEw1h2jgd/t8mFKieQ9lAg0PxZPx4Jon63JpNQZcZZ9lXk1JsvJo7X36aAQyhgN
pS6nB9aR+TW58FefD4C6CTKo+RMLrQqaQA7GrBXcPE06NrLAIcTCgk/ozjjjfOLF
HkBGOzFcGgwVBbHv79RQJ1b3vQ1Olb8fKaekEb6Q99LK0lvTpStiBbAlO2u7WcJF
RQdZ+zapIokl4vcRhMPtYasedCzlkBCbGdc3/PxMMN4UJwdUDEj8iNUFaKC1ELE7
zM2I4DdNsMMh7kj9ForxMfS4SbrII4PuyZL2j//BtV/Wkss61kwfzPBSgHP8dL5c
xx+aLelWITWQgq3JipRMmXyNPKHRtHO3hiCHyD+vexAGK9uVwrJv6hw1VZkrw4tK
9znek1s3hu30A/AmxK2CC7u1rHKRUGrf0n3FUDv1PvJC27PW7fZCL0agyuEVkJJB
qaHDIUIhmW56ZvdzdnEuXmGIuD4pxzRz2VIoyHtdq1igvolhuDAJ4mjTMNgTPbN1
U46SIDueinYiDrRpMTAcvWTTz75DJEFkNwIEhBAkhY442Ox0UA+4xuYZbJ6J+4Ch
tNxRmPgu1bMr4CmvXFcFlrVlYySXVkvAHqt87zj52dVLvGN9ils=
=gnFq
-----END PGP SIGNATURE-----

--5sdzrxlcfxsqscbx--
