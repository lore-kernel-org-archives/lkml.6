Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754487AbeDWHZc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:25:32 -0400
Received: from foss.arm.com ([217.140.101.70]:36364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754220AbeDWHZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:25:30 -0400
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] cleanup and hardware keys
Date: Mon, 23 Apr 2018 08:25:13 +0100
Message-Id: <1524468316-6606-1-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small cleanup and add support for CryptoCell hardware keys.

Changes from v1:
- The cleanup patch is new, as Herbert took the previous one :-)
- Hardware key API uses the "paes" designator to indicate a protected key,
  same as s390, as per Herbert preference
- Avoid direct casting and reference of key material, as pointed out by
  Herbert

Gilad Ben-Yossef (2):
  crypto: ccree: enable support for hardware keys
  crypto: ccree: use proper printk format

 crypto/testmgr.c                 |  43 +++++
 drivers/crypto/ccree/cc_cipher.c | 350 ++++++++++++++++++++++++++++++++++-----
 drivers/crypto/ccree/cc_cipher.h |  30 +---
 drivers/crypto/ccree/cc_driver.c |   2 +-
 4 files changed, 362 insertions(+), 63 deletions(-)

-- 
2.7.4
