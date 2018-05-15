Return-Path: <sfr@canb.auug.org.au>
X-Google-Smtp-Source: AB8JxZpGjk71Vu/Zx4NP3Fl0mfDw3ccyMVT0YvJ7weDbiFfA6Y5TaW4rhrRls3n4sO72BEfyg867
ARC-Seal: i=1; a=rsa-sha256; t=1526343438; cv=none;
        d=google.com; s=arc-20160816;
        b=L/8ReyBreo2Z/oqApomLMCtPWK37SHPwB6weEaHrtrNbY+Q42kKeKX4IldTiWfi1Qq
         m+wSo9Fmov1XGlsm+r+DK2iXM63usn+a0LiwolwdcBeKZPDTsyvrNvg0y+aNaimnTMpL
         uw7FZpMz6U+ktKqn3wg8137i+8PunGwpfAlmlebgkncoGWpTHIkjIGcbqLFGVXh8p+U7
         DKmB+ivyQ/1s8UnGcT4yyAZIC2BLwLpegwJZncVLWCoRYqBOQLiXAKfWGYxEFoTckgG5
         /mExcVxeZqQvdc76EhIkHFLAQVPDPWfr+BCnH5B3z2xVZwtZRPepAwp8A57RXIkUfQ1n
         R+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:dkim-signature:arc-authentication-results;
        bh=8F2Qve68V0vFI1ejJLU7RywRttkBXqK7rPhl8uZhurM=;
        b=HvlX90CQtHzg2eWr2mYLMAnPcxBFoLkTmiVxX3jFLNVPh1+FSR9f6EUtqc0Le4ONII
         uXAFydb3gzb92hWgJf+2PyJfFwBpqmqffU2NSEWaXAJbrayMTb2tAK3rI9thih2eIIMP
         XeCJPUDPdaVGdx87BTTSF16t8khnasvzscRnqUiqGbfNa+ooHwaOWYJUbVi0Sxhewrdz
         kMB4wU4XMonx7b5eTbmkeZAs+ul22DFYhB/SPsREwKEzDHkxzTXXhWOzt22JpdXTY6C1
         cXyRocYADi+ZhbgXfMBXYiHgCW87dHkMElGsWWIRgdWbrYvdsnnu5b3+Auf1+yeC/doo
         uiHA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@canb.auug.org.au header.s=201702 header.b=D5yJjpfS;
       spf=pass (google.com: domain of sfr@canb.auug.org.au designates 203.11.71.1 as permitted sender) smtp.mailfrom=sfr@canb.auug.org.au
Authentication-Results: mx.google.com;
       dkim=pass header.i=@canb.auug.org.au header.s=201702 header.b=D5yJjpfS;
       spf=pass (google.com: domain of sfr@canb.auug.org.au designates 203.11.71.1 as permitted sender) smtp.mailfrom=sfr@canb.auug.org.au
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 15 May 2018 10:17:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, syzbot
 <syzbot+481ad819c717f6b78df9@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 gregkh@linuxfoundation.org, tj@kernel.org
Subject: Re: general protection fault in kernfs_kill_sb (2)
Message-ID: <20180515101712.366c0624@canb.auug.org.au>
In-Reply-To: <20180514040415.GD30522@ZenIV.linux.org.uk>
References: <14892403-d680-dc5d-1927-bc4a279514fb@I-love.SAKURA.ne.jp>
	<20180514024726.GB30522@ZenIV.linux.org.uk>
	<201805140320.w4E3KG2o056158@www262.sakura.ne.jp>
	<20180514040415.GD30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dJnsP3VONjtL+M36zJw8hlU"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600278456456605720?=
X-GMAIL-MSGID: =?utf-8?q?1600487097206622623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/dJnsP3VONjtL+M36zJw8hlU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

On Mon, 14 May 2018 05:04:15 +0100 Al Viro <viro@ZenIV.linux.org.uk> wrote:
>
> On Mon, May 14, 2018 at 12:20:16PM +0900, Tetsuo Handa wrote:
>=20
> > But there remains a refcount bug because deactivate_locked_super() from
> > kernfs_mount_ns() triggers kobj_ns_drop() from sysfs_kill_sb() via
> > sb->kill_sb() when kobj_ns_drop() is always called by sysfs_mount()
> > if kernfs_mount_ns() returned an error. =20
>=20
> Trivial:
>=20
> unfuck sysfs_mount()
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

I noticed this turn up in linux-next today.  Can I ask that you please
add an actual commit message to it before sending it on to Linus.
--=20
Cheers,
Stephen Rothwell

--Sig_/dJnsP3VONjtL+M36zJw8hlU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr6JwgACgkQAVBC80lX
0GwogQf+KjYWMWOMO/ULDvpyFBf1wFB2wbi3hwXzNaFyY891h+iTd91usMrzg/YL
7yKB0UbNo7LHAL2sunDoYOAP05X48HacHA2Tl0vJicrd6VuTMOAnztucqkixbL+k
krAn/4bfOSP470/gozNDY+czzTjW3ofX/6YKIMKxgzRP67K1ylrhfVkm/oN6zza8
wegMHvBjDxT1s3wnxzbzwBs0XMo2wjwcnoqoYuR+17AuYSgQ2lO89lqNrAGczEpP
TkEByS+Jdn49taqieLqK2wRIWIBLOZbQusw+5g30hLs8TIkZZzNfqShBM2whKq7N
WRF7kX+o4/QpVh1r9HFEJD9ZY/R0ww==
=xvpq
-----END PGP SIGNATURE-----

--Sig_/dJnsP3VONjtL+M36zJw8hlU--
