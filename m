Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeBZVnK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:43:10 -0500
Received: from sauhun.de ([88.99.104.3]:38907 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751343AbeBZVnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:43:09 -0500
Date: Mon, 26 Feb 2018 22:43:07 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: piix4: Use request_muxed_region
Message-ID: <20180226214307.irourq2svpd7ok7e@ninjato>
References: <1519678013-32749-1-git-send-email-linux@roeck-us.net>
 <1519678013-32749-2-git-send-email-linux@roeck-us.net>
 <20180226205204.p37lf7dcl5k7az37@ninjato>
 <20180226213406.GB2211@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s4l73sjh4hth2fsg"
Content-Disposition: inline
In-Reply-To: <20180226213406.GB2211@roeck-us.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s4l73sjh4hth2fsg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> It is an alternate and somewhat simpler solution which does not
> attempt to change the kernel API. My primary goal was to find
> a solution for the immediate problem between the watchdog and
> i2c drivers. My solution does not attempt to fix the access problem
> for (initialization) functions with no return code. At the same time,
> I prefer to use functions which _do_ return an error if that is possible
> since it _may_ after all be that there are other users calling
> request_region().
>=20
> Having said that, I'll be just as happy if Zoltan's series is accepted
> instead of this patch (except for patch #5; the watchdog driver has
> already been converted to use request_muxed_region).

Thanks for the explanation!

So, as I understand: I can apply this patch to fix the immediate (and
long standing) problem and decouple it from the API change. The latter
can then still be worked on and the changes for the piix driver should
then be minimal. Correct?


--s4l73sjh4hth2fsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqUf2cACgkQFA3kzBSg
Kba3LxAAsobSsNiTDRldEyuRL/J4kp5qQQ/GpWp2s85qh24XH5N+1zcDQ3cpZ10c
PAevGlg41l2vB4jz4qhAwW8PPBKYAvhRIutg06Nynci2Ic0pxGxKkKNdBfJKaaik
qaCh9PnVbGtwBJOR3GbnpgOUS7ZZIOBZ6vh56phEtXNqRZV9Vpa+GlLFt3Xyp6jv
KkRBUcqck3V3Lnbe3wZmLSU8n11B3AzhDFcIluKXT1zmiZA/klPdDg38H2WMwAHK
mXhcT/2fk6mCbhoFnTzsgq5l3C8a3ihtknzhcV0F4oaX4nQ2m41lG//zZOksn6uu
4NcCvXdR9IcbI4rFc1d1D6air9MFQFW9q4iWa0Qix95BV7alj/hvU7TqcgsrEQ98
gZZow6YTGJGs7pFXK5oZ/XHKTJ2UHRUUzdOVXJlET9MI+2oom5giAtVzlN8f56O7
HYABkn8edwkeBaVYVoBkkxMS/Mk6UqmPyVYNGuqRNt/jCLsU3Te3PM4oL3YGZ0c2
DoAq61fgENXt6ytnv7eh44XHnBNDJOh0YIWjfZOaFx/3Ty+H65FOGmxwmD2w+b2q
eku1Le5+9dFVN5Mr/Oen0PbvfvSSV33J4DFB1Bc7qKn+vgPVpg/ZB3m6t3rZLQyP
cyROzqhvAhpgcTx6KQR0wNQufAYL3/wbxmSeChDfdKNBYpUYGy8=
=Ids+
-----END PGP SIGNATURE-----

--s4l73sjh4hth2fsg--
