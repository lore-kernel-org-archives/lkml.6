Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B136C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB57C20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB57C20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbeLAI7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:59:06 -0500
Received: from mout.gmx.net ([212.227.17.21]:59271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbeLAI7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:59:06 -0500
Received: from ovpn-120-135.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MBrCt-1gcznS3CT9-00Anxd; Fri, 30 Nov 2018 22:48:10 +0100
From:   Qian Cai <cai@gmx.us>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        john.garry@huawei.com, linuxarm@huawei.com,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH v2] dma-debug: Kconfig for PREALLOC_DMA_DEBUG_ENTRIES
Date:   Fri, 30 Nov 2018 16:48:03 -0500
Message-Id: <20181130214803.3119-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-Provags-ID: V03:K1:6zsCU38gxD5/XQ5CaUdqQRhIKxJPdvaZDXmsEI2wnve2CzDvC9I
 +QWaTcP5zpF8yOaaJzgJx7wLwFmAUd1zpYdgix9xcSv0X56Dp2aPsiBe1nqkFVXRAWLg3+o
 mLrhkPHxhRecuack5jqMW98D0LajDGKoEWJklHA54o7tnrCd4IsFFef6PhnQqwg8wSRGu8L
 80DYzoCoZifCK+P/mIw6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oKv3BAz+GTs=:1RCuyR/ENbx7qTj/E3AzBE
 CS0JJTbnn8j9ELjsvw4+mU4ageba6vsqZWo/kb38CUIMOmIIB4h3Naa4JX23dZ5oUnl15EOiv
 MH9dy9U/1CGM8roapT8fgWhSZlFJNKCdcP7345t5dnFjHKgE2QHoYlON0puwgDRLkGCRBy2QF
 gVEM5bsUxYu74481dqPTMZCv9BfNkDH4KJ+D6XLGeHBmebgifW03BrvF96y4Nyhz8XjE+D2Dh
 VR1lvtgaJ/kFvv3VP/IbEfNecSu7TSKs7PXRmwtZpD3SobPgEzGA6ZM/kbNC+tHbbB9DFtAKV
 pUzsiVr+Fx+pu5d50SIdGpOgdGti5q06s9sYmhH3L2xeDs7WrunHt/0hXLfWQsIdz2Y9q10kG
 ew5x5pGcgcYASi6YkB+E6PHv0HyJfiz6NeHw2AUk0Q0t69peddTLxNOSmVdd9N51vhLzPCxpR
 ZaQZwo+Gc2f7qF3uEXJ7RgpYXxp1sgHU3pmEpbuAoOvKiNNPXyD8N1fW+yjQ1ZpY7baZZ//8N
 WIvw2AxiLOCSXRd8ZcUDdAWckeYBEgukACXt48dAYazzSzuwvff9vVpDAPr14fbshjjaNzWaS
 W9P3Y2eGoDx6W8pWfEGVdBlWgHyixiuY0Erkxi+YbRpX6GOItY3NsCExLN4gII4q98pBQmQ55
 FWM+a6S/ndVkB+XXWzPdVf82rHXLDixMZR8OzbbXM5mJQ8wXXg6MQATwQiWM9QNBnV5GvSGlw
 2iNEQPiQKtotkBZdThYBlW5xZd5fj3GugI9eJj0+IJnY7DjqJzbEVOdeVPHrgovAlCwl8czkJ
 H2reHiTCsYFupNKAgVDDrxafbnDRWPMCLyUXMog8EkzC+zCnXHd2JYIZ1yN7SyKaQILxNwOQK
 gge7qWPZWy8KAjLjo7lGTuC3pyb7XFIP2CjK36HZE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amount of DMA mappings from Hisilicon HNS ethernet devices is huge,
so it could trigger "DMA-API: debugging out of memory - disabling".

hnae_get_handle [1]
  hnae_init_queue
    hnae_init_ring
      hnae_alloc_buffers [2]
        debug_dma_map_page
          dma_entry_alloc

[1] for (i = 0; i < handle->q_num; i++)
[2] for (i = 0; i < ring->desc_num; i++)

Also, "#define HNS_DSAF_MAX_DESC_CNT 1024"

On this Huawei TaiShan 2280 aarch64 server, it has reached the limit
already,

4 (NICs) x 16 (queues) x 1024 (port descption numbers) = 65536

Added a Kconfig entry for PREALLOC_DMA_DEBUG_ENTRIES, so make it easier
for users to deal with special cases like this.

Signed-off-by: Qian Cai <cai@gmx.us>
---

Changes since v1:
* Increased the default value if has HNS_ENET suggested by Robin.

 kernel/dma/debug.c |  9 ++-------
 lib/Kconfig.debug  | 10 ++++++++++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 231ca4628062..3752fb23f72f 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -41,11 +41,6 @@
 #define HASH_FN_SHIFT   13
 #define HASH_FN_MASK    (HASH_SIZE - 1)
 
-/* allow architectures to override this if absolutely required */
-#ifndef PREALLOC_DMA_DEBUG_ENTRIES
-#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
-#endif
-
 enum {
 	dma_debug_single,
 	dma_debug_page,
@@ -132,7 +127,7 @@ static u32 min_free_entries;
 static u32 nr_total_entries;
 
 /* number of preallocated entries requested by kernel cmdline */
-static u32 nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
+static u32 nr_prealloc_entries = CONFIG_PREALLOC_DMA_DEBUG_ENTRIES;
 
 /* debugfs dentry's for the stuff above */
 static struct dentry *dma_debug_dent        __read_mostly;
@@ -1063,7 +1058,7 @@ static __init int dma_debug_entries_cmdline(char *str)
 	if (!str)
 		return -EINVAL;
 	if (!get_option(&str, &nr_prealloc_entries))
-		nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
+		nr_prealloc_entries = CONFIG_PREALLOC_DMA_DEBUG_ENTRIES;
 	return 0;
 }
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af29b8224fd..9f85a7a13647 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1659,6 +1659,16 @@ config DMA_API_DEBUG
 
 	  If unsure, say N.
 
+config PREALLOC_DMA_DEBUG_ENTRIES
+	int "Preallocated DMA-API debugging entries"
+	depends on DMA_API_DEBUG
+	default 131072 if HNS_ENET
+	default 65536
+	help
+	  The number of preallocated entries for DMA-API debugging code. One
+	  entry is required per DMA-API allocation. Increase this if the DMA-API
+	  debugging code disables itself because the default is too low.
+
 config DMA_API_DEBUG_SG
 	bool "Debug DMA scatter-gather usage"
 	default y
-- 
2.17.2 (Apple Git-113)

