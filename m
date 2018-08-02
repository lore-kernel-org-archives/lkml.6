Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F560C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2849F2150E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hovCdr6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2849F2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbeHBQBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:01:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53581 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732533AbeHBQBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:01:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id s9-v6so2688141wmh.3;
        Thu, 02 Aug 2018 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OFumUdGhZ7/Qo2AF6h3QVzXCRrFVnDrRwV2P55v4HHw=;
        b=hovCdr6bLm8TVWK0kHNpxnn89wuopWV6lIn6LDgsezkq27AUiCy7HZbs+XPWJkjVYx
         gqdjG83yAZN61ra0sWZoHUhd3+6Lh6i3hvq9vInPkIyVOlLw6zWpDJ6CX21VAqxMCPjg
         HkHDXD4JIMOQvWmMSyvMyFanuCE5JvSZvQfJW81S3k3HlqLEkDpIdPLtGuYmfxCQwPbz
         bUMCebnR6n1ti9EeWOcn7DWuEiQo5Xrm1D9G3EFpoUFSYJhUHAs+xfFShJdWvmFNUmQQ
         fA27bytWg0PoeAW+M3J1woYl93UVg39dyruCG5KRXdtDS4KQCJiTN+pElddRXa3Zn7+t
         q9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OFumUdGhZ7/Qo2AF6h3QVzXCRrFVnDrRwV2P55v4HHw=;
        b=j6JvXUQMopc+eDYx6+dFpFtQNbIZFki1Dk29XPsV+DPsYH79rP+RkXAbBD61o+Nb22
         59p51QzFgR3xXqBt2p8DgZshitslRXfB/eq7FsI9jM1jBvw7V63XVBwLH4ozXdq5529C
         eACRPmMLvvEl4E0U148bQePKLYHzVIM3hMBw/4PdYw8ARePcY7NNML1Qu7udnX6pKO4V
         ywS/wIMVpKkwfj4K6BO12L3fXpB4SUXp5KNdV7xX11Bmqfhr+PLswaBR4ger1f42ywvw
         YrSkTqgwZW0/wnAzMSBQcEx9oWoRAYF7vkOEXjG/WgRCNLOv2mO3BbpLXfCKS+H+GDlM
         g0fg==
X-Gm-Message-State: AOUpUlFICKiqDwZdiuaqLVQMzyyguixJSug27KgH0fpmWOpe7VcoKnnK
        u3A6+9llf6H2FDct+y4KA98=
X-Google-Smtp-Source: AAOMgpdyoZdKqc7ohkKhpoBeOYM5vOxXsdCI9oH9ErfvQ7HlkLtn+f1uZBSMu0O/Tcx8KAns2AexTA==
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr2198153wma.143.1533219024796;
        Thu, 02 Aug 2018 07:10:24 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id d78-v6sm3392310wma.37.2018.08.02.07.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 07:10:23 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     v4-000linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v4 6/7] dt-bindings: dmaengine: xilinx_dma: drop has-sg property
Date:   Thu,  2 Aug 2018 16:10:11 +0200
Message-Id: <20180802141012.19970-6-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802141012.19970-1-andrea.merello@gmail.com>
References: <20180802141012.19970-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property is not needed anymore, because the driver now autodetects it.
Delete references in documentation.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
	- cc DT maintainer
Changes in v3:
	- cc DT maintainerS/ML
Changes in v4:
	None
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index aec4a41a03ae..3051bc3713c6 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -37,9 +37,6 @@ Required properties:
 Required properties for VDMA:
 - xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
 
-Optional properties:
-- xlnx,include-sg: Tells configured for Scatter-mode in
-	the hardware.
 Optional properties for AXI DMA:
 - xlnx,sg-length-width: Should be set to the width in bits of the length
   	register as configured in h/w. Takes values {8...26}. If the property
-- 
2.17.1

