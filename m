Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC668C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B822D20700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B822D20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbeLFQRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:17:08 -0500
Received: from mout.gmx.net ([212.227.17.21]:45001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbeLFQRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:17:07 -0500
Received: from ovpn-121-90.rdu2.redhat.com ([71.184.117.43]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MYwQh-1gzzcp0sJ1-00VkjW; Thu, 06 Dec 2018 17:17:04 +0100
From:   Qian Cai <cai@gmx.us>
To:     akpm@linux-foundation.org
Cc:     ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
        marc.zyngier@arm.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [RESEND PATCH] efi: let kmemleak ignore false positives
Date:   Thu,  6 Dec 2018 11:16:33 -0500
Message-Id: <20181206161633.36292-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <1543517152-23969-1-git-send-email-cai@gmx.us>
References: <1543517152-23969-1-git-send-email-cai@gmx.us>
X-Provags-ID: V03:K1:icbn2ncgSA/eyt4FK5BOmU4VDzgHBtftAqpyuoLh5teXXvk536x
 2t709JpAxe2/xDN2O4IVF5HhhBeerxC47N/KpMjck7w8Uo+J1KSI9RV/ZqEbFnyL1nwbxeL
 S20PnMOh1OGKLECzBvK0VpdDQYd4E/3wOtNgzUeFkWl/2LmQAQ3FZ4xexdOm07awrUgaLjE
 xMK2eab3eJy25vy+l4RrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X2WpldfLbSE=:ikURFGkXBPM9NLXj8dtWXA
 6qk/nxXTLYtxEmxyVGweyQms8qcyJOH/6NBTV0iSTBQtrob8Er9J8lAGvCtZbkNFKULLysLLS
 SmCjJmtbj40Kjcj8nFrmCy9eg/0i87f3fKyqbAtkZSrmLN3TB9tzsTtZEMLUmFNUkMjhb6wNj
 ZcM1DzSkf0xk3dYHGS0JjVKo096MrcegFXNa8WH2KZpZqpbI53g8oSzcgZOMGE2Qm3WGsABgB
 DAXndQy9zzOCIybCnyE96D0Tm+gb7M5INXWlQpCcf+6hwY1Af8muyC3K5rKOPMT/n3Lgg+aeT
 VzC05Byg79FvzdJP9e8Qc+vrMyL53F7VNGHZ8BBFUkGvw+t7A6OLuW5jDehS5Mbr2MsOgCzhk
 dDEwOK7I4ik29vm+rhoETSZ+o2UpQTIc9nfG7/Ho89eiM+d+D0Ud86pfR026PMeaxFWAbeuhU
 iO3O1ZDpwU02RDzXgYxpVIaST7U8WbZ789s+9NVUfqfzxMjnDqfmKbdLuQGhguxR0ReLw86cx
 +SHSWvOZ8YF6ZkKo3qmKr9f7XzFkFZGaqX9KVw8ykHQTvN+jEHY3XWUPHSFrel3b7vQwbdSR7
 1H0CpAvaDbkGiAg1LcjlSKWspS9vvoI4mhxiLbkN8yFWUEGBLXc1c/IYmJX90FVIuAbgBrQEB
 vdz+xWpzoIPQom9ZkoHM4OlVudy2YmX67fAJ/1rz9RrFFnhWJYyo5ekt2xxkMroMQ1+2QTeuo
 mFE+aG6GeOUy4Q+6fA8FLzYHhaBj2ri7vN990owVLyg92o+4+7q5Zt2LiD2oSziDtTkQ7f1w2
 cxH/+0t+xLa8KWRYFTdxHcF9dkx2g39BhlurKAogU6YmW3FesbSLiRiegamZfzU3xPFe7uOI9
 xsGEVCk2gNCWUJ57/miPZsrQj2V8u0hyoq4DoMf0E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unreferenced object 0xffff8096c1acf580 (size 128):
  comm "swapper/63", pid 0, jiffies 4294937418 (age 1201.230s)
  hex dump (first 32 bytes):
    80 87 b5 c1 96 00 00 00 00 00 cc c2 16 00 00 00  ................
    00 00 01 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
  backtrace:
    [<000000001d2549ba>] kmem_cache_alloc_trace+0x430/0x500
    [<0000000093a6dfab>] efi_mem_reserve_persistent+0x50/0xf8
    [<000000000a730828>] its_cpu_init_lpis+0x394/0x4b8
    [<00000000edf04e07>] its_cpu_init+0x104/0x150
    [<000000004d0342c5>] gic_starting_cpu+0x34/0x40
    [<000000005d9da772>] cpuhp_invoke_callback+0x228/0x1d68
    [<0000000061eace9b>] notify_cpu_starting+0xc0/0x118
    [<0000000048bc2dc5>] secondary_start_kernel+0x23c/0x3b0
    [<0000000015137d6a>] 0xffffffffffffffff

efi_mem_reserve_persistent+0x50/0xf8:
kmalloc at include/linux/slab.h:546
(inlined by) efi_mem_reserve_persistent at drivers/firmware/efi/efi.c:979

This line,

rsv = kmalloc(sizeof(*rsv), GFP_ATOMIC);

Kmemleak has a known limitation that can only track pointers in the kernel
virtual space. Hence, it will report false positives due to "rsv" will only
reference to other physical addresses,

rsv->next = efi_memreserve_root->next;
efi_memreserve_root->next = __pa(rsv);

Signed-off-by: Qian Cai <cai@gmx.us>
---
 drivers/firmware/efi/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 415849bab233..7fcfe8a7ae98 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -31,6 +31,7 @@
 #include <linux/acpi.h>
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
+#include <linux/kmemleak.h>
 
 #include <asm/early_ioremap.h>
 
@@ -1000,6 +1001,8 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	if (!rsv)
 		return -ENOMEM;
 
+	kmemleak_ignore(rsv);
+
 	rsv->base = addr;
 	rsv->size = size;
 
-- 
2.17.2 (Apple Git-113)

