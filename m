Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEA7C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317B42176F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549811866;
	bh=VnkLwyfz2y5oJ1AwrbXtdH8RHcIiOlUTEBTeXSz3IrI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=U2yhkaMf4RID2vbtwNduzbz9s0ozEiFu2lnmZ8nqKtPGasxbgqa7Kx2+1jC3lgoa+
	 BwWEoBn8mddP1CvyzJvz8ZhEYaAin39mlPFT0+OB0gc1W37wtk3HwpdZb544G0f0Ht
	 8swMPCe+cFiBczqUld4FlLX/PXXyVUBUOE5HXF8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfBJPRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 10:17:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfBJPRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 10:17:32 -0500
Received: from localhost (unknown [117.99.91.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 032872176F;
        Sun, 10 Feb 2019 15:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549811851;
        bh=VnkLwyfz2y5oJ1AwrbXtdH8RHcIiOlUTEBTeXSz3IrI=;
        h=Date:From:To:Cc:Subject:From;
        b=QnLjhIiWAMVl4mhyTb6mb1QI2y19Ejc6F8vOnWNEtg/xweis1K3GUQ7ekDqyYbU/G
         KzDYvV0vwWH4nCSK+U1DcGVy74i484Fb5WuEP1p5y1kG7/2j944YELp2A2Zwj/KsyK
         CmzA+t7HjWbGj5uKHQVTevFYzUfC0pQT2bk5YWxY=
Date:   Sun, 10 Feb 2019 20:47:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmaengine fixes for v5.0-rc6
Message-ID: <20190210151722.GM4296@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull to receive the fixes for dmaengine. We have fixes in bunch
of drivers like xdmac, imx, bcm etc.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.0-=
rc6

for you to fetch changes up to 6454368a804c4955ccd116236037536f81e5b1f1:

  dmaengine: dmatest: Abort test in case of mapping error (2019-02-04 14:34=
:22 +0530)

----------------------------------------------------------------
dmaengine-fix-5.0-rc6

dmaengine fixes for v5.0-rc6

 - Fix in at_xdmac fr wrongful channel state
 - Fix for imx driver for wrong callback invocation
 - Fix to bcm driver for interrupt race & transaction abort.
 - Fix in dmatest to abort in mapping error

----------------------------------------------------------------
Andy Shevchenko (1):
      dmaengine: dmatest: Abort test in case of mapping error

Codrin Ciubotariu (1):
      dmaengine: at_xdmac: Fix wrongfull report of a channel as in use

Leonid Iziumtsev (1):
      dmaengine: imx-dma: fix wrong callback invoke

Lukas Wunner (2):
      dmaengine: bcm2835: Fix interrupt race on RT
      dmaengine: bcm2835: Fix abort of transactions

Vinod Koul (1):
      Merge branch 'fix/brcm' into fixes

 drivers/dma/at_xdmac.c    | 19 +++++++------
 drivers/dma/bcm2835-dma.c | 70 +++++++++++++++++--------------------------=
----
 drivers/dma/dmatest.c     | 32 ++++++++++------------
 drivers/dma/imx-dma.c     |  8 +++---
 4 files changed, 53 insertions(+), 76 deletions(-)

--=20
~Vinod

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcYECCAAoJEHwUBw8lI4NHiQAP+wUw/7mrhiSILQWUdooqQaEW
+VWczAx8hyj96Src6k6B9tgLEixkqoysLLZ57rkoh9yeW6L8G6INEL7QovXK6y30
FpAWggydgL1Uqw+BXSsZNVELkqRCP2DtpHtu682/e2lamaQX6VqQ+STNlXbGZMPn
r8mfZxKFDAqV+Oc6cg19izDqwFUfyrTHxRfnpPU6MWZqAtBG1JwnsBxDhp5zF4UZ
mI18k/PAgh/1LTT2AAqaE0HXPogEOwoFcIS4VNdqH4X/ITrYnPWB4rTnm8IeTbZ4
SSx+Oxwj6Sg8xmcIEXfm019zY0udA8ax6DE0sbIySuUvswNp02a4A0mpO+o382yd
N441axXBacsALCec+jmP9FC3JxQQ4PcRVR9cDEIKKp63q/ZHxxD6BAKURSdZVz+s
+7PO4IvASZxUU5Cl3Jr1E+GkZQ3iH0ZqQ6gFj+NnEQJeZIIi9b64MhcE2frNwXpb
BMFQK44cDwarRT5CEeBQTkpctuPHeeR6w7X/IfHLefFHCPp6Tm807PduuEnYCdXg
s+8wQ0iMcyx5OsFT3L0LrvJ1e3AHNUMYDHhvdRea89siBA8zw0VxtyaELCuubkSi
6hi7pfckKYy6XkJjQ6cPJmn2IY13/2tApwuVbL3HeJ6qGZn63qTZyaH5zijTD/ul
6nmebH1CzKWVtX5iEYsL
=hYA0
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
