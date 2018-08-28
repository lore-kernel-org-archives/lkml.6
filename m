Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733F2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7592089E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MME6CIbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7592089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeH1NdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:33:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40055 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeH1NdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:33:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id n2-v6so924285wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wc9ZRwnUmb5rXGt9YW/Z3OT0r34lfcDOfLS8ZydfUMY=;
        b=MME6CIbn6ztirIfcMA3UHlZmo1USCfNk6oYrqrfS2kcBjaNSlBGu0Xt3IwJZJhOBa4
         zRIVln4bKyOO9n7wPDACSj85rW1EivMdt4i794d5x79jKqT8lqvxRhLlvILxHCDAOGbD
         seIfVj33o/l6LK9f+eDElZyrX6Z+uhE83lFQTN98edjMRs5CpMwoYxwH6rks8zSFzkdp
         q+1pL9rlXPsXqmQHC/m1wvlrWWZCscU6mCX/Ru8R5B1aMJxPj1b2QDe4SUWDRE0ncTg7
         r1hGif/HO0HXvVRQzxgJOlmQeSasPabVm9nYQ529cNM+/kyaUmuiTT+l8ZFQ9UGnEErd
         C9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wc9ZRwnUmb5rXGt9YW/Z3OT0r34lfcDOfLS8ZydfUMY=;
        b=Q9dobCVJR2SK0FYy6u3sy8KbherGoicTdx1bEvD0ohrlkGTMulC7KDf9CfDDoEIodW
         gHuxrEhJAKSA4eOyj01JuRAm7Qsvhx+9hS2rRJnms5Pch+RkT5eWGjLucEaFwPIXNj3b
         EkfeRrkcRPd1IHf6sR5Zw52uJsauIOnxKCvzBKdpjwze2DxlhE7FVdvJqZznxeXu0Jh1
         P2Ek0dMw+XalxqsJyCR3/ChSlcn5CGNR/GyByV3wDwMvNR70KYvtfK34kcElInlAnRoM
         qFjbJT5Hxuw4yOLlZfZAx5YxPgSZ5w75DXt9SPIQCW8MzK1VPU1HPIjqkLMXVYwf2CZS
         1L7A==
X-Gm-Message-State: APzg51CKwhxfgwVqwGAs67pQu09yY6vnFemrAAZ01NeUkZ7Tv8Rk5gJO
        ByoJZq9ghBnIuHTvVo8GmrNUgQ==
X-Google-Smtp-Source: ANB0VdYZg1uzJ+5+eFWd2GzaecxTUS0AzdL/Zfb2QSzLa7FMQgAFFXWWu6LyRuwDUGxRbdwq6jNxzw==
X-Received: by 2002:adf:f8ca:: with SMTP id f10-v6mr568901wrq.237.1535448848093;
        Tue, 28 Aug 2018 02:34:08 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l18-v6sm952276wru.75.2018.08.28.02.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:34:07 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 2/4] mm: move is_kernel_rodata() to asm-generic/sections.h
Date:   Tue, 28 Aug 2018 11:33:30 +0200
Message-Id: <20180828093332.20674-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828093332.20674-1-brgl@bgdev.pl>
References: <20180828093332.20674-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export this routine so that we can use it later in devm_kstrdup_const()
and devm_kfree_const().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
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
index d2890a407332..41e9892a50ce 100644
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

