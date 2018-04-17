Return-Path: <jhogan@kernel.org>
X-Google-Smtp-Source: AIpwx4/zvtbQUh9wlHV4hAcdJx9cUvP/yYutwFVP6KtdJxTSRY91PD8vHxCUk+9pmtXst4m5v/WI
ARC-Seal: i=1; a=rsa-sha256; t=1524001063; cv=none;
        d=google.com; s=arc-20160816;
        b=K3vZkDU3QAAU+g8mUQVm6Bk6LUVtbKLkHWSy+7pXLo+ZgYJviHqzHOmfkY+TcOkwRe
         0UAD35yCxwRuLSZCg9legWvrhOYwZ4swD4wB64u0LpLacJnN+Gy1jvdGkrnT4qu8czoX
         wBeC+T/EaKKs8FIzQf5TZMMeVoj2uD/4UP32MvAWTT39T4TtmT7GSxrX7cjoCdqqsxvv
         sxVZnSXhOI7voqQPUTGFw6onC4zbZc4LFeGV+lwzt2YXntZei2Je6R+bmCQ6D23S3UPA
         LEQrmeVXVU+tK3c7hWFFOBJvg9oGeN5dA1Q2PQTTIMCT1kgjOmSFvgGbQvGp2llKUZUa
         APdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=yvuR7rxMpLIlng0Oc9X6mQ1buZxy6s536dwbCw7fB8o=;
        b=az8U0WXqa3uH0iIFYz6xrae+hefLkCSqOLcSnLXMlQ7jUl1lG38WkJjp3Po0TfUseX
         VIIBFAQyP/VWXMW/tsYHVE+58u++jdyoy+T87gcEC+HM7H9svziJVnZ2O04m9mcCZYmL
         iWQu+Uebv3D1AWP7J3phtekQwcyhsWc1OzPTFkysnuA1IcALcrdu5tFj2d+kPWonfxtx
         wl0aohOazqyOFbwl+trxCne1MDmyG43BOItV60xNOi/l/NNbOQ09WIzul8JYp/HoMmYe
         JlXUbHgHYJPc3wYKpGhJfdu14HUlRaCxE0bWZFoP4673KgTJISEGQLqCAaNB8CXnalQB
         6zgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7238321789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Tue, 17 Apr 2018 22:37:36 +0100
From: James Hogan <jhogan@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Paul Cercueil <paul@crapouillou.net>, devicetree@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Mathieu Malaterre <malat@debian.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Harvey Hunt <harvey.hunt@imgtec.com>
Subject: Re: [PATCH] MIPS: dts: avoid unneeded built-in.a creation in vendor
 DTS directories
Message-ID: <20180417213736.GC21386@saruman>
References: <1523893290-7958-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
In-Reply-To: <1523893290-7958-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597917995942758168?=
X-GMAIL-MSGID: =?utf-8?q?1598030939376240778?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 12:41:30AM +0900, Masahiro Yamada wrote:
> arch/mips/boot/dts/Makefile collects objects from sub-directories
> into built-in.a only when CONFIG_BUILTIN_DTB is enabled.  Reflect
> it also to the sub-directory Makefiles.  This suppresses unneeded
> built-in.a creation in arch/mips/boot/dts/*/ directories.
>=20
> While I am here, I replaced $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> with $(addsuffix .o, $(dtb-y)) to simplify the code a little bit.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>=20
>  arch/mips/boot/dts/brcm/Makefile          | 2 +-
>  arch/mips/boot/dts/cavium-octeon/Makefile | 2 +-
>  arch/mips/boot/dts/ingenic/Makefile       | 2 +-
>  arch/mips/boot/dts/lantiq/Makefile        | 2 +-
>  arch/mips/boot/dts/mscc/Makefile          | 2 +-
>  arch/mips/boot/dts/mti/Makefile           | 2 +-
>  arch/mips/boot/dts/netlogic/Makefile      | 2 +-
>  arch/mips/boot/dts/pic32/Makefile         | 2 +-
>  arch/mips/boot/dts/ralink/Makefile        | 2 +-
>  arch/mips/boot/dts/xilfpga/Makefile       | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/M=
akefile
> index d8787c9..d85f446 100644
> --- a/arch/mips/boot/dts/brcm/Makefile
> +++ b/arch/mips/boot/dts/brcm/Makefile
> @@ -34,4 +34,4 @@ dtb-$(CONFIG_DT_NONE) +=3D \
>  	bcm97425svmb.dtb \
>  	bcm97435svmb.dtb
> =20
> -obj-y				+=3D $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> +obj-$(CONFIG_BUILTIN_DTB)	+=3D $(addsuffix .o, $(dtb-y))

I like this. I had also spotted the .o files being unnecessarily
generated when building the dtbs target with bmips and CONFIG_DT_NONE=3Dy.
I'll apply for 4.18.

Thanks
James

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrWaSAACgkQbAtpk944
dnpdnw//YD2A/1lEIzZxj8CEUQ2ujJJrxQouFF1sJi9IXcJbCLSImNRiuI9qsoc3
h9T4YeQAAHCkXjIfwwQ2HL3wkCH+KK3xnF/Hq6h6wSMFcFHvoDRNrDwLP6XQx/xL
4cEtVo5DD2IltrFqx1aKI2LFZ9t3kFvaDPQx8rmpLQy/eeExvOG7x0B9MnI49wrT
5wChz2eKWFj3ngy5PSkMD1KaOfjT8aL5gzgLMKGvl6byo5nuiMSG3waSe8K0izJu
KPuwgmL5bJp/hEJOCmc9IiG9HzYlBLzC5wXnkkZ+AGx7wj8N6J6A8fgboziQqvND
CM9LdLwETacwHijTRpRZb66/OjjBgD4gg0Q3Djd6rdkpJJ/g632wZiZm0z8dP722
BxEfunGnDtUl02fTfcPwLlnMQPDXdQ3ZwyRdl5gbPhGHK6jp5aYVU9bXTcDmimOm
/SxylcFCf625dBWeqa0JdxR+UvsOnq6B5iTPhQQ2NYG6E6FPZy+tcFGuuYPzYXld
Lm/SVcoGlfWQpUMm4QMWq8QCISzGQ4bH+c53JzgBpNQ+Hgif+TZGh9SWZFiNfDXw
vQj2DBxAysPkje/ZFNQ+poAwQqvG1WApk9BUvDsojLcP/8TmV8jQuFwdez4n/P64
HA5fXyD8gVVezoGESjXOdmVQOBpZS+siBHrvSBOootQH1zyHgUA=
=wV2M
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
