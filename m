Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C4FC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8ACF2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bzhuhDnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8ACF2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeK3JKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:10:39 -0500
Received: from ozlabs.org ([203.11.71.1]:52893 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeK3JKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:10:39 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 435WkN60KHz9s8r;
        Fri, 30 Nov 2018 09:03:40 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543529021;
        bh=5HBcPYHnyqFFOSXQbmQ2vfX7vVWQc9ADgC4LfLmIPgk=;
        h=Date:From:To:Cc:Subject:From;
        b=bzhuhDnB8Yz1Ya5pGMHSYRpBzh0viLdt+9ajRY4xpViMKINtaSjAyzSZbAZ5A95d+
         m3JniwSfrEySvjVDjlnm2XMdIRVLfDcW9vyZgTm8Mhu3cpAQ89IGC7noeJg40eZSGx
         PrOiEdtEoBOqbYkzvo9LcYFu5M17naL/5hvYroPQad1jRsuAPlv7IBymTx2OlfQ8ky
         iTqrbYyqzP42nScuRW78Gb+oEw5f1ciCYS+D0Mh30ZWbcFMT6DBI4cAWji4jR26icw
         +9KDX/swNfy5nYmgT37iwjjd74tsoTiFqul1mGbfDEhNhhvJ9xKMmKay+Cdb4hZnfp
         1XxPQRH20UckQ==
Date:   Fri, 30 Nov 2018 09:03:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: linux-next: build failure after merge of the clk tree
Message-ID: <20181130090325.7526140e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5w=Bnuv=9s_CopRFLzS.c2B"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5w=Bnuv=9s_CopRFLzS.c2B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the clk tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arm-linux-gnueabi-ld: drivers/clk/imx/clk-frac-pll.o: in function `clk_pll_=
round_rate':
clk-frac-pll.c:(.text+0x50): undefined reference to `__aeabi_uldivmod'

Caused by commit

  9fd680d0fafd ("clk: imx: add fractional PLL output clock")

I have used the clk tree from next-20181129 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/5w=Bnuv=9s_CopRFLzS.c2B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwAYi0ACgkQAVBC80lX
0GzI8gf9HFn6FEGZpfjlEjDmk9VAO8pqSde850yQIoTNZYdOj0DPUgaGiAPHVccR
0uU7I5yWMiBfuCpp3OWesfMiDjhb98Wj8sxqbqHljjY8M7kWSn6BHwIYStQuyuyO
DUzHuxPtxRfGEFtcbj2ApZU/2Up8Hec1uEVNLs0JTo5I0Wm89QRG4v22Vm794oau
/rsZNfhGj+0W+mPGvBYZLTvq2V3kxrzxmV1POoTpqbH8MS/uxJoEUj1ZuVD7WjBL
/sFM4UusrMlausFGC0qU+nia1EFvfHIrETFqamzfCoHvDfJPPyKeLyNmmn2z8ciZ
lph8ZRTAwmm1tol495g2vOqZLgzEnw==
=5mU8
-----END PGP SIGNATURE-----

--Sig_/5w=Bnuv=9s_CopRFLzS.c2B--
