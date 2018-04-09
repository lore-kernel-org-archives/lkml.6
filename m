Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbeDIPqj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 11:46:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54931 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753211AbeDIPqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 11:46:35 -0400
X-Google-Smtp-Source: AIpwx4/Xn3bi32RDbYg7shqogR4RJR2L2XiINSzDBsfzd5VJiPZ32Sql+qlDWhNga6Ust4pui+FrGw==
From: Jan Glauber <jglauber@cavium.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mahipal Challa <Mahipal.Challa@cavium.com>,
        Robert Richter <rrichter@cavium.com>,
        Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v2 0/5] ThunderX ZIP driver bug fixes
Date: Mon,  9 Apr 2018 17:45:49 +0200
Message-Id: <20180409154554.7578-1-jglauber@cavium.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some bug fixes for this driver after it stopped working with virtual mapped
stacks. I think the first two patches qualify for stable.

Jan Glauber (5):
  crypto: thunderx_zip: Fix fallout from CONFIG_VMAP_STACK
  crypto: thunderx_zip: Limit result reading attempts
  crypto: thunderx_zip: Prevent division by zero
  crypto: thunderx_zip: Fix statistics pending request value
  crypto: thunderx_zip: Fix smp_processor_id() warnings

 drivers/crypto/cavium/zip/common.h      | 21 +++++++++++++++++++++
 drivers/crypto/cavium/zip/zip_crypto.c  | 22 ++++++++++++++--------
 drivers/crypto/cavium/zip/zip_deflate.c |  4 ++--
 drivers/crypto/cavium/zip/zip_device.c  |  4 ++--
 drivers/crypto/cavium/zip/zip_inflate.c |  4 ++--
 drivers/crypto/cavium/zip/zip_main.c    | 24 +++++++++++-------------
 drivers/crypto/cavium/zip/zip_main.h    |  1 -
 7 files changed, 52 insertions(+), 28 deletions(-)

-- 
2.16.2
