Return-Path: <sfr@canb.auug.org.au>
X-Cyrus-Session-Id: sloti22d1t05-3759944-1521095373-5-2667538600027696038
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
    t=1521095372; b=sN+R/gbnVpmnfMb9Vd1irRR71OK0EdmiRiCJU6D+36ZkBd7
    ZLcMIkMRJHx7hsVAoGFS4RCXCD9tKcUvW9IUv1/rdTqmzY9zOGw9kuawt77e61Di
    IjjnR4HOT4SYkbEq7naZXuGgF+llavSt759HAsrS9ZzdsxtC+tIzKQUUbetVzeJI
    fNKQkcVOZKfh643BqNriY3V9bqJ428InrjeAM5G/IMbz5kyZeEE5lKkuwM1AG24N
    quYJbdTsTiQiWqrWoWUe5rOyjQRe8esa/dukVrm4rnnitRpK8zFsCWCOxlspL9i4
    JG0yiR5HGgdiinhOLzlsXBDY9SwBWewxjdH7DWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type; s=arctest; t=1521095372; bh=O/zZisdQ
    QV4Rd1JCLwtFXY6v022Rr9IAYXGKYWmN5MI=; b=m9JXkq+v/2jjLukBty0W88L+
    joA1IqsgIHaggW2LiByHKvLgyRR+qU5sNFHIto6+JJbb2zk6ipm66wTRPiydHhER
    +2HaIhaGPbi9d4liGw4Yo2qxJExrN/775dMk2M5TCL7v9Dm78SNU98Oe8RQVknBI
    rdGyvT+CO4g5DKBxUNLir6zZJzV5OC+TtwrAt+kfw3+PvY5QMT++GdYo9KjTcLw1
    fK5FEwL9iwBvaak30vTHT7hODDgfP24wG/qXiP1MgRUzxmAEUu5cjS6Oz7476pOJ
    VJeSXfbv4Ye8T7qfvKXNaOMUvyGweeDe+z/M7yYH7WZFPue90gPjU0ALXQDgKQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=fkEyi/qp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
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
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=fkEyi/qp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
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
Date: Thu, 15 Mar 2018 17:28:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann
 <arnd@arndb.de>, ARM <linux-arm-kernel@lists.infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Patrice Chotard
 <patrice.chotard@st.com>, Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the tty tree with the arm-soc tree
Message-ID: <20180315172858.7928ed93@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4ha+r0qvfPKGPW1D4+qMNM."; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/4ha+r0qvfPKGPW1D4+qMNM.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the tty tree got conflicts in:

  arch/arm/boot/dts/stih407-b2120.dts
  arch/arm/boot/dts/stih410-b2120.dts
  arch/arm/boot/dts/stih410-b2260.dts
  arch/arm/boot/dts/stih418-b2199.dts

between commit:

  db5430663017 ("arm: dts: replace 'linux,stdout-path' with 'stdout-path'")

from the arm-soc tree and commit:

  dbb3fb45edff ("ARM: dts: STi: Remove "console=3DttyASN" from bootargs for=
 STi boards")

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

diff --cc arch/arm/boot/dts/stih407-b2120.dts
index de3c8bf129b5,a7a0f76e9cbc..000000000000
--- a/arch/arm/boot/dts/stih407-b2120.dts
+++ b/arch/arm/boot/dts/stih407-b2120.dts
@@@ -14,11 -14,11 +14,11 @@@
  	compatible =3D "st,stih407-b2120", "st,stih407";
 =20
  	chosen {
- 		bootargs =3D "console=3DttyAS0,115200 clk_ignore_unused";
+ 		bootargs =3D "clk_ignore_unused";
 -		linux,stdout-path =3D &sbc_serial0;
 +		stdout-path =3D &sbc_serial0;
  	};
 =20
 -	memory {
 +	memory@40000000 {
  		device_type =3D "memory";
  		reg =3D <0x40000000 0x80000000>;
  	};
diff --cc arch/arm/boot/dts/stih410-b2120.dts
index 0a59b7b0f4b2,6c6b4cc37e97..000000000000
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@@ -14,11 -14,11 +14,11 @@@
  	compatible =3D "st,stih410-b2120", "st,stih410";
 =20
  	chosen {
- 		bootargs =3D "console=3DttyAS0,115200 clk_ignore_unused";
+ 		bootargs =3D "clk_ignore_unused";
 -		linux,stdout-path =3D &sbc_serial0;
 +		stdout-path =3D &sbc_serial0;
  	};
 =20
 -	memory {
 +	memory@40000000 {
  		device_type =3D "memory";
  		reg =3D <0x40000000 0x80000000>;
  	};
diff --cc arch/arm/boot/dts/stih410-b2260.dts
index feb8834478fa,50d36758391c..000000000000
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@@ -15,11 -15,11 +15,11 @@@
  	compatible =3D "st,stih410-b2260", "st,stih410";
 =20
  	chosen {
- 		bootargs =3D "console=3DttyAS1,115200 clk_ignore_unused";
+ 		bootargs =3D "clk_ignore_unused";
 -		linux,stdout-path =3D &uart1;
 +		stdout-path =3D &uart1;
  	};
 =20
 -	memory {
 +	memory@40000000 {
  		device_type =3D "memory";
  		reg =3D <0x40000000 0x40000000>;
  	};
diff --cc arch/arm/boot/dts/stih418-b2199.dts
index 39b4db2e3507,7f5f3252bfc7..000000000000
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@@ -14,11 -14,11 +14,11 @@@
  	compatible =3D "st,stih418-b2199", "st,stih418";
 =20
  	chosen {
- 		bootargs =3D "console=3DttyAS0,115200 clk_ignore_unused";
+ 		bootargs =3D "clk_ignore_unused";
 -		linux,stdout-path =3D &sbc_serial0;
 +		stdout-path =3D &sbc_serial0;
  	};
 =20
 -	memory {
 +	memory@40000000 {
  		device_type =3D "memory";
  		reg =3D <0x40000000 0xc0000000>;
  	};

--Sig_/4ha+r0qvfPKGPW1D4+qMNM.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqqEqoACgkQAVBC80lX
0GzXvwf/T1hgz4WxTULRxPjm33O5iSXCnTGteV5a2YWbJy4xlzcB+6FOhyKYz0r2
ibpc+lETcxYrS2oOXHSYQxo/jXY1hME7L1BQ/GKlCLWNkrEqslKNnKY1iI9YfPvc
3Mm4T9qNFKq1blv7fdnKZkLELRCII60ehZEAy0BpHGMmkb3VeG3bGQj0Uu4SwKZK
u66r7+XH804AwVwGJR/Zr/mfyaVD5jERLSsEKL7B74CfJ8xRDNWXBva7gh9roQAS
bkXQGM0+lsrLF63Yx8KbOLR4YKKXf20sGer61/pMjzTAkE+CvgkamL79YCmYmviz
Xtgx4T571eAD7TLW65PIXS83YLhixw==
=SQkC
-----END PGP SIGNATURE-----

--Sig_/4ha+r0qvfPKGPW1D4+qMNM.--
