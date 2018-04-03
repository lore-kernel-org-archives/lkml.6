Return-Path: <jhogan@kernel.org>
X-Google-Smtp-Source: AIpwx4/BiiX+1N6p4dpEiA7fHSnYwqnCq+Ye+5GJ9nWiLDLgrQ9Yqqk8EZv2+rZMgmOg0mY6ErE9
ARC-Seal: i=1; a=rsa-sha256; t=1522745640; cv=none;
        d=google.com; s=arc-20160816;
        b=p/ilD0cjmqhw5VmnbipzhgtG+D4EQHriz/93N60lewRbjmKlpyX3p42eQ3vrRvI5z9
         MyepYW+EMj2DhqT1MZoN49GFuoQuH/6zX4R4k5+yl4ialFj9WXx9Ez4nbmdtbX1qKTim
         +529+8uWEJlJMjY747/jpUhzrJ605rMz9AAhH0fOc+ia37hlUTq9qLM7D+o3UJ37NOir
         vbomV/DL+yuYo3/I1UczooBij08Hv1fzmkBA3mqoQRw1IAJ+4I8MFABzQODG91e4Niyb
         PhRQhPFSwuDdync+p2TDxpV/1266ye0yu2IWFR5ku9nslHHzXegatNhghJAnYXPbzboQ
         K8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=kkWAX23E+ar8tTz9EVPf4wmt02oHPYB94Qfekkso2ow=;
        b=B5VCm6aZpYV1RqssLSq20cOFQCWiJjnVXEyOHX/PxmG4U5PMWViYoE+sFVjSH/WFPg
         srwvgEoqU0Wn4YUkeSDL5xAg/dk9w5Fds1eE0XwCqvKVgyE79FugODKhridgySa1v7S8
         /vG5fh5OzFECXv5NYhmh4ZqmgaqSEpOBlPr17nQ0NFqO7vpdSIhDO+wgC51uHqIhnJVI
         tLRX1NfaKwFBTyrLTekH2lrq2LOb96WASn4aSNn1HZznmtdPVcZNiaGigEbKMdMUL+Xy
         6qp2Md4rgPU5f8+BloV0EU5juSAa/cE3eCYPFuHrXq1wAoNJDxsS0Th+c6pL2h6wy8T2
         I9Ag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC3920CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Tue, 3 Apr 2018 09:53:54 +0100
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Palmer Dabbelt <palmer@sifive.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Paul Burton <paul.burton@mips.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 3/3] MIPS: use generic GCC library routines from lib/
Message-ID: <20180403085354.GC31222@saruman>
References: <1522320083-27818-1-git-send-email-matt.redfearn@mips.com>
 <1522320083-27818-3-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <1522320083-27818-3-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596278698028411080?=
X-GMAIL-MSGID: =?utf-8?q?1596714532868772838?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2018 at 11:41:23AM +0100, Matt Redfearn wrote:
> This commit removes several generic GCC library routines from
> arch/mips/lib/ in favour of similar routines from lib/.

> diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
> index e84e12655fa8..6537e022ef62 100644
> --- a/arch/mips/lib/Makefile
> +++ b/arch/mips/lib/Makefile
> @@ -16,5 +16,4 @@ obj-$(CONFIG_CPU_R3000)		+=3D r3k_dump_tlb.o
>  obj-$(CONFIG_CPU_TX39XX)	+=3D r3k_dump_tlb.o
> =20
>  # libgcc-style stuff needed in the kernel
> -obj-y +=3D ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o mu=
lti3.o \
> -	 ucmpdi2.o
> +obj-y +=3D bswapsi.o bswapdi.o multi3.o

Have you missed deleting the files?

Cheers
James

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrDQSIACgkQbAtpk944
dnoaBw/9HMbx/CMVCDbUgpib19iwGMsLVXjz8S8SSeswxejNpm2Be9sRqYwSblYA
qOEgL8A5UQdYJISchU7R38UtCWF2IMfQFbD4R1oSmrKQfGOerxwXRtXYj4tmiXIz
wFYrys908McStD2mNn2WsjCfbN6gTYAtTQ9VLeIwElT6d8Db0Wid3L8MXuqV9Gem
e8/TIrDfjZt/S+RwMvG2aKBKvHByQfpAeE9ipZCwzuOyibj6vJMdlpn/5eJfv9kh
ESlboYbUh0wjJ+barZKGuOe29bNmH+2w/aNSoVCZlyqyhXOxRh1koMdUZJzcvjZR
vliIX/5LCUK2zhCwI5uQOqmLOu9TnT5nbmY0nuYuDEHmmQ4fsikLgKBLdQd6hdME
ip0cjiZT9MZa1qrr96sbq5J117QczJq4baAXW+xzRX1u9uBs3P7sG4+mdP8egTrQ
7pKRslRsNgZUsEAIXhWjN+tTTEI+m2RFCHi0BFyR1neyQ7/9sswXXNNQtIWGswy5
yvEXmgT7wnhuor+PI+CBsqemBKyI4wblOWS92JHlKSEgNvughOGRMQH0RiGM8r+L
prn6lvPZ34uh4H1stDgSBJ1qAAoQn+55jsrEC32R0IJ+dKLjwCy+Vrpsrq5Eqr5K
MjiPN5gnH+/oAIw8NKR0YjRCuSCM/bbrGtYzzVvw/cafDqqAHDA=
=GUUh
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
