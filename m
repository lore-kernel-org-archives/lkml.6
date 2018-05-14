Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbeENFK6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 01:10:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47173 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeENFK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 01:10:56 -0400
Subject: Re: [PATCH v6 3/6] kernel/reboot.c: export pm_power_off_prepare
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
 <20180305102524.5905-4-o.rempel@pengutronix.de>
 <20180504185052.bjhfkvpgrblc7tfc@pengutronix.de>
 <1937901.oyadCYFYNo@aspire.rjw.lan>
 <a431b0e1-f4f4-1439-f0bf-736018c6ab0c@pengutronix.de>
Message-ID: <091ccf85-ae4c-f6fd-0455-1a70e973c85c@pengutronix.de>
Date: Mon, 14 May 2018 07:10:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a431b0e1-f4f4-1439-f0bf-736018c6ab0c@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RtB0pzA4sEIikWDKYFSjABFlnFe6ToT2P"
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RtB0pzA4sEIikWDKYFSjABFlnFe6ToT2P
Content-Type: multipart/mixed; boundary="CRLiw7b3SfKPy3MVyt35HefVydl0PKi0x";
 protected-headers="v1"
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, kernel@pengutronix.de,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
 Mark Brown <broonie@kernel.org>
Message-ID: <091ccf85-ae4c-f6fd-0455-1a70e973c85c@pengutronix.de>
Subject: Re: [PATCH v6 3/6] kernel/reboot.c: export pm_power_off_prepare
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
 <20180305102524.5905-4-o.rempel@pengutronix.de>
 <20180504185052.bjhfkvpgrblc7tfc@pengutronix.de>
 <1937901.oyadCYFYNo@aspire.rjw.lan>
 <a431b0e1-f4f4-1439-f0bf-736018c6ab0c@pengutronix.de>
In-Reply-To: <a431b0e1-f4f4-1439-f0bf-736018c6ab0c@pengutronix.de>

--CRLiw7b3SfKPy3MVyt35HefVydl0PKi0x
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 14.05.2018 06:33, Oleksij Rempel wrote:
>=20
>=20
> On 12.05.2018 13:13, Rafael J. Wysocki wrote:
>> On Friday, May 4, 2018 8:50:52 PM CEST Oleksij Rempel wrote:
>>> Hallo Andrew,
>>> I need your ACK or NACK for this patch.
>>>
>>> This function is used to configure external PMIC to interpret
>>> signal which will be triggered by pm_power_off as power off.
>>> Since same signal can be used for stand by, I linked PMIC configurati=
on
>>> with pm_power_off_prepare to avoid possible conflicts.
>>>
>>> On Mon, Mar 05, 2018 at 11:25:20AM +0100, Oleksij Rempel wrote:
>>>> Export pm_power_off_prepare. It is needed to implement power off on
>>>> Freescale/NXP iMX6 based boards with external power management
>>>> integrated circuit (PMIC).
>>>>
>>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>>> ---
>>>>  kernel/reboot.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>>>> index e4ced883d8de..350be6baa60d 100644
>>>> --- a/kernel/reboot.c
>>>> +++ b/kernel/reboot.c
>>>> @@ -49,6 +49,7 @@ int reboot_force;
>>>>   */
>>>> =20
>>>>  void (*pm_power_off_prepare)(void);
>>>> +EXPORT_SYMBOL(pm_power_off_prepare);
>>
>> Why not EXPORT_SYMBOL_GPL() ?
>=20
> No special reason. Fixed.
> Any other comments?
>=20

Or with other words, will it be enough to get your Signed-of-by for this
patch?


--CRLiw7b3SfKPy3MVyt35HefVydl0PKi0x--

--RtB0pzA4sEIikWDKYFSjABFlnFe6ToT2P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlr5GlIACgkQdQOiSHVI
77Rh4wgAwEu/IcL9h9DDgNxT7+bLULmv3Idsqw2YuCkCPyoqdzZMba4+xNxfzyzt
fP7Mm0m1yYFfM0ZJ8xYJeSlhcb0Y991+YCRBPWv00zQplUPONo6Z8E5hmnmvqHav
jmaBw+jLhosfgbdyzRlheDr/HQKgojWe8M2SkFyVnkwgk9tWvV/nEwgxtef177bB
cDFVV48p8mpEPMcdn7OaAlDrHD2sLC8YmLYdM4PqUdwzrWTuAaOuuNkPOsgrNI29
C+IHaIB/jG/JvWCTIbU7O0G7wGhAuhFhFqU4NwWjnZIrTfLpCgqMo7zW6E/ktmcy
Kfqp7JlWNFroTiGOoHzBRbET/uIK1w==
=Usu/
-----END PGP SIGNATURE-----

--RtB0pzA4sEIikWDKYFSjABFlnFe6ToT2P--
