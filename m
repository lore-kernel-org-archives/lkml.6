Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6BAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90226208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Td7fbzWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbfAJReX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:34:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39464 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbfAJReU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:34:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so5108107pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=scRXab2BdItzSN7N1dJ/E1JYLmZRr6aPorQ+GwZ0j2A=;
        b=Td7fbzWkPt9bckm0kS6rnBoYHYHCKlvh7QFb6oOn+CCUeIMD/22IHUq8NnzFbeQurk
         MZxTslUUWDC/6JSxlE8MF0x5AoQbDiXjD8B51boKY3w3AvatDNBwIxZT1dzm0KD4COmg
         /iMTRtaWvDAc7EhrwQ7ncDznFDiLAtBfNTxlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=scRXab2BdItzSN7N1dJ/E1JYLmZRr6aPorQ+GwZ0j2A=;
        b=KtFvS58BOfhuZoe78eF/q9xj8ptofRPmcvfoepDUg3Lb/1L35XGahcYSxOQfNVSfBV
         BZJ4IqTA/4Z6iYAR+OhBEzqR8LmsZYkIKQyN3WkgcJta0wniy/8LPTXbexs9e/nTxm0C
         rknacpcPtwe6kOdLZSkpY7azf7Bo9bPoo1wjH5Rek/ljumuAfZIAmChnRAzyeoJBdvRc
         nG9stUiXXjpmagVeVtzYDmm/MqUfEABdag0e3eppKVz1VUjDHzvCfLwEujbG6WJFlI9T
         pwOmgb+2KWyhizGHpwgV3Fn+0wdhLPvLiyl7IaCo3bZGCnIdN32f0Qf0Ws+bdbQXbJti
         dLXg==
X-Gm-Message-State: AJcUukfy6IDrBaXdkplmehfXaQYMLOLFshCJcoeBO01+daCqRyZvdavG
        YbZXN9UiQSUeb88L1oyhAtjtr0LWDF9HYQ==
X-Google-Smtp-Source: ALg8bN4pGFoTbckpuD5ANArZkBTvgy0LhUQwq8LqprlEYCoap08zvU2dN6+zVMogZ3wsWiy0xyRPBQ==
X-Received: by 2002:a63:5518:: with SMTP id j24mr10037682pgb.208.1547141658464;
        Thu, 10 Jan 2019 09:34:18 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id k15sm125977409pfb.147.2019.01.10.09.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 09:34:17 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 2/8 v3] Documentation: bindings: k3dma: Add binding for hisi-dma-avail-chan
Date:   Thu, 10 Jan 2019 09:34:06 -0800
Message-Id: <1547141652-8660-3-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
References: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some dma channels can be reserved for secure mode or other
hardware on the SoC, so provide a binding for a bitmask
listing the available channels for the kernel to use.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: dmaengine@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Renamed to hisi-dma-avail-chan
---
 Documentation/devicetree/bindings/dma/k3dma.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
index 10a2f15..38825d4 100644
--- a/Documentation/devicetree/bindings/dma/k3dma.txt
+++ b/Documentation/devicetree/bindings/dma/k3dma.txt
@@ -14,6 +14,9 @@ Required properties:
 		have specific request line
 - clocks: clock required
 
+Optional properties:
+- hisi-dma-avail-chan: Bitmask of available physical channels
+
 Example:
 
 Controller:
-- 
2.7.4

