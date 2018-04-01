Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753258AbeDABlL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 21:41:11 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47314 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752879AbeDABlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 21:41:07 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <b5565777219806dc2744af99d3308a31bd948223.1522546571.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1522546571.git.fthain@telegraphics.com.au>
References: <cover.1522546571.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 02/12] m68k/mac: Fix SWIM memory resource end address
Date: Sat, 31 Mar 2018 21:41:04 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resource size is 0x2000 == end - start + 1.
Therefore end == start + 0x2000 - 1.

Cc: Laurent Vivier <lvivier@redhat.com>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 54f3a8421afc..1aba633b7268 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -1007,7 +1007,7 @@ int __init mac_platform_init(void)
 		struct resource swim_rsrc = {
 			.flags = IORESOURCE_MEM,
 			.start = (resource_size_t)swim_base,
-			.end   = (resource_size_t)swim_base + 0x2000,
+			.end   = (resource_size_t)swim_base + 0x1FFF,
 		};
 
 		platform_device_register_simple("swim", -1, &swim_rsrc, 1);
-- 
2.16.1
