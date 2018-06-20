Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762B4C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2877F208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5WEUZn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2877F208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754801AbeFTIhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:37:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51283 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754788AbeFTIhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:37:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so4575217wmc.1;
        Wed, 20 Jun 2018 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6nq5Egk6SkOXwkfaidMz/nOMtwj3QnkiTUu9x4Xq2UE=;
        b=Y5WEUZn8k1z71vkCn648xg1TA3nGkFajYLtSKdCCSIgt3nR0A/K7IOtM87vlLJhV2b
         RQOpUoJ1uv9jYJavTCyyu9l6LafC4ndCgWzdj1gylMTfG5gU+1RkwBOLDVEChRPEyI1E
         7TC6MSL8qCr/3bINEodoPRYrzvYzS3hItkYWzwxld31fT76jBsNfFZTGsUxFwkGrGeiv
         jkw25JcqbzuuHSvP9Rnmdbx5erXiyq/kKLYwORByXur+ioEUxnsS/b3FAHZ4a3zIicBT
         8lr10XD/UiRnQSVJSp18FPDjHdeKgZ6w56KB4P4ecVfpXaL5mV2azXdyFYiwzTkrWxxE
         7VQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6nq5Egk6SkOXwkfaidMz/nOMtwj3QnkiTUu9x4Xq2UE=;
        b=ESlDtrSeWaBc1L1Fcwbs71p68pCnPWA/xU6HWopoFQTj4xZxGjfBy7qgTyWGQqaLlk
         JHcPRJH/qAF4TpO0z3XPs9tW2fbXnaW1Eiipaxxv9iIjHe/+DtCUgei2NrXq3TWjLx+5
         BrfOXZw3EOvTCodklWlpRVLdwt9R49x7+Y0rMqwU/YvLwRkU1VFrLFgvqs+KjI5q/rW5
         eOYLHKzwDvNGRoIhaqzXW+Z5Wj2uZ6wMa49sq0ORt5y30tJoF09erTZspVphNkXwFfFF
         dEOPVUPEEP7a2wvDiZJss2TYRChq+4hlricSf3wH5oYCWrHVOXjiRiB7wODlg/mY6KaT
         OT6g==
X-Gm-Message-State: APt69E0eYqcSkBih4q60e77VtpmZBJjuHpgLkhWYg6ar1o579/iK+Ppr
        XcdrwXg5jWoeaeGGvsm57yI=
X-Google-Smtp-Source: ADUXVKKqiDhtnYan2zAlP4Pg2LCdHNRPYkovkDFA6hm/xVBAlLF/52y71mh4PmhLTMl5Fs+XAOr8yA==
X-Received: by 2002:a1c:ed0d:: with SMTP id l13-v6mr958072wmh.73.1529483830965;
        Wed, 20 Jun 2018 01:37:10 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id f24-v6sm1615933wmc.0.2018.06.20.01.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 01:37:10 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 3/6] dt-bindings: xilinx_dma: add required xlnx,lengthregwidth property
Date:   Wed, 20 Jun 2018 10:36:50 +0200
Message-Id: <20180620083653.17010-3-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620083653.17010-1-andrea.merello@gmail.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The width of the "length register" cannot be autodetected, and it is now
specified with a DT property. Add DOC for it.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index a2b8bfaec43c..acecdc5d8d47 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -36,6 +36,8 @@ Required properties:
 
 Required properties for VDMA:
 - xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
+Required properties for AXI DMA:
+- xlnx,lengthregwidth: Should be the width of the length register as configured in h/w.
 
 Optional properties:
 - xlnx,include-sg: Tells configured for Scatter-mode in
-- 
2.17.1

