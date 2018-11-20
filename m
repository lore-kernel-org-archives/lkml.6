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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A7EC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BC520831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6QOMPNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BC520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbeKUCCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:02:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33558 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUCBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:01:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id 79so5272299wmo.0;
        Tue, 20 Nov 2018 07:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SxxJgmbLU8DQm4q7pBzucwRse/NWd1WEcuZvJUw+NKI=;
        b=U6QOMPNJUyhfC/t+E0nqJFlqLMKQKzaoeT366uCCF1TyI92BG03x7DFM04vXwIE1Ji
         sCDCWvteWf3q7ZWdFbBqJ3e6bV50Fy0idU8XJ/KMZvo4CqAbszPFPwBxKB39W5i2vxfm
         H9ZcMvq2iLFseuYaNaxQiEf/HP988C7/VbUZV1lox/9vlE33Q6ymBCfIPY/55aSMh6Ke
         U+zAOlUhzAFXTS8k6eMCRVjd2yAh4HOHsQrBiLIoa/gtoutKFwit5aARaUTw4caMM0Vz
         w6eZ1qq65QKqUcOfzVPyK17o3XdEnGkAL1z+7g2i9sz2KMrl/ckhZroNeJitqUaoSMBm
         RLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SxxJgmbLU8DQm4q7pBzucwRse/NWd1WEcuZvJUw+NKI=;
        b=U69Qt54nBbvo//ACs8eykhpq5riRMGuQW/sef4FFUlAUy1AVQKrhG5Eiqf2nrRveXO
         vDAuG38gOv/U+UeC8qenZEiqL9ScwQPFlNUjGkziOYQDqOYNY261jEiKT6fnrjYBNiGw
         znpjWBcKpeK+FCBaahwvDf2WZsxN0lpMnM1GjS74Nlo0yaq3vPJKrT2YLWcpC1PV3jiv
         sZ+K8g89j8tMihXG0hGW1F7aqyJwTRtlpyFIJ7aCL9QqgMtI+8QWhJ+x+U6fVP1+nI6T
         ICGMRoUM0JpuHdUTwQxuHTEiJtzke3g/wGZud56bUOY6oNfzY4NK5bCHx39PcA+2ho/3
         BkIQ==
X-Gm-Message-State: AA+aEWYMb7f+6xP2raNjLCrxxuJwM8EiGkc9UbclCsytfAYJNuIzt9Tx
        l2B5svchlfHFhHdKOvIUszs=
X-Google-Smtp-Source: AFSGD/UITQpPW0oxdnxd9LS+wO5wcZmacLQ4zsE094U9DFK8WoHB2t0iXybI3xpcq3qOsRotRqQ+2g==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr2485909wmc.5.1542727921993;
        Tue, 20 Nov 2018 07:32:01 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id k73sm14677464wmd.36.2018.11.20.07.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:32:00 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v6 3/7] dt-bindings: dmaengine: xilinx_dma: add optional xlnx,sg-length-width property
Date:   Tue, 20 Nov 2018 16:31:47 +0100
Message-Id: <20181120153151.18024-3-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120153151.18024-1-andrea.merello@gmail.com>
References: <20181120153151.18024-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The width of the "length register" cannot be autodetected, and it is now
specified with a DT property. Add documentation for it.

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
Changes in v5:
	- commit message trivial fix
	- fix spaces before tab
Changes in v6:
	None
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index 174af2c45e77..2fce9fb4b270 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -41,6 +41,10 @@ Optional properties:
 - xlnx,include-sg: Tells configured for Scatter-mode in
 	the hardware.
 Optional properties for AXI DMA:
+- xlnx,sg-length-width: Should be set to the width in bits of the length
+	register as configured in h/w. Takes values {8...26}. If the property
+	is missing or invalid then the default value 23 is used. This is the
+	maximum value that is supported by all IP versions.
 - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
-- 
2.17.1

