Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeCTJws (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:52:48 -0400
Received: from www.zeus03.de ([194.117.254.33]:46600 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752597AbeCTJwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:52:44 -0400
Date: Tue, 20 Mar 2018 10:52:42 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1 2/6] i2c: i2c-stm32f7: Add slave support
Message-ID: <20180320095242.tedafu5wphsx55qx@katana>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-3-git-send-email-pierre-yves.mordret@st.com>
 <20180317205109.gocf5wemtjkyomct@ninjato>
 <5a3c5b21-bc66-ce73-a997-f686ecc275f3@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5jxnagqpgmadd775"
Content-Disposition: inline
In-Reply-To: <5a3c5b21-bc66-ce73-a997-f686ecc275f3@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5jxnagqpgmadd775
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I do believe the hw can support it, even it looks odd to me having the same I2C
> in slave and master mode at the same time.

I2C is multi-master, so it is perfectly valid for a device to be master
and slave. I do have seen designs making use of that more than once.

> Nevertheless the driver is devised to support either master or slave more but
> not at the same time.

Why should we limit ourselves here? Also, why should we have an
unnecessary configuration option?

Unless the HW is broken and does not support it, I usually don't accept
slave-only solutions. If the needs for master and slave arises later,
this is hard to refactor and better done properly right away.

Is it so hard? Usually you have irqs for master and for slave seperated,
so you can code things quite orthogonal. Check de20d1857dd6 ("i2c: rcar:
add slave support") as an example.


--5jxnagqpgmadd775
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqw2eoACgkQFA3kzBSg
KbYyDRAAjXCW/pmeZcMJjdvfYFoNwGZsP22j3BZeEZItjKNlwS5wh8dXRqCHxHkZ
XY3c0gph1dMRtw8hvKZwVKhX6s4rQkDs2o7QaNgI1rvgm5i8iZQo23sAjvrsC2cm
FKjavVHfwXwarR5Va/5AzZCFHCCPjXt4hKO/7Fs3FbpCi/aw+T2D0q9EUQp6V+f1
ifdzbBKwSaxF3QVSCNRlwQ2s++MU5jq0iwAKB/CWKrFzJ3sZkimIvRdugQ/0PpyG
7gGTon6SCIZNHv68zGX2Iv4FiNmhJCBc2jEjXnUr0eVw/wh0R5guL9Yg+XJe67uT
bGVODYb4p/jD4myVy9WGll2DwJhCltHcl+wE/+3TFd+vr2pghsgN0UL9SIhOM+R2
1R9U1a1puIBK5HFTwJTVH3531+2QopOojneoHI9zsjBCpt6Sr0yYZdf8NWP9jk3e
+boQuEfr4dUnVazCPpyKwaM5EsdWn4pEysmcCqnePgFd7MVXQ5sB2njx8PA5VEi2
Lhje8MmjKuj7LImLZvp6mEyU5C3V6pBnFNueWKuAxGCHTxSzS+PYq+gAUPLVXUXb
fAeouu4ttp3xgURU9Oeq38hAqZjbWYpmriq9ktMOvrZK6NMNp3ncK198qmuZXr7x
WxAo04uSBia+ydp8rklNY27v0PH2ZAfCeXTNL6wRPSJkM6HjxDI=
=CXbC
-----END PGP SIGNATURE-----

--5jxnagqpgmadd775--
