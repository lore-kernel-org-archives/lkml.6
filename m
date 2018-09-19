Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1005FECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B642E2151C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgFM0L3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B642E2151C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbeISULb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:11:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42780 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732354AbeISULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:11:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id g13-v6so3104889qki.9;
        Wed, 19 Sep 2018 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=49XKRLw+VduGtPPfO5f283By1unVPESvv99WdhGdEis=;
        b=kgFM0L3QHkfGQBVXtIpT9ptsYwFJwWGEmuhV0ZbZUlp5B6TsA8/bVGYb5eLS1eQ2oa
         CH/h4VJmumEZnhAg6MTmvu2IDJEv9CYechTEK2pRGLook2md4EwyfDmJnQwvJee0uZQg
         Pj9E07bSWB9FsjOKMqCPzdYgBpQLt2Xkp4FeUcpEkS0ffHwZAYnlJMOjpYXGOr78W+/g
         FSUGD6NhEma/Ix2mX6tC7mcTu4C4oh/ZVgHP4pv5PpQbmGIW6NbXvkaBm2kAFcp8+ZvT
         /7rMgMnqyOOfhKsYWhu2FcGfmfXexd0ZF/XU3ZQNZqdeJTTUvs7iUn8Xg7L200f/JrdX
         DgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=49XKRLw+VduGtPPfO5f283By1unVPESvv99WdhGdEis=;
        b=i54xsYLyrlQ5sbenrLCQKZEozshgvEolMX2sHalGMo51xItVjz2cCbdUx5/lYFZfeD
         6DXq5PcypM2dy+58EHKnYka5mZHwxVTpXgbgAf8agvXNOL7A0hRITpQNjZqZCH1IVkjL
         dz789GhmMzQFO4hNUu6eMiJBiDoLBLQ8rrP7dRK7RAn7MUSerlj53itxxfOKRaC0S1pd
         FEkUMjxQ9H702DqaHeVtqUsBe+nwQRjXzIBRyrnZuA8TZ/Oy3fpDSMPeniplttlqL2iZ
         S9mlbScOfCSpPp6X35DACJojdUMhAkUVkemV3rCYRoc75lBvG9YhWlbO/Xd2LsGLIaFv
         DI2A==
X-Gm-Message-State: APzg51BRdUrWvnvqJopfO6+YC3G0tf9+UHB6xXcWw/arWL/VrCH3D1Jq
        TFD6xHh1j9huyHY0sVyEfHjt3nQp
X-Google-Smtp-Source: ANB0VdaiDFeciKw1cUxW3t1hRcQjovaiumeyktd7Hfme4GoD9pZOg4NRT+gBRX55hJw1Fo8HK8oKJg==
X-Received: by 2002:a37:6e01:: with SMTP id j1-v6mr24482787qkc.70.1537367598263;
        Wed, 19 Sep 2018 07:33:18 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 17-v6sm2104051qkf.74.2018.09.19.07.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 07:33:17 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 10/12] ARM64: declare __phys_to_dma on ARCH_HAS_PHYS_TO_DMA
Date:   Wed, 19 Sep 2018 10:32:05 -0400
Message-Id: <1537367527-20773-11-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change allows one to define custom routines for __phys_to_dma()
and __dma_to_phys() for the ARM64 architecture by selecting
ARCH_HAS_PHYS_TO_DMA.  This is done for similar reasons that caused
arch/x86/include/asm/dma-direct.h to exist (see CONFIG_STA2X11).

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/arm64/include/asm/dma-direct.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 arch/arm64/include/asm/dma-direct.h

diff --git a/arch/arm64/include/asm/dma-direct.h b/arch/arm64/include/asm/dma-direct.h
new file mode 100644
index 0000000..d87da92
--- /dev/null
+++ b/arch/arm64/include/asm/dma-direct.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ARM64_DMA_DIRECT_H
+#define _ARM64_DMA_DIRECT_H 1
+
+static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
+{
+	if (!dev->dma_mask)
+		return false;
+
+	return addr + size - 1 <= *dev->dma_mask;
+}
+
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr);
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr);
+
+#endif /* _ARM64_DMA_DIRECT_H */
-- 
1.9.0.138.g2de3478

