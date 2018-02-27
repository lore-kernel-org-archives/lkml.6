Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeB0JJS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:09:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46625 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752096AbeB0JJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:09:16 -0500
Date: Tue, 27 Feb 2018 10:09:13 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: wens@csie.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] rtc: ac100: Fix ac100 determine rate bug
Message-ID: <20180227090913.3vb6yudd4nh2wlyh@flea>
References: <20180226211901.9805-1-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f3wecsvhqugikgzn"
Content-Disposition: inline
In-Reply-To: <20180226211901.9805-1-embed3d@gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f3wecsvhqugikgzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 10:19:01PM +0100, Philipp Rossak wrote:
> This patch fixes a bug, that prevents the Allwinner A83T and the A80
> from a successful boot.
>=20
> The bug is there since v4.16-rc1 and appeared after the clk branch was
> merged.
>=20
> You can find the shortend trace below:
>=20
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
> pgd =3D (ptrval)
> [00000000] *pgd=3D00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 0 PID: 49 Comm: kworker/0:1 Not tainted 4.15.0-10190-gb89e32ccd1be #2
> Hardware name: Allwinner sun8i Family
> Workqueue: events deferred_probe_work_func
> PC is at clk_hw_get_rate+0x0/0x34
> LR is at ac100_clkout_determine_rate+0x48/0x19c
>=20
> [ ... ]
>=20
> (clk_hw_get_rate) from (ac100_clkout_determine_rate+0x48/0x19c)
> (ac100_clkout_determine_rate) from  (clk_core_set_rate_nolock+0x3c/0x1a0)
> (clk_core_set_rate_nolock) from (clk_set_rate+0x30/0x88)
> (clk_set_rate) from (of_clk_set_defaults+0x200/0x364)
> (of_clk_set_defaults) from (platform_drv_probe+0x18/0xb0)
>=20
> To fix that bug, we first check if the return of the
> clk_hw_get_parent_by_index is non zero. If it is zero we skip that
> clock parent.
>=20
> The BUG report could be found here: https://lkml.org/lkml/2018/2/10/198
>=20
> Fixes: 04940631b8d2 ("rtc: ac100: Add clk output support")
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--f3wecsvhqugikgzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqVIDgACgkQ0rTAlCFN
r3SKUBAAmcXMlygQJbkcmBF6rYnTivNolCp0SWBSagp/4wBeR4LMQZr51PVntfS8
NoUaJgQGBXV3Wt1wwO18KSzeK8QzA/ngbBl+W+uPERXij5VxR+huYYALvj82aK+X
i/se2qemdHkbpPOxtAgglYHv2WjBk2y+cCTLOrzRMaeyUldUfSbPl/ddMiC8e19e
LrM326W4/F+tva8DE8dGy6ojyg023b6NfM/VKQGGGA9iVOJUIkNV67rTKs5npiK8
teSqME/NdORF43ZAzF0qkGZqvBLAOGZXCFRpRb7QDnTO6NpyfCiOHIj4rkb9XlpX
OI4DkqfsMeve6pyYYperLoVA3bhIj8T3qzjVXgRdVKjG+Cz4afwQ9gsP5WIKr9wT
VlzhTSdBx9c64ZuG+6bphH2cVUVUdtWTJVSd+jx1nGJeaOiP+1Pv/nB8A/wMnM0+
oucA+oxQhWPVnIczlWyZ0Scs7HmaR9r0ZkWROSX+WtlQn5N1gU0fpFsnyfiFh47o
XF2sCDbAXtC8KckNI39vUM5uYTsZlrhgA+g5uzYRrlFBJnvV6Ds/nHuDu1ZNc6nK
9Le7Y0TkceLZNfmGZX0v19clFt1d73c8cnbHwTVB0kz/hmffKEzoX8A7IJOjWv5w
bCRiIZL9eODMX2oaBby0dvEgn/5eUgm+zZHfBgrxgl2n2+BuIUQ=
=4Khs
-----END PGP SIGNATURE-----

--f3wecsvhqugikgzn--
