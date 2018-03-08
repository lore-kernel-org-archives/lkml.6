Return-Path: <SRS0=1I8i=F6=ucw.cz=pavel@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2157884-1520522067-2-17518907264490870678
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: to='utf-8', plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=1I8i=F6=ucw.cz=pavel@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520522066; b=iyJdyySae/OA2ce6Cwkb1/437SWnvizBSlT8iPlQWlD69PU
    I6Lp1DatdrBs7y0h/GyvFoNhL1SnX0n0oNJSftqePMgLS14kaQ76PkbHK9vY56cp
    eyKNrkCNnI1QOdHdWM0y/JTiHjJ30G+ipX7bs6ZZNM7XO43fAGK0TCPDY8YNu1YZ
    UBGcQYGxquW7doLQF8ckxQ+Ciu6Fpi82CvICuJpCZ7CP33IY72r6N+M6VQYSh4Re
    m8iU+TjdyqIR05EJXubsqiZuyMJPKX+1VsSGQJa1A1QAJa4AC54JIeUcRNUMECqi
    xLsGkt2HrEQ8MKkKH037sHomtOb9derFvO15R6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type; s=arctest; t=1520522066; bh=OJ+oawmg
    jgG6ASotPKiKwHQzz3hbQbfO0jFKlhGMqng=; b=sQRIxtZ7iAi6rodEoiF5eGkr
    qLsKW9FdDEZXv72A2OCYvQiZE+DHtTNX16V47tzR/TvbZY6WozlPK2djh/ERZX2f
    w0rgKi3k+oc7C6bqR7/bh5r7AFbJiW0tbMs2t7fasIfN2yQlwQ5TQUVi2OSJhujy
    fHKsy/Z4+EPV9MEx1Cw/iwZT/HRj0vMW6qtV0Q13ampk6N5JNUciF2jtmyAb243w
    ZOqiTW1bm+VRyhOHVxtgSwg8zOcZhttSNzMePCoDU7klMov1anziZgyn04BwpQc3
    UubbXzYLjYauHAvUfZfyBp97EqOQj9IwR+W3eDWhd77PRd6FgI1mzr4rAm6SAQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=1I8i=F6=ucw.cz=pavel@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=49 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=1I8i=F6=ucw.cz=pavel@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=49 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF12205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=pavel@ucw.cz
Date: Thu, 8 Mar 2018 16:14:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: pali.rohar@gmail.com, sre@kernel.org,
	kernel list <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
	aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
	patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
	clayton@craftyguy.net, martijn@brixit.nl,
	sakari.ailus@linux.intel.com,
	Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
Cc: broonie@kernel.org, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org,
	security@kernel.org
Subject: linux-next on n900: oops in codec_reg_show() when grepping sysfs
Message-ID: <20180308151421.GA13160@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

pavel@n900:/sys$ uname -a
Linux n900 4.16.0-rc4-next-20180308 #71 Thu Mar 8 15:27:49 CET 2018
armv7l GNU/Linux
pavel@n900:/sys$ grep -ri fasdfasdf .

leads to an oops:

[ 2278.331878] DSS: context saved
[ 2278.820343] Unable to handle kernel NULL pointer dereference at
virtual address 00000004
[ 2278.828948] pgd =3D c36040a2
[ 2278.831787] [00000004] *pgd=3D876c4831, *pte=3D00000000, *ppte=3D00000000
[ 2278.838439] Internal error: Oops: 17 [#1] ARM
[ 2278.843017] Modules linked in:
[ 2278.846221] CPU: 0 PID: 16337 Comm: grep Tainted: G        W
4.16.0-rc4-next-20180308 #71
[ 2278.855529] Hardware name: Nokia RX-51 board
[ 2278.860015] PC is at soc_codec_reg_show+0x8/0x19c
[ 2278.864959] LR is at codec_reg_show+0x28/0x30
[ 2278.869506] pc : [<c0598f84>]    lr : [<c0599140>]    psr: a0000013
[ 2278.876098] sp : ce063e10  ip : cd7a9000  fp : 00000001
[ 2278.881561] r10: cd7a8000  r9 : c0842a04  r8 : 00001000
[ 2278.887023] r7 : 00000fff  r6 : ce69fd80  r5 : 00000000  r4 :
00000000
[ 2278.893890] r3 : ce5d2000  r2 : 00001000  r1 : cd7a8000  r0 :
00000000
[ 2278.900726] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment none
[ 2278.908203] Control: 10c5387d  Table: 87664019  DAC: 00000051
[ 2278.914215] Process grep (pid: 16337, stack limit =3D 0x2c91d92b)
[ 2278.920410] Stack: (0xce063e10 to 0xce064000)
[ 2278.924987] 3e00:                                     ce063ed0
00000000 00000000 ce063ed0
[ 2278.933563] 3e20: 00000000 00000000 00000000 c01e113c 00000000
ce063ed0 ce063f74 c01e5068
[ 2278.942138] 3e40: c059c388 00000000 00000000 ce69fd80 00000fff
00001000 c0842a04 cd7a8000
[ 2278.950714] 3e60: 00000001 c0599140 00000000 00000000 00000040
c7699200 c0c4a0c8 c0412f14
[ 2278.959289] 3e80: c0412ef8 c7699200 ce597008 c023d598 ce063ec0
00008000 cd7a6000 ce063f80
[ 2278.967895] 3ea0: c7699200 c7699230 00000001 c023bf90 c023bf6c
c01fab30 00042000 00000000
[ 2278.976470] 3ec0: 00000000 00000000 00000000 00000000 00000000
c080f7c4 00042000 cd7a6000
[ 2278.985046] 3ee0: ce063f80 00008000 ce062000 00042000 00041f90
c01d82e8 5aa1523b 34732c66
[ 2278.993621] 3f00: 5aa1523b 34732c66 00004024 00000000 00000000
00000000 0003520c c718eaf0
[ 2279.002197] 3f20: 00020000 cd7a6008 00000004 ce063f80 ce062000
00042000 00041f90 c02fad9c
[ 2279.010772] 3f40: 00000000 00008000 cd7a6000 00042000 00000000
ce063f80 00042000 c01d8464
[ 2279.019348] 3f60: 00000010 cd7a6000 00000000 00000000 cd7a6000
cd7a6000 00008000 c01d88ec
[ 2279.027923] 3f80: 00000000 00000000 beaa2744 00035330 00042000
00008000 00000003 c01011e4
[ 2279.036499] 3fa0: 00000000 c0101000 00035330 00042000 00000004
00042000 00008000 00008000
[ 2279.045074] 3fc0: 00035330 00042000 00008000 00000003 00001000
00000000 7fffffff 00041f90
[ 2279.053649] 3fe0: 00000000 beaa2748 0000d350 b6eb78dc 40000010
00000004 00000000 00000000
[ 2279.062255] [<c0598f84>] (soc_codec_reg_show) from [<c0599140>]
(codec_reg_show+0x28/0x30)
[ 2279.070922] [<c0599140>] (codec_reg_show) from [<c0412f14>]
(dev_attr_show+0x1c/0x4c)
[ 2279.079162] [<c0412f14>] (dev_attr_show) from [<c023d598>]
(sysfs_kf_seq_show+0x90/0x108)
[ 2279.087738] [<c023d598>] (sysfs_kf_seq_show) from [<c023bf90>]
(kernfs_seq_show+0x24/0x28)
[ 2279.096435] [<c023bf90>] (kernfs_seq_show) from [<c01fab30>]
(seq_read+0x1dc/0x500)
[ 2279.104461] [<c01fab30>] (seq_read) from [<c01d82e8>]
(__vfs_read+0x2c/0x120)
[ 2279.111968] [<c01d82e8>] (__vfs_read) from [<c01d8464>]
(vfs_read+0x88/0x114)
[ 2279.119445] [<c01d8464>] (vfs_read) from [<c01d88ec>]
(SyS_read+0x40/0x8c)
[ 2279.126678] [<c01d88ec>] (SyS_read) from [<c0101000>]
(ret_fast_syscall+0x0/0x54)
[ 2279.134521] Exception stack(0xce063fa8 to 0xce063ff0)
[ 2279.139801] 3fa0:                   00035330 00042000 00000004
00042000 00008000 00008000
[ 2279.148376] 3fc0: 00035330 00042000 00008000 00000003 00001000
00000000 7fffffff 00041f90
[ 2279.156951] 3fe0: 00000000 beaa2748 0000d350 b6eb78dc
[ 2279.162261] Code: ea05f08a c09c66ec e92d4ff0 e24dd034 (e5905004)
[ 2279.168792] ---[ end trace cbbe0b4a3061a0e7 ]---

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqhU00ACgkQMOfwapXb+vIRagCfUQ9z+7iaeHP6FE3m2eQVDwiv
7MsAoJ6cz8X21nimfMOYZ+tcRt0A8dqZ
=Jk/o
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
