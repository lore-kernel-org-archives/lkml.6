Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932101AbeCSIYX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:24:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48589 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753013AbeCSIYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:24:08 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, oferh@marvell.com, igall@marvell.com
Subject: [PATCH v2 0/9] crypto: inside-secure - hmac(sha256/sha224) support
Date: Mon, 19 Mar 2018 09:21:12 +0100
Message-Id: <20180319082121.32103-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

This series brings hmac(sha256) and hmac(sha224) support to the Inside
Secure cryptographic engine driver.

The first 7 patches are fixes and reworks needed for the hmac(sha256)
and hmac(224) support to land in. Then 2 patches adds the 2 new
algorithms.

This has been tested with boot tests, tcrypt and IPsec traffic. This
series is a preparation series for more algorithms support (so that
the series are smaller and easier to review).

Thanks,
Antoine

Since v1:
  - Fixed a kbuild reported compilation issue.
  - Added missing commit messages in the last 2 patches.
  - Removed 3 patches from the series that already were applied in
    the cryptodev tree.

Antoine Tenart (9):
  crypto: inside-secure - move the digest to the request context
  crypto: inside-secure - fix typo s/allways/always/ in a define
  crypto: inside-secure - fix a typo in a register name
  crypto: inside-secure - improve the send error path
  crypto: inside-secure - do not access buffers mapped to the device
  crypto: inside-secure - improve the skcipher token
  crypto: inside-secure - the context ipad/opad should use the state sz
  crypto: inside-secure - hmac(sha256) support
  crypto: inside-secure - hmac(sha224) support

 drivers/crypto/inside-secure/safexcel.c        |   8 +-
 drivers/crypto/inside-secure/safexcel.h        |   6 +-
 drivers/crypto/inside-secure/safexcel_cipher.c |   3 +-
 drivers/crypto/inside-secure/safexcel_hash.c   | 189 +++++++++++++++++++++----
 4 files changed, 170 insertions(+), 36 deletions(-)

-- 
2.14.3
