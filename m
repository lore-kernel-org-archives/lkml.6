Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA05DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20CC20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20CC20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeK3Fwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:52:55 -0500
Received: from mout.gmx.net ([212.227.17.20]:43543 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeK3Fwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:52:55 -0500
Received: from qcai.nay.com ([66.187.233.206]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MgXCF-1gqPjc1UON-00NzGi; Thu, 29
 Nov 2018 19:46:31 +0100
From:   Qian Cai <cai@gmx.us>
To:     ard.biesheuvel@linaro.org
Cc:     marc.zyngier@arm.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH] efi: let kmemleak ignore false positives
Date:   Thu, 29 Nov 2018 13:45:52 -0500
Message-Id: <1543517152-23969-1-git-send-email-cai@gmx.us>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:y2qigTIqku976iZS0VF0KI20pkKTInCT7ylRvB+fIvHbp0rpkH2
 38Y3lIqLr76FsIo6AULbeAc84fqIeT3ExVVgNKbQawKuUCDkBZjf+AtZmZgha0406D4PnBb
 rbpQ8k0E57WaukM8xof21+4Zr3G0frpyd+Dz/b6XuNF4VtNLp2aLwkW/9gc69h46BYac70n
 I5jpPhrBExcvtRumQXSjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oDEfZw1DAFI=:c6DUERruP1TQE061nslGQs
 zNvs5QFwRcbc5Ni/P8gd+cXjBhOCG1BNxuE+/yVQwy/x2ufpG6EF0YVRHgn/jI7gJQDcHH06C
 6ugIh9SiljODEqafMuNQG8hcUFUUHVSvJdTljeyFJQj4xIM88UGSFFoi6fjavRASij0iEL9Nm
 Gwb883wZxAoyJ3RuUeNqVYJnkJipd/Z/4MXqDJWLDdqrNh9etTKy7k71iGIlhNcImQvorQ1bs
 oAwvyhQ2HXqus+m10raN35/7g2NkEDruUztL0LRYrkldMEWaNPBuwO2tGQ7uzJOTCJ94jejmm
 G/qhVZ1qe7ofAmqgvJM8C58rsjDSsQkyVNvKcUMziimq0P8VhI3ucwyQ5Wi8EobXGMR9w9m5q
 eQ2kzf8qAQfn9i2N2w/Y5OBhspQS7g3H78TjalvDRJEqAZ9141bscCDbPfoiOQHOodnkwqhuV
 R+OEBYNhIIhYsF4w7rHb5yFD4Uy9Bf4FYgbqdeUwxWa+coXR9nQjhbFcTGN5QLtwbTva7OtNC
 qHZfLUUS+q1Cmu0U4kEg9meu8nlzOPDpfM6GAywr+PTaAppvNvK2/ReCisWa9ebiE73PWH76j
 xyjZcKvecqBY3fd/FGuh4ZtGxu++X64/96znQsAt/n61LWR9RqbYT22pniUV6+ZH+iiY5pUUn
 3QvvtKkNSaZ8II1Qf8WOlc18CN0UPIHe8aoaz0QnnAlLfmQIVFnxkCCsp7au2C3uv/0ceVOk9
 rC21MN2Ot4CoNKTfSgpFpOFhoy9kEGD+crfzGnYG5lYr5mAOq94Ae6/VElp6cS83KJ7MCqTNt
 joZ4OT+EtAdeq0Kr7M/O8swMc9pJr7r6fxO486kheacPH+Tp93S+2cJL0TxgPgM551+mhkbg9
 +u46pXzkojrx9kwOsmVjvoO4iFMrA8lbuhaFD9GV8=
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
index fad7c62..0b69bb6 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -31,6 +31,7 @@
 #include <linux/acpi.h>
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
+#include <linux/kmemleak.h>
 
 #include <asm/early_ioremap.h>
 
@@ -980,6 +981,8 @@ int efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	if (!rsv)
 		return -ENOMEM;
 
+	kmemleak_ignore(rsv);
+
 	rsv->base = addr;
 	rsv->size = size;
 
-- 
1.8.3.1

