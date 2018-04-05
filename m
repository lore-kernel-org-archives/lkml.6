Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeDEJ7b (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:59:31 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40999 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752006AbeDEJ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:59:28 -0400
X-Google-Smtp-Source: AIpwx4/YR02UYWa/+sXK3PERpMlk/GjgY4JWfo2EJGjOZwUJ+bht9ygExzhehbTqpFyyxqlMvMwWeQ==
Date: Thu, 5 Apr 2018 11:59:24 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Tejun Heo <tj@kernel.org>, Patrice Chotard <patrice.chotard@st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] ata: ahci-platform: add reset control support
Message-ID: <20180405095924.GB7506@ulmo>
References: <1521768653-11824-1-git-send-email-hayashi.kunihiko@socionext.com>
 <20180405095429.GA7506@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <20180405095429.GA7506@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 11:54:29AM +0200, Thierry Reding wrote:
> On Fri, Mar 23, 2018 at 10:30:53AM +0900, Kunihiko Hayashi wrote:
> > Add support to get and control a list of resets for the device
> > as optional and shared. These resets must be kept de-asserted until
> > the device is enabled.
> >=20
> > This is specified as shared because some SoCs like UniPhier series
> > have common reset controls with all ahci controller instances.
> >=20
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
> >  drivers/ata/ahci.h                                 |  1 +
> >  drivers/ata/libahci_platform.c                     | 24 ++++++++++++++=
+++++---
> >  3 files changed, 23 insertions(+), 3 deletions(-)
>=20
> This causes a regression on Tegra because we explicitly request the
> resets after the call to ahci_platform_get_resources().
>=20
> From a quick look, ahci_mtk and ahci_st are in the same boat, adding the
> corresponding maintainers to Cc.
>=20
> Patrice, Matthias: does SATA still work for you after this patch? This
> has been in linux-next since next-20180327.
>=20
> Given how this is one of the more hardware-specific bits, perhaps a
> better way to do this is to move reset handling into a Uniphier driver
> much like Tegra, Mediatek and ST?
>=20
> That said, I don't see SATA support for any of the Socionext hardware
> either in the DT bindings or drivers/ata, so perhaps it'd be best to
> back this out again until we have something that's more well tested?

Tejun,

I just noticed that Linus already pulled this for v4.17, so backing out
isn't going to work anymore. Still, I don't think this is tested well
enough, and given the lack of users of this I think a revert is the best
option at this point.

Thierry

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrF83wACgkQ3SOs138+
s6FsGw/+NGCyYB3zZfQTbmWc6w7aQKkTM68wBIKQ8CfnEP1Jt95ldFZqpiMyWw+7
F1TWFxuKgn7t0GcABzlczYHvAkxDE9u+JFyuOh8vzLQctkOcLFmhlegKjwrT8UUp
+0MVxMtNptCyQ2qF9Z65uKuRbRgnltHtaapt6OpS9mBf15ssvC8NMxl/l2FSRcbk
dPJ3kxTmx5CAS3SHMQV81kO+vJ3HL2zIcDKRIbJfj6lIM0vPtSOWWety4eEVxJpo
cMejkZfmeQ7iLO5EbAkmeG44RnWsk75BzUN/QKnyPRUlL4owsTRu9HyY5f3K2vO9
Ap0giLD2y3Rp5pLwqW68BVP0+bco362Yv9d6XEjCma1Pq5cBDNX3F+ig3p8+t0j6
Ijdzk5G5vKxo3f0xS7L8IkctvQhmSAsRG90BPO/8rDpWxopv3RAWFjYQ18EtZG3q
jI8MZCQsUF/+JX8XM5olnNj0q9MIaFncBX7Sd9kcEmPzkdDlWhRMBcVjO6Mj+4qm
HjoMFhrfadK0AhO7TD84SLIC+puGu5blfB6GBfsAcx1e7vAL8fRZe92p3TKm8wT1
F4taQb3ysHufJySo3ykBN7vkblSm5ZhBbbxgMWyvYQ2AvSrG+ejK7m25UZ2EZxSU
lluwb4yIdnyo3FHbX25akiz/Ph7F9iT1bGaRLzs4SAHl+/xV64U=
=Z69j
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
