Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934979AbeCTBM2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 21:12:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53568 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932939AbeCTBM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 21:12:26 -0400
Date: Tue, 20 Mar 2018 09:12:16 +0800
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: alsa-devel@alsa-project.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: uniphier: evea: add switch for changing source of
 line-in
Message-ID: <20180320011216.GN2186@sirena.org.uk>
References: <20180314123900.19505-1-suzuki.katsuhiro@socionext.com>
 <20180314162609.GV2186@sirena.org.uk>
 <001101d3bf39$6e3933c0$4aab9b40$@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Wi2ae8OABxFj6q5L"
Content-Disposition: inline
In-Reply-To: <001101d3bf39$6e3933c0$4aab9b40$@socionext.com>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Wi2ae8OABxFj6q5L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 19, 2018 at 01:19:10PM +0900, Katsuhiro Suzuki wrote:

> > I'll apply for now but this should really be a DAPM control so that we
> > can power down things connected to the disconnected line inputs when
> > recording.

> Thanks a lot for your suggestion. I tried to change the implementation to DAPM
> control as follows:

> I can see the value of ALINSW1 register at 'Line In 1 Mux',0 using
>   amixer get 'Line In 1 Mux',0

> But I can't change the value.
>   amixer set 'Line In 1 Mux',0 LIN2
>   Simple mixer control 'Line In 1 Mux',0
>     Capabilities: enum
>     Items: 'LIN1' 'LIN2' 'LIN3'
>     Item0: 'LIN1'

> Would you tell me what is wrong...

Ugh, I *have* run into that before but I can't remember what triggers it
and your code doesn't have any mistakes I can spot.  Unfortunately I'm
at Linaro Connect this week and don't have a test system I can poke at
with me to remind myself, and I'm still travelling next week
unfortunately.

I'd add some trace to the set code path to make sure everything is being
called as expected.  It's somemthing really small that's hard to make a
warning for in the code IIRC.

--Wi2ae8OABxFj6q5L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqwX+8ACgkQJNaLcl1U
h9B+8Af/QQGTFkLC66sq2/jYkUs8UZJhHNj12km7M4MmEXAn7DBmnkE/EOBWonBW
VkUyPNIpqrLEVd9ROjvHiBRzvGgJsnZUAJ0ZFVpWEYyFlp34nJdHNggw2KQPC8/n
OXDXw203NShiCmzqBJ/G+kanSDSIiUGq+yXFoDApjemx6VjtKKxuf8Q9m8Ys54o2
UWgmaDAVXmnikl+H9dV5GQ7y3II8OMVgYeYApPtzhW8PKKq+Hx4XesxcyT/UzLeW
TEOQd6nkhrNYAG8RvBQqfBfG4xYIvrqjkm7kdo4udETAMPCQZlVya7hK0Mj37BLj
z4UMUpRSlt1VSXTifOY2fml1/8/f3w==
=WXd1
-----END PGP SIGNATURE-----

--Wi2ae8OABxFj6q5L--
