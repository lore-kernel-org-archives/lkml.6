Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C187C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167E9206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa8G6Qhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167E9206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbeKUCBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:01:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39017 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeKUCBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:01:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id b13so2434049wrx.6;
        Tue, 20 Nov 2018 07:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jsZEbtzXddStkl/unoxEn2IHJkwc1Or+BPoxoA+8H3A=;
        b=Wa8G6QhjCgbGTqH2W8tarvEcnjGMz5zbWAFsdzQGX5fnTdm4nIhf5FsyiyGzWTmyiM
         7102qjHPi8R5PqUAfcELqNSXgXNTVIB2qZqnItiwkzl2/KmTtqBhNuMHXVGfFNplqjWk
         hHc40pebYbkGFAX57D7lAndSxA2gUnmHv+5Ft1ytF9p7CZ5vCGFzDgkTsinF8NnFWlHM
         pnBDFnMOtaE69VqO7SYu0rKsgcuDKa8fMoo5fb98E2TnGSOXOSGr5wP4l7nuZWWaBbp8
         9Xs85xKK3tZyrLRtZ1/S0JRA5S2U0SVuUzI++Ph/Dtgh+3yGYkThX+8k2lPchmu0uRL6
         ha6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jsZEbtzXddStkl/unoxEn2IHJkwc1Or+BPoxoA+8H3A=;
        b=IURFR/ETOQJqedyfsMp0RhsX/2pbxL8YSYI41Se64UtIJQWEMMfzISZHep9vZez+gS
         GKuJKX5Qdnji9+sLqGitOUSGmv/cllFkxu5oabM5nbDQSgMpGN+KrrNqufiDj2zYKHJE
         lqanTk5BLp1P5oXixE9f6UMhXh+mpO/gNz0R95k4oa/9q7LaZhFfc8adV1ru+4D7dzqQ
         zH4vi6iUjMyEGmhUYH0A/jrsyA5S62bHuvS/kG0i21dscXY9Lr1jQPR0rm8GNT5b41A6
         UtRXnVYF06ehGwMdyEtvzo08BSH5fUZBTLWQ9JzD/dcuftzEuz7dK1zQqLOt808+MYiQ
         bX0g==
X-Gm-Message-State: AA+aEWYXA5N04Bsh0droowUivHv/I3KQucC0GsGIIt88IRAyN4ivOZLa
        YTncZjTmzE8xoDVLyxPz5P+GOHBkO+U=
X-Google-Smtp-Source: AFSGD/UXkJZ9njMmidYgkjklo6d1AqHtmcoTv7xG13KlDc/a0/+VAH/tOVSP7n2CT4BOdTQH2wWLBg==
X-Received: by 2002:adf:ed92:: with SMTP id c18mr2435677wro.194.1542727925804;
        Tue, 20 Nov 2018 07:32:05 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id k73sm14677464wmd.36.2018.11.20.07.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:32:05 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v6 6/7] dt-bindings: dmaengine: xilinx_dma: drop include-sg property
Date:   Tue, 20 Nov 2018 16:31:50 +0100
Message-Id: <20181120153151.18024-6-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120153151.18024-1-andrea.merello@gmail.com>
References: <20181120153151.18024-1-andrea.merello@gmail.com>
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
Changes in v5:
	None
Changes in v6:
	Fix wrong property name in commit title
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index 2fce9fb4b270..93b6d961dd4f 100644
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

