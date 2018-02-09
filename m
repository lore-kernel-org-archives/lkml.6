Return-Path: <sre@kernel.org>
X-Google-Smtp-Source: AH8x225RxdjwoalW1VkW7+wh2wIDv97iQ7cRieDJHSa9rc5gByotcCzteZG6P8OnhzPCx+C41hLr
ARC-Seal: i=1; a=rsa-sha256; t=1518188512; cv=none;
        d=google.com; s=arc-20160816;
        b=a78sjQb54QRPN3aswX5RWOASAaDERUNcLm+cKqZy7gtL1SVqPwSms1Bt5eICx1F/2C
         sh9cYgsfzo3+KjW0Ll2dr4zCsUB9drVCI4/TFWgL+HS6b/dipdZDsxA2N24VaJ2sPuK6
         en21OORl9ndETbWv0NKsv8sIP0KG3avJavWYxtTvo05BbIqw99GiEqHmAeGtP2Y08of9
         GYzeWU2cNenG2sEYiZlyMa/FLiA1Ibt+tElL5NFYXAA4g3a+8AkHIO65vk2U3sYhnfae
         WnEdLG30MxKogCq0EoAKxpSUlMI3CesJyI47AN+xNEMUFy89I0Pva+O+RyyLqJqPDYnw
         172Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=uDSFJJfHbTLc8wZhmes09zd1NdS0L3TtQgDyfii++oc=;
        b=uBlrNhEfWFRZLXxaZCWuBxYUW5frQoikBvnludw0LOdVW54t2OuOxq3JQAI81nHqX7
         WCRDXRnf8ELp19WtD6d4GJMdCEVbGk3VJJMjk5tnkI952ScJ/YlIqLnYD9eSySh7WApS
         NNZLZ3x6Qo1EiBOfn42ui0KMSvrxXQZy28Ihm/RTHJddBFRiIcNNZ8sj/vHJ2H5lem7s
         96zcbbzNCP4+n8A+G+bcXyGq5tj0UZ/NOdk96yKw+bXnbJw09UV5wasAdIdnnGNRkzR0
         T9bkhtmOKh6VjvKrE1yt5l9a01aIzjtXOiVaImBlA8DkS7x4myMlfxJ208U5STmkDnKc
         XOuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of sre@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=sre@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of sre@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=sre@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983A521789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Fri, 9 Feb 2018 16:01:48 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Yueyao Zhu <yueyao.zhu@gmail.com>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH v4 5/7] power: supply: Add 'connected_type' property and
 supporting code
Message-ID: <20180209150148.624fb4qb34wuml6l@earth.universe>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <3af7db87e0e6bdfa46ef3c1c9053297f711aee5a.1514904983.git.Adam.Thomson.Opensource@diasemi.com>
 <20180208213054.oqgoktru3lzjiyyn@earth.universe>
 <2E89032DDAA8B9408CB92943514A0337014C1C1FDA@SW-EX-MBX01.diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ia2pxk24in2rjaux"
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1C1FDA@SW-EX-MBX01.diasemi.com>
User-Agent: NeoMutt/20171215
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588496437968457675?=
X-GMAIL-MSGID: =?utf-8?q?1591936037456032691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--ia2pxk24in2rjaux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 09, 2018 at 11:28:42AM +0000, Adam Thomson wrote:
> On 08 February 2018 21:31, Sebastian Reichel wrote:
> > On Tue, Jan 02, 2018 at 03:50:53PM +0000, Adam Thomson wrote:
> > > This commit adds the 'connected_type' property to represent supplies
> > > which can report a number of different types of supply based on a
> > > connection event.
> > >
> > > Examples of this already exist in drivers whereby the existing 'type'
> > > property is updated, based on an event, to represent what was
> > > connected (e.g. USB_DCP, USB_ACA, ...). Current implementations
> > > however don't show all supported connectable types, so this knowledge
> > > has to be exlicitly known for each driver that supports this.
> > >
> > > The 'connected_type' property is intended to fill this void and show
> > > users all possible types supported by a driver. The property, when
> > > read, shows all available types for the driver, and the one currently
> > > chosen is highlighted/bracketed. It is expected that the 'type'
> > > property would then just show the top-level type, such as 'USB', and
> > > this would be static.
> > >
> > > Currently the 'conn_type' enum contains all of the USB variant types
> > > that exist for the 'type' enum at this time, and in addition has
> > > the PPS type. In the future this can be extended further for other
> > > types which have multiple connected types supported. The mirroring
> > > is intentional so as to not impact existing usage of the 'type'
> > > property.
> > >
> > > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> >
> > Thanks for the patch. I think, that it's a good idea to provide the
> > subtype in its own property and just set the type property to "USB".
> > I would prefer to name this "usb_type". Otherwise
> >
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >
> > -- Sebastian
>=20
> Thanks for your review. I chose 'connected_type' as I thought this would =
be more
> generic in case other main types would have some dynamic connection eleme=
nt to
> them and could also benefit from this. If we don't see that as being some=
thing
> we want though then I can make this just for USB.

If such a thing appears at some point we can add another property.
I think usb_type is easier to understand from a user point of view
and it helps to keep our enums clean.

-- Sebastian

--ia2pxk24in2rjaux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp9t9kACgkQ2O7X88g7
+pqIsw//YTGtow/RCInDMNnwvWIWwJ4pGDvT6FhQ+nnEx1Gz8z9e5rxKEHoY7why
Akq5tfsto87k4vcO3w68zAhlJuHfwlY36VXlP253ao2cj0X4MM9IPWZ/FupDhkex
ZwB9Hl/OHkyJNRSXyni0b+mV7fDTwYK9fH3xexeqqlPfSpuGC68asTH95Bq5ixX3
g33rT5KC4U3WLcs69qTRIPnd1vgLGilfSM81l+mm4kdp34qaIIvodeg6r6hCSPrf
iUGxM61C54TRtxqMQ9UDR5qbPRfloX2lsBgxWX4QndgUqfXyFjDS4zudyePE2RV3
Nt1oGtTBHaT8fmif3NaCZt6VWfVJqzd7cVQ0EQhl7dZ89Ea50o6gR5ThR3vLKDN5
mevRiuLzvQbezd/IdlvT+5eMLZgLRCu/JSJg3zK83hnkIfuFGlfB/w1aFd/CSBV5
z7ixEnxWW15/F6CZtOUsoZqikbToUkEAHOQKH2t8WDLsS+s/iZeA29A77DVqe167
/LivgymItXpZ9F2vzkaWtfmdMlQHOmNjb1zEg2anW/VRd4nfzkhB8G4fTVusmDQe
+c+GnU6ulbao+QJqhanQmVuQyThuwRikDK0pThRp7H+mY+kD2X4B/8mVsFNsbu9/
qHTMDFEfaNgO9pR9r2PEC1dY4g1r8fdDgDWSTSaxCzZDF5hTRBs=
=ClSJ
-----END PGP SIGNATURE-----

--ia2pxk24in2rjaux--
