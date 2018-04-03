Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbeDCPbZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:31:25 -0400
Received: from sauhun.de ([88.99.104.3]:43234 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751461AbeDCPbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:31:23 -0400
Date: Tue, 3 Apr 2018 17:31:22 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] i2c: i2c-stm32f7: Add initial SMBus protocols
 support
Message-ID: <20180403153122.ux6hnnmexwmq3soz@ninjato>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-4-git-send-email-pierre-yves.mordret@st.com>
 <20180324224911.xz3fz2jojcdrovb4@ninjato>
 <2fadcd7f-3bfc-997e-a30e-808f6d854f2c@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="56erioblcg7mp7u5"
Content-Disposition: inline
In-Reply-To: <2fadcd7f-3bfc-997e-a30e-808f6d854f2c@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--56erioblcg7mp7u5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> All SMBus protocols are implemented except SMBus-specific protocols.
> >=20
> > What does that mean?
>=20
> It miss SMBus Host Notification and SMBBus Alert. They are almost ready b=
ut I'm
> struggling to put them back to operational state after recent changes rel=
ated to
> SMBust Host Notification. A more "classic" interrupt base solution has be=
en put
> in place but I fail to use implement it in my side.
> Another patch set is going to be delivered for these 2 commands.

This is totally fine to implement it incrementally. Please just update the
commit message with the more detailed explanation above.

> > That is quite some complexity considering we have I2C_FUNC_SMBUS_EMUL. I
> > don't mind, but you really want that?
> >=20
>=20
> All SMBBus commands are implemented as such. I never try to emulation com=
mands.
> Should we use emulation SMBus commands or real commands... Don't know.

You won't see any difference on the wire. I don't know your HW. It might
be that SMBus mode is more "automatic" and uses less interrupts. Or
stuff like Alert or HostNotification only works in this mode. If you and
the driver maintainers think it is worth the added complexity, I am
fine, too.


--56erioblcg7mp7u5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrDnkoACgkQFA3kzBSg
Kbaa8w//W/hT0ITcBW6N8zC3a9Rp4e/q0ZWUP+89RbxYKkCeHRm+GClsF2dapEa1
HIsIJwlXfEOoIqb4Ryqx78J7xAezNzYznnIGMRdIQgws7JwjIpfrQYwxdSB7Vr32
h4uxkrMOitRHoZylarwk+uGtFnH4i89TcB27cZBo3Vo4Zr0mrCSV94gk/lTjP8oC
gkEyUvyIbeBN45DSsqyW9e1M/xY/aFVj0EYfwDX41yr1IfIsq11jXUqtv9doH0Bn
xtGEKzfbaZM+VnF37EGATqWEPjsLz/LuFNQBzAzdc7o+KHGW4odCvAzRbnLeGZWy
wHApv/JeibFDiAhIfnZTQfy3bZd1KR/GpHS4XkAXVPWE3f7f2Ooyd5tLL5hFlsKT
9jYs+yQup+LIhwytcS/o/zo+zP0ycn/tMlOb+i3mNb+E2bIg+elvoHAKO1MJKBb4
zJRWGXnERVc/wAfPlzB7fpzjvFLbKNvankyUR4bI7XjjW8JlThkH/IlfDhnwH7Sp
m/Z3G1M3tpx3HtRPqgoykGb1Xz6s5BfC91YOI59RCZ0W45KmHgYaoYtQfPxRVGFG
Q9MdqrqCjxDtkDceujUuZZL6xsIDQG/AdeKhCK0g219KGpZAoobT7qX7Be7A+pEG
pXtg9Azny64XZBK3cl5L16LlD6Amoz8NMYoOCo2J1UqH0dS00wI=
=F0lT
-----END PGP SIGNATURE-----

--56erioblcg7mp7u5--
