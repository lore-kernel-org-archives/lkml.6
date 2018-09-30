Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66A6C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7929F2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HdPzKJtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7929F2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeJADAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 23:00:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38629 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbeJADAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 23:00:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id a13-v6so862730wrt.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 13:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wBfa6xDfzr2sbr6kcGWmagCtbFwHshVsfFISZaQ0oEg=;
        b=HdPzKJtFKp4jLhqD4bGDbutkfIahpZZ7OVs4nwGKidH7w9kTz8XeYUeSqGI+h2vA+8
         pZ1RFFZoQnTSKQpUpN/qsAsdVOuclYBaU7MoajlLiRTqXNW3utEgPZD6lGS/BWfMYsDq
         a1Er5IxYMx4XYimDfMYgy25UVltfGQibcx9WU3CIWRQ6Ngpsau9nd110RcMCkaSOaiqv
         lIDNLt7FCgYiRDanzB10z5HxhWeRzSj7JzU8iOX0b5EV6+bh50X8x71akBrVWCe5j7S7
         iUkR3igSLII4T3t3T34nY5UYAbKo4nxBXnuZPOuuI5AwBaQRJBOh1uoMfNy8ECfO8dp4
         jk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wBfa6xDfzr2sbr6kcGWmagCtbFwHshVsfFISZaQ0oEg=;
        b=KD+Xfw62uQymkQKzvM6heuiijeAPKn4VSAJMODlhQ3vwHpM1dsUe3FP3Mz97Jn/AXC
         shdOGvUaOOwEIY13pixIrxMjW2/BdsFpEUiljf5O55/iOofQyTiTaGKhhmwHLNQ0Sozr
         Zgk0B3X8KM5G6tHzzxgMViATe6cs8BOS39QZIRHbSuuIdjfcO4yItGNRpW09tiHo3fNX
         SZrR21cnI+Cw4xilYAgOPBtj9IonD2xpIfS7WmIp23X4R4J+t4ykCP5CmmI23/WE8oHD
         vVkjafSxKcI4zMMvIr00gtvdObAy5AKjL9HMEcps8bP6SiupWLFqley0ThySLgFgbm2p
         9G6Q==
X-Gm-Message-State: ABuFfoi3jDSdnMdl0Cf9RH/aEptE1hNZ2m/s8t1HwgrlxI+sgXKfAhjI
        +JUbj4pZfkiKb8G5autF9kHaug==
X-Google-Smtp-Source: ACcGV622Z46pF1NKwfHISnsVzRZHaVzp8ASHZfRhlfkuDJYHOHEfG+9WB751+SLAPtm4rAGk7e+0kw==
X-Received: by 2002:adf:f88d:: with SMTP id u13-v6mr4749013wrp.311.1538339183427;
        Sun, 30 Sep 2018 13:26:23 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v16-v6sm18566465wrw.12.2018.09.30.13.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 13:26:22 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v6 2/4] mm: move is_kernel_rodata() to asm-generic/sections.h
Date:   Sun, 30 Sep 2018 22:26:13 +0200
Message-Id: <20180930202615.12951-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180930202615.12951-1-brgl@bgdev.pl>
References: <20180930202615.12951-1-brgl@bgdev.pl>
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
2.18.0

