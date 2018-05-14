Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753702AbeENNPX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:15:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47580 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932472AbeENNPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:15:15 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, oferh@marvell.com, igall@marvell.com
Subject: [PATCH v2 00/10] crypto: inside-secure - AEAD support
Date: Mon, 14 May 2018 15:10:54 +0200
Message-Id: <20180514131104.25552-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings AEAD algorithms to the Inside Secure SafeXcel driver.
The first 7 commits rework the driver to allow the future AEAD addition,
and then 3 commits add AEAD functions and 3 algorithms.

This is based on top of v4.17-rc5.

Thanks!
Antoine

Since v1:
  - Reworked the driver to remove VLA's and added a custom on-stack
    request definition in the driver, to be used in the invalidation
    process. (Patch 1/10 was replaced, patch 8/10 was reworked).
  - Rebased on top of v4.17-rc5 (was -rc3).

Antoine Tenart (10):
  crypto: inside-secure - remove VLAs
  crypto: inside-secure - rework cipher functions for future AEAD
    support
  crypto: inside-secure - rework the alg type settings in the context
  crypto: inside-secure - make the context control size dynamic
  crypto: inside-secure - make the key and context size computation
    dynamic
  crypto: inside-secure - fix the hash then encrypt/decrypt types
  crypto: inside-secure - improve error reporting
  crypto: inside-secure - authenc(hmac(sha256),cbc(aes)) support
  crypto: inside-secure - authenc(hmac(sha224),cbc(aes)) support
  crypto: inside-secure - authenc(hmac(sha1),cbc(aes)) support

 drivers/crypto/Kconfig                        |   1 +
 drivers/crypto/inside-secure/safexcel.c       |  32 +
 drivers/crypto/inside-secure/safexcel.h       |  44 +-
 .../crypto/inside-secure/safexcel_cipher.c    | 642 ++++++++++++++----
 drivers/crypto/inside-secure/safexcel_hash.c  |  23 +-
 5 files changed, 600 insertions(+), 142 deletions(-)

-- 
2.17.0
