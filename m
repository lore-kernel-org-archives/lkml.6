Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38096C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0146620834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0146620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeLAFFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:05:14 -0500
Received: from mout.gmx.net ([212.227.17.20]:54093 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725754AbeLAFFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:05:14 -0500
Received: from ovpn-120-135.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MQvDO-1gwvpJ2hSA-00UFfP; Fri, 30 Nov 2018 18:54:56 +0100
From:   Qian Cai <cai@gmx.us>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        john.garry@huawei.com, linuxarm@huawei.com,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH] dma-debug: Kconfig for PREALLOC_DMA_DEBUG_ENTRIES
Date:   Fri, 30 Nov 2018 12:54:49 -0500
Message-Id: <20181130175449.2625-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-Provags-ID: V03:K1:TUbb/gMiUmKvjCYnTIRe2O7NIAaF/Tv0SGqfkpxtpTRu65R/vzj
 j1mWyaXJPnvWzagfvvpgbFx6OHC+oE/pbptb209h75ovEZ4rKKu/UnSYKeOoHtmRhi856PB
 a/0imas7Ht837dwNyhNvSvCRJiHHRRIoOqbZ187afrAlbgeL6NcF+q56le5gFiVHBn2jXB2
 pp1EKQmkpaxxvv3zZ4CVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DM6fj799yeo=:IkvKzZcx9bUwmwViy/3bbz
 xaUSPwMdsO8AQzj+Cv6aMW28VrmHD1cmPo+vrov9E007F9dHi8LE+pw7Olf+NMVpfr9VIO+C0
 3fvuhIjrw9kvPTgw46AkaOWMk7LPNu/6/YpPygTXloVd4Sp2qOK/y2dJ0UaKjCOeGm9O2Of8N
 11l2qUHMmZI4hqXg3qK6OER5XFpBbcWp5rXtZuvnsyP2fZZKN3m3x4hMEEwvxIHecwiU7HDLR
 xymahFf7aawwaubHFZjuS1jDOCsBpmPpoBn3YBIOCUnPweXsOnz7CkqMjqfGcqr+m/8zP7cp5
 7UiDVDGymccI0pn/W+eHaofqiYhYP/KsxI93t33Sqt8ap5bxeE9X+lA9uyyKfAWuLu6KPlyDT
 7icGgH3wJNsnyuOy0M7s0Zpi96wSCgq45KmpAusn9gcu7QQc7vkg6leDBpCFzDQLA1rusKU7S
 CwFZ+0bLpAYIpysPkYMgMyzPIjj31sD9dWGjeQxq+sN3oVnx8pTu/QYDBt86ZW81PFw+XO8ZK
 zRskPW0Wc3RwdlfDsOFXZqwDaT1cTUWE/Lyc0p9bmqu9nbz/NGIqMesaJPXUKU8w5hjzw9eW+
 jTiVyP7V59okEhEhsHReuYEh+5+ZPpIBvi27litG+123P0AZRyieMmwFqwGlGDvEJxlffalTB
 8JrsahnInzO4QrnS4F9JxaYzRn8uPMHzBgLZCMxKxH1ogl5v6W+JlmQ+D4SBiF3zrB1fenQOD
 aQd53DQuzCnTy5MedKDNWc7Ans4Bp8v0c7K/GJ0a4G9deLi5orKdt7iC/mUH/2Eb46M3oAgXf
 Tf2waJ6t75RjHEX8/f1/9mQO4sX3CLpcC4fWzA+f2CH9TNPVw91LJybblglAv280n9spuy7Ar
 R0tFSke1RSYrTfja/BG2qVYQLiZZheMdWx8NTD0FE=
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

On this Huawei TaiShan 2280 aarch64 server, it has reached the limit
already,

4 (ports) x 16 (handles) x 1024 (rings) = 65536

Added a Kconfig entry for PREALLOC_DMA_DEBUG_ENTRIES, so make it easier
for users to deal with special cases like this.

Signed-off-by: Qian Cai <cai@gmx.us>
---
 kernel/dma/debug.c | 9 ++-------
 lib/Kconfig.debug  | 9 +++++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

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
index 1af29b8224fd..2c281edcb5ad 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1659,6 +1659,15 @@ config DMA_API_DEBUG
 
 	  If unsure, say N.
 
+config PREALLOC_DMA_DEBUG_ENTRIES
+	int "Preallocated DMA-API debugging entries"
+	depends on DMA_API_DEBUG
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

