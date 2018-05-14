Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeENEdo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 00:33:44 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58985 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbeENEdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 00:33:43 -0400
Subject: Re: [PATCH v6 3/6] kernel/reboot.c: export pm_power_off_prepare
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
From: Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <a431b0e1-f4f4-1439-f0bf-736018c6ab0c@pengutronix.de>
Date: Mon, 14 May 2018 06:33:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1937901.oyadCYFYNo@aspire.rjw.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="guq0sp4rSU1SNUAcQxYjs9jesGI0bByNP"
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--guq0sp4rSU1SNUAcQxYjs9jesGI0bByNP
Content-Type: multipart/mixed; boundary="H2u0RczUq28YJQFfyQp017tZrWHiIKswr";
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
Message-ID: <a431b0e1-f4f4-1439-f0bf-736018c6ab0c@pengutronix.de>
Subject: Re: [PATCH v6 3/6] kernel/reboot.c: export pm_power_off_prepare
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
 <20180305102524.5905-4-o.rempel@pengutronix.de>
 <20180504185052.bjhfkvpgrblc7tfc@pengutronix.de>
 <1937901.oyadCYFYNo@aspire.rjw.lan>
In-Reply-To: <1937901.oyadCYFYNo@aspire.rjw.lan>

--H2u0RczUq28YJQFfyQp017tZrWHiIKswr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 12.05.2018 13:13, Rafael J. Wysocki wrote:
> On Friday, May 4, 2018 8:50:52 PM CEST Oleksij Rempel wrote:
>> Hallo Andrew,
>> I need your ACK or NACK for this patch.
>>
>> This function is used to configure external PMIC to interpret
>> signal which will be triggered by pm_power_off as power off.
>> Since same signal can be used for stand by, I linked PMIC configuratio=
n
>> with pm_power_off_prepare to avoid possible conflicts.
>>
>> On Mon, Mar 05, 2018 at 11:25:20AM +0100, Oleksij Rempel wrote:
>>> Export pm_power_off_prepare. It is needed to implement power off on
>>> Freescale/NXP iMX6 based boards with external power management
>>> integrated circuit (PMIC).
>>>
>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>> ---
>>>  kernel/reboot.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>>> index e4ced883d8de..350be6baa60d 100644
>>> --- a/kernel/reboot.c
>>> +++ b/kernel/reboot.c
>>> @@ -49,6 +49,7 @@ int reboot_force;
>>>   */
>>> =20
>>>  void (*pm_power_off_prepare)(void);
>>> +EXPORT_SYMBOL(pm_power_off_prepare);
>=20
> Why not EXPORT_SYMBOL_GPL() ?

No special reason. Fixed.
Any other comments?


--H2u0RczUq28YJQFfyQp017tZrWHiIKswr--

--guq0sp4rSU1SNUAcQxYjs9jesGI0bByNP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlr5EY8ACgkQdQOiSHVI
77Romwf+Oud20PXLIhkk9kB9S1hdjhqEs/O32pH5DS8/+iBA4q85Icq2u6welZLQ
rEZvCD8HVefVmmB1+nHLOK/0h1KHZX/IR6+92KE5icdaLYESTLCw3/gtDyT1hRv2
rlH4B4CZIM/vYUn0C9mmfX3T8GZyTclbjpkwrbHetMse8z/hYL5upz0PyiCvBLw6
YQQ8F9DS+OVjnHmFBooCI9itH6LAVkpCf3d8AmNAtHSNq66yTEENTQiPrRghLcb1
fcQj9nEpa4uE1XDKT+F+AQ2QwC2gY0ET1tGfLeUSk3we4y5UNxa4rESC9CZKJScF
nvzvgIAEwGP9A19o/P9fq7Kak3NTWA==
=a7B0
-----END PGP SIGNATURE-----

--guq0sp4rSU1SNUAcQxYjs9jesGI0bByNP--
