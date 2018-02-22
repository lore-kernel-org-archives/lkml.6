Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeBVUIM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:08:12 -0500
Received: from anholt.net ([50.246.234.109]:35688 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750776AbeBVUIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:08:11 -0500
From: Eric Anholt <eric@anholt.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Stephen Boyd <sboyd@codeaurora.org>, Tom Cooksey <tom.cooksey@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/p[111: add CONFIG_OF dependency
In-Reply-To: <20180222162420.2825703-1-arnd@arndb.de>
References: <20180222162420.2825703-1-arnd@arndb.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Thu, 22 Feb 2018 12:08:08 -0800
Message-ID: <878tbkaitz.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Arnd Bergmann <arnd@arndb.de> writes:

> We cannot select a symbol without meeting its other dependencies:
>
> warning: (DRM_PL111) selects DRM_DUMB_VGA_DAC which has unmet direct dependencies (HAS_IOMEM && DRM && DRM_BRIDGE && OF)
> drivers/gpu/drm/bridge/dumb-vga-dac.c: In function 'dumb_vga_probe':
> drivers/gpu/drm/bridge/dumb-vga-dac.c:207:13: error: 'struct drm_bridge' has no member named 'of_node'
>   vga->bridge.of_node = pdev->dev.of_node;
>              ^
>
> Here it seems reasonable to depend on CONFIG_OF, as all platforms
> using this driver already require that anyway.

Looks like we'll be going with

https://patchwork.freedesktop.org/patch/205580/

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqPIygACgkQtdYpNtH8
nugBJQ//Q4AzkWW4EpUVzY0YWgKs0fvcC0IiH0PDba6Z4WLKAAkC0fxHNlh65MwW
8OklOV5aaoikY0DmSs15ls0CIr5kFReGllTav/u+Os0oHLfehh9uAm9m4VXbkNsU
hCD6uQx56Jq4uXgxlYeM602aKlOChz+cFyhtuUneRGzqrQtPrl5T4hZ+59gUra6l
F4RRg/K9BsHNiarcAO5O8Ttz1ZTNSRzj2k2g+AM0iyFaTGhpN29Nls4oavJSFTSC
NG46D0t0Ogzr7EGRE4RX7dpsMds3/6XE8P+NWEgOCGtb4PkOmFtttG25WtgbKU4J
LelbcGMRBMO8wd5Z6Ajp3U0jdn7JLPmhK+jUxmoLGMZbwj2+F9O7RePSoj7l2SF7
XdUUBdqMQoIHu4rTEljZiTb7TtnWzPxYpYYxJG911VQUQJR75w76LzpDWPz47Ipf
YAmcDa22xMTHQ0ec4nwsEtHm1xdWpHHByDCcWVNb8J76Bw013Gs8fRP3XKT7IgX7
21Zqju0rAZrD9qDJo/CpK90PUk6yCGpGysmGOjD35lznPTUsY/umL9RnZrUGa6j9
fift1TRKXUitpCUWxls3H25X2OFyDYn6K+OsyR9yJIVY75LEN+8XTes830rouMqL
goVDDVQf5X3TliN6p5grdelA7feKzt3mNNE4cIbst1AEs+i68Is=
=QxGZ
-----END PGP SIGNATURE-----
--=-=-=--
