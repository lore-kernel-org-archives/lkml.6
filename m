Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5449C1B0F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672722075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672722075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967381AbeFSVrb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:47:31 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:33896 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967271AbeFSVrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:47:16 -0400
Received: by mail-yb0-f195.google.com with SMTP id n23-v6so489233ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LC5sN3D4i3c7rmr3NVM7+l7w8yoxwsjrueH4YGTx6Bw=;
        b=H9CxYwriiz2yw44N/s2dI6YfotgSIbxLsoU/XKzE+cw8e8rh6TrXriBpYu0AnMEr9X
         n+qknZwLHIsgWZQZJ1DZPO+8tRlv50NTPusuLaeFP6HcZ03eYgLl9koEPGDVaOQwiBnn
         QTde5sGNDxCW77SSzGPHF9nJhPfTtYPfNAVwpOTBQZsi1xi/iSKChkTKtHm1SferUmdf
         ngNWzPnfwmjALbnSGw1wlFYHjBYJ2E0WaE39Pn3jyoOwYxXi9YLeHzj7twnl/YlFcmPy
         xsaFzGSDF/hv8r0MWCAJMAoWqPXACBBUsaRCDerYXPXDTkKmN+vay1301+h9oD6kWt1h
         VS1Q==
X-Gm-Message-State: APt69E0QSDVJwjxX/xh3iNzYNTDZbeAtIg1i4NV4IsQf0xA1tQcR+X7l
        piGVocrX+82ETIjZJXsqaA==
X-Google-Smtp-Source: ADUXVKLuJ8i9DyLEFpRBFtxIAH7bgHir/IWUJ8F0iE7gvlar1QLWrkqL920xOe7TKU7oRFGkryq+NA==
X-Received: by 2002:a25:7e05:: with SMTP id z5-v6mr9708903ybc.442.1529444835927;
        Tue, 19 Jun 2018 14:47:15 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id x66-v6sm333612ywc.76.2018.06.19.14.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:47:15 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 2/5] MIPS: netlogic: remove unnecessary of_platform_bus_probe call
Date:   Tue, 19 Jun 2018 15:47:07 -0600
Message-Id: <20180619214710.22066-3-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619214710.22066-1-robh@kernel.org>
References: <20180619214710.22066-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT core code will probe "simple-bus" by default, so remove
the Netlogic specific call. The probing of simple-bus happens at
arch_initcall_sync, so the call being removed here is already a nop.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/netlogic/xlp/dt.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/mips/netlogic/xlp/dt.c b/arch/mips/netlogic/xlp/dt.c
index 856a6e6d296e..b5ba83f4c646 100644
--- a/arch/mips/netlogic/xlp/dt.c
+++ b/arch/mips/netlogic/xlp/dt.c
@@ -93,17 +93,3 @@ void __init device_tree_init(void)
 {
 	unflatten_and_copy_device_tree();
 }
-
-static struct of_device_id __initdata xlp_ids[] = {
-	{ .compatible = "simple-bus", },
-	{},
-};
-
-int __init xlp8xx_ds_publish_devices(void)
-{
-	if (!of_have_populated_dt())
-		return 0;
-	return of_platform_bus_probe(NULL, xlp_ids, NULL);
-}
-
-device_initcall(xlp8xx_ds_publish_devices);
-- 
2.17.1

