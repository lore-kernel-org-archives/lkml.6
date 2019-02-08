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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1832EC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C826720869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lE6bdRkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfBHBsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:48:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45681 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfBHBsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:48:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id j3so893491pfi.12;
        Thu, 07 Feb 2019 17:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kyKqT67Ym+Kxym2IHpFSKTArXrd40CU9Yu3Owt+/PEA=;
        b=lE6bdRkth3zCOMFrggLPHNFPNb0g0Lw6MSZGXx1wSM3yN8NWrzoMbganpEOp3FLKcv
         LjVdhv3tVcb5RPmJ/Ljnh4wq7trvxZcE7pwc8x+ngE3v3clSeA7duQXFGyQUkD7zqygo
         Pn4q24rfKUp54MoDVD5MI13yPY4Q0pXaodXm/V2mB7K9sBsAkvV0Y5cPRVX0/CUXRix8
         GjhhSeXZ25jW+zgszM2CSNrhTuHlnlA+RL9klhvUa+TGn7Wv/RL4Nurc456EhT4wgR4F
         qIQR/g/5WsyuvnU/+MFYkGS8DtbgSL+4cmZZY1MHYrVmDSbGDAyrEdf3oB2en4iYolvc
         auwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kyKqT67Ym+Kxym2IHpFSKTArXrd40CU9Yu3Owt+/PEA=;
        b=kTzFpvzDxZn5yt5WImtG1Cw78Nyc+UGDnHvwGmRaIQcrEN5U+LRk4+NPy7AsuYy3+3
         sJNux/anfF53lJLmKpzz/4NhQQdTV2XyZpf3vVcZODUh9T+Zfs6B9Imtp7V28no4JLDK
         2zcCTkV+Jybr5Tb8hosm8uRvE8sVo7+a9AIbEtnY2VVz96H8SGI1eZ8fwv/eAEabtkAS
         1pVq7Dv7YQBmR85J4L17BdTXpoGiUGaRXSlb4wxM0teG6xaQKa/IquJFJp64MKSfxnuF
         laqcj3v0tw8S5Wnol+Hc7/4ZcEWoW/ShsJytZnj3lYAvcgafRb/F6P8kUkT1s2fL6TDB
         f82A==
X-Gm-Message-State: AHQUAua4aJ6WTPUK+xEh28FkBfskj/c344An06VgoyOWpw4yle9cMkV9
        qvoCVrcjV3L5gTDiELeUsA9uOBh1
X-Google-Smtp-Source: AHgI3IZSLjX7L7BBsm9HhSOa9RSdttal/R1Tfvss4gL9w8rBStkQvErvpyFcrOdYYj5o5x6+7FJY7A==
X-Received: by 2002:a62:4587:: with SMTP id n7mr19303812pfi.118.1549590519985;
        Thu, 07 Feb 2019 17:48:39 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o1sm504266pgn.63.2019.02.07.17.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 17:48:39 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] xhci: Convert xhci_handshake() to use readl_poll_timeout_atomic()
Date:   Thu,  7 Feb 2019 17:48:16 -0800
Message-Id: <20190208014816.21869-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xhci_handshake() implements the algorithm already captured by
readl_poll_timeout_atomic(). Convert the former to use the latter to
avoid repetition.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

Changes since [v1]:

    - Replaced readl_poll_timeout() with readl_poll_timeout_atomic()

[v1] https://lore.kernel.org/lkml/20190207000308.7051-1-andrew.smirnov@gmail.com

 drivers/usb/host/xhci.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 005e65922608..51c25a664ca4 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/log2.h>
 #include <linux/module.h>
@@ -52,7 +53,6 @@ static bool td_on_ring(struct xhci_td *td, struct xhci_ring *ring)
 	return false;
 }
 
-/* TODO: copied from ehci-hcd.c - can this be refactored? */
 /*
  * xhci_handshake - spin reading hc until handshake completes or fails
  * @ptr: address of hc register to be read
@@ -69,18 +69,16 @@ static bool td_on_ring(struct xhci_td *td, struct xhci_ring *ring)
 int xhci_handshake(void __iomem *ptr, u32 mask, u32 done, int usec)
 {
 	u32	result;
+	int	ret;
 
-	do {
-		result = readl(ptr);
-		if (result == ~(u32)0)		/* card removed */
-			return -ENODEV;
-		result &= mask;
-		if (result == done)
-			return 0;
-		udelay(1);
-		usec--;
-	} while (usec > 0);
-	return -ETIMEDOUT;
+	ret = readl_poll_timeout_atomic(ptr, result,
+					(result & mask) == done ||
+					result == U32_MAX,
+					1, usec);
+	if (result == U32_MAX)		/* card removed */
+		return -ENODEV;
+
+	return ret;
 }
 
 /*
-- 
2.20.1

