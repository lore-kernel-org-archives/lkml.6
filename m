Return-Path: <sfr@canb.auug.org.au>
X-Google-Smtp-Source: AB8JxZpqBFUvQK6v4IytfKNcl1Zbi+DAd1IPZhBzAQP30t479RBAluU1VGj+1ttD818PApC8ibj/
ARC-Seal: i=1; a=rsa-sha256; t=1525407500; cv=none;
        d=google.com; s=arc-20160816;
        b=d6qfRydMj9ReZWt+YKtlaqiynN2ksh9SZCzWdtQKIiI7qr/Y51rHiZzu+3IBxEyLbo
         2zg8sAHdivRuL9QeaNg8dofqoQFkM9Rudku8tr0lr5VFfzEMlqEqhnnIQZEKKicSrKCt
         5mwxTsLnwcdGhMFxcM9WPu1TvdwkTM8iFqCfEg7bPyR21Fhx9CLYou7SPx0ABpJn9Lgn
         YaVl+a2rV3Y1DqdEFzqcMLf0BxyEDttKvPXcxsk1EpDtRaygT6uKszP6ylxK7fr4W4dM
         GTag7YL8A+j2zhpXavQnP8VS/hGfoxao04HGH3LbAxKQkgj45xUB+6t0Ja72BqBpUkW2
         HTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=lO2uFeaCQBGFCP8iicsIzIYgVD8hfoTjQbVMvoeXbDw=;
        b=XZw85To0xB+BHwP74XYeL6Amc5oocFo5qj5Twbzv1xMSMJuOVaoYonSbgeLcBNGKqG
         X23QOx+Wxy8+Rd1U2e9Hkm+2CvI4YhKp1uIwS5KsQstXIYTpc59gm4wjaQ/lbvGCHeXT
         4U1Ub/6/Ayx8rtZ+Ficq1bw09K+8pa9p5xWZinz/rRcc836Lo8vvyOw3UCjMcOPIb9XO
         8tzH6g6X5FtEqao4M+jzQ0w4ns0Aev/+f8dpfIfIDMj8dqE4LUn1nhwTm6Qg0YTO7Ri1
         1KGS+mVyoLI6xgXRAuiBdh4KPXJIl9xRW7+KTw/syDhX2whneBALnQ+6ou6qGYk3FIe4
         jx8w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@canb.auug.org.au header.s=201702 header.b=S9Al+HJq;
       spf=pass (google.com: domain of sfr@canb.auug.org.au designates 203.11.71.1 as permitted sender) smtp.mailfrom=sfr@canb.auug.org.au
Authentication-Results: mx.google.com;
       dkim=pass header.i=@canb.auug.org.au header.s=201702 header.b=S9Al+HJq;
       spf=pass (google.com: domain of sfr@canb.auug.org.au designates 203.11.71.1 as permitted sender) smtp.mailfrom=sfr@canb.auug.org.au
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 4 May 2018 14:17:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Minchan Kim <minchan@kernel.org>, Randy
 Dunlap <rdunlap@infradead.org>, Sergey Senozhatsky
 <sergey.senozhatsky@gmail.com>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20180504141756.670dc3f3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=/Tc5mW9Nj5Wdyl8rOBY+ij"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599505695773381278?=
X-GMAIL-MSGID: =?utf-8?q?1599505695773381278?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/=/Tc5mW9Nj5Wdyl8rOBY+ij
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm-current tree, today's linux-next build
(x86_64_allmodconfig) produced this warning:

drivers/block/zram/zram_drv.c: In function 'read_block_state':
drivers/block/zram/zram_drv.c:674:16: warning: format '%llu' expects argume=
nt of type 'long long unsigned int', but argument 5 has type '__kernel_time=
_t {aka long int}' [-Wformat=3D]
    "%12lu %12llu.%06lu %c%c%c\n",
           ~~~~~^
           %12lu
    (unsigned long)index, ts.tv_sec,
                          ~~~~~~~~~

Introduced by commit

  827c7dbda8eb ("zram-introduce-zram-memory-tracking-update-fix-fix")

--=20
Cheers,
Stephen Rothwell

--Sig_/=/Tc5mW9Nj5Wdyl8rOBY+ij
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrr3vQACgkQAVBC80lX
0GzoEAgApamxJmvlwEytxiGZwDhW3CYK3Za0jtTD7LMd+b17SyZIAT/Ah95K6j7L
3XcgiI6GbJ+YUhSVHbAfcvMb5HoLD+IDegl+0Ma+9NqfS18vYEciiXl0RM5LPtT2
Pn1CdUy0xaKYJThBbcWcKR41MlpaMWxlqzj7ihGXJa1JzG53d343g7fDQCIgEFjJ
hNZZYGeIVbOqQGFxI9e/R5EZtUvJtfuE2+dOwCjqrs7NM6bIpyWszWoUDZb3GjCL
GMdV3nBB5JsQVJWF+Q/brOk5RgwcZaMYc/4rOk1kfuDXVYv6R8UzdXjZPtStIBqX
u27JHdNU8yzktdiQWrWsvuBIgG0VVw==
=sutG
-----END PGP SIGNATURE-----

--Sig_/=/Tc5mW9Nj5Wdyl8rOBY+ij--
