Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9184CC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6036120838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6036120838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeLFQIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:08:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:41093 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbeLFQIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:08:51 -0500
Received: from ovpn-121-90.rdu2.redhat.com ([71.184.117.43]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0Lcjdr-1hEUEm0PY7-00k6aq; Thu, 06 Dec 2018 17:08:43 +0100
From:   Qian Cai <cai@gmx.us>
To:     akpm@linux-foundation.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@gmx.us>
Subject: [RESEND PATCH] drivers/base: kmemleak ignore a known leak
Date:   Thu,  6 Dec 2018 11:07:51 -0500
Message-Id: <20181206160751.36211-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <1543504357-4873-1-git-send-email-cai@gmx.us>
References: <1543504357-4873-1-git-send-email-cai@gmx.us>
X-Provags-ID: V03:K1:2EXpTXHwwZh5LYDTxekmW+j5xG/MoDyaeMsUhUqGZPzBjQkCXaB
 12rlhJjVelwtFauJMp6qUAJcKE9msPxtetLiU1cxdX8g5WCH6XHvQX7tTw0+y40e6T1HwDm
 LlP9YygpwlNKOyvPlwc1JuijnnBtT1F6kdR2c3MOUfhySeb7Ojk16Bho1SlU2cWjJEt4H3V
 tjQbwupuwBa2CUufUrJ9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LA9n3qnkU+M=:QSLCRlygYqZZJb46asFhPO
 zRwwOOeMTqSAU2sT/CKgKr3RkKluQTRcqYufixa6tn/UKLxSlFzMHGFDVHVk9c1sLHib2VLFw
 7YaZM1zLa9ahTypNM9NK1eacg1lvbD1L4nm0hFM1zKaIBYc4K0TWWQiG6friSWtcuZnq+HZ9I
 IP3AM+FXjvAXfpodmgXs4MWpZJvnTky4ovLIx2tlwUL67p2vzkN3KCyqr9R2RDVzOutxw7Rwn
 dELICb6CRgLWOawSDzZyjAkGNWXTZzCgXHbpqK7O3/0nS5t9knvKssOTsSiMsw7FhNAqSG6YD
 0rihm5AGuLrY5gic7qAb3RrsPbfcfiyKjW7ZNmJNUrMMExr9RhVnZ4mj4xGx6Z+1LnoOW1xgi
 OldkXh4hL4MDspMk08AUZ31ciyacTgHZMoQwffKldQTtZQp/LfnAv/eTDD64J3v2Ysk7jNa/f
 ZQimrwIZ/7Wcnige7qDaxT6onyKMzVsIGvnOBjvftDSYBQgjWXlaN1FiktcY/VbeSvKTKuf6z
 YHlpmNZYQStwKFdiN0b9sf69uSK5YjdzA40RnB/8wRYpTAIYjD45g96DJ7k4TGssv84rq7mLx
 Skoep3Eo2EVnTntcdRsgiQXXxnwH98OoVAcnNimQnLXlfko6L4AdWlvXEIa0ib/ueaPd+tnwu
 ANHU0n9gl/Yr0w9Yz3s7EwxHuMsew8PqWYuWndU4i29+kaJhSjlN3D8mljoIoO0siPHTDuwuk
 KsB0WxKeIml38reflSX7fvaEqNHm5DGI3nLrv+XEo7dvTurAOFmpCnPIwqJ9MOQpHE9z/Aw2J
 X8a23eZy2Hy7kPK2+IyKWtpw1+6h/5o0XKaUKrV0M/Q/jvdMMtx1Z1Pw3l8JnF2ZooYqEYOU4
 NVV03iJ3YQw5cBJKFOYpLauEOCF9vyAbJC+aIsYb0=
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
index 41b91af95afb..3e1587d8320a 100644
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
2.17.2 (Apple Git-113)

