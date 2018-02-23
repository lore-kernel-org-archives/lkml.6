Return-Path: <sfr@canb.auug.org.au>
X-Cyrus-Session-Id: sloti22d1t05-1666428-1519352925-5-16654015844605123561
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
    t=1519352924; b=cuVRq1DjqF+d1CT9sjsVHbUR86xkWpVClYzE7DmZpVcaHUw
    s1wwgRf2ym36ka985iJuaSWYjnIUDw/Rby/j0GGa2TLrEFm80gwzsuY0U2YSiTPO
    SX8ptg/bZUT/I1xWENX+lkfJa7x6tAYPx6Ndt59TvHb753GmapFoS9UEasQlixhD
    hy4HINr7lAOWLcCRfYmdQ3zuboXaBv0NYbKGnCX+FsSEzZ+IJv+In5xgLZOD5mEd
    vM8wtmGTPpreGjsolwzpO54vNzePy3mGkUI6+mIDMY5X6C/yLFTdHbgVoOnbvmJl
    JChVenn2IOL9GRdNYcmS35YNTnB3dJvSpj+3J+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type; s=arctest; t=1519352924; bh=l1tXAfXE
    AwmR1XktY6MtKiOK/YIVEJf3d5ZE+30L+9k=; b=MdrEmtWuhQiG3WSBBXxfMwxV
    +XaGq2IhYXU5I9VGrPRt/5ky1+4KcjAS1ZX+qCwErSx2fCifdbiySG9Ns2F2buM5
    MgyNfbyMOGXl8wtnp4O5fu4zGbZwN9CEzyvkhvajI++A5yyPXiDfpoAvO9MZHlau
    COsgRbHlmvqv1mk4olSY4VMrq1zCOckknuk8iR/eRBWID2WUvl4WV9ztpUPul/M+
    woADDhNsya3vAFQA4fPZ2ivyugwwThygh0Adlol0Zr6Yr+Ef3/XNArE0raYsvblA
    zVpwWeEreZkp+UFzhuiTZOTl3PB1LsN7B44aT0TcY62rwlFxrPTuEKR/hKqluA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=p6R3Bf0t x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=103.22.144.67 (ozlabs.org);
    smime=temperror;
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no header.domain=canb.auug.org.au header.result=pass header_org.domain=auug.org.au header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=p6R3Bf0t x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=103.22.144.67 (ozlabs.org);
    smime=temperror;
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no header.domain=canb.auug.org.au header.result=pass header_org.domain=auug.org.au header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Date: Fri, 23 Feb 2018 13:28:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Bogdan Purcareata <bogdan.purcareata@nxp.com>
Subject: linux-next: manual merge of the staging tree with Linus' tree
Message-ID: <20180223132836.6c7afdff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2b_kVVH=C=ShM0jIsYtf7t9"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/2b_kVVH=C=ShM0jIsYtf7t9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/fsl-mc/bus/Kconfig

between commit:

  02b7b2844c2f ("staging: fsl-mc: fix build testing on x86")

from Linus' tree and commit:

  6bd067c48efe ("staging: fsl-mc: Move core bus out of staging")

from the staging tree.

I fixed it up (I used the latter version of that file and applied the
followinf merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 23 Feb 2018 13:25:34 +1100
Subject: [PATCH] staging: fsl-mc: merge fix for CONFIG_FSL_MC_BUS moving

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/bus/fsl-mc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/Kconfig b/drivers/bus/fsl-mc/Kconfig
index bcca64486fd3..c23c77c9b705 100644
--- a/drivers/bus/fsl-mc/Kconfig
+++ b/drivers/bus/fsl-mc/Kconfig
@@ -7,7 +7,7 @@
=20
 config FSL_MC_BUS
 	bool "QorIQ DPAA2 fsl-mc bus driver"
-	depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X8=
6 || PPC)))
+	depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X8=
6_LOCAL_APIC || PPC)))
 	select GENERIC_MSI_IRQ_DOMAIN
 	help
 	  Driver to enable the bus infrastructure for the QorIQ DPAA2
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/2b_kVVH=C=ShM0jIsYtf7t9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqPfFQACgkQAVBC80lX
0Gwougf/dEdwi/0QEATCox0OtG11Us93yz+Rl0rn+Hik8+9boISwyFFaL1Gl74zF
8MyxYzsE4lmgErzYhAai6c8R7uzXeUiFr+Tq82huPuCKiFRU/VelFzplNkE6uenW
i2RZtgvE2GZKAKlU1b6aeneDrko1SBssJlwqQkHgzbiazVOKvwtwwwnqHpI9TmGN
NwNJEG3dAp2MwgeahUXoQhKLyVJVnv2Lgck35noiaaCUq1cw5eVm9lP64CmL1qIc
E/4tCMOOcxsMUtRRjKPuWyPCLgbGuETwrdi4Iy4lO9Rq/x7kW+uG6HS5PAVCB/U9
B52wZnCmizdLR7cvjsjOhMx2zdf2+A==
=Q91X
-----END PGP SIGNATURE-----

--Sig_/2b_kVVH=C=ShM0jIsYtf7t9--
