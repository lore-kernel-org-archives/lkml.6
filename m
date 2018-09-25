Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E8BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A945E20858
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="U4ysULxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A945E20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbeIYSyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:54:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44516 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbeIYSyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:54:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so23215422wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aahfn6W3XqbfPKSIMQjYMgIUnQeoDBftDVQeJAnnkHA=;
        b=U4ysULxbQKP2iLd6agdmTy0MZcKrK53uYOV/CWcFRJvATAOIl4McMKBxBu0vJ9ERN2
         R07N++hpe0OTNEBXkV0NetWtAloETayE235TrPyEBLXV9eY3/Jt+DjLCbpiYIzJ6miWh
         P3Dqdt1sguL/k6nvZU5Iq7UHmdBorzvYjOnbVjhgpXtNKG18Ok737iuJRvD6d0TjvRV6
         /8THm4vi7+hU4UgFAvvqnpQhzSjMvdB4O6ivm+4u6guOXH5UCSWBx9rCtpAHtQzW5Jxs
         FquGlIQcoIljnFQXopr4KSAmbN/WQBRYf9bs8Opb0egxmpJGyBsv9njxV3y/q02L+1+y
         Y55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aahfn6W3XqbfPKSIMQjYMgIUnQeoDBftDVQeJAnnkHA=;
        b=pGnNfZwyZYPMMFFjENdRYapylBSDstkQ13J/wLdqrvBaaM/5sL5ShHWzZ6SH9weVDa
         L+pVGAroF8/S+3xdohyNg1Nlp8G8Uufx9ecdSDOsn2NTanU/Nrz6OGxN6FsM+J19g8nI
         cqYshsmwWOXA5fas4xQ4i31dm8nYHCFB13KSMLF0VrngtQTxfDXbRaRnMt6RBRyBS7hY
         igULuPUr1V8bZFFHqA8FqzmperyywDJhMxGT/4QGtfk1mOJkbcfrPH5GU2i5JBKghHeq
         p9dSqfUg42Kqf5Q86WhLdpMDXPRB2x38a6v/NYKFuA+7CZCfWJAKH5tDJwdKiDvxTd3l
         +Bhw==
X-Gm-Message-State: ABuFfogAf9Iy3qBlLvX2b5/I72WdX0DzI1h15TRnxEsWzIcqp2j/jos+
        d7CBUJnU93H2Sf7oPwWu4IG8bA==
X-Google-Smtp-Source: ACcGV61Du3tqo+1NOpmGdGsMj6oqmDw1DPj/MK3lJ6tiZjpB48sO6GuYv8zCYx5jBgY98KZS66MymQ==
X-Received: by 2002:adf:9dd1:: with SMTP id q17-v6mr841688wre.12.1537879602515;
        Tue, 25 Sep 2018 05:46:42 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id z13sm2276160wrw.19.2018.09.25.05.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 05:46:41 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v4 2/4] mm: move is_kernel_rodata() to asm-generic/sections.h
Date:   Tue, 25 Sep 2018 14:46:27 +0200
Message-Id: <20180925124629.20710-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180925124629.20710-1-brgl@bgdev.pl>
References: <20180925124629.20710-1-brgl@bgdev.pl>
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

