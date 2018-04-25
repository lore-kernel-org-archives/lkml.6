Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753840AbeDYWmO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 18:42:14 -0400
Received: from ozlabs.org ([203.11.71.1]:42859 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753808AbeDYWmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 18:42:11 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 26 Apr 2018 08:40:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andy Gross <agross@codeaurora.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Evan Green <evgreen@chromium.org>
Subject: linux-next: build failure after merge of the qcom tree
Message-ID: <20180426084041.5cf81918@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bMFW/RqPBvphZ+mxtjv19IA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bMFW/RqPBvphZ+mxtjv19IA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andy,

After merging the qcom tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: "geni_se_select_mode" [drivers/tty/serial/qcom_geni_serial.ko] undef=
ined!
ERROR: "geni_se_init" [drivers/tty/serial/qcom_geni_serial.ko] undefined!
ERROR: "geni_se_config_packing" [drivers/tty/serial/qcom_geni_serial.ko] un=
defined!
ERROR: "geni_se_resources_off" [drivers/tty/serial/qcom_geni_serial.ko] und=
efined!
ERROR: "geni_se_resources_on" [drivers/tty/serial/qcom_geni_serial.ko] unde=
fined!

Probably caused by commit

  eddac5af0654 ("soc: qcom: Add GENI based QUP Wrapper driver")

I have used the qcom tree from next-20180424 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/bMFW/RqPBvphZ+mxtjv19IA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrhA+kACgkQAVBC80lX
0GwMBAf9HwEPcZeJqpEqQ+LbsNl9X1ZzLlrog43+FrMaXXp7VlOSdgecXgCcFQRn
vVE9Xm4Kslb3COrH6qYXt/XIUYNelFLj7ZlMo5dDniKCBJ1+TEtV+H8RDGcnrwbk
LlEic7CR5NODqcJdw9lg1Qaai/j8PyE54l1DjoZEkDSMMyHa6Kq7xcrT1D8s/EAe
xjc0Y47PGfwsLwMrvjCcTMhK0ndgzSkcPoucWrzal0oKpCyIBWeosh2KtT3s/I46
4YXrIk6RELF3mysYFg3zwpyThxiDKj0/cEUKinkT7hu8Qs8cUZkqAzV/Mm72Cvah
EFZ4qyop80Vjd/PGoJdJJWIQN3MjpA==
=Oa+f
-----END PGP SIGNATURE-----

--Sig_/bMFW/RqPBvphZ+mxtjv19IA--
