Return-Path: <sfr@canb.auug.org.au>
X-Cyrus-Session-Id: sloti22d1t05-3794104-1521096244-5-11743095287230870858
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
    t=1521096243; b=PIU7oHX8+LPdA2u0cRa4L7vEE+leDh+KREHLcklbX6HA3jm
    ccGc6r7f/udXVmYtl021wMO/JnRfy4FZ+hMC/zasdlBJE2j/2kCJMBKEtIB3VVXU
    nO3bbsgEPSbZsoxMDZvf5O/NM9e0cCK/310Z3mp3BblquVJmsLG6J6/U9HLM9CU/
    cbuKRyWcszX/oSsrCOZ9+awMvq3kJex3WNhdVUA7BBCrzlVwwhiGjA210ZiRH+BD
    9oC3AME+xIFTsmKfPq9ptisaflwYzaDNcVBylgxt/OqYq6hTrNfgyDXD4pHrw97W
    haws8t3SuyqN4W1Io2U1BGv0t1k2PoBLWLAt3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type; s=arctest; t=1521096243; bh=HyDpZxFY
    I4tfNQIAq7vp7+6K1svCeinMao21UL7bI9k=; b=S6pwZKY+NdEQaMULe3TL4L8Y
    z0A7wXQT0rpnTsYcK9XZS8UvHxnniw842FnKngVua5T1m0xxeRmyQL2H+KWHOeM7
    9PsGwGz1pRJBYrDZxrBold+rshCoDUp28WeC9yMpaahKnNk+p+k6K6PRHSCsTYXX
    bBhZzO8pLvAJ174r46Ac5sUeOSNaLCa9oSWYkJgg9Q8ES3AM15GI3iFzhFUrK05A
    mVJNgtf6Cq0Hh+V3dM+J3disFhftUq6Fqf79d0VYO4m1mCluiVxGH1r3ciVJtElK
    eeH1zXL1QzZX2bEDd3/14VXIcaIe0WNidb1kNMw8mVf46qZJ/mdmSphKLyUmLw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=DLVntZJb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=103.22.144.67 (ozlabs.org);
    smime=temperror;
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no header.domain=canb.auug.org.au header.result=pass header_org.domain=auug.org.au header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=DLVntZJb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
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
Date: Thu, 15 Mar 2018 17:43:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Bich HEMON <bich.hemon@st.com>
Subject: linux-next: build warnings after merge of the tty tree
Message-ID: <20180315174331.6c7b600b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ackI8q0np7VJh5Tz=d1M9Fd"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/ackI8q0np7VJh5Tz=d1M9Fd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

After merging the tty tree, today's linux-next build (arm
multi_v7_defconfig) produced these warnings:

drivers/tty/serial/stm32-usart.c:155:12: warning: 'stm32_init_rs485' define=
d but not used [-Wunused-function]
 static int stm32_init_rs485(struct uart_port *port,
            ^~~~~~~~~~~~~~~~
drivers/tty/serial/stm32-usart.c:100:12: warning: 'stm32_config_rs485' defi=
ned but not used [-Wunused-function]
 static int stm32_config_rs485(struct uart_port *port,
            ^~~~~~~~~~~~~~~~~~

Introduced by commit

  1bcda09d2910 ("serial: stm32: add support for RS485 hardware control mode=
")

--=20
Cheers,
Stephen Rothwell

--Sig_/ackI8q0np7VJh5Tz=d1M9Fd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqqFhMACgkQAVBC80lX
0Gy5GQf+N67+p6m6motxVAYn91y0eWQ3EIr6wcl6n+k2/4arhfqBOILx0/culEBV
J9dHeuhd3YWe4g745vssGANmBSHuaYlhuyAd9XtyOIEE7nv9vOnvX880+IZOJAye
VaEUmisNAjr58DwdDBW6+OOrJbGaEwZ4C6SF4z9d9XrJX5qms74QmI8DgPKMJSHJ
NB4ywHpZ9MmU0jc5YH2/l1bHbBvQ7fMgJX+dT2FVmbSScnXLUvevXHiRyaC8oG10
HsenwdL6p54325YwwAXm7Y5RcHZoEPxMxaqAKuo3xTB/B76baVMn68+GxrJ6p88c
yJpBmIryzOgNLHE7OeeQmfly4tVwqw==
=4ShK
-----END PGP SIGNATURE-----

--Sig_/ackI8q0np7VJh5Tz=d1M9Fd--
