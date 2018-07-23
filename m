Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A8DECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C326020852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V6wd/YD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C326020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388339AbeGWXvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:51:14 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:51351 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388207AbeGWXvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:51:14 -0400
Received: by mail-qt0-f201.google.com with SMTP id x9-v6so1705258qto.18
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 15:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=LRx61XYR9pf5fEAAUGx24kr7W9bPqHXVvdzSEsUiWQ4=;
        b=V6wd/YD0V2EYi767x7u3LXlGPHc1UkuM/K3vwzAET3rxvfP0Uc40MovK7jlDOrayhO
         TrFfBw+I2sekgYCE0c0UBDbSimZ8EmsLRK1uj1VNqyOCnTKK+YJ3OWcFq4FExev+KbWR
         2yZoJR/h4TtPk138ZuaoIaVCEU3QNzBAP4Dw4bEWK6uLCFOpumQA0IrvM4iqKKyQke2Y
         lUO1P7aNQxh38zxDmnQzatubNp0zx3PiZ5d79DRZPrAfflu5M/IPY6oFCrsuuiHP/kFj
         o+HtTgHLbNJ8pzWOrPUrMskoSM2O9TWOGdH12UH/hNc9fuvZDk/hpJIPYc4c6uWpltN/
         g/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=LRx61XYR9pf5fEAAUGx24kr7W9bPqHXVvdzSEsUiWQ4=;
        b=ZJsnSTQAkhG8ySHQnHHcwV2T+tHM8DrkoC+B9KX2jWgm4iSv3ft+piws0vEtyXcC+l
         JjK3NS9dEGq1JGHaD/0Hb8POwt3xKVZswQrgk7TIbqBXvC7QfocDDuQ9wG1msmYvtPWm
         UjFBsvxD3139xV72yYi/ZblA2MxBBj2GaKGmurGeOGO5vz+Ic8Bs5a2HML3feluekRbg
         N6lzfDuNSM1qpqSaTo2t/aoLTYKRb2PlTnNQQ6Hztxy7Jg5O0T9E97ircxn/3u/9pJif
         jQ9QF8hzLr5thF4IjFmN7GXMb04gFrg5769xDGlXVAm1JAkUN4vIvTjXh5unZX4VhbuB
         NK4g==
X-Gm-Message-State: AOUpUlHvP30gL8rDDr3dxhg14hg3JIijMP73oMlgwGml8asxlv3MjKMC
        rneAo1NHANlMyQFO5GFYITki691O
X-Google-Smtp-Source: AAOMgpd26razBvRguIbexsu9LJAy2kgjM5QuwBhdh7fWIN6dzAeNKPx+YpAHSy5LW6kLFuQXt23fWHgk
MIME-Version: 1.0
X-Received: by 2002:a0c:f70d:: with SMTP id w13-v6mr7845178qvn.20.1532386068779;
 Mon, 23 Jul 2018 15:47:48 -0700 (PDT)
Date:   Mon, 23 Jul 2018 15:47:27 -0700
In-Reply-To: <20180723224727.120952-1-rkir@google.com>
Message-Id: <20180723224727.120952-2-rkir@google.com>
References: <20180723224727.120952-1-rkir@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 2/2] goldfish: Use dedicated macros instead of manual bit shifting
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

There are dedicated macros (lower_32_bits and upper_32_bits)
available to extract the lower and upper 32 bits. They provide
better readability and could prevent some compilation warnings.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 include/linux/goldfish.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/goldfish.h b/include/linux/goldfish.h
index 159b4191f15d..265a099cd3b8 100644
--- a/include/linux/goldfish.h
+++ b/include/linux/goldfish.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_GOLDFISH_H
 #define __LINUX_GOLDFISH_H
 
+#include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/io.h>
 
@@ -10,9 +11,11 @@
 static inline void gf_write_ptr(const void *ptr, void __iomem *portl,
 				void __iomem *porth)
 {
-	writel((u32)(unsigned long)ptr, portl);
+	const unsigned long addr = (unsigned long)ptr;
+
+	writel(lower_32_bits(addr), portl);
 #ifdef CONFIG_64BIT
-	writel((unsigned long)ptr >> 32, porth);
+	writel(upper_32_bits(addr), porth);
 #endif
 }
 
@@ -20,9 +23,9 @@ static inline void gf_write_dma_addr(const dma_addr_t addr,
 				     void __iomem *portl,
 				     void __iomem *porth)
 {
-	writel((u32)addr, portl);
+	writel(lower_32_bits(addr), portl);
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	writel(addr >> 32, porth);
+	writel(upper_32_bits(addr), porth);
 #endif
 }
 
-- 
2.18.0.233.g985f88cf7e-goog

