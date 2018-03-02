Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AG47ELt0eo2u82MEaTn89YINDYssEOY40bXkae/dEyT65n3wrbUd5JRrtYqGY9hKDTz2DMNy1Rt8
ARC-Seal: i=1; a=rsa-sha256; t=1519981550; cv=none;
        d=google.com; s=arc-20160816;
        b=twM1lKv9/dzh5gMs/VzkJk664yr/9SaRhZWoDfxW7c8osWxj7b/NiZDsCaLYPYxrA9
         Z4xFlySLy45alSL1VwXIt0llTNPzduw5o3oHr4qE+/hLAz/W0XibDHAA62Z1vwttC/Yn
         rnrKSp4kk3g7tMFLFcNNReW7F1cu7MRO217MJFrMdezrfz2LrUUisBx/ObWCZe9v3GXd
         yETnWko99Yg2djfBVw/4JPGgP43BnYPUkeMSMPjCrx3IB3K3jxg8b7FYZueF+HNud8+7
         DtK23gwR03YAp4+ukzooJ2ILZXXmgtHkecrOFYsqiOaSpgx1m3liGJgbErnOWZOyS2cA
         2UGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=AW3G4KKlLNV5B0SHkySS1s6XB8UhdNQvVam2fhPREDY=;
        b=xrmScmYtI2Ao0QzDQV9V7lh0HfhowZNLdcY7+MwOV9vwfvEIrFcsBH/IBDtxOIUelP
         8xyAUmSrmntgiZUUzdYQwFPJ4UpAdkYcEbzdCBisOCfpRC8lZM+g4ZAbbFxdhH1dJzNS
         DBvtT/qRRUflYxS67k8wO7EYxWWoBtM1JEcpKzMT3NegVCv/3h9AJXgL+TpaP1a8VJ61
         mDN48JC5bIRjSZLaKFY20p+4Ew0kz+BTkbXeEsgzbKNGN/whmwIvfVMK+lXcghHP+96E
         04QfFiKG+9hb42Y4kne01ofPRBiGUmX+yMh6NsSLADZ3j/aoiJUFpuQx13jfFSeV0DZs
         53xQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Fri, 2 Mar 2018 10:05:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / wakeup: use seq_open() to show wakeup stats
Message-ID: <20180302090546.GB30267@amd>
References: <1519966860-32519-1-git-send-email-opensource.ganesh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <1519966860-32519-1-git-send-email-opensource.ganesh@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593800783059204124?=
X-GMAIL-MSGID: =?utf-8?q?1593816173474493880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-02 13:01:00, Ganesh Mahendran wrote:
> single_open() interface requires that the whole output must
> fit into a single buffer. This will lead to timeout when
> system memory is not in a good situation.
>=20
> This patch use seq_open() to show wakeup stats. This method
> need only one page, so timeout will not be observed.

Can the rcu_read_unlock be delayed arbitrarily by userland code?

Is that ok with RCU?
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqZE+oACgkQMOfwapXb+vJ5bgCeM/co3MWj3kAQshb7/8RKlNG+
0tAAoJfEsFTH1kDbQDRBU/h31TIf6CQu
=Ts+6
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
