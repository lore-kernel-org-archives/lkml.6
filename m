Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeEPBj1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 21:39:27 -0400
Received: from ozlabs.org ([203.11.71.1]:41267 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752026AbeEPBjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 21:39:25 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 16 May 2018 11:39:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Simon Horman <horms@verge.net.au>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: linux-next: manual merge of the rockchip tree with the renesas
 tree
Message-ID: <20180516113918.1ccdd8ec@canb.auug.org.au>
In-Reply-To: <20180503083654.625b1f9b@canb.auug.org.au>
References: <20180503083654.625b1f9b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tFCK/k+hDev/JLTwxX4qW6e"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tFCK/k+hDev/JLTwxX4qW6e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 3 May 2018 08:36:54 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the rockchip tree got a conflict in:
>=20
>   arch/arm64/configs/defconfig
>=20
> between commits:
>=20
>   93f7bfd930c0 ("arm64: defconfig: makes SND_SIMPLE_CARD to module")
>   ddf3fa8b8a16 ("arm64: defconfig: Enable CONFIG_SND_AUDIO_GRAPH_CARD")
>=20
> from the renesas tree and commit:
>=20
>   e9cfce4195ec ("arm64: defconfig: Enable HID over I2C drivers")
>=20
> from the rockchip tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/arm64/configs/defconfig
> index 7930caf5dde4,34037d24fbf4..000000000000
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@@ -158,9 -157,9 +158,10 @@@ CONFIG_BT_HIDP=3D
>   # CONFIG_BT_LE is not set
>   CONFIG_BT_LEDS=3Dy
>   # CONFIG_BT_DEBUGFS is not set
> + CONFIG_BT_HCIBTUSB=3Dm
>   CONFIG_BT_HCIUART=3Dm
>   CONFIG_BT_HCIUART_LL=3Dy
>  +CONFIG_BT_HCIUART_BCM=3Dy
>   CONFIG_CFG80211=3Dm
>   CONFIG_MAC80211=3Dm
>   CONFIG_MAC80211_LEDS=3Dy
> @@@ -443,8 -447,8 +451,9 @@@ CONFIG_SND_BCM2835_SOC_I2S=3D
>   CONFIG_SND_SOC_SAMSUNG=3Dy
>   CONFIG_SND_SOC_RCAR=3Dm
>   CONFIG_SND_SOC_AK4613=3Dm
>  -CONFIG_SND_SIMPLE_CARD=3Dy
>  +CONFIG_SND_SIMPLE_CARD=3Dm
>  +CONFIG_SND_AUDIO_GRAPH_CARD=3Dm
> + CONFIG_I2C_HID=3Dm
>   CONFIG_USB=3Dy
>   CONFIG_USB_OTG=3Dy
>   CONFIG_USB_XHCI_HCD=3Dy

This is now a conflict between the renesas tree and the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/tFCK/k+hDev/JLTwxX4qW6e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr7i8YACgkQAVBC80lX
0Gz88Af9G8bZBQji1bw4dZP+HAf3hrxnKZsb1UQeCz5hK3wOztWvFI2uBxJUM/L+
v/GBpkj8ZKvWUGuiclCP1CnithCQnxW1WW9mYgcNEW9X+stPeoRoFUHxacAXKysL
fmnpZnwpJv22mHlzxmBZk+szzdoFnK/fEVBByjvHajiZPEpubGAzFVFoV/QijLQV
kHrIL8dOL5F1ieD5duwNJturvdt1L7SutOOt/bt2xpbMGolIUWRA8Q/ria0DSaqO
SOe3mJR1LDzY302CWgh/1XubgQKvE60f21MEIAcFWf+BS97B7BVuwxhLZj3qlab2
4tYeG/+Lcib1TAJHU0tEh2MT8Dp2ig==
=9lMq
-----END PGP SIGNATURE-----

--Sig_/tFCK/k+hDev/JLTwxX4qW6e--
