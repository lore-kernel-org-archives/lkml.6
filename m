Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeEQOaR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:30:17 -0400
Received: from anholt.net ([50.246.234.109]:46184 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751293AbeEQOaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:30:16 -0400
From: Eric Anholt <eric@anholt.net>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <alpine.DEB.2.21.1805171007260.7820@macbook-air>
References: <20180517131727.29263-1-eric@anholt.net> <alpine.DEB.2.21.1805171007260.7820@macbook-air>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Thu, 17 May 2018 15:30:11 +0100
Message-ID: <87efia1hjg.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Vince Weaver <vincent.weaver@maine.edu> writes:

> On Thu, 17 May 2018, Eric Anholt wrote:
>
>> diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.=
dtsi
>> index 7704bb029605..1f5e5c782835 100644
>> --- a/arch/arm/boot/dts/bcm2837.dtsi
>> +++ b/arch/arm/boot/dts/bcm2837.dtsi
>> @@ -17,6 +17,12 @@
>>  		};
>>  	};
>>=20=20
>> +	arm-pmu {
>> +		compatible =3D "arm,cortex-a53-pmu", "arm,cortex-a7-pmu";
>> +		interrupt-parent =3D <&local_intc>;
>> +		interrupts =3D <9 IRQ_TYPE_LEVEL_HIGH>;
>> +	};
>> +
>
> why this and not
>
> arm-pmu {
> 	compatible =3D "arm,armv8-pmuv3";
> 	interrupt-parent =3D <&local_intc>;
> 	interrupts =3D <9>;
> };
>
> which works, though when I didn't get very far when I submitted the patch=
=20
> to add this last August.

Is that better than a53?  I'm happy to switch to that.  The important
part to me is the a7, since basically everyone with this hw is running
arm32.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlr9kfMACgkQtdYpNtH8
nugh8hAAppFgslLzTmpl2HL5S2OQdj7pmNuULSr/2zGR9wR6gJKi525m2YUmExET
mklAuaFFMV/gobblrfCeyfEpKRt1Zyvr6INITKBzc/9162ZeF/o8KlmMFv8W6sXY
7B9p0xfTez52T371+JRmO6KcQtrqB0aUTOaO7ZUjkSBuBCTTQbZW8RQ2s7CVdrTV
cR2tzGBbu5Af6mwMgFj+zRwtQ8Qk8ehNyu2cp50yZ+Tnq+CrX09pWMb7Ec/34HO1
UiqKuYXkFm/Guvy+fsKgqBOm61TEZKwMYImOAYqbR7bWHYSxBrPjzKjq0iEIsFKA
6paP/TEZaZ38oD+2Amwqsea6StNtfzVwf4OBXBEMt1vzQmqYFgY8YpmLFYUivb1t
okmslqj6/4CM38o5ekEpbB6WceJjtgK2Htwyjd5sMMQswZJwrNcn7KZ5YjtSflRK
P8LhpWWyvDMoLZH5Mayx4toRFWqxJBo+BsG34m0ODhRRsnWIyzZ9qlAU1hxYq8Xn
aWUnjfuePvpRRxA9mkszCuZMLZ4HjcRGbz3bitLwjgNq0v8L33i6ZRj08ivYomVe
GcroTIyzhs34OGKq0Qp1HLGk6bxYpVa1w5UQCQtCW3tTkRDT9VOnvc9Tzl2nIaoS
uGTy75H7upUwI6dL4LBuZ0kZl0734W3PE8sb8VsWfEZeF5t+DMw=
=TN6G
-----END PGP SIGNATURE-----
--=-=-=--
