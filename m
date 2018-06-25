Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB835C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6367B20837
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggqwbo9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6367B20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755077AbeFYJ2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:28:24 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36030 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754796AbeFYJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:27:55 -0400
Received: by mail-wr0-f195.google.com with SMTP id f16-v6so12914122wrm.3;
        Mon, 25 Jun 2018 02:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mgO40f8n9w89aHcutaEUj7o5V6BOx3gjAhX/RR1Z2pI=;
        b=ggqwbo9X445+VOVkaiYvQVTpFixm28l2ilB7xKIpBu1Y1KNrz3Aj7xumwN1O4lUU7s
         zYIySIIwj31Bzy6YeIJfLEl/S2W8bOoA82WH685J7nqGu5mMdZBlUr3SGCvnqi4qnsZQ
         DqaEQr+Yk32oXAGfNXBHUuYSBHdf3Iy6zDas50E0ZqqSZRseGXwOZMSUogiRnSZkBkD9
         M9MfJYP7LdV0HDGSPrvQ7uuvxHcibrDIGKd+Gb4o7OfX+YDxqRigvO9ORTxycb9lf01x
         ecJ3aG5lNWg5xfYiWbqnWp3P8bBcmRlNje4HPxAQU7vHxpUeOljRvSzkd621J4H0i/IE
         CF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mgO40f8n9w89aHcutaEUj7o5V6BOx3gjAhX/RR1Z2pI=;
        b=gWHuc507ADojy41xo/UfYAC5BOF3KwAcYAAe0Vm2V+0vRfOQ0BjtKePJDJxVHEUkAM
         cF6fQUT62K5DAJqLaaemg6XloSWl0H2FVoSjPuRGtN2DxK3r+mtsK17QtobkjL8dp5vT
         txv/Q4aota4y7HXa+NDWsXV7AbcirSbZcnwqSv2PC56IGWIBF7j4syspAtn6ZHlTIx7x
         I+1hwZaNgiZX9ZNVm8h39pu57iEw4RcuXl7BhJ1mejDnlHdtZQTV19aaY9eXV1jpjnTI
         5P6pz83l2c22p4G1doskYdZfkUFWbQ5BezuJLFBPY3z5EQcQFWr+3zSicIKGCdRjt0Hc
         StqQ==
X-Gm-Message-State: APt69E10thlbJW8vjA9xptziHx8w6zzpycNPujgTEWovUym14S42qLC/
        v/uKxeuX7rhOhJgGb1aAjeOpLOQ0
X-Google-Smtp-Source: AAOMgpddR9+IVRjvYuyyUoXaRtfwInoYRWGBASNqRE2iVH1sF9WvHUYshaxuIoyvfOYyhb+AaH1B0Q==
X-Received: by 2002:adf:af27:: with SMTP id z36-v6mr992674wrc.59.1529918873117;
        Mon, 25 Jun 2018 02:27:53 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id v2-v6sm15638779wrm.84.2018.06.25.02.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 02:27:52 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH v3 5/5] dt-bindings: dmaengine: xilinx_dma: drop has-sg property
Date:   Mon, 25 Jun 2018 11:27:24 +0200
Message-Id: <20180625092724.22164-5-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625092724.22164-1-andrea.merello@gmail.com>
References: <20180625092724.22164-1-andrea.merello@gmail.com>
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
---
Changes in v2:
	- cc DT maintainer
Changes in v3:
	- cc DT maintainerS/ML
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index c894abe28baa..09a41843cbc0 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -37,9 +37,6 @@ Required properties:
 Required properties for VDMA:
 - xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
 
-Optional properties:
-- xlnx,include-sg: Tells configured for Scatter-mode in
-	the hardware.
 Optional properties for AXI DMA:
 - xlnx,sg-length-width: Should be the width of the length register as configured in h/w.
 - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
-- 
2.17.1

