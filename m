Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9913C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C369520855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfBKN24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:28:56 -0500
Received: from sauhun.de ([88.99.104.3]:54652 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbfBKN2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:28:54 -0500
Received: from localhost (p54B333B4.dip0.t-ipconnect.de [84.179.51.180])
        by pokefinder.org (Postfix) with ESMTPSA id 17ACF2E3542;
        Mon, 11 Feb 2019 14:28:52 +0100 (CET)
Date:   Mon, 11 Feb 2019 14:28:51 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        peda@axentia.se, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V18 4/6] i2c: tegra: Add DMA support
Message-ID: <20190211132851.pxrawigdgggoc32k@ninjato>
References: <1549652382-5476-1-git-send-email-skomatineni@nvidia.com>
 <1549652382-5476-4-git-send-email-skomatineni@nvidia.com>
 <20190211125509.tnsgfl3yoobdpnmj@ninjato>
 <ed92df42-459e-26fd-ce4e-f4530bf30783@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zeqgcqe6d7redppc"
Content-Disposition: inline
In-Reply-To: <ed92df42-459e-26fd-ce4e-f4530bf30783@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zeqgcqe6d7redppc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

> > I am not sure if you are aware of this document, so I mention it:
> >=20
> > Documentation/i2c/DMA-considerations
> >=20
> > I am not pushing you to use the i2c_get_dma_safe_msg_buf() helpers,
> > just wanted to make sure you know about them. I am also fine with an
> > incremental patch on top of this if you want to add usage of those
> > helpers somewhen later.
>=20
> At least I was not aware of those helpers. It looks to me that the
> approach of having a statically allocated buffer is more optimal than
> having to allocate and map the buffer on each transfer.=20

Can be argued, yes.

> >>  /* Match table for of_platform binding */
> >>  static const struct of_device_id tegra_i2c_of_match[] =3D {
> >>  	{ .compatible =3D "nvidia,tegra194-i2c", .data =3D &tegra194_i2c_hw,=
 },
> >> +	{ .compatible =3D "nvidia,tegra186-i2c", .data =3D &tegra186_i2c_hw,=
 },
> >>  	{ .compatible =3D "nvidia,tegra210-i2c", .data =3D &tegra210_i2c_hw,=
 },
> >>  	{ .compatible =3D "nvidia,tegra124-i2c", .data =3D &tegra124_i2c_hw,=
 },
> >>  	{ .compatible =3D "nvidia,tegra114-i2c", .data =3D &tegra114_i2c_hw,=
 },
> >=20
> > Shouldn't this be a seperate patch?
>=20
> I asked for this change and no, it shouldn't be a separate patch as it
> adds "has_apb_dma =3D false" property for T186 that older Tegra's have
> as "true". Without this change T186 uses tegra_i2c_hw_feature of T210,
> see [0]. Hence this change is absolutely correct and appropriate for
> this patch.

Then please update the patch description to contain this information.

> > This should definately be a seperate patch. While I am all for taking
> > it, are you sure it does not regress on older Tegra platforms?
> >=20
>=20
> All the patches are tested on older Tegra's (T20/T30 specifically by
> me) and we fixed several bugs that were regressing them over the few
> versions of the patchset. I specifically asked for this change for
> older Tegra's because the APBDMA driver (T20-T210) is getting
> registered from the module-init level and hence I2C driver probe is
> always getting deferred. I'm not sure that it's worth to factor out
> this hunk into a separate patch as it's directly related to the DMA
> support addition, maybe worth to mention why this is needed in the
> commit message.

At least, this, yes.

Thanks,

   Wolfram


--zeqgcqe6d7redppc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxheI8ACgkQFA3kzBSg
Kba4nA/+JPpDKhEe1m4cyv2HP4wvhFQWP2VcdBlTmazt9YSoMVd0GHs6jmzVXKF3
xcz3FFh+8SNP6xjXW62kTOEzSCexbqSSk/uoFMq8o1svZrHvLJv80iQiaIRCXfw6
jnm/NGlJ92hXTf7TDcMhp+v3QygQda0srZWHWBkSnvBp42rPWVAqMj5kVDCsa1mR
pFPnhUXVsRsYxh+yjrSVl8LifP7XdaBI3mROQwnJjjKWMgf7GA40odMQwvvagw7o
kPrNvVGxNajcAftUZkN0rLzBoJq71t5HpRsSX9XsxS9OBvtXRKA+rokeIgrD8vmw
sc+LbbH/QKc81oPV4tR0Fgpl2lMiTF2q2lkXbkNNlPvhNAFYeeRqBB9M0IEcNZVu
QOGMRZjbA7BXuN4p5lmQuE7lOOCBfuD+mE6zL/bbAQ66NmlKhrW5u3STHGv9SK4r
fMWdkU0uQqTHE27mmiEopCTL/LUp0ZdXzUf+xqx9MBO0sFb3G9czVvh4fRZSgZ4D
Et1qm/TPjZW6sVJGKIWsS4yBVnFnsJ1aFuW85fHYy9151OQ6+rMQ1r0r2xJLzKzr
1rGa4folV52oLKFPT4SeE4uguMrvnH1XwXShZqQbuDt+59KshvZIluBRLFpQm+an
ek/jOQaVOBGWEUuVs0VG4KLq5It0rYMtWCYOrF0jPyGntLV8XGA=
=91ks
-----END PGP SIGNATURE-----

--zeqgcqe6d7redppc--
