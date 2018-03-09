Return-Path: <SRS0=Tvze=F7=ucw.cz=pavel@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1493289-1520633547-2-9349106422532186487
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: to='utf-8', plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=Tvze=F7=ucw.cz=pavel@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520633547; b=BCywJmqCdeIhJ66VSOqOLSMSi2v0FcOCtj85xF1PhEcSvUJ
    /yLnFsyar9V1dytjeYNPi055+YEeAY0fAPPLjpAd6yOOgBVOGVkHUPDscdnKY8EE
    ZMyfCQJGT1OvY+4teH6UOChWbntYmzlFxOlUCVw+L7XKFA7wb1zSJABg1ZGyMMMt
    hVHB/k/tpXuSXfq2Ev5UjU4lV0wWzy3SCg13liGPfecflOerZ0fHXFV2Azw8Lbtx
    9VC68HoG6UETLAtTXYbQXuSUI9VLI6g0XiI60bu/i85E8xlwPskbCZm2Jc2Ojph2
    Ela6D3V0H9MgQbTHDB6RxHNABI+yTIkCveJS0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:content-type; s=arctest; t=1520633547; bh=xIvLBCq2
    OPRaLeb8smLeFEStPBIzuvZwl3DGBbNsnv4=; b=MjpZmFKXzDc2xBRoWZoPoE5Y
    PHiRMkX6cgqewAqHiG5OC9GiAc2/iKOpx/zxbihalhhbmxV8fCJm0y/03DSAPOms
    d/1nIqFz4VuBUtVNHWtyw8VA4qhBswia+Lr1zpMTIGkwVArErd+LTZZxIZtAZNrN
    oULJQckG7nUT7J6cW/mBPidDoyfLBLDeQMqWb2QfOCMxLyh2wKh0hd2ZG5MGb/UJ
    za+79bVNyHZmrLp0ZyzE7rAXI92QlApnrM3O3gJK0ey5DZYCMUBBF+iqi/TkdUNU
    pyDOGLXKQoTKjq1kmuG5I8zjugbV4AWlTpl5XVz147l506mYnsP4scz1gCyYOw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=Tvze=F7=ucw.cz=pavel@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=49 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=Tvze=F7=ucw.cz=pavel@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=49 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2047421771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=pavel@ucw.cz
Date: Fri, 9 Mar 2018 23:12:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: pali.rohar@gmail.com, sre@kernel.org,
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
Subject: Nokia N900: v4.16-rc4: oops in iio when grepping sysfs
Message-ID: <20180309221220.GA15272@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Hmm. Looks like there's a lot of fun to be had with sysfs.

								Pavel


pavel@n900:~$ uname -a
Linux n900 4.16.0-rc4-59690-g7f84626-dirty #543 Thu Mar 8 19:53:30 CET
2018 armv7l GNU/Linux

[  306.402496] bq2415x: command Timer reset
[  312.761322] adp1653 2-0030: Read Addr:03 Val:00 ok
[  313.264129] Unable to handle kernel NULL pointer dereference at
virtual address 00000
000
[  313.272308] pgd =3D 01336620
[  313.275146] [00000000] *pgd=3D800af831, *pte=3D00000000, *ppte=3D00000000
[  313.281463] Internal error: Oops: 80000007 [#1] ARM
[  313.286376] Modules linked in:
[  313.289459] CPU: 0 PID: 3584 Comm: grep Tainted: G        W
4.16.0-rc4-59690-g
7f84626-dirty #543
[  313.298919] Hardware name: Nokia RX-51 board
[  313.303222] PC is at   (null)
[  313.306213] LR is at iio_ev_state_show+0x38/0x54
[  313.310852] pc : [<00000000>]    lr : [<c05d69c0>]    psr: a0000013
[  313.317169] sp : c7b47e70  ip : c087bb24  fp : 00000001
[  313.322418] r10: cb19e000  r9 : c0857220  r8 : 00001000
[  313.327667] r7 : 00000fff  r6 : cb711c80  r5 : cb19e000  r4 :
00000000
[  313.334228] r3 : 00000001  r2 : 00000000  r1 : c087b4dc  r0 :
ce584800
[  313.340789] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment none
[  313.347991] Control: 10c5387d  Table: 87bec019  DAC: 00000051
[  313.353759] Process grep (pid: 3584, stack limit =3D 0xc4e45eab)
[  313.359619] Stack: (0xc7b47e70 to 0xc7b48000)
[  313.364013] 7e60:                                     c05d6988
cb711b00 ce585c00 c0450d68
[  313.471038] [<c05d69c0>] (iio_ev_state_show) from [<c0450d68>]
(dev_attr_show+0x1c/0x4c)
[  313.479187] [<c0450d68>] (dev_attr_show) from [<c023f934>]
(sysfs_kf_seq_show+0x90/0x108)
[  313.487426] [<c023f934>] (sysfs_kf_seq_show) from [<c023e2f8>]
(kernfs_seq_show+0x24/0x28)
[  313.495758] [<c023e2f8>] (kernfs_seq_show) from [<c01fc954>]
(seq_read+0x1dc/0x500)
[  313.503479] [<c01fc954>] (seq_read) from [<c01d9f80>]
(__vfs_read+0x2c/0x120)
[  313.510681] [<c01d9f80>] (__vfs_read) from [<c01da0fc>]
(vfs_read+0x88/0x114)
[  313.517852] [<c01da0fc>] (vfs_read) from [<c01da584>]
(SyS_read+0x40/0x8c)
[  313.524780] [<c01da584>] (SyS_read) from [<c0101000>]
(ret_fast_syscall+0x0/0x54)
[  313.532318] Exception stack(0xc7b47fa8 to 0xc7b47ff0)
[  313.537414] 7fa0:                   00035330 00042000 00000003
00042000 00008000 00008000


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqjBsQACgkQMOfwapXb+vKPawCeLfAhJytBgevyhfgmPNyTsian
8B8Anj3pRQ/gHj/CDq0yO2i7sLuJsZbx
=X+br
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
