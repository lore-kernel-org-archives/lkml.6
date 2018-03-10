Return-Path: <pavel@ucw.cz>
X-Cyrus-Session-Id: sloti22d1t05-3011481-1520683258-2-12032595930448477175
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_MED -2.3, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='195.113.26.193', Host='atrey.karlin.mff.cuni.cz', Country='CZ',
  FromHeader='cz', MailFrom='cz'
X-Spam-charsets: cc='utf-8', plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: pavel@ucw.cz
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520683257; b=gFCzpych8PS2jw4C/lW1yv0RgJ2uLOsNx8UKHHaeYAiKiKa
    B/1cjXHlKdRgfG59HiVgSbMT5fnyYlfl4F3YTRNW04yiabHPxD9yY2aY64NLl+Ml
    oUaaIyEVX0uHBEld4EW2UxsdI1Kx/KMnQeyzfUNgQ5ZbkGPp1fNomnRHBvNOkKfE
    tEoNOofnkLpcwIW8f/Vkd4GmEXFKiqGqSXJUErT5CK+9zimfNk8CXNnQGbaeO4Gx
    7+YFmYdcjDcXftIS1StSa29DnuXxn4LwB2ZL6gqn+wLTyknL4fNEG+0Iue1N/SUf
    0go4oGeKZ7BVorNxiMd596JIjkgHSWsppB9jfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1520683257; bh=w+8kx7AvsCQ701gs6XPMEMdjaWIw5WP9NKx8b8qZaTk=; b=N
    Hfsd9rvejMlTmlMpfHzkbZ9wJNm2HKi3PWThu4128eDLyXmHwOuhfIyo10CEBGQv
    83aPBnwTA79V8nqpKWqbglZJNaF+BkkNiKpAzF2Q0LMXXoapWjEso2k6R8d3azA9
    rcFU38PdvRRtKItLRkvxQZNoH4AAm2vYUj/yp9q5BQlvT7b1wtiq6u9D4O5vgEqx
    TaYxqBkjAtqlFgLoZeaCwh7Snc9J3jWXesEmuOCtIwWekfvQHN6/RUaEUCqgZH5m
    jaVZJK24teubHHjsxxb2kH3vTftFUPxAIm7HQHCFmQ37yDD0yqKuKvEiELZViDOP
    MmVlJ/kPMhTS+nWr7f4Cg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=195.113.26.193 (atrey.karlin.mff.cuni.cz);
    spf=none smtp.mailfrom=pavel@ucw.cz smtp.helo=atrey.karlin.mff.cuni.cz;
    x-aligned-from=pass;
    x-category=clean score=-51 state=0;
    x-ptr=pass x-ptr-helo=atrey.karlin.mff.cuni.cz x-ptr-lookup=atrey.karlin.mff.cuni.cz;
    x-return-mx=pass smtp.domain=ucw.cz smtp.result=pass smtp_is_org_domain=yes header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=195.113.26.193 (atrey.karlin.mff.cuni.cz);
    spf=none smtp.mailfrom=pavel@ucw.cz smtp.helo=atrey.karlin.mff.cuni.cz;
    x-aligned-from=pass;
    x-category=clean score=-51 state=0;
    x-ptr=pass x-ptr-helo=atrey.karlin.mff.cuni.cz x-ptr-lookup=atrey.karlin.mff.cuni.cz;
    x-return-mx=pass smtp.domain=ucw.cz smtp.result=pass smtp_is_org_domain=yes header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Date: Sat, 10 Mar 2018 13:00:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg KH <greg@kroah.com>, jic23@kernel.org, akinobu.mita@gmail.com,
	javier@osg.samsung.com, gregor.boirie@parrot.com,
	pali.rohar@gmail.com, sre@kernel.org,
	kernel list <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
	aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
	patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
	clayton@craftyguy.net, martijn@brixit.nl,
	sakari.ailus@linux.intel.com,
	Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
	security@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
Subject: Re: Nokia N900: v4.16-rc4: oops in iio when grepping sysfs
Message-ID: <20180310120053.GB31614@amd>
References: <20180309221220.GA15272@amd>
 <20180309222821.GA16973@kroah.com>
 <20180309230124.GA17721@amd>
 <1bb9aa1e-1a78-5d1c-d2d6-f2cd6b925f31@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <1bb9aa1e-1a78-5d1c-d2d6-f2cd6b925f31@metafoo.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sat 2018-03-10 12:19:29, Lars-Peter Clausen wrote:
> On 03/10/2018 12:01 AM, Pavel Machek wrote:
> [...]
> >> What file are you opening to cause this?
> >=20
> > Strace says:
> >=20
> > openat(7, "in_intensity_both_thresh_rising_en",
> >>> O_RDONLY|O_LARGEFILE|O_NOFOLLOW) =3D 3
> > fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D4096, ...}) =3D 0
> > ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbe83b714) =3D -1 ENOTTY
> >>> (Inappropriate ioctl for device)
> > read(3,
> > Message from syslogd@localhost at Mar  9 23:54:39 ...
> >  kernel:[ 3097.357696] Internal error: Oops: 80000007 [#2] ARM
> >=20
> > So that would be:
> >=20
> > ./devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029/iio:device1/e=
vents/in_intensity_both_thresh_rising_en
> >=20
> > And indeed, manually cat-ing that file reproduces the problem.
> >=20
> > pavel@n900:/sys/devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029=
/iio:device1$
> > cat name
> > tsl2563
> >=20
> > I can not find tsl2563 in MAINTAINERS, file is
> > ./drivers/iio/light/tsl2563.c . I added few people pointed by git log.
>=20
> The driver registers event attributes, but does not provide a handle to
> access those attributes.
>=20
> Now the question is how to best handle this case.
>=20
> 1) Return an error when the device is registered and abort registration
> 2) Skip registering the event attributes
> 3) Skip registering the event attributes, but print a warning
> 4) Register the attributes, but return an error when they are accessed
>=20
> I'd prefer 2 since it offers a nice method of disabling all events for a
> device (e.g. if not interrupt is provided).

2 works for me.

Tested-by: Pavel Machek <pavel@ucw.cz>
Reported-by: Pavel Machek <pavel@ucw.cz>

Now grep -ri asdfasdf /sys finishes.

Thanks,
								Pavel

> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -477,7 +477,8 @@ int iio_device_register_eventset(struct iio_dev
>  	struct attribute **attr;
>=20
>  	if (!(indio_dev->info->event_attrs ||
> -	      iio_check_for_dynamic_events(indio_dev)))
> +	      iio_check_for_dynamic_events(indio_dev)) ||
> +	    !indio_dev->info->read_event_config)
>  		return 0;
>=20
>  	indio_dev->event_interface =3D

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqjyPUACgkQMOfwapXb+vKYcQCgsW3F4PGJPs/Sd+qmGxbE6FB6
fMoAoLrsw3Ko+09FqnqvF7GoQ6eIXoEA
=82F1
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
