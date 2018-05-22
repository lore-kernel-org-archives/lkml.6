Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753090AbeEVMKZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:10:25 -0400
Received: from sauhun.de ([88.99.104.3]:58570 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753016AbeEVMIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:08:37 -0400
Date: Tue, 22 May 2018 14:08:35 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: George Cherian <george.cherian@cavium.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        jglauber@cavium.com, kamlakant.patel@cavium.com,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        Jayachandran C <jnair@caviumnetworks.com>
Subject: Re: [PATCH 2/4] i2c: xlp9xx: Fix issue seen when updating receive
 length
Message-ID: <20180522120835.okaho5xuahtozhoc@ninjato>
References: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
 <1526454019-32714-3-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="enegb25e522ccrec"
Content-Disposition: inline
In-Reply-To: <1526454019-32714-3-git-send-email-george.cherian@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--enegb25e522ccrec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2018 at 12:00:17AM -0700, George Cherian wrote:
> The hardware does not handle updates to the length register gracefully
> if the new value is less than the number of bytes received so far. If
> this happens, the i2c controller will not stop the receive transaction
> properly.
>=20
> Fix this by ensuring that the updated length is ok. This is done by
> making sure that the new length written to hardware is at least few
> bytes more than the bytes received so far.
>=20
> While at that refactor the length updation to a new function.
>=20
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> Signed-off-by: George Cherian <george.cherian@cavium.com>

Applied to for-next, thanks!


--enegb25e522ccrec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsECEMACgkQFA3kzBSg
KbbwyQ//feJ4Q63YiClatugj1hhm2p8lThiAOIXn4z8gBOckIKiQ5aXsnjYFR9Zz
+F4len4L7RsnvG4ZHC0FtSE1M6kRFYmjWxLQmqTrfxxHgoitcdc+YQvpG50rjfCE
9Chu6yIW+TcqFvhvn8iNdXTrsoH9Ul1Vhsz9DbKUchNgU+J0Ah+/PMtHF2cRzfYn
7OJun+d4SxR3++ryG92efZ2OCdGjupqZhodHa2J1Z8K0c/W1gOoW2uF59aGQ79HC
0u+zXAP1vmKsjH/KGU8X0sQ6cjgumSotdfYSbDujbviLTK5VS3y52LF859+WDN/X
nBbK1qwYpQH1w/Djlep/QLyDZ3erc4RS0sqRDb8WYLPYbswV8+zPFIaXApfFDqUH
C5WABCQNiCIdrBpJhcLzQNKZdhpCQ8fcWeqe5xxGhfAm2gKjzOtEiaHVVrOP/fbV
V1hL3r03zRnATJB7dx3Mq/y6a3pEZcy91jUDrIw1q/31WN5xH1b2l0E7ue+PWOMs
Lm7OV+7anaAEnU79BemjFMLoSYSaLBv4Wn5LuhD2cOsv3xZhPTIkPMXqa0E0HkEi
cI/7K2OjpXImHInDxv56zAAFi3mkzJLAVZ1LSLIJhJwNNCucaZVIsHU3BAncl18R
UKHHdHh0dZg4J2FxDmx3JvxSSm5l+exL/VYiiyoALwBFyNYtgK4=
=Zym2
-----END PGP SIGNATURE-----

--enegb25e522ccrec--
