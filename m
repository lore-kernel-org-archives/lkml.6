Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A8CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4052E208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4052E208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeHXTMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:12:51 -0400
Received: from sauhun.de ([88.99.104.3]:41670 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbeHXTMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:12:51 -0400
Received: from localhost (p54B33931.dip0.t-ipconnect.de [84.179.57.49])
        by pokefinder.org (Postfix) with ESMTPSA id 7202F305F1B;
        Fri, 24 Aug 2018 17:37:40 +0200 (CEST)
Date:   Fri, 24 Aug 2018 17:37:40 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jean Delvare <jdelvare@suse.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.19
Message-ID: <20180824153735.ffqgp6k3utguwpwb@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="asfofoxe35wwz27d"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--asfofoxe35wwz27d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

as promised, here is my 2nd pull request for I2C, containing:

* removal of the attach_adapter callback, converting its last user
* removal of any __deprecated usage within I2C
* one email address update
* some SPDX conversion

CCing Jean on this one, he will probably be happy to finally see
attach_adapter be gone for good as well :)

Thanks,

   Wolfram


The following changes since commit 33e17876ea4edcd7f5c01efa78e8d02889261abf:

  Merge branch 'akpm' (patches from Andrew) (2018-08-23 19:20:12 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next

for you to fetch changes up to 00efcdce67a365ec1881a6fbf17f769d690244e9:

  i2c: don't use any __deprecated handling anymore (2018-08-24 17:26:43 +0200)

----------------------------------------------------------------
Peter Korsgaard (1):
      i2c: ocores: update my email address

Sedat Dilek (1):
      i2c: don't use any __deprecated handling anymore

Wolfram Sang (3):
      macintosh: therm_windtunnel: drop using attach_adapter
      i2c: remove deprecated attach_adapter callback
      i2c: use SPDX identifier for Renesas drivers


with much appreciated quality assurance from
----------------------------------------------------------------
Simon Horman (1):
      (Rev.) i2c: use SPDX identifier for Renesas drivers

 Documentation/i2c/busses/i2c-ocores      |  2 +-
 MAINTAINERS                              |  2 +-
 drivers/i2c/Makefile                     |  1 -
 drivers/i2c/busses/i2c-emev2.c           |  5 +----
 drivers/i2c/busses/i2c-highlander.c      |  5 +----
 drivers/i2c/busses/i2c-ocores.c          |  4 ++--
 drivers/i2c/busses/i2c-rcar.c            | 10 +---------
 drivers/i2c/busses/i2c-riic.c            |  5 +----
 drivers/i2c/busses/i2c-sh_mobile.c       | 10 +---------
 drivers/i2c/i2c-core-base.c              | 11 +----------
 drivers/macintosh/therm_windtunnel.c     | 25 +++++++++++++++++++++++--
 include/linux/i2c.h                      |  6 ------
 include/linux/platform_data/i2c-ocores.h |  2 +-
 13 files changed, 34 insertions(+), 54 deletions(-)

--asfofoxe35wwz27d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluAJjsACgkQFA3kzBSg
Kbao8w/+ImcI7fiANu+KsU4M6ro1T8lsOPXklHA8+SiMOXniWcUw7XPE9ES3FGTo
BQDWHRilgyqVWPPdtzbjneLe7LhFsGXYFl2veW8rOegz0IUrN0J2G7yIicdg3y7A
tnPCOFUUAFD6YaFonVoB4K7wfB/BqhktqLAkRe2WyI7XpHw+x4nnxk9ga6xjR6qi
kOX3OVA5DcZXRd26mT0hb6FFTlH4AurzPp/e6h+tmgPEhYWwYZB3CeDO2+RM7tCo
hC+QtmnZe3oAlvQFptAgHFO4x2BGjNM3wpDKual6M8RwfbPH7s6mQX5zkhgAfNEi
d4OOQmP2tDIdBpukkoDiSTOEJy1vuQybeMCXp3UicETx4duq3f2LnAmR3eEW6uPU
H4zYIidn+SQ70MXy4JwwwRauqmG6M3vDVrm4PPh3ujVIgCWfNpIB7uBNkSeMzq9l
v4k+UCKsc8GVXRR27/KH+a8ZIeh5+M4EIQjLA5OaPYeRZASxIvEAfZ969krZATLP
6agExIzf9pRksTq9uoVFuSttsLXxvtQXaRz8ofs1CqriTUrs0T97YhzOyhDvLXBo
M9UF1O+a04Nk6RyiPB+oPT2QCOG42WIaAPdHyq+/dvYAaNpXQkCGB0NCc0xjgbVE
312SJE8Mh13JotbI8/QK/V71nAk/Zg1sF/fuI+ed45j0ILliHTc=
=firY
-----END PGP SIGNATURE-----

--asfofoxe35wwz27d--
