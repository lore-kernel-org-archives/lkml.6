Return-Path: <maxime.ripard@bootlin.com>
X-Google-Smtp-Source: AIpwx49EgkEXgacP12rMC0JkgzxQAQjTuYqX/0OZrUpMx0Vptb2p7E0ClDMXDyQYo+k9ae36XMch
ARC-Seal: i=1; a=rsa-sha256; t=1522315406; cv=none;
        d=google.com; s=arc-20160816;
        b=URqwhCYQWDyPEgujPzWVusyBpCOdgpgMnulrCNr+82zw4AmLkCZRPIC03r4AZillUT
         8mgDl2EQQrHGlWmKTwdbmB7IhNkCgXCLZBaFKMm0rTNDFQvCLxbbjg1ldeql0d0Vsj6T
         l6myIoRSQSm1CrOmZ4sculDYI5Fnvl1CRTXN0559o+8oLSnBpv5ulwF1Dhlur2gh+k0v
         6o9Du7YqaPpH/mTCcGnAQbR6x9ik9TrweDKyNauxBipB1TjtKcntpz3mPThgTcQTMXGM
         2IOEgC1K+MRu/rBrHUJnKFZ1lwQbBkkHjq5/9x/vvwDNcDw3i+wmtXnss2KWu2BArusq
         V4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Hxj5sirvauCmcWDzx9Z4IyzEn7lC6q3KO98eWe+TTCo=;
        b=VThkhcbeRzWSMuhbZsJHzeOXQOih4nk/5IJVMvAGdXAknud7R5Avv8l6qckWv6oqHV
         xgorjJjP4Txs1y+LEfZzmGwVjDGIE87XLxg09nM7uO15t69VEurPxAFbpYCSdsHefTaF
         jZxkqQSHiuKvWAI/1ygVcXej56rc10INl6WKueqYM93uIRkpn/uiuLCv8RHRnrKKX4a+
         SzwHxikAWb6fdvWSUmhL3EWC+CIAzVJ091kpCQYHPQAd4LuiSsPPEaTxbGa1B1YbwQLU
         cw6u0k4vQgZvfaYZkIAhSgU103cussTDMvTGU7+qAfwa4aful4WMv+OQX+QPKIbzOX3b
         8WpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of maxime.ripard@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=maxime.ripard@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of maxime.ripard@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=maxime.ripard@bootlin.com
Date: Thu, 29 Mar 2018 11:23:26 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bin Liu <b-liu@ti.com>, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
Message-ID: <20180329092326.dayuccomq5zrywqo@flea>
References: <20180328215213.29538-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3xfx55pm2vby3zbv"
Content-Disposition: inline
In-Reply-To: <20180328215213.29538-1-contact@paulk.fr>
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596219936239404188?=
X-GMAIL-MSGID: =?utf-8?q?1596263399589907712?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--3xfx55pm2vby3zbv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2018 at 11:52:13PM +0200, Paul Kocialkowski wrote:
> This allows dual-role ports to be reported as having gadget mode by the
> musb_has_gadget helper. This is required to enable MUSB at all with MUSB
> glue layers that set the port mode to MUSB_PORT_MODE_DUAL_ROLE at init.
>=20
> Most notably, this allows calling musb_start when needed in the virtual
> MUSB root HUB, regardless of whether the current mode should be gadget
> or host.
>=20
> This fixes USB OTG on Allwinner devices that I could test it with,
> mainly A20 devices.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

Surely there's more to it than that. The gadget mode of A20 boards
have been working in the past, including when compiling with mUSB
setup as dual role.

Is this a regression since a particular commit? Or is there another,
deeper issue overlooked in the commit log?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--3xfx55pm2vby3zbv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlq8sI0ACgkQ0rTAlCFN
r3SApA//SjVYr8ba2jF2UA1jjeIu3YSzR5Ph05uU1Xs/bgDo7Nef8DCHSGsiFTfu
XDYNLnJG9eCwW5f0CcPaSux4QYFlliQiBFcOw9ue7ql3JR5RPEPM04d99jXXMuzX
XNy6FcV7BUXJ9SB+gzAjnpP81F60OrsN3EL1qE4s643YkuMCxLWTvULFo0Dsag3k
YvfmLmNSNu7qYbMG0gHXbE/TrteWggWZnFO3DS8DcDcKO58ahD2G7Rin7UQdEydY
WnDHW78uP9RGj+IJEMDZp80oz2YsUh15tkmfJO95zqaQvjMwJ4xHvfR7ilITYP+2
iqQmK90JcmCndlfq7xn7g0baVkkR8dbh9oY0K1u4gPBMZHuwGxiP3jk68/eFpDc/
pKRpaO8Z4sKr/h/9cH8lv6gprFIVSz9rtrbzqaA4RMKTSvl8CjXAQXK5lRf7eVzp
1TsWU/Xg86cCNjzv9Vy5WbbtIj/W5pvz17/B1AJyfIwUV/terLiF/Vdj6+U1a1GP
IAdKoih8nDGkKt9i3VkQOX/MVL3X8KsLeiHAIVElfT7wRwp4wLbCGPsfi4HM34tE
3Pg87eaFKcn6zV3u3hygxA3Aspeet8f6hX5krI5JKDesG528+ZtBXeKDcXd7gHDk
h1ELH3BF4dhliaBYmy5+KUZBn7FCcWsbbwOn/v0ejRw6aIUsZ8E=
=WUG9
-----END PGP SIGNATURE-----

--3xfx55pm2vby3zbv--
