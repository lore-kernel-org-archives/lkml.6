Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D656CC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976C821746
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WcoMX+C9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976C821746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbeI1Ngs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:36:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45845 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbeI1Ngq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:36:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id m16so5137389wrx.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aahfn6W3XqbfPKSIMQjYMgIUnQeoDBftDVQeJAnnkHA=;
        b=WcoMX+C9r7Nhm6nWDcA0cWik7JPGoLzUMGxGlEyBvVT0v4JaG3FAcbtCBsSffzoNQQ
         9NE2wgmzuC0gupcc0ODXgTmXUWWdbbwNEsZ/MDeL2P80n8bV3vzDufGm5Wul5F5nb2bz
         ZwGsS63plVXwHDRByuDDyspsS2y1TS/GCjsGmBm+To/eQJ7XDPLsGY7vjXkgQ6nXsvmh
         bLQhsAaDqw3/HxFpqClJ+S2JYXjXhlJveYBeiBlUC1BqCKyR+iy+j5wdKfnfLXDOSLSv
         7IJAYRQsmMl6nmDKbYosByBPUdq5xi4XhAjLYKwPd+lJGlhffdA1JSQGb5InfFt65+z3
         S30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aahfn6W3XqbfPKSIMQjYMgIUnQeoDBftDVQeJAnnkHA=;
        b=VCpYllLjAvuuhJ5ljZb4yQDxpubPKb1KQPaUeAUIayY1VYCt0+V0zkeDajhDxL23aN
         uMN7dtM4uWckFFAMzUxUZLtaZ4QTp//sLwhpye6GuyLsWL7rtQaaMwIdep+362dcUjTw
         jaYLgynp8wbbnfryoHuKRh20fiB3jhfFy6rtk9WsG/NawvWvKYl38f2Hgek/VHulYPvv
         Uz+C2VyujHaxOT4KXW2AZcSmfSV/07fy4YtgRTEO7ecjDFph2bS9JkqTUA8HRV+CujuT
         utyOkD8+IAbLFMDunnSYaEYbTZAu09Rv8b/M6RECp7y23q3JsGLLMR1kjtY7/ehaFrS9
         3GpA==
X-Gm-Message-State: ABuFfogFwdd+7ptE4YpMqQ5VwuVTDb/6UFpMK0zf4E9o19zX5iZd0vjl
        ER2p49/skTxOt8unZV8Ff0MUZpM6Asg=
X-Google-Smtp-Source: ACcGV63dAIzBiNxrypnzZ7c/q17bjSFrJU94ofSqZ0yNmyySuop9DsNdLC9R2TnGlRQDb6WSwx9PxQ==
X-Received: by 2002:a5d:4143:: with SMTP id c3-v6mr11258748wrq.61.1538118865099;
        Fri, 28 Sep 2018 00:14:25 -0700 (PDT)
Received: from brgl-bgdev.sitez.s.ibrowse.com (93-158-26-51.subs.ibrowse.com. [93.158.26.51])
        by smtp.gmail.com with ESMTPSA id w3-v6sm2699580wru.93.2018.09.28.00.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 00:14:24 -0700 (PDT)
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
Subject: [PATCH v5 2/4] mm: move is_kernel_rodata() to asm-generic/sections.h
Date:   Fri, 28 Sep 2018 09:14:12 +0200
Message-Id: <20180928071414.30703-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180928071414.30703-1-brgl@bgdev.pl>
References: <20180928071414.30703-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export this routine so that we can use it later in devm_kstrdup_const()
and devm_kfree_const().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
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

