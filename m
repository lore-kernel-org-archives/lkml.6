Return-Path: <pavel@ucw.cz>
X-Cyrus-Session-Id: sloti22d1t05-1595710-1520636489-2-9151644715239209349
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
    t=1520636488; b=twp3ZQ25Z5hElqiSYMtuir7Hh3/gNxszQfuYeD6knXGePol
    c6csqPOp0+beXNwDRWGKhFdVnV4Fr6K/XmqBCGus6KVDwv4dbjuhbYo1qXQ8uR1U
    +f0yZreTGrlWDZxrPIH14zsXLvRorfZ4RTyWdNvxV/23AlBV66Bt99ZBRgcDk0A4
    FD+AdSEeqYn5gVCSz4Kuo/760O8H2YHNr/i20kU37IKChnM0bJ7r5PPA2if5IQt6
    Qfi/2nN8FU8pWma9swLz8rj/sowQvJ/z3L7CG6aBuMUKsAwak9NiQ3AErhPPAK1v
    yZY5wiyLLlz0IlHdkkgvgZ+PJy4G/Q7vHDfSe4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1520636488; bh=YxSTo+U89YJ+ULT5YdBUaopskj8nTtwD6TGYroAZelM=; b=I
    R3/tuAq41ziLgC1PteGA0aoe9SszbHfB8tmzStcC3NAsJrkQ/18Vr+ZglTg4kgHx
    E2FVt2Hg6gjzvurxyRVaWOZOLI6UT3d1zEDe4UBu1fxs5JLq9qgP7rOkbvt6jvYU
    uWNi2VOdE1PCqSGHxzzMmyVFXLjFtNZfsXU7wbi7kFhdQIOvj/v5ivCC+S1zQrTp
    CjWCzKXPXiGIDqdLXeQ0Ag9osmJ0jJN0OVCoVQcHkiV8yZg9GblxmPoEhh5ulxV0
    tVA0FzQKHDTfW8ES/2jboCPL+M3d3DEXawweNtdkwQBSo/DS67aYlIidT4axdnFH
    UK9ei+Mi4fQfZtOZsTulA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=195.113.26.193 (atrey.karlin.mff.cuni.cz);
    spf=none smtp.mailfrom=pavel@ucw.cz smtp.helo=atrey.karlin.mff.cuni.cz;
    x-aligned-from=pass;
    x-category=clean score=-51 state=0;
    x-ptr=pass x-ptr-helo=atrey.karlin.mff.cuni.cz x-ptr-lookup=atrey.karlin.mff.cuni.cz;
    x-return-mx=pass smtp.domain=ucw.cz smtp.result=pass smtp_is_org_domain=yes header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
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
Date: Sat, 10 Mar 2018 00:01:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>, jic23@kernel.org, akinobu.mita@gmail.com,
	javier@osg.samsung.com, gregor.boirie@parrot.com
Cc: pali.rohar@gmail.com, sre@kernel.org,
	kernel list <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
	aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
	patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
	clayton@craftyguy.net, martijn@brixit.nl,
	sakari.ailus@linux.intel.com,
	Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
	security@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: Nokia N900: v4.16-rc4: oops in iio when grepping sysfs
Message-ID: <20180309230124.GA17721@amd>
References: <20180309221220.GA15272@amd>
 <20180309222821.GA16973@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20180309222821.GA16973@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Hmm. Looks like there's a lot of fun to be had with sysfs.
> >=20
> >=20
> > pavel@n900:~$ uname -a
> > Linux n900 4.16.0-rc4-59690-g7f84626-dirty #543 Thu Mar 8 19:53:30 CET
> > 2018 armv7l GNU/Linux
> >=20
> > [  306.402496] bq2415x: command Timer reset
> > [  312.761322] adp1653 2-0030: Read Addr:03 Val:00 ok
> > [  313.264129] Unable to handle kernel NULL pointer dereference at
> > virtual address 00000
> > 000
> > [  313.272308] pgd =3D 01336620
> > [  313.275146] [00000000] *pgd=3D800af831, *pte=3D00000000, *ppte=3D000=
00000
> > [  313.281463] Internal error: Oops: 80000007 [#1] ARM
> > [  313.286376] Modules linked in:
> > [  313.289459] CPU: 0 PID: 3584 Comm: grep Tainted: G        W
> > 4.16.0-rc4-59690-g
> > 7f84626-dirty #543
> > [  313.298919] Hardware name: Nokia RX-51 board
> > [  313.303222] PC is at   (null)
> > [  313.306213] LR is at iio_ev_state_show+0x38/0x54
> > [  313.310852] pc : [<00000000>]    lr : [<c05d69c0>]    psr: a0000013
> > [  313.317169] sp : c7b47e70  ip : c087bb24  fp : 00000001
> > [  313.322418] r10: cb19e000  r9 : c0857220  r8 : 00001000
> > [  313.327667] r7 : 00000fff  r6 : cb711c80  r5 : cb19e000  r4 :
> > 00000000
> > [  313.334228] r3 : 00000001  r2 : 00000000  r1 : c087b4dc  r0 :
> > ce584800
> > [  313.340789] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
> > Segment none
> > [  313.347991] Control: 10c5387d  Table: 87bec019  DAC: 00000051
> > [  313.353759] Process grep (pid: 3584, stack limit =3D 0xc4e45eab)
> > [  313.359619] Stack: (0xc7b47e70 to 0xc7b48000)
> > [  313.364013] 7e60:                                     c05d6988
> > cb711b00 ce585c00 c0450d68
> > [  313.471038] [<c05d69c0>] (iio_ev_state_show) from [<c0450d68>]
> > (dev_attr_show+0x1c/0x4c)
> > [  313.479187] [<c0450d68>] (dev_attr_show) from [<c023f934>]
> > (sysfs_kf_seq_show+0x90/0x108)
> > [  313.487426] [<c023f934>] (sysfs_kf_seq_show) from [<c023e2f8>]
> > (kernfs_seq_show+0x24/0x28)
> > [  313.495758] [<c023e2f8>] (kernfs_seq_show) from [<c01fc954>]
> > (seq_read+0x1dc/0x500)
> > [  313.503479] [<c01fc954>] (seq_read) from [<c01d9f80>]
> > (__vfs_read+0x2c/0x120)
> > [  313.510681] [<c01d9f80>] (__vfs_read) from [<c01da0fc>]
> > (vfs_read+0x88/0x114)
> > [  313.517852] [<c01da0fc>] (vfs_read) from [<c01da584>]
> > (SyS_read+0x40/0x8c)
> > [  313.524780] [<c01da584>] (SyS_read) from [<c0101000>]
> > (ret_fast_syscall+0x0/0x54)
> > [  313.532318] Exception stack(0xc7b47fa8 to 0xc7b47ff0)
> > [  313.537414] 7fa0:                   00035330 00042000 00000003
> > 00042000 00008000 00008000
> >=20
>=20
> What file are you opening to cause this?

Strace says:

openat(7, "in_intensity_both_thresh_rising_en",
> > O_RDONLY|O_LARGEFILE|O_NOFOLLOW) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D4096, ...}) =3D 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbe83b714) =3D -1 ENOTTY
> > (Inappropriate ioctl for device)
read(3,
Message from syslogd@localhost at Mar  9 23:54:39 ...
 kernel:[ 3097.357696] Internal error: Oops: 80000007 [#2] ARM

So that would be:

=2E/devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029/iio:device1/eve=
nts/in_intensity_both_thresh_rising_en

And indeed, manually cat-ing that file reproduces the problem.

pavel@n900:/sys/devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029/iio=
:device1$
cat name
tsl2563

I can not find tsl2563 in MAINTAINERS, file is
=2E/drivers/iio/light/tsl2563.c . I added few people pointed by git log.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqjEkQACgkQMOfwapXb+vKITwCeP1tgBYdQTIHgZKqz9l4ABVAL
WggAoKIGoQ0V3fel/58awEbWBVELQtIa
=dprE
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
