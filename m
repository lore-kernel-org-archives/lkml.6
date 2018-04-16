Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AIpwx48t373OP3nRZNNSwvD9d91NaC7nsMvB5noD/jmkwp9BIrEDDubEyRKVOavAXMNWliUOt62y
ARC-Seal: i=1; a=rsa-sha256; t=1523868280; cv=none;
        d=google.com; s=arc-20160816;
        b=QMZZXRvK8cp0koC0lAXM4p5d5f4CA3DlIFHJFSOv/BAF/ROqm8PpOjtRuLWnke7pfE
         OrfQsCKt2cdNF1vlcuEZkHZCe551OigXJzaE3zhrnENtn8W/p+mpYv7jLgSG/BlctQSx
         tSldVHALn8Sv3LqYsP0HUJM6vjp5pntGUuAi7DdyQb/4coqggst4oPOu0VrnfoHZEu6S
         DYLKHU8w9GSavxaUXzXFPgC5RIwcKHTefc1S1hTljVmBOGF+ChL02UWOLFqPN5Qmw/Vi
         DguJGjr/7fzyxfuXnWsIUCKOCwKJHzYhQPPql08UqKciFGX6tQKgofwvIyXg5+5ULglm
         RCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=/Z5Vy69xJbbHN+Um1rJhRFoAU+23cznEwY3J9IBiNZE=;
        b=Xsvkb1hfgIhQEyjv3FDd9lbfK7vi7W67xeBAIbRVfxr3ghP8c9J2jZZzbNE8Gvz4M2
         i4Oy7Ki1AcuyYKt5yQNJ3od6UkkkBeG9y+3pw1js65YNOKNiZaV6NsZkBYqkQDFUQKgX
         Is4b2re7j0HrVxduNJ9DcHlJh+ZMM3eU9mRQimrv3XuZ1+kUsuF1iahZR9SbLYma6hKp
         fVYTke+/Asj4c0u9urn11tBx5ze6KvHlpNhxUajB2B9vj7AcmdknHNSuG5aPptuMGtac
         lCivu8mhONzvAJ2Qs8/NaDYf4pUbVc8Emd02vnyd7Mb4y5dtBStHluIyEguzhU6HDqiY
         a25w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Mon, 16 Apr 2018 10:44:39 +0200
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
Message-ID: <20180416084439.GA5489@amd>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
 <20180408165038.GM5700@atomide.com>
 <20180408190600.GA24342@amd>
 <20180408235740.GN5700@atomide.com>
 <20180409105407.GA15315@amd>
 <20180409134259.GO5700@atomide.com>
 <20180412212412.GA29243@amd>
 <20180413002415.GC5700@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20180413002415.GC5700@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597108755036082132?=
X-GMAIL-MSGID: =?utf-8?q?1597891706201467812?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Do you have phy-mapphone-mdm6600 loaded? That is still needed to
> configure all the boot mode pins for the modem so it is usable..
> The UART will then work also without ohci-platform, just the
> USB PHY is disabled without ohci-platform.
>=20
> I have these in my .config:
> CONFIG_SERIAL_8250_OMAP=3Dy
> CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP=3Dy
> CONFIG_PHY_MAPPHONE_MDM6600=3Dm
> CONFIG_N_GSM=3Dm
>=20
> And then the two patches from $subject thread. I just tried
> it with today's mainline kernel and it's still working for
> me.
>=20
> Maybe you're missing some related patch though if usingv4.16?
>=20
> 984c7706ff18 ("ARM: dts: omap4-droid4: Configure uart1 pins")
> e5b9fd7bdeb5 ("ARM: dts: omap4-droid4: Configure MDM6600 USB PHY")
> fdd192037fce ("ARM: dts: omap4-droid4: Fix USB PHY port naming")
> bca809d8183c ("ARM: omap2plus_defconfig: Enable MDM6600 USB PHY")
> 077e1cde78c3 ("ARM: omap2plus_defconfig: Enable 8250_OMAP"
>=20
> So maybe you're still using CONFIG_SERIAL_OMAP=3Dy instead of
> CONFIG_SERIAL_8250_OMAP=3Dy?

Ahha, so first I missed two of the patches, and second, I was not
patient enough. I was stopping my test after first or second
error. Now I get... so I guess it works for me.

Thanks!

For the series:

Tested-by: Pavel Machek <pavel@ucw.cz>

								Pavel

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
Testing ngsm..
Could not open /dev/gsmtty1: Level 2 halted
Trying to start ngsm again: Level 2 halted
Starting ngsm..
Testing ngsm..
Could not open /dev/gsmtty1: Level 2 halted
Trying to start ngsm again: Level 2 halted
Starting ngsm..
Testing ngsm..
1> U0000AT+CFUN?
1<
Enable speaker phone..
2> U0001AT+EACC=3D3,0
2<
2> U0002AT+CMUT=3D0
2<
2> U0003AT+NREC=3D1
2<
2> U0004AT+CLVL=3D6
2<
Started ngsm, press Ctrl-C to exit when done



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrUYncACgkQMOfwapXb+vLc7gCgq/aLRu7gM4OfPZRhjEe4+55M
necAnAriSBPemK/Aq/Fd5AJOVe2wvdVr
=9jD2
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
