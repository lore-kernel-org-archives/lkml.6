Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C07C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120B2218E0
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZNzDxOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfBGAD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:03:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37577 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfBGAD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:03:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so3913530pfb.4;
        Wed, 06 Feb 2019 16:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V0ERADXv9Gz9O1kdLx7xVCP5bUz3nHAwpxglz9jFLK4=;
        b=mZNzDxOk4VnC/9IPoKhWZFCbKZOYo2fSLji9eYT2NUenK0LrEyNAQLLijd7RAoHnGZ
         ZVE+Q2GTrWdt21x1OHU4cU7qtax+r4t1sFfqG9FxSjgErsqSmitmN7NTmtRIW+kk63Xk
         55+TiliE+d6A5dGTTOsfLR2RaWSQsMzD0QuTEh9ru7MLhwqzvzoFeOsvv9v7Lg1Uv5sa
         TLZtw0ifSgeC0BfknaF5FOC2MWsnJrCyj8ij/v+P24o4cSOjsv0BowVUFFG2UeupLhFM
         IpDggL/TD6XfZoRsyVLrMp+3rADMFJFkHTzubvEA29ZkG8y15Fmf5vLkZZu5u7vc9R5j
         HTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V0ERADXv9Gz9O1kdLx7xVCP5bUz3nHAwpxglz9jFLK4=;
        b=s8eKEYPenzZdIa9XAVc8H7jPw27kYrE2hmpUtleihF3eBCl3Gq6kdI+gMeUVXebcQt
         mKFkCsTQOirFmCkBQMXkh6Ci6BHs9IlglceChZnOWQMQ8R6FjdCjoc992un+wwjAiWHd
         05SfWuqLl7mkEJi/nFix08nZkI5oi1QXhoWCosxqEJyVvuC1Ds5Ox3MkPoBC159OPaoy
         QI9kEnQYMBJckH8ZdVaVQxTO++c7Zwvuf7zWheHD4oWgd4SNbUeXtqoRmwxFnd2Tbgp7
         xNmZuLpTwLrDD/iwmPAMLnfYdOyKgDIDONSLjMTr1ePfGAE40j8W5+xGuTA5BwhX4d5S
         tnVA==
X-Gm-Message-State: AHQUAubGVA9vQJmMqi827O9kOEyKE3/u4D+qKOEaA0opYfNVpZsJACq1
        JU8oEkuyXE6CJEE8FiwyQJTJTRsW
X-Google-Smtp-Source: AHgI3IbLTENHgEyPwbcpt0zk5zZlU/018G2eGFtA3OKPnNhjDdRaNPlld0Q66eIQ1jmq97lF4JFRLA==
X-Received: by 2002:a63:374e:: with SMTP id g14mr12361159pgn.59.1549497836082;
        Wed, 06 Feb 2019 16:03:56 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id f8sm5639853pga.24.2019.02.06.16.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 16:03:55 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xhci: Use ffs() to find page size in xhci_mem_init()
Date:   Wed,  6 Feb 2019 16:03:49 -0800
Message-Id: <20190207000349.7816-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get page size order using ffs() instead of open coding it with a loop.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/usb/host/xhci-mem.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 36a3eb8849f1..44b43c3d819f 100644
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
+	i = ffs(page_size);
 	if (i < 16)
 		xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"Supported page size of %iK", (1 << (i+12)) / 1024);
-- 
2.20.1

