Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BC3C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB9A20855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sKt5xSaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB9A20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbeLKDas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 22:30:48 -0500
Received: from ozlabs.org ([203.11.71.1]:41001 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728584AbeLKDar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 22:30:47 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43DQSg4MQKz9s3C;
        Tue, 11 Dec 2018 14:30:43 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544499045;
        bh=hXp7hTeBSZCLNJQnpZgXmBqc0LDtKgeAUWYpyaOpFOs=;
        h=Date:From:To:Cc:Subject:From;
        b=sKt5xSaq76jrBvZg1V3uSGBluaKdCWIs8FMYWi1TWaSGndPBePJVPq7X9oG6oGPk2
         9bESTPsU8+rikUiBO+jP6tEAFOZYnMq7NaMHxYCty7BNpMXFHnE6fx8wgsxMoRxNQm
         kxzMkcNm0U1hdsfPY20gKd2tY/xiqzplc7w+Zb2ulDM0AmBkNGCyocSWc0A6zYouPu
         JQ/vV89gczIwYrAx7RfkNPbicNdun4j5zBbvA7Fan0gjjD3HpEakJnTiseND52U10p
         sonVdg1nD2lp6su4qZas6vrShCjQtk/lGxvO8tdYT4iii/uht40kV67sKinvEzcZ3b
         MhUvcyA8+kwfg==
Date:   Tue, 11 Dec 2018 14:30:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pu Wen <puwen@hygon.cn>, Brian Woods <Brian.Woods@amd.com>,
        Borislav Petkov <bp@suse.de>
Subject: linux-next: manual merge of the tip tree with the hwmon-staging
 tree
Message-ID: <20181211143043.668c45c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YpFLWko5lt5qaw6TbsNjpEl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YpFLWko5lt5qaw6TbsNjpEl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  drivers/hwmon/k10temp.c

between commit:

  c552e29fdd63 ("hwmon: (k10temp) Add Hygon Dhyana support")

from the hwmon-staging tree and commit:

  210ba1201ff9 ("hwmon/k10temp: Add support for AMD family 17h, model 30h C=
PUs")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/hwmon/k10temp.c
index 1eb954daa2c8,9790f1f5eb98..000000000000
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@@ -367,7 -360,7 +360,8 @@@ static const struct pci_device_id k10te
  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 +	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
+ 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
  	{}
  };
  MODULE_DEVICE_TABLE(pci, k10temp_id_table);

--Sig_/YpFLWko5lt5qaw6TbsNjpEl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwPL2MACgkQAVBC80lX
0Gy8xwf7Bwaw5+huoUwidlH59nd21kjdBj9iQuZdH9f8wg0EDrBnrtPb7rDfmhoD
d97TQjTK2xuPW62DDabJl/4uGq5q5e3ioPNIGgvvvsjGWwTDLeVxmlxBoC8AvSJr
yGyZs+ma+QxK/ClVBIiKz6ui7UiHUJR+XSRDyvt07i/f7vLEggSFA8109WTQNlAi
j7mdBuN086xjleEIF5TBZ414cFgI0KcItGZby7eLFda14MD3yvFWOzUVFH/q7nH1
v2GBrOpMYwpTnoG9Trq6pIYN/D7sTR+M9ppkA3xE9PVC50Sg5Zucs3HaP23JUOTc
10k+wE9n0c/M7vpIyvAG13UKdMtzaA==
=2kk1
-----END PGP SIGNATURE-----

--Sig_/YpFLWko5lt5qaw6TbsNjpEl--
