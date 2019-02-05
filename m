Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B11C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EAF2075D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeS5MbfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfBELGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:06:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32880 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfBELGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:06:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so12247296wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 03:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kftc7L3wb6wxmCweyhvznj9VgfHVcRoDEP/ekrdFv54=;
        b=PeS5MbfWfTHNyEZoNDkJfdhErPEMEVQrjGrYA5DbqQqYiov+Jvfhj5jcniZ0Hk6t9q
         z/3krXXMLvtJj5bSHteXPXgzrefUs1KhZMfPdqIweCb16pw16/sxjPB65iLkMVVYB+R4
         TlSF9IYFbjB6xYsLXCo4z+IZVTtrX+41O6RAx/+kah3Ki0aSYiVMFnirQ9OWWCg3Eic5
         TbrMyBEU9JrrgPmkHwwFfzYkhwx7kOANP25VoR0oOTCNEVHomZHfAPwYdldIMjUMQvqo
         W3uyauFCrDa5CyQ0t0zzlEYZgrKs8g6F68zFv49JiRg+KtDMsdSDjeZAytJZBUA5x27E
         3hqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kftc7L3wb6wxmCweyhvznj9VgfHVcRoDEP/ekrdFv54=;
        b=rCLjnhAbwuWIrwMgm7Onv6V2lqwp0wigVKbTJFrOyMCT/F1AzboZYG4FwsmlG0IQtF
         dHUGKdhD9F1V9oiUd6fpoVc4xOTeOHeyBo5W3hs9tlyRbQG7ZWoARZDpwbxBIOT+cweV
         n6px1upbSdXQJlBmcVR/OcAyZDAyD1Mah6B5xdyt+npxO8nsYyZe7E9P7kkwqbVWcRiF
         n+8oTWsbIsleGeEaKYeQjERN8+MIjlBqiZ2nl+G0+4LS5xG7YREHg1eG01mnJ7tb2RjX
         rOkhWMKXu/UfR4o5phj7rHjn/Nl93E1NoTHzIc5G/JoQiebjFEFj06lUXyHrgNs5N2QD
         gddg==
X-Gm-Message-State: AHQUAuYcuagVtuPuinkd+X7YoxlGivFWyC7bQmj6NvwG7fDyToRICWpc
        0+hQGXFb5EZIiawPxLCwFAI=
X-Google-Smtp-Source: AHgI3IZ+WeLnjap+VFRXtx392/eAzhmnvtrqCAWyM7xhv6o0dkAUuIRAj+WHhNc536A+34Dm6xpPkQ==
X-Received: by 2002:a1c:7616:: with SMTP id r22mr3235518wmc.35.1549364764552;
        Tue, 05 Feb 2019 03:06:04 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id d17sm8210007wrw.68.2019.02.05.03.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 03:06:03 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-direct: Export dma_direct_alloc() and dma_direct_free()
Date:   Tue,  5 Feb 2019 12:06:02 +0100
Message-Id: <20190205110602.27717-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Drivers that are built as modules may want to use these functions, so
make them available like the rest of the functions.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 kernel/dma/direct.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 25bd19974223..f14b7ced4592 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -200,6 +200,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
 	return dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
 }
+EXPORT_SYMBOL(dma_direct_alloc);
 
 void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
@@ -209,6 +210,7 @@ void dma_direct_free(struct device *dev, size_t size,
 	else
 		dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
 }
+EXPORT_SYMBOL(dma_direct_free);
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_SWIOTLB)
-- 
2.19.1

