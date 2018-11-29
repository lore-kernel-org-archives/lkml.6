Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7719C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8481D20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8481D20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbeK3CSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:18:51 -0500
Received: from mout.gmx.net ([212.227.17.20]:42131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbeK3CSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:18:51 -0500
Received: from qcai.nay.com ([66.187.233.206]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MaW7Z-1gmXRw459d-00K6sN; Thu, 29
 Nov 2018 16:13:06 +0100
From:   Qian Cai <cai@gmx.us>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH] drivers/base: kmemleak ignore a known leak
Date:   Thu, 29 Nov 2018 10:12:37 -0500
Message-Id: <1543504357-4873-1-git-send-email-cai@gmx.us>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:lnnftETvPtCtJnA/059mpJB2L/kI83crxipHbJH63jnTVKe8pLK
 f1JHDHmPaeSLcBzQYDuoB45I2tju5sZ1Pp2P8gMJJ7vG1zRf3WjNO3KmTc218C8b16kuN1M
 h2oyeaqT1pS/YL0dMrq3X1uCZvK1FnaM/xyquk1UuWAzrBwaQtFh5TNyQFH6AenMnkOt6NV
 RGFBCuQBDBYEJaXhxgr7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cy93LiFgKpE=:C0GhFTmMKLvCtPfn2qK1MU
 +b+E9rpqfTKvAExoVjsoHSWH3MgdDHtOQ7ARc22RkCIWlO3JOQl6L/IO6nGB6oCxEwnjVKWdw
 0r4elhFpm9tWR4P1t78rN3DYJwUwDhVFybXh9H+Wo68rxGr2t+kLR4YeU7NJd8USfa/UNSm2s
 GA46lDdK6T01tkLm67tRXhadpomN8sBjOeJke/0heWEF+xz9F4+62eIWK1AIGS0H2hOJm5IUl
 nZth81oZRQT4RRMhfnAo61XNNsv+VZ+8wtD3u9AHN9yybbmuhn2TcKUUOpIl8ULi5ZymsfV09
 2eWsvAmUI8hAh9OdHQqscjPZWnIsUdbxn4uMtz7/VeTfYmpqGsJ5tAlHdo2/R9T1r09F1FZkD
 0D/olvdMWCCh64DN5F4AgSmRmYbdiHwwhU11nrlYxH3BG/nfM6HYwigJLg2dwAl80k6vjVneO
 qf77UYWu+dxT+0sqiSwdzLLiiZy6xGDIZ11XavU5bwJLO2jNgTvHjVjYzBo7enkB62VGC6VAW
 pob1764LAGzBSBZxqF950WZdV+auuj0pCgnyLW+5soVw4zhebaHRiB5mzTvm5RxHZZlqdSx/Z
 lEj5cjJf9cHZ+8EXmfv5psddzPvHdewvjRNkFkjMbyFO21DL8RhVm1bfOB0cp3zyeb+ii7h/M
 PHERgf7mBze15ZIOfA5cTphUc+dGwdZNB2nshwVHpcHXhXz+Prk0qiTlZu/n8eCpx4TGe8pcL
 2sv4c7DIfL9lXGroIKWy9ZxaNsWi9bDSL/hlNLXJYebTCQjp/9v+LQxTCN1H7xO9ePbbxxHgS
 rsSpcSCCs6WBr4Fooetd/XpCnONDcrGOiusay86xaCT2xxfJVOAyZ7dtxfVMKgwWiSgYgdo7q
 K3NV7NMvHDzdfZ/NE71vb3dOq8GckoQ0s4PDDSvSw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unreferenced object 0xffff808ec6dc5a80 (size 128):
  comm "swapper/0", pid 1, jiffies 4294938063 (age 2560.530s)
  hex dump (first 32 bytes):
    ff ff ff ff 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
    6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
  backtrace:
    [<00000000476dcf8c>] kmem_cache_alloc_trace+0x430/0x500
    [<000000004f708d37>] platform_device_register_full+0xbc/0x1e8
    [<000000006c2a7ec7>] acpi_create_platform_device+0x370/0x450
    [<00000000ef135642>] acpi_default_enumeration+0x34/0x78
    [<000000003bd9a052>] acpi_bus_attach+0x2dc/0x3e0
    [<000000003cf4f7f2>] acpi_bus_attach+0x108/0x3e0
    [<000000003cf4f7f2>] acpi_bus_attach+0x108/0x3e0
    [<000000002968643e>] acpi_bus_scan+0xb0/0x110
    [<0000000010dd0bd7>] acpi_scan_init+0x1a8/0x410
    [<00000000965b3c5a>] acpi_init+0x408/0x49c
    [<00000000ed4b9fe2>] do_one_initcall+0x178/0x7f4
    [<00000000a5ac5a74>] kernel_init_freeable+0x9d4/0xa9c
    [<0000000070ea6c15>] kernel_init+0x18/0x138
    [<00000000fb8fff06>] ret_from_fork+0x10/0x1c
    [<0000000041273a0d>] 0xffffffffffffffff

Then, faddr2line pointed out this line,

/*
 * This memory isn't freed when the device is put,
 * I don't have a nice idea for that though.  Conceptually
 * dma_mask in struct device should not be a pointer.
 * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
 */
pdev->dev.dma_mask =
	kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);

Since this leak has been existed for more than 8-year now and it does not
reference other part of the memory, let kmemleak ignore it, so users don't
need to waste time reporting this in the future.

Signed-off-by: Qian Cai <cai@gmx.us>
---
 drivers/base/platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 41b91af..3e1587d 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -26,6 +26,7 @@
 #include <linux/clk/clk-conf.h>
 #include <linux/limits.h>
 #include <linux/property.h>
+#include <linux/kmemleak.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -525,6 +526,8 @@ struct platform_device *platform_device_register_full(
 		if (!pdev->dev.dma_mask)
 			goto err;
 
+		kmemleak_ignore(pdev->dev.dma_mask);
+
 		*pdev->dev.dma_mask = pdevinfo->dma_mask;
 		pdev->dev.coherent_dma_mask = pdevinfo->dma_mask;
 	}
-- 
1.8.3.1

