Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CCEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D094C20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D094C20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbeHaQsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:48:45 -0400
Received: from sauhun.de ([88.99.104.3]:60760 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727294AbeHaQsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:48:45 -0400
Received: from localhost (p54B33960.dip0.t-ipconnect.de [84.179.57.96])
        by pokefinder.org (Postfix) with ESMTPSA id 2048434AE18;
        Fri, 31 Aug 2018 14:41:24 +0200 (CEST)
Date:   Fri, 31 Aug 2018 14:41:23 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.19
Message-ID: <20180831124120.suchscewwcrta476@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ixjdo3bmjypr3tme"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ixjdo3bmjypr3tme
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

I2C has for you:

* regression fixes for i801 and designware
* better API and leak fix for releasing DMA safe buffers
* better greppable strings for the bitbang algorithm

Thanks,

   Wolfram


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-curre=
nt

for you to fetch changes up to cebc07d84ad71bc58d6f59b770e4347da48a5a2b:

  i2c: sh_mobile: fix leak when using DMA bounce buffer (2018-08-30 23:13:5=
9 +0200)

----------------------------------------------------------------
Hans de Goede (1):
      i2c: designware: Re-init controllers with pm_disabled set on resume

Jan Kundr=C3=A1t (1):
      i2c: algos: bit: make the error messages grepable

Mika Westerberg (1):
      i2c: i801: Allow ACPI AML access I/O ports not reserved for SMBus

Wolfram Sang (3):
      i2c: refactor function to release a DMA safe buffer
      i2c: sh_mobile: define start_ch() void as it only returns 0 anyhow
      i2c: sh_mobile: fix leak when using DMA bounce buffer


with much appreciated quality assurance from
----------------------------------------------------------------
Andy Shevchenko (1):
      (Rev.) i2c: designware: Re-init controllers with pm_disabled set on r=
esume

Jean Delvare (1):
      (Rev.) i2c: i801: Allow ACPI AML access I/O ports not reserved for SM=
Bus

Niklas S=C3=B6derlund (3):
      (Rev.) i2c: sh_mobile: fix leak when using DMA bounce buffer
      (Rev.) i2c: sh_mobile: define start_ch() void as it only returns 0 an=
yhow
      (Rev.) i2c: refactor function to release a DMA safe buffer

 Documentation/i2c/DMA-considerations        | 10 ++++--
 drivers/i2c/algos/i2c-algo-bit.c            | 55 ++++++++++++++++---------=
----
 drivers/i2c/busses/i2c-designware-master.c  |  1 -
 drivers/i2c/busses/i2c-designware-platdrv.c |  7 +++-
 drivers/i2c/busses/i2c-i801.c               |  9 ++++-
 drivers/i2c/busses/i2c-sh_mobile.c          | 15 ++++----
 drivers/i2c/i2c-core-base.c                 | 11 +++---
 include/linux/i2c.h                         |  2 +-
 8 files changed, 66 insertions(+), 44 deletions(-)

--ixjdo3bmjypr3tme
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluJN2wACgkQFA3kzBSg
KbY4xw//R0MzLS066a0HzbRD6NwGqKFk9hyT5jqaUSxTRrtI2jIkVD+4FpSODFSe
46LnZixGGN8ox+WWl9UU/LZDqW80qhxK5zq+kmB+S6j/DFxuGmxLbfIwKaocMbyA
0mRx1orfHacWpF8zpxrkwl2KZf08M8bhynwmh9e8RMYBawpJy/GRAtTXgj99lTTB
HHNhXaQO2XwSvXQaWi64ErmSaRLFYpxrnu6cdhaJgG8gpDYKoANcAZuA74UUNGfO
dNeAkemwuSCcnuZkHFckllSW28fy4yYRJWYmI+kdWrXqbG1w/+P9zwdDM0mDqD5j
bZSHsWhN+91DvKSS0HYb7xIFOsOCaHbID3/WnS9GVK/jmVPrjVtrxWwItFRkrCb3
un2+au3+ePVpCkRZYJqEeRdFvNpRTzBdCCLAGa8hgUo0l5m86OwgYjXnsX+bGA7h
mjLIGmO0KQfieTiBWo/zOXi1vKtEHeXfpT4DIXPGmYaCa7B3CmDMVI2UAjzPlowK
iB3HZnSXnFXEsx38iSrN3YeUk40/M3LKbXVCNP+XG8hT8T7SKP44HZQ9sXHPGpX9
tYucOyDlh8Jr7LqEM2r3j+31xnrShLHO41dP7uMQ8L8/fRLxo67c3+bI0jw77B7s
9MTdDv0fycDSXbh2IrTvVKlfbceTAYN0QjyYV+nzdtZAg4xkuSw=
=wlos
-----END PGP SIGNATURE-----

--ixjdo3bmjypr3tme--
