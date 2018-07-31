Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA98C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6702D208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DEGLUv6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6702D208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbeGaG6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 02:58:35 -0400
Received: from ozlabs.org ([203.11.71.1]:52445 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbeGaG6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 02:58:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41flBG0h0mz9s3N;
        Tue, 31 Jul 2018 15:20:05 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533014407;
        bh=8ajvBxGrzjK8L4xjgRL/YfyE3xUWpAAu9czmgR/ThYs=;
        h=Date:From:To:Cc:Subject:From;
        b=DEGLUv6Z/AbqHD+Odk5vIH2xICzIAlI2LqOBFhZ60f+tn2V/MsheFMmbj/dETDFF+
         6/RQ6eaSy3vwWFMluJ+LqRZwqfhBWNtN/WmsNCkXdvzbWeowGx8pYTH/LYPhwkBgg0
         7QnCIeJgnV8q6NKguMipNHsUMFsDR0xqBkM3bZOXepdajzhg3pUUcGBwhipUb++h/K
         WSU5cyKOK4Dkc+XVFQY67IUpb9sNO/s5qht5fjPY6hIaATtqAaWI4qdL2ymEX8fgDc
         TVAws/onFx9MRfhmSXHYV/SdSaimmXIlNQ78nklfLKqnU5KAfqIiL6Xt5jflqb61DX
         DxQMIy6tk1wCg==
Date:   Tue, 31 Jul 2018 15:20:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Peter Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        Stefan Popa <stefan.popa@analog.com>
Subject: linux-next: manual merge of the mux tree with the battery tree
Message-ID: <20180731152004.7a5a4c54@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XkWjOn12ORf2gl=uLwowV4O"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XkWjOn12ORf2gl=uLwowV4O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mux tree got a conflict in:

  MAINTAINERS

between commit:

  fe8e81b7e899 ("adp5061: New driver for ADP5061 I2C battery charger")

from the battery tree and commit:

  703160ff3e50 ("dt-bindings: mux: add adi,adgs1408")

from the mux tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index db24b8939ed4,eaa2b55a0e9b..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -829,13 -810,12 +829,19 @@@ L:	linux-media@vger.kernel.or
  S:	Maintained
  F:	drivers/media/i2c/ad9389b*
 =20
+ ANALOG DEVICES INC ADGS1408 DRIVER
+ M:	Mircea Caprioru <mircea.caprioru@analog.com>
+ S:	Supported
+ F:	drivers/mux/adgs1408.c
+ F:	Documentation/devicetree/bindings/mux/adgs1408.txt
+=20
 +ANALOG DEVICES INC ADP5061 DRIVER
 +M:	Stefan Popa <stefan.popa@analog.com>
 +L:	linux-pm@vger.kernel.org
 +W:	http://ez.analog.com/community/linux-device-drivers
 +S:	Supported
 +F:	drivers/power/supply/adp5061.c
 +
  ANALOG DEVICES INC ADV7180 DRIVER
  M:	Lars-Peter Clausen <lars@metafoo.de>
  L:	linux-media@vger.kernel.org

--Sig_/XkWjOn12ORf2gl=uLwowV4O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltf8YQACgkQAVBC80lX
0GwzHwf/XlO57ooBPlEwN+mUSM0f6hO8gQgIuwHTCg5GQcHqOKSEGQetSYNAzFx6
anXChgsDPEfZezcZZyPefeWqm/E7QHxGmfRCocf3JSGcfGx+j/9BHV0Bys2lyT/I
3KPvge+hU9pqtaAdq8SuN0M7WD62IFFpRC3yjh/4KA6RZePxhdCoVHuU1IEycuVU
BPpk1mOgF1afBg+iUJMEyKaYYQ9wu4+cofujRllZD/M5CfPFDNlneyklSqj33eAr
UrmqyoMmnQtLixatZ4FFbqGfF671p1S9NqXICQQBR1pg9oJc6Xc1UPBIm1t/Av+3
uK4yxRl3DRoNB84N9F+gUMfREpcGTg==
=VY3a
-----END PGP SIGNATURE-----

--Sig_/XkWjOn12ORf2gl=uLwowV4O--
