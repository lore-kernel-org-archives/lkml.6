Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6460C46463
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2C52172D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jNmDqqFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2C52172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeHCGcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 02:32:12 -0400
Received: from ozlabs.org ([203.11.71.1]:47705 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbeHCGcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 02:32:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41hZ5z3c2dz9s0R;
        Fri,  3 Aug 2018 14:37:43 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533271064;
        bh=U38eVCYHar5+dzBYf7sgPlAyNKbOUIFgtq74lbKC0TI=;
        h=Date:From:To:Cc:Subject:From;
        b=jNmDqqFPRiJpB3yIDO7Ag4EbhdAwq1HFJ7+pHUiuUV672cyv2+vx4GwT7KnYwU24S
         wJZsEBkaAfqT8POFyXW/LvFiYqoHwGR+961fGzk858XvL60hyXlVKND9qx97aVOuDi
         wxkk+HEP2bWD2LGK3GTIWupKWyiMbMgNllM4zrV81HQqKSceL4Jtuc6k2PR2VHPpRQ
         WB6olEKFP2L1dndnkg4vxiQrAaFgs2TAjUiW1Pp6sDi8XmBcnyT5DJFVdpKn3KmIXG
         OL1YFnXfdbKyAf2sIVZ/9poCWcQLk3RcZ6z51GNG0QJlhVBglReqNwuY8bwpffmrio
         GX5dm5XpS/Owg==
Date:   Fri, 3 Aug 2018 14:37:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: linux-next: build warning after merge of the spi tree
Message-ID: <20180803143743.37978047@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bgZm_X=yja8uZ2YMjbktdsg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bgZm_X=yja8uZ2YMjbktdsg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

After merging the spi tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/spi/spi-mem.c: In function 'spi_mem_probe':
drivers/spi/spi-mem.c:375:13: warning: assignment discards 'const' qualifie=
r from pointer target type [-Wdiscarded-qualifiers]
   mem->name =3D ctlr->mem_ops->get_name(mem);
             ^
drivers/spi/spi-mem.c:377:13: warning: assignment discards 'const' qualifie=
r from pointer target type [-Wdiscarded-qualifiers]
   mem->name =3D dev_name(&spi->dev);
             ^

Introduced by commit

  5d27a9c8ea9e ("spi: spi-mem: Extend the SPI mem interface to set a custom=
 memory name")

"const" is good :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/bgZm_X=yja8uZ2YMjbktdsg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltj3BcACgkQAVBC80lX
0GzvnAgAkNkyIabc6S0z8LmOEsbtfv3V7qM8W/uWwZJ3uglrd478Ohi7p5fFpqRZ
lAwqh1iWP912Ll7J/CFn2uxoFiyyaaTL585jhzk7s+BvR/KXAej2j3hK5FBWp1ep
rpHA1ZhgKeFO2NatP2SlKhbjuSzKEicP7Ez+FFb8HGPoTbtv6kOJKUEELMcp9IPQ
TovnLdq4DfGy7gQzB79jrvh1uHyjHLZEMps2e+SrHzyxWC/KivTitnG2pytBw9mo
PlxE8pHc2YjCSE/VXWE4mkIn25/9rM/ZoxGDGex4c6QGMHdRYB3eJXs57HM+PWfW
pGh3lTtZ3++jMtcRk6TONPD1PKr/rw==
=jq7K
-----END PGP SIGNATURE-----

--Sig_/bgZm_X=yja8uZ2YMjbktdsg--
