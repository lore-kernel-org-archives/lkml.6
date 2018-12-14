Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED21C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF55E2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FxX823Of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF55E2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeLNDoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 22:44:11 -0500
Received: from ozlabs.org ([203.11.71.1]:58693 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbeLNDoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 22:44:11 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43GGcl4MfQz9s3q;
        Fri, 14 Dec 2018 14:44:06 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544759048;
        bh=7twsiVnLTuTTxVYKA4dLC5jPwzJPQ0p1KlT+teZq+7U=;
        h=Date:From:To:Cc:Subject:From;
        b=FxX823OfKPAHYkfPUzQHm1vSjjjOkSQR/VcttnR2rsdwpLA/MEF/J1EfMvwlLZvlZ
         g9uev2YiNc/oW2E1OiMGXY0Trr4AUAM+buThWiF3yK8/eArMS9pzfQBuEmDkIsxclb
         syxyPZ0jbN2nESiZzloGGuqB98aKsQ6L3PC0DQwjgxYbrdo97QcOqtcGcrgBNnajNN
         Po7CiIh1DJEGlyTFkhEV3XHJQUEXuLMYCqa1HBcNXCu75lp8Fghe7xbZzhGj+tlqXH
         PnNlZIIdXHAgBsQCTqeeDy3oRJMAlbChGoTquAVpZy6+RcKOs8BEO11KSx6uM+CvEU
         3WnQ9GVMFJacA==
Date:   Fri, 14 Dec 2018 14:44:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: linux-next: build warning after merge of the irqchip tree
Message-ID: <20181214144406.0dbffbc8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QkpWb.PN52T/CNFEaINp=o="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QkpWb.PN52T/CNFEaINp=o=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the irqchip tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

In file included from include/linux/io.h:25,
                 from include/linux/of_address.h:7,
                 from drivers/irqchip/irq-imx-gpcv2.c:9:
drivers/irqchip/irq-imx-gpcv2.c: In function 'imx_gpcv2_irqchip_init':
arch/arm/include/asm/io.h:96:22: warning: this statement may fall through [=
-Wimplicit-fallthrough=3D]
 #define __raw_writel __raw_writel
                      ^
arch/arm/include/asm/io.h:305:29: note: in expansion of macro '__raw_writel'
 #define writel_relaxed(v,c) __raw_writel((__force u32) cpu_to_le32(v),c)
                             ^~~~~~~~~~~~
drivers/irqchip/irq-imx-gpcv2.c:263:4: note: in expansion of macro 'writel_=
relaxed'
    writel_relaxed(~0, reg + GPC_IMR1_CORE3);
    ^~~~~~~~~~~~~~
drivers/irqchip/irq-imx-gpcv2.c:264:3: note: here
   case 2:       /* FALLTHROUGH */
   ^~~~

Introduced by commit

  ed01edc0ab6f ("irqchip/irq-imx-gpcv2: Add support for i.MX8MQ")

This is caused by my use of -Wimplicit-fallthrough for Kees Cook.

Replacing the "/* FALLTHROUGH */"  with "/* fall through */" but on the
line above will suppress the warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/QkpWb.PN52T/CNFEaINp=o=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwTJwYACgkQAVBC80lX
0Gz4NQgAo3Za9eTrjAx4D5/hfTvrKT18e+MnsCc2J54PG+0eqjzRh60sR1NQmg/a
RfpChV8pg1r2iGdAlZoNUymdf+rxs5FrZdRs0P9mBncY43dAQOwrOdgkSHqpfYX3
5jez5hAvbzreiFqX+4h0iLqYke5/GSgHSdfQdlWnF3bNTCS8FLACcp8zqrLHFhWY
iLsn7n0DlEMJE8Tly2sJIzVwyYVMy8kqsotOwJYzo3Qj70TS1Z8JfqlKOlklTkl9
RuP5lo6nFQDpQ62db6e1vwpQAGoN4Rp1CZXbq6kk8xPhk2QUe4NicSdo7RCY3/ml
5XrYH8eQG31axVED3PG0oy+m3bh0uQ==
=5+rv
-----END PGP SIGNATURE-----

--Sig_/QkpWb.PN52T/CNFEaINp=o=--
