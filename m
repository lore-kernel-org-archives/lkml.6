Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34464C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA012150E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbFaVvW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA012150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbeHBQCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:02:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46032 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732141AbeHBQBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:01:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id f12-v6so2258012wrv.12;
        Thu, 02 Aug 2018 07:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nFjdJlN5uSi6gOX8L6ohs2T0Z1o07cnerZr+JKHCTXw=;
        b=cbFaVvW0btnyTVvGDGO5bp7mlpsgQvWqMQH60G9TEgiorzDNv2PGcTGSf6ERmNxnBt
         st+PU+gao6VD2Z6f0+7zGjwvj1lCDzk23p5lpRL9mCqH4D6YQDyzqi7heq/zKzMZcMdo
         sQe5QX9u8qSPa5QWISzno5UbqOfyMCjFz4dhX1gI0w8E8otqmS/JCaWWREGib80vKG+3
         2VCwBqRggxFLLEEyLLfMYP5Bglnc8EhvyAC9MO4ZALFQFRtaa7cKVmlD2Usnb5ebUu8m
         CByk/QlxOgDiYLK08m+M+lC/ykxzKrbqHqLRtvpaNHSJ7xc/2+neCN2SFtdWJ1EmPkvb
         7/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nFjdJlN5uSi6gOX8L6ohs2T0Z1o07cnerZr+JKHCTXw=;
        b=cy+JvX2I4lMzTnPWH5rXy0FvWicLAPISKvtfJN5/rxYgnka6mUVX11CbSaYJ0Q6kE7
         SmC9efXupK1T8POIGM4Tc8VVe+TM5VlK5+OolVcn2ZBh7PQzfe2cA0BKNw31s6O1fl84
         axpNI3oApNGKAJxWkYyr3ZUFLye59ZSYBiy1EegLa4V+NvEnSapPPpdfU0h+B7ak8oyu
         9mhwVtI2JOgXcOXaKD/OFS30acnWkMzXFEV4gRFZMmLvfpuW4hACuJXDgMXQY3+ydA7P
         VYSaDZYe7kA3A+a/5bwIrvtwgsqsIR835+kCClu1060OGg6U32ILRTuHjeBP0ZDlZsON
         hviQ==
X-Gm-Message-State: AOUpUlFXgcWrcSZ+B6USiyxn3ZrSEytQNF65QIcuutFbhbi+lkxh4woP
        /6kdsEu0cZnxQFzJNyCqBMM=
X-Google-Smtp-Source: AAOMgpdWXb+mP99MCpxjkJ1+8hOIjMSRbQSd5gFr/6NHTlLRQMe1w+wIJ5XC2oCtNBK1O7JsSmFM8A==
X-Received: by 2002:adf:88e3:: with SMTP id g32-v6mr2015453wrg.62.1533219020734;
        Thu, 02 Aug 2018 07:10:20 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id d78-v6sm3392310wma.37.2018.08.02.07.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 07:10:19 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     v4-000linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v4 3/7] dt-bindings: dmaengine: xilinx_dma: add optional xlnx,sg-length-width property
Date:   Thu,  2 Aug 2018 16:10:08 +0200
Message-Id: <20180802141012.19970-3-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802141012.19970-1-andrea.merello@gmail.com>
References: <20180802141012.19970-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The width of the "length register" cannot be autodetected, and it is now
specified with a DT property. Add DOC for it.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes in v2:
	- change property name
	- property is now optional
	- cc DT maintainer
Changes in v3:
	- reword
	- cc DT maintainerS and ML
Changes in v4:
	- specify the unit, the valid range and the default value
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index a2b8bfaec43c..aec4a41a03ae 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -41,6 +41,10 @@ Optional properties:
 - xlnx,include-sg: Tells configured for Scatter-mode in
 	the hardware.
 Optional properties for AXI DMA:
+- xlnx,sg-length-width: Should be set to the width in bits of the length
+  	register as configured in h/w. Takes values {8...26}. If the property
+	is missing or invalid then the default value 23 is used. This is the
+	maximum value that is supported by all IP versions.
 - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
-- 
2.17.1

