Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D49C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 00:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A983621525
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 00:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="A0PfNZHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A983621525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeHQDkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 23:40:45 -0400
Received: from ozlabs.org ([203.11.71.1]:43149 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbeHQDkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 23:40:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41s48d2gdFz9s3x;
        Fri, 17 Aug 2018 10:39:29 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534466369;
        bh=oh4DfZmdyKWlQkPgCIBN80CUz1ceNIF7qIpqQ+AwjSI=;
        h=Date:From:To:Cc:Subject:From;
        b=A0PfNZHikT7alNkiXz4+9BLn5vrRO0RGp94fUZGvFsM1yne3eWCerqhEhQmWKCfc4
         qtl31Er0zlhNuoBt3aEtWHQik3kKaHRxYQCsm1UVh4CuVX3pj+qErxuBHx3A7N46Np
         aSWnc5N2f/1VAatBVr3oRCnr0PX1JgHXDjOcrPijseTSckhdyPq14UwYy6/09qODa+
         AXL4tjAYzz6EygHMV76qgsiQzdWzJxlhZdb+5nQNsi0QuAzl5MEGHay3QES4RY+BtP
         6xq4EACEsOtkDYi/6gg6XjHfr98vae1ZxAplX+HPHVngBKu0lObtl1T5I7ZrFCiCdu
         s7lnxVHHTdqVg==
Date:   Fri, 17 Aug 2018 10:39:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: linux-next: manual merge of the mfd tree with Linus' tree
Message-ID: <20180817103913.52544928@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/d_C1UIw2solsaophUWt17Kn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d_C1UIw2solsaophUWt17Kn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mfd tree got a conflict in:

  MAINTAINERS

between commit:

  16b7db4c8150 ("MAINTAINERS: Add .clang-format entry")

from Linus' tree and commit:

  97c2b5cba204 ("mfd: madera: Add register definitions for Cirrus Logic Mad=
era codecs")

from the mfd tree.

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
index 041b111596bc,2c1c6aef7d74..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -3557,11 -3513,23 +3557,27 @@@ M:	Christian Benvenuti <benve@cisco.com
  S:	Supported
  F:	drivers/infiniband/hw/usnic/
 =20
 +CLANG-FORMAT FILE
 +M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
 +S:	Maintained
 +F:	.clang-format
 +
+ CIRRUS LOGIC MADERA CODEC DRIVERS
+ M:	Charles Keepax <ckeepax@opensource.cirrus.com>
+ M:	Richard Fitzgerald <rf@opensource.cirrus.com>
+ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+ L:	patches@opensource.cirrus.com
+ T:	git https://github.com/CirrusLogic/linux-drivers.git
+ W:	https://github.com/CirrusLogic/linux-drivers/wiki
+ S:	Supported
+ F:	Documentation/devicetree/bindings/mfd/madera.txt
+ F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
+ F:	include/linux/mfd/madera/*
+ F:	drivers/gpio/gpio-madera*
+ F:	drivers/mfd/madera*
+ F:	drivers/mfd/cs47l*
+ F:	drivers/pinctrl/cirrus/*
+=20
  CLEANCACHE API
  M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
  L:	linux-kernel@vger.kernel.org

--Sig_/d_C1UIw2solsaophUWt17Kn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt2GTEACgkQAVBC80lX
0Gzf1Af9GVIqDQSFd6Qj1Rw0m5tD2uYRas0vxRSJeYrVBWk5B7ywkI2OZEr1VOIK
IkFwEzRx7lfR9Gd/sDmq8xLlgt+7F6lgwNYDJxMJkHuw14mvncNkfhE/lpZuXlSZ
jx2Ecf3Lr7czTLZGZUpMZUZ4/08Eh4KHFelvVjYUaI/giUyCBG/NTu3unsVvClcJ
mEe39Bq01C/ra560g1BbD5xuzvmwv7wZebtEhUs8CbWgva0d1/PNRnloF+EQ/Sly
lsbqlkoscwjBm11HHvzjhPpW5S6WwdqurBu90UcQ3VbVDClDVAZ6EQuwpkq5F0+n
DYv54jLqrYv5oWhzbCO9VbGxon1nLw==
=rug9
-----END PGP SIGNATURE-----

--Sig_/d_C1UIw2solsaophUWt17Kn--
