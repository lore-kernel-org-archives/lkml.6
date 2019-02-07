Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A39C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 02:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490382175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 02:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="N5ywQxjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfBGCri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 21:47:38 -0500
Received: from ozlabs.org ([203.11.71.1]:40097 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfBGCri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 21:47:38 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43w2m62rsyz9s7h;
        Thu,  7 Feb 2019 13:47:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549507654;
        bh=sW4JP+fhcFZ8Tnqr7Yzub2Hf7YYEjT0vY9TCEpYX7o4=;
        h=Date:From:To:Cc:Subject:From;
        b=N5ywQxjOpgcO4nwEF/gpFnuq7pmCgWwhPAUf4Ez3HYUi0N9JeZK8TNYUayE577pek
         1dQyyaMAm14e6aB/q1dB9tnUBACshLijfCIMtom8vZgeX/GCmJcLX7nURyYFTi/CEA
         yeY8TZZ7qGuTBmmC47rUd9fEkNPgnUE/mIqYDOz8GB+/Oq3FVY7LNTpZVoJnBlT2gj
         jpy8PRTzNvS6JdEbZvkUddM8ER3yTrkeupvndxqmybjV9bFnJufwlEAiWMDaJUnKVp
         ygGVjeZCbmCaDOedwGwW77XUzKzUNUywojdP3zZcoBkMlwr0NHNmCmpQNcOvUi3eby
         cVmYI3Zv5O3cQ==
Date:   Thu, 7 Feb 2019 13:47:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: linux-next: build warning after merge of the tpmdd tree
Message-ID: <20190207134733.05a8e55a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=d=+R=oonV4=cYeZD9ZjYxr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=d=+R=oonV4=cYeZD9ZjYxr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

After merging the tpmdd tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/char/tpm/tpm_i2c_nuvoton.c:45: warning: "TPM_RETRY" redefined
 #define TPM_RETRY      5
=20
In file included from drivers/char/tpm/tpm_i2c_nuvoton.c:35:
drivers/char/tpm/tpm.h:43: note: this is the location of the previous defin=
ition
 #define TPM_RETRY  50
=20
drivers/char/tpm/tpm_i2c_infineon.c:30: warning: "TPM_BUFSIZE" redefined
 #define TPM_BUFSIZE 1260
=20
In file included from drivers/char/tpm/tpm_i2c_infineon.c:27:
drivers/char/tpm/tpm.h:41: note: this is the location of the previous defin=
ition
 #define TPM_BUFSIZE  4096
=20
In file included from drivers/char/tpm/st33zp24/i2c.c:30:
drivers/char/tpm/st33zp24/st33zp24.h:22: warning: "TPM_BUFSIZE" redefined
 #define TPM_BUFSIZE                     2048
=20
In file included from drivers/char/tpm/st33zp24/i2c.c:29:
drivers/char/tpm/st33zp24/../tpm.h:41: note: this is the location of the pr=
evious definition
 #define TPM_BUFSIZE  4096
=20
In file included from drivers/char/tpm/st33zp24/spi.c:30:
drivers/char/tpm/st33zp24/st33zp24.h:22: warning: "TPM_BUFSIZE" redefined
 #define TPM_BUFSIZE                     2048
=20
In file included from drivers/char/tpm/st33zp24/spi.c:29:
drivers/char/tpm/st33zp24/../tpm.h:41: note: this is the location of the pr=
evious definition
 #define TPM_BUFSIZE  4096
=20
In file included from drivers/char/tpm/st33zp24/st33zp24.c:34:
drivers/char/tpm/st33zp24/st33zp24.h:22: warning: "TPM_BUFSIZE" redefined
 #define TPM_BUFSIZE                     2048
=20
In file included from drivers/char/tpm/st33zp24/st33zp24.c:33:
drivers/char/tpm/st33zp24/../tpm.h:41: note: this is the location of the pr=
evious definition
 #define TPM_BUFSIZE  4096
=20
In file included from drivers/char/tpm/st33zp24/st33zp24.c:34:
drivers/char/tpm/st33zp24/st33zp24.h:22: warning: "TPM_BUFSIZE" redefined
 #define TPM_BUFSIZE                     2048
=20
In file included from drivers/char/tpm/st33zp24/st33zp24.c:33:
drivers/char/tpm/st33zp24/../tpm.h:41: note: this is the location of the pr=
evious definition
 #define TPM_BUFSIZE  4096
=20

Introduced by commit

  569c1057f9ac ("tpm: move tpm_chip definition to include/linux/tpm.h")

--=20
Cheers,
Stephen Rothwell

--Sig_/=d=+R=oonV4=cYeZD9ZjYxr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxbnEUACgkQAVBC80lX
0Gw2Owf9HH8whEe0KGtfzMrkqlrYsRUgJ1suOxLPHzD4RA42Y7itmZz0aKiNrTp2
heNMNsEDQYTyGbO6Vgc5XNJgtV2eciv6CXMY6YdnM2TgrgwVXQNqXG5Httj2SqxB
aO1G/grEAnNSXlZPDYJUwwLfYuiIqUePeCWN3gG3qo6B3nqTSwF7l4JNtIr/XAZ2
QxDn43dbdG+hl0onQIVXHwMeFi9ApUTYU8WRfmRI4Pg+WrU/67ckjg5WRlrLrWOK
aVXOaNtjpz6XuDdafaRZHNtGLnOFjllDmoscUDLGrCvkPY28OvhoJBEpsMIMBllw
wYWv+IjwzObHE8aw3iFGml3QrTq6Xw==
=7kGl
-----END PGP SIGNATURE-----

--Sig_/=d=+R=oonV4=cYeZD9ZjYxr--
