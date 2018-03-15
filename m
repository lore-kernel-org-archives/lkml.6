Return-Path: <sfr@canb.auug.org.au>
X-Cyrus-Session-Id: sloti22d1t05-3786778-1521095798-5-13029023017213388098
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='103.22.144.67', Host='ozlabs.org', Country='AU', FromHeader='au',
  MailFrom='au'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: sfr@canb.auug.org.au
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521095797; b=boUmPqLIcS97rP8mQuZsPJvbHh/0Uqh8Ml7Bik4KrNH66dv
    UkCgnpcXDcPBNxUOLOe5jw18Ra9BuuLY/7S+cAABUQfALAEvybVfwcPU23ISKWjf
    apUf3G7BikXXZefNBx8z1nrW7DauU6inrPpiOc595Hif//HypINfp8jMf9zrvRqw
    04s2d4ItYaIuKoGgiQna6irShG5hghsIQvA01Okwb7vct2awFzmf3fTRck/Eeo2k
    2DVxjC8MBQMZ0FsUWaKwyL8pjMAGRICBV44MaeMty5laPgD4iFwd9PAviS6sdXdx
    z41UNtW6iHPezVoJPWmNPYUlHWzs94in8iExVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type; s=arctest; t=1521095797; bh=U1sIrafY
    5CQ6Rpzi8Nk4kQg8Pri7PFurwlEqyQjN778=; b=hs5Xtq0FkKVMsVGDtCbRqpMo
    3H9nUJwcZQ48dxBVJtagq+TRB56MIyCKP/BPip5VOHVOUhqfe8Ku3isrUCk4ULq8
    TXSpYbEsq7IeV552K3JGdfZ3zt65umnf1olX2/x7stuTaL9AMvPEp0dfrifeaWrG
    DAosmhNOJHaM+szqSSKjopkwYPtNifNtZX/wQCgndz+5Mwc946cSjJN6OzI34XfR
    los9vLMXXEAD0kZwWikE/pku9U8P99tWRbLeJSWg1VZjKxMHRF4dcuCZu9ISTazn
    dDfkM4jqbdc09E1UqOKYISZzljucjxlw2CCOuSNT9HnnYvHHyCqBpZSFTuiNiA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=o8XJvn1v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=103.22.144.67 (ozlabs.org);
    smime=temperror;
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no header.domain=canb.auug.org.au header.result=pass header_org.domain=auug.org.au header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=o8XJvn1v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=103.22.144.67 (ozlabs.org);
    smime=temperror;
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no header.domain=canb.auug.org.au header.result=pass header_org.domain=auug.org.au header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 17:36:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Palmer Dabbelt
 <palmer@sifive.com>
Subject: linux-next: manual merge of the tty tree with the asm-generic tree
Message-ID: <20180315173604.5c858ed8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iGXVQ7fEF9Uy8H_Bob4g059"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/iGXVQ7fEF9Uy8H_Bob4g059
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the tty tree got conflicts in:

  drivers/tty/hvc/Kconfig
  drivers/tty/hvc/Makefile

between commit:

  c235c62f99e6 ("tty: remove bfin_jtag_comm and hvc_bfin_jtag drivers")

from the asm-generic tree and commit:

  afa6b1ccfad5 ("tty: New RISC-V SBI console driver")

from the tty tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/tty/hvc/Kconfig
index 3bade5ad3d71,e7cc617d6e45..000000000000
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@@ -88,6 -88,25 +88,16 @@@ config HVC_DC
  	 driver. This console is used through a JTAG only on ARM. If you don't h=
ave
  	 a JTAG then you probably don't want this option.
 =20
 -config HVC_BFIN_JTAG
 -	bool "Blackfin JTAG console"
 -	depends on BLACKFIN
 -	select HVC_DRIVER
 -	help
 -	 This console uses the Blackfin JTAG to create a console under the
 -	 the HVC driver.  If you don't have JTAG, then you probably don't
 -	 want this option.
 -
+ config HVC_RISCV_SBI
+ 	bool "RISC-V SBI console support"
+ 	depends on RISCV
+ 	select HVC_DRIVER
+ 	help
+ 	  This enables support for console output via RISC-V SBI calls, which
+ 	  is normally used only during boot to output printk.
+=20
+ 	  If you don't know what do to here, say Y.
+=20
  config HVCS
  	tristate "IBM Hypervisor Virtual Console Server support"
  	depends on PPC_PSERIES && HVC_CONSOLE
diff --cc drivers/tty/hvc/Makefile
index 7da1934d34e8,83079ae000ae..000000000000
--- a/drivers/tty/hvc/Makefile
+++ b/drivers/tty/hvc/Makefile
@@@ -9,4 -10,6 +9,5 @@@ obj-$(CONFIG_HVC_IRQ)		+=3D hvc_irq.
  obj-$(CONFIG_HVC_XEN)		+=3D hvc_xen.o
  obj-$(CONFIG_HVC_IUCV)		+=3D hvc_iucv.o
  obj-$(CONFIG_HVC_UDBG)		+=3D hvc_udbg.o
 -obj-$(CONFIG_HVC_BFIN_JTAG)	+=3D hvc_bfin_jtag.o
+ obj-$(CONFIG_HVC_RISCV_SBI)	+=3D hvc_riscv_sbi.o
  obj-$(CONFIG_HVCS)		+=3D hvcs.o

--Sig_/iGXVQ7fEF9Uy8H_Bob4g059
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqqFFQACgkQAVBC80lX
0Gw84Af+JSpHXDpB1HfEw0JrSom98lezyVgJAJf6E9WlOiU8qe/N7SjMhbEFNok0
YQFjhpnmtf6yev+ZYSKoyNi8ccODX4wJ2R/dqHGnyZdfbmGsCsH3m4GsA0OoO9QJ
1SHNJvaB/hQTc6UoMGYYcSwhXMLcHOpJT4GwgmDJ4EQdcSkJcIUEomMMHHIlGXkH
syfu/AcsCFWc7if74PbzpIYsJZUI0eYZk8TtMX7RjWcIDBXcHi3wDhbZWadS5Bg0
RJD7DcXN02DWLQ8WPdvSBevBkUxaNLTcHIUf7cBsyMpDwtzYTzQ7s3a7fd9Fow8n
0KG06HVfNULvQtrV67jsf8lyUTppqg==
=9NgR
-----END PGP SIGNATURE-----

--Sig_/iGXVQ7fEF9Uy8H_Bob4g059--
