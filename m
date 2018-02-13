Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935133AbeBMMsP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:48:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:54548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935077AbeBMMsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:48:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0676B217B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Tue, 13 Feb 2018 13:48:10 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: arnd@arndb.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] power: reset: Add Spreadtrum SC27xx PMIC power off
 support
Message-ID: <20180213124810.oyf4ec5bpbnsnkqy@earth.universe>
References: <7655f39d44e804c9ed3209db475567abc250f642.1518169282.git.baolin.wang@linaro.org>
 <20180209123044.vjvkb3yfmk4gqfiv@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e3joup3i3zxrjweb"
Content-Disposition: inline
In-Reply-To: <20180209123044.vjvkb3yfmk4gqfiv@earth.universe>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e3joup3i3zxrjweb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Baolin,

On Fri, Feb 09, 2018 at 01:30:44PM +0100, Sebastian Reichel wrote:
> On Fri, Feb 09, 2018 at 05:43:38PM +0800, Baolin Wang wrote:
> > On Spreadtrum platform, we need power off system through external SC27xx
> > series PMICs including the SC2720, SC2721, SC2723, SC2730 and SC2731 ch=
ips.
> > Thus this patch adds SC27xx series PMICs power-off support.
> >=20
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>=20
> Thanks, queued. My public -next branch is waiting for 4.16-rc1,
> though.

I just dropped this patch. It does not compile as a module:

ERROR: "freeze_secondary_cpus" [drivers/power/reset/sc27xx-poweroff.ko] und=
efined!

There is no EXPORT_SYMBOL for freeze_secondary_cpus, so you either
need to add that or make the new driver built-in only.

-- Sebastian

--e3joup3i3zxrjweb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqC3ocACgkQ2O7X88g7
+prqDw//VCglygGLR9QIGoWI9+fIXUOp4vte5Ru9R4eqtLau1h6/Jt86n9OmQS6y
XLJf5PMfslOyvP62da+aYyEfI4UwEUbmxS/guhgksFMIFuG/Pdu8zoSU+fyuQxHc
rqUnJgr4jcn2643iirQMabBEXM66Uxdl7qiLFSFkPcUAPIuGPFsvD5B3sQrE58qM
UsaraVEhjDZvWCjHqy1nuUfZLXoeVFfOpZjtAK5sQrgSPAB5zEZlRVtjO8Z1nj4F
JTgeLMjLqAQZcltDIjkQOYcTPBSIU97TSGrUt56y50qL8bSug9ccYcW1qf4u/NEm
P9CFclrzp8tUSvBbcEkmDT/d3ToI//YYTQvm/e1pchdPxxMREg5IMO2wDmWkGtKg
czg9f9qRuHR0fzenSEzh6RsOgnditkFrCx5SIZembfRTfkB7bKr5ATxEbw34mSzb
RNaELFL4yqbewT6ImKC4JzQzYfsscY+viFhuJl+liJaSc9ZauCjoUK3xtyqL1ofP
df1eKZwQXLRXbNVF5BSeZSWJT8735Pav1LXrVGZbnrXsboiysx72b8eoCugfEk8M
1+ooJTI5ZDFIBpQR2tB202arzLSiTKaI5b/yc2hRV0anCvwIQ84Y4iH8iBhwKYM0
8OiKs6m/Z6+U+OfaiDy31Pf3hmHOMCj/bZt4Ie4fZRHiNtujjpU=
=oEbs
-----END PGP SIGNATURE-----

--e3joup3i3zxrjweb--
