Return-Path: <corsac@debian.org>
X-Google-Smtp-Source: AH8x227VdrFZAPBLT1iZNcM8YlBdKZkkOafWsXTEyjkx0AXU9K98c5xDgWU8rITfXGFuPrAW1z/z
ARC-Seal: i=1; a=rsa-sha256; t=1519307958; cv=none;
        d=google.com; s=arc-20160816;
        b=o54u1aPAz9SBA8XAl0Vo6omoItofgzotmlh9tQE+aB33AvJKE7RMNUntbblMhQXC4C
         eP1u7w9ug2VzkrBZyn6YrJmFtBGoo7A+xoaCrMUHA5LL+18lK8oHLhWA4gX2ATe90XCT
         SU/OxkCKDMBcen2SBXL8neM4Ey1Kg8rUTwbJ/Px0svGcabP3UTXLV2qzjDC2/E1/wSSJ
         L+V3dfK4g4Ac4N1xV1aIasPsNDTFPPEDbUgk55rwjqpn4gP0UxrIPEpHZYOYzbUX5c5o
         vlkyecYvBPLm3bBDrnOn+55h9FG1nATR7QhF5zLVVe0SbAcmeMnkQLHt2vsjLoolYaUD
         cu3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:date:cc:to:from:subject
         :message-id:arc-authentication-results;
        bh=S2P4bPxdrDCsmGYB5yWB8/qONMZj5vjef3j4naQPQaY=;
        b=mDf2O66VlYQ0Al91nOmlIgu86AoSkMedlc1bGBz5VVyOm5boMIQSyDgCy9MVYayGbU
         zerzwMJaZpWLgLsp5cq9oTa8dn/lhl98PtQRGU8oVgeaEz+O0afYNKRo7HTxDgc3vuT9
         aXuqOI2K7IeoF8XVmZEHPVVpB6HiK/BdB7waB5e5NbtVs3InP5jTfJSePY3vcBNZPpbl
         zYA2gJMuVYzfiqp084xB7kP5bK5o5KFP/g9sxbO3D0VVMXm2fqwNwLrMSsC0SBp2wP4X
         xP5/fbQkIsXtenQc7yCzxThephQUzKNI9j1i8/4TdCCSRmYXQOuuj1E3RJ/5xvSDPPJc
         pZ1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 78.194.244.226 is neither permitted nor denied by best guess record for domain of corsac@debian.org) smtp.mailfrom=corsac@debian.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 78.194.244.226 is neither permitted nor denied by best guess record for domain of corsac@debian.org) smtp.mailfrom=corsac@debian.org
Message-ID: <1519307952.2388.22.camel@debian.org>
Subject: Re: [PATCH 4.9 34/77] powerpc: fix build errors in stable tree
From: Yves-Alexis Perez <corsac@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Nicholas Piggin
	 <npiggin@gmail.com>
Date: Thu, 22 Feb 2018 14:59:12 +0100
In-Reply-To: <1519300931.2388.17.camel@debian.org>
References: <20180221124432.172390020@linuxfoundation.org>
	 <20180221124433.618725458@linuxfoundation.org>
	 <87k1v5rg66.fsf@concordia.ellerman.id.au>
	 <1519292030.2388.14.camel@debian.org> <20180222110835.GA22572@kroah.com>
	 <1519300931.2388.17.camel@debian.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-FYReE8WWyRnHGWqHqRU+"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593015251280374527?=
X-GMAIL-MSGID: =?utf-8?q?1593109861638221178?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-FYReE8WWyRnHGWqHqRU+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-02-22 at 13:02 +0100, Yves-Alexis Perez wrote:
> On Thu, 2018-02-22 at 12:08 +0100, Greg Kroah-Hartman wrote:
> > Did you look at /sys/devices/system/cpu/vulnerabilities/ to see what th=
e
> > files there say?
>=20
> Unfortunately I don't have access to a powerpc box where I could run a ne=
w
> kernel and try it on. I'll check with our ppc porters and see if I can ge=
t
> access to something.
So someone tried for me on Debian 4.9.82-1+deb9u2 on this hardware:

processor	: 0
cpu		: POWER8E (raw), altivec supported
clock		: 3425.000000MHz
revision	: 2.1 (pvr 004b 0201)

we have:
/sys/devices/system/cpu/vulnerabilities/meltdown:Mitigation: RFI Flush

Does this mean it's correctly enabled or do we still miss the various patch=
es
sent by Michael?

Regards,
--=20
Yves-Alexis
--=-FYReE8WWyRnHGWqHqRU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlqOzLAACgkQ3rYcyPpX
RFtIfgf/aNPVNY1IOD2IYEjFYwkMm7TS+rwxPwem77xNiIGGv1430r+kGdZb2qri
1t1NORaIxoeuMWVTLzgwn3/vM+XmIN9nlOpRu73AXUp1i/55Kwf5SbdTM1mmNrt2
5b6E4NHCosLN8hYvy0hfP0ufAOfickWA0LXXc1UfxCkVCG00R5rOmPq3c6C13FBH
PsE+iQksMgXy72g2ro0DOcPA50zKokWeCWmp2BO7FofVpXgCdwLq6woUb5eZRCI9
HK/humvkrtJpPi+uFqYH3wjePGuesyjs5TEKV4Cn3NeU3qVGF06na2uvBg8xatgV
9Pl+AdO11h4TQIqHCOfdW9N2/ttRvg==
=KAV6
-----END PGP SIGNATURE-----

--=-FYReE8WWyRnHGWqHqRU+--
