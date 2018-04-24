Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AB8JxZrWs8WRMnaZPm6FJDTliaPjFMOTt/pvRDF4pSXA2WGfq1jT6dEVW4dki7H/7oqhHyKSXl8v
ARC-Seal: i=1; a=rsa-sha256; t=1524600799; cv=none;
        d=google.com; s=arc-20160816;
        b=eNH2xWlsVGxbxYLe329MjlR+53J5l7w08XNwtbXVc8Mrst6U4eGQw3d28uuQTD1/ld
         DZHf/ZsvJlAf2uSMIzflChYp2gpyfK6hpOHbSw1qc5iUpRnFJLPV5Xm+QdpqAFwWYQ/B
         qXz64M1B+qKRX/yGhz92MZPPCscR0OtXNHdDrmgaDbHdC9x/v/yZ1awKTAqmipZroqYV
         7tacQhIovxD2BYhK8/6V7EnopQh78epViZNku8Kun0l5tdicUM8lDKFpo9AQ46R/mXzM
         s9BJW3yZlkvfFZOeBLSqDleuDuLwHPxaxudMRXEXIzy7WYQbxQb0VkjyCx5FtJNrMZso
         v6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=m8WaxDZmGfRwlecfV0adlt/s9x39yhyBcb6t8KoFqt8=;
        b=vu+JlL1SD7o4gU3svLBWMNHhKrVMQoEKrcH7TbtUI0GvUxkNZ5tFFtQdXz8Ril9YCl
         Ym1KC6zoVA74aWtHTEuMSSx835p/91ztiCjv6ISAP+WO6NlmuvPTCqMe1xWtN2VmymgG
         Z/407e/05ArWD2aI4ek9gO3aW38oyWGkyOj8foJB0nlOlZG0wJFmiIiU/HFMZoBDdinJ
         Co6/C7OOCGgp2+dkBxeWfB4Xk+pNCFl698ZaHewTP8XgCHBf+E0CMlKHzK2DxcQfVKWI
         CpKTTUqZxtfeCJpCIqtYshW1CsplVKbNh/+9N4suhyHbfmKtpvmcw/p9eIaLqyDnW2bT
         d48g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Tue, 24 Apr 2018 22:13:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
Message-ID: <20180424201318.GA14390@amd>
References: <20180424163458.11947-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20180424163458.11947-1-johan@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1598659807831723476?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds a new subsystem for GNSS receivers (e.g. GPS
> receivers).

Actually... I'd just call it GPS subsystem. Yes, GPS is a bit
misleading, but so is GNSS. We'd like Loran to use similar interface,
right? We'd like to QZSS to use similar interface, too...

https://www.pcworld.com/article/205325/japan_launches_its_first_gps_satelli=
te.html
=2E QZSS is not _global_ positioning system. Still they call it GPS. I'd
call it GPS too.

(Alternatively, we could have drivers/position and /dev/pos0...)

Looking closer... I'm not sure if it makes sense to push different
protocols (SiRF, NMEA, ...) through one device. Userland should know
what protocol to expect... Yes, there will be common code between
/dev/nmea0 and /dev/sirf0...

I don't know. I'd really like to see '/dev/input/event0'-like layer,
so that userland would not need to know about different protocols. But
your work solves some problems we have now...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrfj94ACgkQMOfwapXb+vID3wCfaYeCgIwFkq8aiao6DhY5zrPh
2+QAoL9evS+5bkUhFLJOsItcsQ2fpDAh
=x62g
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
