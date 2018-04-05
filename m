Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeDEJyf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:54:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55975 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbeDEJyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:54:32 -0400
X-Google-Smtp-Source: AIpwx49b+XPnDqeU2YxsOHNMyohIy3lOqYoK4focezfHEqgEf/A6+OadI+93NtWhveGzDOzH1ZZnPQ==
Date: Thu, 5 Apr 2018 11:54:29 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Tejun Heo <tj@kernel.org>, Patrice Chotard <patrice.chotard@st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] ata: ahci-platform: add reset control support
Message-ID: <20180405095429.GA7506@ulmo>
References: <1521768653-11824-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <1521768653-11824-1-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2018 at 10:30:53AM +0900, Kunihiko Hayashi wrote:
> Add support to get and control a list of resets for the device
> as optional and shared. These resets must be kept de-asserted until
> the device is enabled.
>=20
> This is specified as shared because some SoCs like UniPhier series
> have common reset controls with all ahci controller instances.
>=20
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
>  drivers/ata/ahci.h                                 |  1 +
>  drivers/ata/libahci_platform.c                     | 24 ++++++++++++++++=
+++---
>  3 files changed, 23 insertions(+), 3 deletions(-)

This causes a regression on Tegra because we explicitly request the
resets after the call to ahci_platform_get_resources().

=46rom a quick look, ahci_mtk and ahci_st are in the same boat, adding the
corresponding maintainers to Cc.

Patrice, Matthias: does SATA still work for you after this patch? This
has been in linux-next since next-20180327.

Given how this is one of the more hardware-specific bits, perhaps a
better way to do this is to move reset handling into a Uniphier driver
much like Tegra, Mediatek and ST?

That said, I don't see SATA support for any of the Socionext hardware
either in the DT bindings or drivers/ata, so perhaps it'd be best to
back this out again until we have something that's more well tested?

Thierry

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrF8lEACgkQ3SOs138+
s6H7EA//fqnLBMRIi+b3go4vL4naTiR/ajPZkj30Gl9LMUb0uprVgnPOC1ClhAEd
VUqcL75MwXydIasQixfzTEmX2DPXGC4EYaPY1Zv/FDgnC0PXJMOezup8W40mHZKU
9imul0pq7on0izFRB32xb45s2BXHAVpAyB/uEVthyWopnWK6cvGlaL5BdbHgtVhj
GaajtH+v6+LY54zquz0noREZqFqDS5ugUHFkZq7Vquza99K2TAs9Jw9O9FaloNZq
/rwKurnds9aeegnt6661XK5mYjuGzlA0Zwf4zk9uzU71pGmKDBNBu6WEwvTSM1jK
l8/io7YCmbr4mVbzzoLn3hzzI9loK0ohL3e7mVJO+mORJZBCTjOzBIz+bQOdkU4y
BQyiX8RK1tl4q1beYKV0HD6sffXiJDTBdHNMON3UNqF9MCOyAaX4t5Nr9MITUsaz
NggHnWunPeJD0TPDEVrdYGQHj/z4Ri6AAEcuBW6KsPrwLOxRbM+qAw3VF29Ur1fC
4v5e7Olr1ltu/NmvBiiHEELk8lnVmgZwVacpVLv2a8JZ2XMp0WH9lxVXB57SoEQ7
KdrmDfYTcpyeCIOrUqdaz64CDsWGbZL+X048KoZmoxV5I5VEcXjCOJzd49CJYNtW
J9bCVROflae3vM95hOt98CnC1ewPDe/SlR1HX7cySdFdAQxOaXs=
=5EOF
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
