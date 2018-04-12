Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AIpwx4/JG6rcmHs8F1p+ADJkLbyjUPSvpm+E/6m9f/9DPK3FccyMYrloWQAdz6MrD8GbMkWlu/Dq
ARC-Seal: i=1; a=rsa-sha256; t=1523568254; cv=none;
        d=google.com; s=arc-20160816;
        b=fFsapxueXh8HV2Qj4aAnUvew15Zf8VK0g8aejf6chNv2uYTgOTND1Ek4c0UnIx+1s5
         n55pVx7DOohODJcRRx9LvidSGAN3jHos5D3ud+2y4SV1xKJWA5ziZWx809RyXvPAp3iP
         H5qXFOfN9SBDyp7uEEPUAFESiukAUPjSufO6sdWwOSfe9a6KcTUoEIlN73jOxGPC8j/j
         aHVzUeNg9LZ0lloTpY/tOmegHilDIS9paDIuhoEsxj2qwDh5CkiodEYMnB0ySkz7X5wm
         dxlIuu/qbZeQHwtGBfFdHhNtKWnnuKipDUi9n5Cz9/L0H/1964o3Rq5dVJEf8GVDslBq
         ibwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=frUcmE3D8LuR4UpU9m9XAnQ2rBh+p1jD99uIRipEm2M=;
        b=xF7aggdtCsYyLNknw8/ukxjqxRoOxA0xilDrX+yY14QZl+gyK9y3AgEiqy5N2Wz5wr
         i7BAIvU2B+776VAXqEsXOEBK6rXnYetMtRRAG06Wwzbg26hgXfNvZkVgltuDNLobDgOl
         Mj1EHJzsB+7lCp+1Pg/0tuRyyrgvBZIRek0Z2XNqi8wDAkHm+Rl4tTm1H1pNX/yYYUDb
         yBSYmaW1YIOJBNrqlXePkoWkBWxUP1K9kytaUBzMxn1SPjFgZDwtBQL1GJcrjJY9Ks2U
         1Z7/I1VIs6P0mjZD6alYkA6Fe7U7ugBorZwLUpAzh1QPJXP/ODGFKXBzEKg/e5WaWtOo
         N1Tw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Thu, 12 Apr 2018 23:24:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Alan Cox <alan@llwyncelyn.cymru>, Dan Williams <dcbw@redhat.com>,
	Jiri Prchal <jiri.prchal@aksignal.cz>, Jiri Slaby <jslaby@suse.cz>,
	Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>,
	Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	Michael Scott <michael.scott@linaro.org>,
	Peter Hurley <peter@hurleysoftware.com>,
	Russ Gorby <russ.gorby@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] tty: n_gsm: Fix long delays with control frame
 timeouts in ADM mode
Message-ID: <20180412212412.GA29243@amd>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
 <20180408165038.GM5700@atomide.com>
 <20180408190600.GA24342@amd>
 <20180408235740.GN5700@atomide.com>
 <20180409105407.GA15315@amd>
 <20180409134259.GO5700@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20180409134259.GO5700@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597108755036082132?=
X-GMAIL-MSGID: =?utf-8?q?1597577105466379203?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-04-09 06:42:59, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180409 10:56]:
> > Ok, I should have all that enabled. But droid4-ngsm still fails:
> >=20
> > user@devuan:/my/droid4-ngsm$ sudo ./droid4-ngsm
> > Starting ngsm..
> > Testing ngsm..
> > Could not open /dev/gsmtty1: Level 2 halted
> > Trying to start ngsm again: Level 2 halted
> > Starting ngsm..
>=20
> I guess you must have phy-mapphone-mdm6600 enabled as you a have
> working modem over USB. What do you see in dmesg if you enable n_gsm
> debug with modprobe n_gsm debug=3D0xff or on kernel cmdline?

Ok, let me try... Got some debugging output, hopefully you can see
what is going on there?

Thanks,
							Pavel

sudo insmod /tmp/n_gsm.ko debug=3D0xff

user@devuan:/my/droid4-ngsm$ sudo ./droid4-ngsm
Starting ngsm..
Testing ngsm..
Could not open /dev/gsmtty1: Level 2 halted
Trying to start ngsm again: Level 2 halted
Starting ngsm..
Testing ngsm..
Could not open /dev/gsmtty1: Level 2 halted
Trying to start ngsm again: Level 2 halted
Starting ngsm..
^CCould not set conf: Interrupted system call
Could not start ngsm: Interrupted system call

[ 3378.381134] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[ 3408.460937] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[ 3413.633239] Q>  0) R: UIH(F)
[ 3413.639190] C3
[ 3413.642761] gsm_data_kick: 00000000: 7e 01 ef c3 aa 7e
~....~
[ 3413.653564] gsmld_output: 00000000: 7e 01 ef c3 aa 7e
~....~
[ 3413.978942] Q>  0) R: UIH(F)
[ 3413.984924] C3
[ 3413.988586] gsm_data_kick: 00000000: 7e 01 ef c3 aa 7e
~....~
[ 3413.999114] gsmld_output: 00000000: 7e 01 ef c3 aa 7e
~....~
[ 3414.328247] Q>  0) R: UIH(F)
[ 3414.333068] C3
[ 3414.336608] gsm_data_kick: 00000000: 7e 01 ef c3 aa 7e
~....~
[ 3414.346984] gsmld_output: 00000000: 7e 01 ef c3 aa 7e
~....~
[ 3414.679870] gsmld_output: 00000000: f9 03 3f 01 1c f9
=2E.?...
[ 3414.690979] --> 0) C: SABM(P)
[ 3414.798370] gsmld_output: 00000000: f9 03 3f 01 1c f9
=2E.?...
[ 3414.809570] --> 0) C: SABM(P)
[ 3414.918243] gsmld_output: 00000000: f9 03 3f 01 1c f9
=2E.?...
[ 3414.928588] --> 0) C: SABM(P)
[ 3416.743682] Q>  0) R: UIH(F)
[ 3416.748352] C3
[ 3416.751800] gsm_data_kick: 00000000: 7e 01 ef c3 aa 7e
~....~
[ 3416.762145] gsmld_output: 00000000: 7e 01 ef c3 aa 7e
~....~
[ 3417.088256] Q>  0) R: UIH(F)
[ 3417.093078] C3
[ 3417.096679] gsm_data_kick: 00000000: 7e 01 ef c3 aa 7e
~....~
[ 3417.107208] gsmld_output: 00000000: 7e 01 ef c3 aa 7e
~....~
[ 3417.438201] Q>  0) R: UIH(F)
[ 3417.443206] C3
[ 3417.446990] gsm_data_kick: 00000000: 7e 01 ef c3 aa 7e
~....~
[ 3417.457733] gsmld_output: 00000000: 7e 01 ef c3 aa 7e
~....~
[ 3417.788330] gsmld_output: 00000000: f9 03 3f 01 1c f9
=2E.?...
[ 3417.799163] --> 0) C: SABM(P)
[ 3417.918243] gsmld_output: 00000000: f9 03 3f 01 1c f9
=2E.?...
[ 3417.929107] --> 0) C: SABM(P)
[ 3418.038208] gsmld_output: 00000000: f9 03 3f 01 1c f9
=2E.?...
[ 3418.049102] --> 0) C: SABM(P)
[ 3419.854248] Q>  0) R: UIH(F)
[ 3419.859527] C3
[ 3419.863555] gsm_data_kick: 00000000: 7e 01 ef c3 aa 7e
~....~
[ 3419.874481] gsmld_output: 00000000: 7e 01 ef c3 aa 7e
~....~
[ 3420.208221] Q>  0) R: UIH(F)
[ 3420.213500] C3
[ 3420.217498] gsm_data_kick: 00000000: 7e 01 ef c3 aa 7e
~....~
[ 3420.228393] gsmld_output: 00000000: 7e 01 ef c3 aa 7e
~....~
[ 3420.598205] Q>  0) R: UIH(F)
[ 3420.603515] C3
[ 3420.607513] gsm_data_kick: 00000000: 7e 01 ef c3 aa 7e
~....~
[ 3420.618377] gsmld_output: 00000000: 7e 01 ef c3 aa 7e
~....~
user@devuan:/my/droid4-ngsm$

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrPznwACgkQMOfwapXb+vLsGwCfevVpkrT7LX6DhpN0ZhV2XLOb
7T8An2ckSVX52ReGUi6HCj53b3vBLA08
=LNJ2
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
