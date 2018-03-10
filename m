Return-Path: <kernel-hardening-return-12386-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvGvKgRmbcXXBAkOBUzAuXjG+y736HvbeYyhWZ5sRgZpRwaF1UmoTG2pPAZghvpmIOpQ+8v
ARC-Seal: i=1; a=rsa-sha256; t=1520714998; cv=none;
        d=google.com; s=arc-20160816;
        b=Pt7X0wG5uxh+Fl8qpRK1ePcxt2UsjLtemneQC1vZIFJaINJLsdZA2TsF+mvnqvOCxS
         ylHTowZ9EIfFY77AWJ3dzKPua4WE0mHdiwtoJym0nBQk7i7uwMaUnwwKkpokpjkXpobH
         NfH3YGfuFzhLxk+5ff0o6YftL1Y90Q9pRK3FD7Zq+hfk/gVaLgLlie5ZG0GI4JW3H5fz
         cKd+qVzHt86VNf4Fw2LXzDEFiOeg+tQcs8vqtyfFJQKsEiBuXMSJkMBtut59zWQ77/9Y
         RJfWcZ8GF23yEnEdSH0XcBBU9t2UL060IMncP0EJxNjBNhXO7s7A+5Yu+p8hQgdz5yag
         TVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:mime-version:references:in-reply-to:date:cc:to:from
         :subject:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=670YpE19lQdi+HzJhkgye9x1Q5/mRBwFavXmHlNlNIk=;
        b=KXyD8rrcaytTAl6yV2iVd5QBK+0Nl1bUEUoabGlteIX/BDo5CGOvAWaxXVHxtZoNBu
         TTQaYvwWug6qQuVYNjpqV6Ly3MdbIVDbIK89Br8uBnkaA+eYnFX52vvr4UWHHZVZC2LH
         QA5R/b87ek7TIPkx5hSMyH95o+mqu8sZCTkxXHcPJpnL7ujQxsn3t/B123FyTRXB8gBe
         1AXpAPZRtPoJPYvObU6yPlhBzCVxeRpcU9yOSLdvPyMZi9KEWs+Mqc2+jZnVxJsA9yGS
         jYC9zgeGVmGIhktBNmHqjXoCj1yeZH5hM2JmIe3Ds9MPc1nkd57MK9wF8a03SUv/yAqW
         m9xw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12386-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12386-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12386-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12386-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] scsi: resolve COMMAND_SIZE at compile time
From: James Bottomley <jejb@linux.vnet.ibm.com>
To: Stephen Kitt <steve@sk2.org>, Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hare@suse.com" <hare@suse.com>,
        "martin.petersen@oracle.com"
	 <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org"
	 <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org"
	 <linux-block@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com"
	 <kernel-hardening@lists.openwall.com>
Date: Sat, 10 Mar 2018 12:49:17 -0800
In-Reply-To: <20180310142930.0692200b@heffalump.sk2.org>
References: <20180309232933.14e39858@heffalump.sk2.org>
	 <20180309223355.21222-1-steve@sk2.org> <1520635631.2907.16.camel@wdc.com>
	 <20180310142930.0692200b@heffalump.sk2.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-OM5HNyDTbZlw5Ws0bDJ4"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18031020-0016-0000-0000-0000085F90DA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008648; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01001157; UDB=6.00509306; IPR=6.00780488;
 MB=3.00019960; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-10 20:49:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031020-0017-0000-0000-00003DCA3343
Message-Id: <1520714957.4495.5.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803100254
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594501214170730131?=
X-GMAIL-MSGID: =?utf-8?q?1594585250089996924?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-OM5HNyDTbZlw5Ws0bDJ4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-03-10 at 14:29 +0100, Stephen Kitt wrote:
> Hi Bart,
>=20
> On Fri, 9 Mar 2018 22:47:12 +0000, Bart Van Assche <Bart.VanAssche@wd
> c.com>
> wrote:
> >=20
> > On Fri, 2018-03-09 at 23:33 +0100, Stephen Kitt wrote:
> > >=20
> > > +/*
> > > + * SCSI command sizes are as follows, in bytes, for fixed size
> > > commands,
> > > per
> > > + * group: 6, 10, 10, 12, 16, 12, 10, 10. The top three bits of
> > > an opcode
> > > + * determine its group.
> > > + * The size table is encoded into a 32-bit value by subtracting
> > > each
> > > value
> > > + * from 16, resulting in a value of 1715488362
> > > + * (6 << 28 + 6 << 24 + 4 << 20 + 0 << 16 + 4 << 12 + 6 << 8 + 6
> > > << 4 +
> > > 10).
> > > + * Command group 3 is reserved and should never be used.
> > > + */
> > > +#define COMMAND_SIZE(opcode) \
> > > +	(16 - (15 & (1715488362 >> (4 * (((opcode) >> 5) &
> > > 7)))))=C2=A0=C2=A0
> >=20
> > To me this seems hard to read and hard to verify. Could this have
> > been
> > written as a combination of ternary expressions, e.g. using a gcc
> > statement
> > expression to ensure that opcode is evaluated once?
>=20
> That=E2=80=99s what I=E2=80=99d tried initially, e.g.
>=20
> #define COMMAND_SIZE(opcode) ({ \
> int index =3D ((opcode) >> 5) & 7; \
> index =3D=3D 0 ? 6 : (index =3D=3D 4 ? 16 : index =3D=3D 3 || index =3D=
=3D 5 ? 12 :
> 10); \
> })
>=20
> But gcc still reckons that results in a VLA, defeating the initial
> purpose of
> the exercise.
>=20
> Does it help if I make the magic value construction clearer?
>=20
> #define SCSI_COMMAND_SIZE_TBL (	\
> 	=C2=A0=C2=A0=C2=A0(16 -=C2=A0=C2=A06)		\
> 	+ ((16 - 10) <<=C2=A0=C2=A04)	\
> 	+ ((16 - 10) <<=C2=A0=C2=A08)	\
> 	+ ((16 - 12) << 12)	\
> 	+ ((16 - 16) << 16)	\
> 	+ ((16 - 12) << 20)	\
> 	+ ((16 - 10) << 24)	\
> 	+ ((16 - 10) << 28))
>=20
> #define COMMAND_SIZE(opcode)					=09
> \
> =C2=A0 (16 - (15 & (SCSI_COMMAND_SIZE_TBL >> (4 * (((opcode) >> 5) &
> 7)))))

Couldn't we do the less clever thing of making the array a static const
and moving it to a header? =C2=A0That way the compiler should be able to
work it out at compile time.

James

--=-OM5HNyDTbZlw5Ws0bDJ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCWqREzQAKCRDnQslM7pis
hQCdAP9X+JY9S6TJJVa9NN/j9DR6ai4u+PI2CzZEfB4w3WKAagD/TC1cwqmOjCnr
2FGwySKUezmBHURe948ekZU+nbgRvQM=
=yP4n
-----END PGP SIGNATURE-----

--=-OM5HNyDTbZlw5Ws0bDJ4--
