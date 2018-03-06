Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AG47ELuRN+vBnJdRK/1KGmE6JWIdVSFWmB6MHEVbHGUBsNAdSLFt90lZrRYbluC+ViekLbYHuUuS
ARC-Seal: i=1; a=rsa-sha256; t=1520340014; cv=none;
        d=google.com; s=arc-20160816;
        b=VnLBgrDaIjAWapTWo+iwySeNpw5kTrwZX31JtPUBZHbDVPPkB3oZKAGo9xLelK+3ki
         VYNrI32LbKF4jAnw9zxC3bSsbxrVEnYBRbw71N+UysAnZ8YHhxkRSk1ylNm6vlu1Tf6J
         GNqv+NTF7k5RlZTbgbe+i+yXRTSRrBH+gpPHVkphRXNHmHTX1R50NX3sUkWaxirMgIP8
         CnGmj1WkIHMVy/N8ADZeusxpT9Pv2uW2NLvflrYwFX5QkStDdQeebq4OTRHnk0S0oUqU
         gvn6n+6Uij3TViyW8lD8tTUChzBBgDHPcHHEVS1bWUvM1fvb8rK+ZWV4ct81vDdJj+Z5
         vVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=fUCfoTEPza5aM4HEFfbuIXASqTVKjzGdCHw0J8rp6YY=;
        b=vjC2nevtfQjl7GMVp3h/jYh0kFJWIClfxuu6i01MfG/vCr/27SQCdtiXmpdFn072sn
         wP29MSL25GZZdFIJQQmnszRbh5NfZdxXZpjssmt8jE+gNYAcCa//zhARS3JiCNc+/FLV
         eQYYJl3oYiJaShPnClGVjZaWvgrKVq50pT9B8nCg1ROKmnd23NNys7/5CSjNJuPAnJ1n
         8FQoiM1O51z9Ek+iXYOtIBHg6FTm3yyWIH+M2AAZCNO8E7Dvc2yMHfkV1qmtVCYbv4NQ
         hgTznmfPKjJ8zkhD6u6pxEfO6j7Hz/vANv6WwuiYdl92R5ygrHgM20ZevYH3Q2azl5Da
         OAQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Tue, 6 Mar 2018 13:40:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: joel@jms.id.au, andrew@aj.id.au, arnd@arndb.de,
	gregkh@linuxfoundation.org, jdelvare@suse.com, linux@roeck-us.net,
	benh@kernel.crashing.org, andrew@lunn.ch,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 0/8] PECI device driver introduction
Message-ID: <20180306124014.GB13950@amd>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027880268986254?=
X-GMAIL-MSGID: =?utf-8?q?1594192051286032632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Introduction of the Platform Environment Control Interface (PECI) bus
> device driver. PECI is a one-wire bus interface that provides a
> communication channel between Intel processor and chipset components to
> external monitoring or control devices. PECI is designed to support the
> following sideband functions:
>=20
> * Processor and DRAM thermal management
>   - Processor fan speed control is managed by comparing Digital Thermal
>     Sensor (DTS) thermal readings acquired via PECI against the
>     processor-specific fan speed control reference point, or TCONTROL.
>     Both TCONTROL and DTS thermal readings are accessible via the process=
or
>     PECI client. These variables are referenced to a common temperature,
>     the TCC activation point, and are both defined as negative offsets fr=
om
>     that reference.
>   - PECI based access to the processor package configuration space provid=
es
>     a means for Baseboard Management Controllers (BMC) or other platform
>     management devices to actively manage the processor and memory power
>     and thermal features.
>=20
> * Platform Manageability
>   - Platform manageability functions including thermal, power, and error
>     monitoring. Note that platform 'power' management includes monitoring
>     and control for both the processor and DRAM subsystem to assist with
>     data center power limiting.
>   - PECI allows read access to certain error registers in the processor M=
SR
>     space and status monitoring registers in the PCI configuration space
>     within the processor and downstream devices.
>   - PECI permits writes to certain registers in the processor PCI
>     configuration space.
>=20
> * Processor Interface Tuning and Diagnostics
>   - Processor interface tuning and diagnostics capabilities
>     (Intel(c) Interconnect BIST). The processors Intel(c) Interconnect
>     Built In Self Test (Intel(c) IBIST) allows for infield diagnostic
>     capabilities in the Intel UPI and memory controller interfaces. PECI
>     provides a port to execute these diagnostics via its PCI Configuration
>     read and write capabilities.
>=20
> * Failure Analysis
>   - Output the state of the processor after a failure for analysis via
>     Crashdump.
>=20
> PECI uses a single wire for self-clocking and data transfer. The bus
> requires no additional control lines. The physical layer is a self-clocked
> one-wire bus that begins each bit with a driven, rising edge from an idle
> level near zero volts. The duration of the signal driven high depends on
> whether the bit value is a logic '0' or logic '1'. PECI also includes
> variable data transfer rate established with every message. In this way,
> it is highly flexible even though underlying logic is simple.
>=20
> The interface design was optimized for interfacing to Intel processor and
> chipset components in both single processor and multiple processor
> environments. The single wire interface provides low board routing
> overhead for the multiple load connections in the congested routing area
> near the processor and chipset components. Bus speed, error checking, and
> low protocol overhead provides adequate link bandwidth and reliability to
> transfer critical device operating conditions and configuration
> information.
>=20
> This implementation provides the basic framework to add PECI extensions
> to the Linux bus and device models. A hardware specific 'Adapter' driver
> can be attached to the PECI bus to provide sideband functions described
> above. It is also possible to access all devices on an adapter from
> userspace through the /dev interface. A device specific 'Client' driver
> also can be attached to the PECI bus so each processor client's features
> can be supported by the 'Client' driver through an adapter connection in
> the bus. This patch set includes Aspeed 24xx/25xx PECI driver and a gener=
ic
> PECI hwmon driver as the first implementation for both adapter and client
> drivers on the PECI bus framework.

Ok, how does this interact with ACPI/SMM BIOS/Secure mode code? Does
Linux _need_ to control the fan? Or is SMM BIOS capable of doing all
the work itself and Linux has just read-only access for monitoring
purposes?

Pavel

-- (english) http://www.livejournal.com/~pavelmachek
(cesky, pictures)
http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqejC4ACgkQMOfwapXb+vL7QwCbBLqyD0r8Cf3YWmTe5LwbrEhg
QccAoJBgfUrVQ0t2o/5ZoHIVamsWUL6r
=rQIF
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
