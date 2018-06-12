Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 08A46C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3DE2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Lh1Q4FgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3DE2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934208AbeFLAT7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:19:59 -0400
Received: from ozlabs.org ([203.11.71.1]:51323 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934006AbeFLAT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:19:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 414VrX5Z78z9ryk;
        Tue, 12 Jun 2018 10:19:56 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528762796;
        bh=clZu0pAJz3yHa+3GInQnifR/oy4a2ywRAh5X8quyFdA=;
        h=Date:From:To:Cc:Subject:From;
        b=Lh1Q4FgITd4npdZKnFTf3SJsPsGVJEWq3xAR1YJEo3gIcJqgYDkvLz/r/+vncEO/n
         R6dluRV5WK+brukDjsPGfTHxQgjk82/CGAUemT/6R+b6QIBP0Q5hcqmiWtUEzskY2N
         jj7dUcFKViqFyh6JIEwgsEVZY82K8YPLKsG+ERdW05db3eg/L/fqJXYnXWK7IgLbS1
         UUJ7GwdqqG7OmVfbet2/mNTs33mv4GNHKCaT2ElcBVF0ZlMiwxUZOAGuTDl8HQeL8n
         ihh1jK/sPUTTWpzOvXC0gmCpKeeWes1cq8lykBSpPShTCqg3W3g9x6+871ZGNSKbix
         Y0UQOlt5vA/Jw==
Date:   Tue, 12 Jun 2018 10:19:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Samuel Ortiz <sameo@linux.intel.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: linux-next: build warning after merge of the nfc-next tree
Message-ID: <20180612101954.63eb9e60@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//e3dZxhtjRKoFni_fnm7mO+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//e3dZxhtjRKoFni_fnm7mO+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

After merging the nfc-next tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/nfc/fdp/fdp.c: In function 'fdp_nci_open':
drivers/nfc/fdp/fdp.c:250:17: warning: unused variable 'dev' [-Wunused-vari=
able]
  struct device *dev =3D &info->phy->i2c_dev->dev;
                 ^~~
drivers/nfc/fdp/fdp.c: In function 'fdp_nci_close':
drivers/nfc/fdp/fdp.c:260:17: warning: unused variable 'dev' [-Wunused-vari=
able]
  struct device *dev =3D &info->phy->i2c_dev->dev;
                 ^~~
drivers/nfc/fdp/fdp.c: In function 'fdp_nci_send':
drivers/nfc/fdp/fdp.c:268:17: warning: unused variable 'dev' [-Wunused-vari=
able]
  struct device *dev =3D &info->phy->i2c_dev->dev;
                 ^~~
drivers/nfc/fdp/fdp.c: In function 'fdp_nci_recv_frame':
drivers/nfc/fdp/fdp.c:279:17: warning: unused variable 'dev' [-Wunused-vari=
able]
  struct device *dev =3D &info->phy->i2c_dev->dev;
                 ^~~
drivers/nfc/fdp/fdp.c: In function 'fdp_nci_core_reset_ntf_packet':
drivers/nfc/fdp/fdp.c:602:17: warning: unused variable 'dev' [-Wunused-vari=
able]
  struct device *dev =3D &info->phy->i2c_dev->dev;
                 ^~~
drivers/nfc/fdp/fdp.c: In function 'fdp_nci_prop_patch_ntf_packet':
drivers/nfc/fdp/fdp.c:614:17: warning: unused variable 'dev' [-Wunused-vari=
able]
  struct device *dev =3D &info->phy->i2c_dev->dev;
                 ^~~
drivers/nfc/fdp/fdp.c: In function 'fdp_nci_remove':
drivers/nfc/fdp/fdp.c:789:17: warning: unused variable 'dev' [-Wunused-vari=
able]
  struct device *dev =3D &info->phy->i2c_dev->dev;
                 ^~~

Introduced by commit

  7579d009c4a1 ("NFC: fdp: Remove __func__ from dev_dbg()")

--=20
Cheers,
Stephen Rothwell

--Sig_//e3dZxhtjRKoFni_fnm7mO+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsfEaoACgkQAVBC80lX
0GxXzwf/V+PcEUtg5JzbR3IKI9xp0HjSRSb9DgjrKtLVtK0hd6ExUtu5G2LUjyR9
EBvf3zxOdHqMP8s9WU6GYrrf555LIYKbgPdubuZaf7iYuy1y6/7xOHazXR0DRGYA
KZ9FuDTgzGoQXcXHblSdB3DThIDfPZNpFfVVryn3pwTrjsGTZGTnem0Y5kMpohVe
hrf+JB+uP6EKzv1VgvQ9nf5lm20blHJaXbDQFi76M6QmP14v6jqeVkBwd/rpOQeF
w53fzcEHzYJogdH5dP+zXi+lwk14rx2z2lt1xzD+ouI6/8deecxYBanrEmXpd5ON
0gi5mORQN8yh2Yrm8p1Rg4HELQoszg==
=XmbC
-----END PGP SIGNATURE-----

--Sig_//e3dZxhtjRKoFni_fnm7mO+--
