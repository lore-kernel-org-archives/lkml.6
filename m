Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B94CC7112B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E1D2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="znncdVrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E1D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJNXBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:01:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39425 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeJNXBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:01:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id 61-v6so18366722wrb.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ylrYziknVrTZnKjCahR3TZc9dms5fCcVmMAiyFOIO7w=;
        b=znncdVrJ1DfHMo7zxOO/E++Fv7JZA6bTaeKs28VWU1HJzEpO0lys8DUZCYHJhEIyaO
         jzVsRJnlN0r8AWCb140x8EtfTYXfMRkT0NixBkx0cpxJfJvOcdoFvyybp6FvqkkWrqrP
         umX1UDfFUJfNPj0GBnPIV+VgRh+6IY4HM+TTngxvbAgp0v8v9tR19QKrxRBwi5w+YuBx
         HOLStYp4ZS7JH9t0OrTcyrBTldnNX3dU1wSi8JhHZG842KH/3A3jqTl7D1hzsM/T4ut6
         ZJHdERMMOUPIROrobyDHpWReHtjsbKYHXwh7goABncoc6yHLRgWQL75AiYrdP1ve0nb9
         Dg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ylrYziknVrTZnKjCahR3TZc9dms5fCcVmMAiyFOIO7w=;
        b=n65SNfN0KA1TwUwFhAKM2C1Kn5sEq2zJihPVql5gSXgRv4APB8mmAXmNGHmX2qmCSE
         gnKuxn16mXy2yVuiFo8vkBtC9+pPpNz89MmA0vX+lnY3Tuu4p6/8gRTiE1E/yK7aMPGu
         b8MudBfXtaMn9B9A6SlWPwOCYNGX+oaqvFS1u818/d2NPecKhKOeVWDqPeyY/KMiQrfO
         VfqwfrXWtSBXgF9tDknHRY0drnHhGxYGTjnVMxlKiQtkhsnhEs/dhF3UVKQ9maIVYoU3
         3FCXZr5xxiKegJvLhNEymg7HUVOY6GVwxt23bWPpONNZ8yqQVHbpIQywhgOsGpn3OCGn
         omAQ==
X-Gm-Message-State: ABuFfojShFB2CtMdWVVw5Oy6tkACwRvZ489h/0xBz2YTmsVe6YbOf9uP
        zvv8gvts+6xNXwmD1uEYAdPVnA==
X-Google-Smtp-Source: ACcGV61R9Inn+bkyGPvEzGdzmkpZZrf1SVZr5ipTI/X/3Y8nW2TKDQnNuOA3b218nT6IHp5F+EYmHg==
X-Received: by 2002:adf:db45:: with SMTP id f5-v6mr11672407wrj.237.1539530421636;
        Sun, 14 Oct 2018 08:20:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b139-v6sm14789830wmd.36.2018.10.14.08.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 08:20:21 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH v6 2/4] mm: move is_kernel_rodata() to asm-generic/sections.h
Date:   Sun, 14 Oct 2018 17:20:08 +0200
Message-Id: <20181014152010.2021-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181014152010.2021-1-brgl@bgdev.pl>
References: <20181014152010.2021-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export this routine so that we can use it later in devm_kstrdup_const()
and devm_kfree().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/asm-generic/sections.h | 14 ++++++++++++++
 mm/util.c                      |  7 -------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 849cd8eb5ca0..d79abca81a52 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -141,4 +141,18 @@ static inline bool init_section_intersects(void *virt, size_t size)
 	return memory_intersects(__init_begin, __init_end, virt, size);
 }
 
+/**
+ * is_kernel_rodata - checks if the pointer address is located in the
+ *                    .rodata section
+ *
+ * @addr: address to check
+ *
+ * Returns: true if the address is located in .rodata, false otherwise.
+ */
+static inline bool is_kernel_rodata(unsigned long addr)
+{
+	return addr >= (unsigned long)__start_rodata &&
+	       addr < (unsigned long)__end_rodata;
+}
+
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
diff --git a/mm/util.c b/mm/util.c
index 9e3ebd2ef65f..470f5cd80b64 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -15,17 +15,10 @@
 #include <linux/vmalloc.h>
 #include <linux/userfaultfd_k.h>
 
-#include <asm/sections.h>
 #include <linux/uaccess.h>
 
 #include "internal.h"
 
-static inline int is_kernel_rodata(unsigned long addr)
-{
-	return addr >= (unsigned long)__start_rodata &&
-		addr < (unsigned long)__end_rodata;
-}
-
 /**
  * kfree_const - conditionally free memory
  * @x: pointer to the memory
-- 
2.19.1

