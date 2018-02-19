Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbeBSOvj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:51:39 -0500
Received: from foss.arm.com ([217.140.101.70]:60178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753022AbeBSOvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:51:37 -0500
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] cleanups and new HW rev support
Date: Mon, 19 Feb 2018 14:51:20 +0000
Message-Id: <1519051887-4668-1-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduces backward compatible support for the older
CryptoCell hardware revision 710 and 630 along some minor code
cleanups.

Gilad Ben-Yossef (4):
  crypto: ccree: remove unused definitions
  dt-bindings: Add DT bindings for ccree 710 and 630p
  crypto: ccree: add support for older HW revs
  crypto: ccree: replace memset+kfree with kzfree

 .../devicetree/bindings/crypto/arm-cryptocell.txt  |   3 +-
 drivers/crypto/Kconfig                             |   6 +-
 drivers/crypto/ccree/cc_aead.c                     |  34 +++--
 drivers/crypto/ccree/cc_cipher.c                   |  25 +++-
 drivers/crypto/ccree/cc_crypto_ctx.h               |  36 -----
 drivers/crypto/ccree/cc_driver.c                   |  68 ++++++++--
 drivers/crypto/ccree/cc_driver.h                   |  23 +++-
 drivers/crypto/ccree/cc_fips.c                     |  13 +-
 drivers/crypto/ccree/cc_hash.c                     | 149 +++++++++++----------
 drivers/crypto/ccree/cc_hash.h                     |  12 +-
 drivers/crypto/ccree/cc_host_regs.h                |   3 +
 drivers/crypto/ccree/cc_hw_queue_defs.h            |   2 +-
 drivers/crypto/ccree/cc_kernel_regs.h              |   1 +
 drivers/crypto/ccree/cc_request_mgr.c              |   9 +-
 drivers/crypto/ccree/cc_sram_mgr.c                 |  14 ++
 15 files changed, 240 insertions(+), 158 deletions(-)

-- 
2.7.4
