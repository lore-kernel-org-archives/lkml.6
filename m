Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F97C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C291A20821
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1q8oisa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfBHBtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:49:02 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39333 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfBHBtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:49:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so852861pgp.6;
        Thu, 07 Feb 2019 17:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XyA2pcmvE6gX2mfRHI2i1cBV8kEWCuMwrhdJsU/m3ls=;
        b=j1q8oisa0nyB0QEarbzW8nsR3e9TzKoP8A8vMzq/BUNP/6b6eze6yvVRp8eUmzTxz4
         EITZx06j6PL6bvIzz9U/NGjckypgRuQrXwInHldjS7e+acFqAMWxhvJmZtYuWcEDDoH2
         NAslSpBcVpBJtgrc10CHOw1uiK/d+UJlmg30lj6WC8/Bof/5NDlH5VwqnLWvRteIws2Z
         /6qe/hHcE9q3g6MuW7GueycD9p3UMcGWzAfyNYdJLjvGCbvnoy40kVDQggYcjNdpu7i6
         iIHLwxWhrIm0nRHyFiRagdCvOxcpHpe+z6fAQoYoBVwX7xw0izlmbR1ilBmUJirtdwge
         Iiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XyA2pcmvE6gX2mfRHI2i1cBV8kEWCuMwrhdJsU/m3ls=;
        b=QJ0ZmkGXGecDuXwK6S+qUdk6i9GK2BiEwAu1wOfaK2hdeGNk2ABWWQW0jrPPMcc2kT
         GyNkIftOGyfmQP5XElrVSzRPICdr8650F4Z7gO7lRvj55rYp2+kE86iqjFU5WAJbOn+J
         y7yjJdaH0DIxF7cot+xrJJaTYxRxsxN5OmieyGD4ZRyeeZxUwA+6aMOYnKCAc+V988NH
         aPhT0mDctLT/RzgF2CCaGaBRlXe9UTPj3xkDlduclBnJK3xDI2Dmdu64TIP/Pf6j+UGz
         o4MoeGOLK6mQyVybIm6V+zLNZVs2Lkw3obl7noXA+LMAHu9HfizPFbNS3hJoqTHRjVRQ
         l+lw==
X-Gm-Message-State: AHQUAuYM8r1qIvCQle870UWhK7Fx7oQD8xiwqRoOUjpfV9VTD/one3X3
        QZ+Odf3IV/eTCxiMksTW/5qm5u+A
X-Google-Smtp-Source: AHgI3IbLkY0FX3sX68rMRfP4cN//It8LcXWJbYjRLxbOpGwPvmgsdw7Smqif0Vh6PFRza0sqq7B1dg==
X-Received: by 2002:a63:2f86:: with SMTP id v128mr17369855pgv.407.1549590540719;
        Thu, 07 Feb 2019 17:49:00 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id 24sm518945pfr.75.2019.02.07.17.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 17:48:59 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] xhci: Use __ffs() to find page size in xhci_mem_init()
Date:   Thu,  7 Feb 2019 17:48:54 -0800
Message-Id: <20190208014854.22437-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get page size order using __ffs() instead of open coding it with a loop.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

Changes since [v1]:

    - Code changed to use __ffs()
    - Added check for page_size == 0

[v1] https://lore.kernel.org/lkml/20190207000349.7816-1-andrew.smirnov@gmail.com

 drivers/usb/host/xhci-mem.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 36a3eb8849f1..4b350125e1cc 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2362,11 +2362,7 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	page_size = readl(&xhci->op_regs->page_size);
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"Supported page size register = 0x%x", page_size);
-	for (i = 0; i < 16; i++) {
-		if ((0x1 & page_size) != 0)
-			break;
-		page_size = page_size >> 1;
-	}
+	i = page_size ? __ffs(page_size) : INT_MAX;
 	if (i < 16)
 		xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"Supported page size of %iK", (1 << (i+12)) / 1024);
-- 
2.20.1

