Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AG47ELsp1OjZGw/5PviNupxVbANYHT7defvObdzI4pBs3pzxS2t+KqkZbLyXSfE8H7H/yBJ/yrdF
ARC-Seal: i=1; a=rsa-sha256; t=1520341551; cv=none;
        d=google.com; s=arc-20160816;
        b=Itqc0i1S+s4hBKAQ75nS4e4Bmv8QVPojFgiblnpUZl/jMRn0Cs+cvzZcdZLE+zXr8Z
         uqsQHl5iRwK6Sx2+H1M30e4wd3iScZ5IvTWfLcYQaw4pFrEZoOQOyPDYTQQuYWZbQM1Y
         InTTFU3eRP6wI2NjQ+WHQEvsIEWoKnxjNeBxNtbxwg/VWqOI+TDeZPD5XCozLWhqxxtv
         QUKqny0ofqxNkTCBJeGTEvscH4KJeENjXb7jFDala6sEA47s4tPSK4bXzAJUGwfG6pcu
         eJEcNbq9SuzVkGbxhKr9/vD7J9SBJ6e7G3dT/BXVLW+CMIMTdGxj59sQnIkZFhJmEulb
         I/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=PIbFZzYjNmgQpK7ixwXplDKKB4UC+Q36wHRo7hscY3A=;
        b=q2YDxIBcOnw++B+nvnS16PQdGQN72YR/uEMDDoOfJOf+Djne88lM8ucMsAaHojcvKY
         dsarSUM/BzGUBaR2LvFAf2qc1RDdJtaL7wLtDiA40EUeDlaYymKjkXEPlWKmR677itCe
         cvtjdyWO2cCdWXq0P6b1sU16B5O26vDZ7JL8CQtfADH07T1AMfEJZyjfZ6mS9pvPiriN
         Hp93J6GaExFlZvDAW614ayjKye/UWkHvaDlMGLHCiwKeDZh6PKiGuRHFozVR9tP1na0z
         rpomoNdwLEjONYAPuLTZkkAXRUTSvrJkojO0bpVncBpKQb6GBeWcJDYG1znvj2Kg6txm
         BVGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Tue, 6 Mar 2018 14:05:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, joel@jms.id.au,
	andrew@aj.id.au, arnd@arndb.de, gregkh@linuxfoundation.org,
	jdelvare@suse.com, linux@roeck-us.net, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings: Add a
 document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
Message-ID: <20180306130551.GA16061@amd>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-3-jae.hyun.yoo@linux.intel.com>
 <20180306124002.GA13950@amd>
 <20180306125416.GD26143@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20180306125416.GD26143@lunn.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027883264098537?=
X-GMAIL-MSGID: =?utf-8?q?1594193662511247209?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-03-06 13:54:16, Andrew Lunn wrote:
> On Tue, Mar 06, 2018 at 01:40:02PM +0100, Pavel Machek wrote:
> > Hi!
> >=20
> > > Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> > > ---
> > >  .../devicetree/bindings/peci/peci-aspeed.txt       | 73 ++++++++++++=
++++++++++
> > >  1 file changed, 73 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/peci/peci-aspee=
d.txt
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.txt b=
/Documentation/devicetree/bindings/peci/peci-aspeed.txt
> > > new file mode 100644
> > > index 000000000000..8a86f346d550
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
> > > @@ -0,0 +1,73 @@
> > > +Device tree configuration for PECI buses on the AST24XX and AST25XX =
SoCs.
> >=20
> > Are these SoCs x86-based?
>=20
> ARM, as far as i can tell. If i get the architecture correct, these
> are BMC, Board Management Controllers, looking after the main x86 CPU,
> stopping it overheating, controlling the power supplies, remote
> management, etc.

Ok, so with x86 machine, I get arm-based one for free. I get it. Is
user able to run his own kernel on the arm system, or is it locked
down, TiVo style?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqeki8ACgkQMOfwapXb+vLqygCglPEZOOQBA5q0Fn16vyQbhxrU
F6IAoI4+SNEpv1QvK+tYZlnVkaev34y6
=AFs6
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
