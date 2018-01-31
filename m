Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbeAaIo0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 03:44:26 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37670 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeAaIoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 03:44:25 -0500
Date: Wed, 31 Jan 2018 09:43:49 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: ccu-sun4i-a10: Fix mali changing dclk
 frequency
Message-ID: <20180131084349.du2ijvhh5rxa5vvt@flea.lan>
References: <1517354639-92978-1-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2rptceoyv2kyz4nt"
Content-Disposition: inline
In-Reply-To: <1517354639-92978-1-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2rptceoyv2kyz4nt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 31, 2018 at 12:23:59AM +0100, Giulio Benetti wrote:
> When mali.ko is inserted, it set default clocks and call all parent
> clocks to stay into range, causing pll-video0 to change and
> subsequently to change dclk to wrong frequencies.

This is what you should fix.

> "gpu" clock has lot of parent plls inside driver, but on sun7i
> pll8-gpu does not depend on pll-video0, pll-ve, pll-video1.
>
> It only depends on 24Mhz main clock.

I don't really know why you are mentionning that. The GPU clock has
all the parents described in the driver. And the parents' parents are
irrelevant to this particular issue.

> Remove all pll parents from gpu_parents_sun7i except "pll-gpu".

However, this is not a proper fix for your issue.

What kernel version did you use?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--2rptceoyv2kyz4nt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpxgcQACgkQ0rTAlCFN
r3TUAA/5ASqMeOOzopGp1kTCZGR4LE2GpRttlYa69tnsWRy11WLH3WwsKA23Uq+K
u7xtbW5vnDJjbhmcbfWoqvPh4nPciXGIxy0xhMO/PaQ89hGg9ztexP3x7NKtMaNS
71dnKosXKN2lvFHI62BgGcHmZDY2CRTwnbpgSJkPHYuG9fO2ZJxh2y6mN95ZTaSA
B6a6DpAdwOnpY1MJUSAoIA2XrfD65KM/f8T0MCL0I163bLP8a/FskuC5Toeb1+c3
oRCHGd5+qnSEdBP75177y/neBjb1+Z4PUR192zl2dd6l6n6grqR/JV+m6etVvT3f
DD/gVCWN1SiQeJspiiuhnsD2ACAoYK/NWLf3aGvWIMldlHbpAGPbexd+4wNelr+2
rSeUQ7P5FvgtXC4Ryz0IwYXEXvFaPkXHaJNcqgwoY9RuaMusJPyFp8X1ExX8sNrL
mJWygF+Omd01b2CW7luUu/1EnGO5/ioV7h0hYcUWKzr4cXTIldE3kshIeitxEAak
7q+9SMyXaBRFDTcWuOlmHq5u3jwT8rrlBWkKq0UB5U+dyBDLOFSqTeWFv66pTQFU
ldiYBku82603uR/B5penAZC5AYjJic+J9lQWfRBEgNqCS4bk32xybjaF1mwkXIFn
huRvHrzXW3CPEaA5tSNWr0vvbBxFiPwnO2qjILK77LJ7euUWSMI=
=hLEx
-----END PGP SIGNATURE-----

--2rptceoyv2kyz4nt--
