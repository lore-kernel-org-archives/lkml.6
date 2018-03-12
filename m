Return-Path: <kernel-hardening-return-12478-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvjv6qjCwmESoTyavy5GDFQNAhN5Z9qJkIEBZ1c7IxkJ/ef1B11fuiMtRHZEtwctgU2z4nB
ARC-Seal: i=1; a=rsa-sha256; t=1520882854; cv=none;
        d=google.com; s=arc-20160816;
        b=uPhjPVWX3h7D80aswCrJ5ZqtgAWrW35UMUsFE4hSzelpQJ5I1v19S5+4DYQ4wBYnu9
         BDHGTS/13GT+/RLW84P5pPB9k+gqC4RLhNVm/GRqXd0JAaAVLiZY4sfpyqCfQEeQrSvb
         9t3PZOwprG7hmZ0jTTzUphpl1LofyqpIOdylv0FF4ZTFUjxme1fx1ZUUYLHkw2Jw3LCw
         Hklt6DwBSQAAdUsVtLMOTOIV36QhWPgPgjT6VQ8bme6merVZB5J1lKfNw22JdsLfiO/K
         SA6lhHhlCEk4QcPeu7w6qnvWR6XyKqyWg3voDDuTOl16AgyG6NvrC1gyKOOcBPENyDVp
         80UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=a7l2z6nLJR4bWvz0ndrkM1WRAWowaq/h7FvBQ6ynPVo=;
        b=syzOGHJ0tZb+SHqJXAHrt7eexrl2LsSSqru2NYXJtxmQ59BO4enrkF4Wad0G9chpoI
         XmYCVC6/dVLO1jXTu7JltDzQCl+a5l7EWi08zcPPTPYNyhuMbWqfoWl89ZW2TTC4cDFR
         rIp3K01IFPbbCHsx4NnFiLLYBtAZecsYDeWqniI8apov7ON7843aqr543G7oLeGV70UH
         MRaE6Q871mhl3v9N08JSLcV/IZjEliMylsTT3BbaBt9eA+cwl+i4/CqAfH7tXRuwEbah
         Pg/wy4744LbQXb8dJvpSd2ey1ikbk3LACTT6ZesZ7aZP7zN51Kp4oY+GSYujE1fWqkOf
         YHeA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12478-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12478-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12478-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12478-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 12 Mar 2018 20:26:44 +0100
From: Stephen Kitt <steve@sk2.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "hare@suse.com" <hare@suse.com>,
 "kernel-hardening@lists.openwall.com"
 <kernel-hardening@lists.openwall.com>, "jejb@linux.vnet.ibm.com"
 <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH] device_handler: remove VLAs
Message-ID: <20180312202644.5594421e@heffalump.sk2.org>
In-Reply-To: <1520869285.3469.13.camel@wdc.com>
References: <20180309232933.14e39858@heffalump.sk2.org>
	<20180309223211.20473-1-steve@sk2.org>
	<1520635688.2907.17.camel@wdc.com>
	<20180310141422.3a8c451f@heffalump.sk2.org>
	<1520869285.3469.13.camel@wdc.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/Q4hJWW478X8YOM=u9FIG7am"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 15314490536987086302
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrleefgdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594501121445271854?=
X-GMAIL-MSGID: =?utf-8?q?1594761259965391251?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/Q4hJWW478X8YOM=u9FIG7am
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Mar 2018 15:41:26 +0000, Bart Van Assche <Bart.VanAssche@wdc.com>
wrote:
> On Sat, 2018-03-10 at 14:14 +0100, Stephen Kitt wrote:
> > The two patches I sent were supposed to be alternative solutions; see
> > https://marc.info/?l=3Dlinux-scsi&m=3D152063671005295&w=3D2 for the
> > introduction (I seem to have messed up the headers, so the mails didn=
=E2=80=99t
> > end up threaded properly). =20
>=20
> The two patches arrived in my inbox several minutes before the cover
> letter. In the e-mail header of the cover letter I found the following:
>=20
> X-Greylist: delayed 1810 seconds by postgrey-1.27 at vger.kernel.org; Fri,
> 09 Mar 2018 18:05:08 EST
>=20
> Does this mean that the delay happened due to vger server's anti-spam
> algorithm?

That=E2=80=99s right, the greylisting part of its anti-spam measures.

Regards,

Stephen

--Sig_/Q4hJWW478X8YOM=u9FIG7am
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAlqm1HQACgkQgNMC9Yht
g5w4Pg//XsoJ53FkY+BpdO4+B9OJz3sNmy8OJi+HGqMzhLpHeTp/5JKyCQI0J+6M
kHXrYkl76mRyYSnh4Dx/YEaq99igksN9B6mu21Y/y0ZNIveO1ItEnzux3D9K2/K0
M1ErDbD0rbpt14dkhbY4rn7dvmsLY26mmXEqdd9Kc2hiI4BqxTyI1IOYARswrpyk
jYHglsKtBsgUvloVAsLa7DIjuW7Fk/usA7aoZp2xJenKYVEmRbJDDvb3QOjS13eO
SKfWS8a6+viID7GbvADcGEGy0QdWe1I69qSAhkI5zlHZGaPM/dCCJmvJxRZ8JVks
F+Tl2obuWptRJe3muSLNg6y3XkNH18lvPRUC/AHR5wah9ZX3Hlx0gyudcztIw9FF
Ui1BgDmUyZC9hLgoXNKGGve/U3IEXs7wVV/EpxOfqvVnpmi/d566zv8ltRjRRa4F
f0IxclNOBEwlP0H1rEODKopdMSxTRMpvxLHDQr8ejOr6v7OkOW69UK5xIFpX8N7T
59YK14HbjUav7cjB9JnYTcS+4f3/rsubLYKS8y+DELIGskPEGKNkaiXlQINQ/3E8
09VegkFiaiQM1tCOvq3JXSGKnW/kUrGaAMBsAHdHJaZLjGD01i3tymcjf8eHQaTK
cWrpE98iLC1fqoIIY2Z6HnF65PURaUepKhlrQuERwbpSPGYx/C8=
=huhw
-----END PGP SIGNATURE-----

--Sig_/Q4hJWW478X8YOM=u9FIG7am--
