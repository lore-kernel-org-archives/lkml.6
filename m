Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278F4C6787E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20F720841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BUgLBnSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20F720841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeJHJmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 05:42:24 -0400
Received: from ozlabs.org ([203.11.71.1]:53097 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725760AbeJHJmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 05:42:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42T4CY2nFYz9sCV;
        Mon,  8 Oct 2018 13:32:57 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538965980;
        bh=cdIJHGn6Of3Qhg/GxAQlm/slj7e2I3ToXKF3I8DEViI=;
        h=Date:From:To:Cc:Subject:From;
        b=BUgLBnSQRb6QvgxiSGDusRnwKtBoaYslwVchUzKwar0mx3bxsc+8sZFIYHlXkJ9vV
         aAv/3mvkfKEaaKTkjS8H0u3AIwHXC1rjXQ0ab5Hp0VBDyDeByJbWfBxMBm7PCuRlfN
         qtriCw+6xIp9hny1966JUAcYdL+KqaxUyb8o2JIo5Sm1WXLQc0qCMzeB4zGUvYa9av
         Hrh3e4qmMTHlKw/lQI3eApmxoNUnyox+pzcD7h9SiHeVg8AMx1nwS0gDceN5K9Hm+/
         od2LF3aYdiwwnPSZC7us1RwlBebvWxid06laRcMaM3mUVs6LGA1Rip3r9RVI15UAxk
         WuNvQHP9lF8xg==
Date:   Mon, 8 Oct 2018 13:32:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: linux-next: manual merge of the tip tree with the arm-soc tree
Message-ID: <20181008133158.773196b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6q+9B+4RD=TZw/i2wtQxStc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6q+9B+4RD=TZw/i2wtQxStc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  MAINTAINERS

between commits:

  81aa283c6924 ("MAINTAINERS: Add Actions Semi S900 clk entries")
  677309b0e9e6 ("MAINTAINERS: Add entry for Actions Semi Owl SoCs DMA drive=
r")

from the arm-soc tree and commit:

  9d8d47ea6ec6 ("clocksource/drivers: Unify the names to timer-* format")

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

diff --cc MAINTAINERS
index c4d323faa764,2a83f2339651..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -1218,10 -1180,7 +1218,10 @@@ N:	ow
  F:	arch/arm/mach-actions/
  F:	arch/arm/boot/dts/owl-*
  F:	arch/arm64/boot/dts/actions/
 +F:	drivers/clk/actions/
- F:	drivers/clocksource/owl-*
+ F:	drivers/clocksource/timer-owl*
 +F:	drivers/dma/owl-dma.c
 +F:	drivers/i2c/busses/i2c-owl.c
  F:	drivers/pinctrl/actions/*
  F:	drivers/soc/actions/
  F:	include/dt-bindings/power/owl-*

--Sig_/6q+9B+4RD=TZw/i2wtQxStc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu6wcgACgkQAVBC80lX
0GxOpQf9GVWhh0CmrwycKME/puq63HPTgPFkgtBmFvyWjqp9spd/zQOvgQbmAsbG
E509N9jyIlZ1+sECVkqsvbWysuZeFPVALJssKbJheMP9kb3u2sW3NT16ZWZOFCYM
d+rn1+Ge4jkXmXM3/0qsL9QFpwyw/m3DJmAfGMR1nRB2VozfzYB3Bvpdwu2lqP0H
IopVjrpqOiX52C+7tg0DQPh0QrBosALnz6j19F/4JJ65N23Qx74Vtku6PnM67iWC
/aB7/qlAuAFAghMTCl07Zzz/xmc0z+ixRaJ5ixAQxibYizp+lXDD2gvm1UpddHTY
Xi51yhOfS8Zal+Xm9zasLzwGVM0LHA==
=hlwN
-----END PGP SIGNATURE-----

--Sig_/6q+9B+4RD=TZw/i2wtQxStc--
