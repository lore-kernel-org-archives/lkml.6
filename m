Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA0DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DF62145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JJRM0KSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DF62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeIXQN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:13:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36328 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbeIXQN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:13:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id y13-v6so4650337wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 03:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ig9mBor6Vwwn4DYl4UdniUpV/rwBF8VdzUTE/e7dEs4=;
        b=JJRM0KSL00sDd4gsBejDecMytRBu57SOdnHmLSJdvSWRrtQmxoD7GlHievO5p22+XF
         DIwqPilexuKrnMQxg+x7VKNHaqvrxGOciQVt78pq+IiP/07OKF5DIyOMPySo0wVIbCBk
         GfuMANULQwzE7RboMFugcqwVjxXaP/J1Fb4sosS8406LgoX7Q7qNxyFCG6bsunDtTDL3
         A1TQsZDYpdt0MvfqEavVlMJW4IsQUCvKcdc4lP6i3R+I3WHjN+c7mKVjxSkPlNPYEahT
         l4IpY393sTVPuYFHvrHY1fAchqjisT8k0qOuQSNAUkVSQgKfk07YMMMaUkaB3MZ4mTx0
         pORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ig9mBor6Vwwn4DYl4UdniUpV/rwBF8VdzUTE/e7dEs4=;
        b=bPOZ02sdzXV/4EdaukjoASEDHG8IrE61jrjR1DBAaO8UlDBGSkFRzCBSM81NGSIw+R
         gj8tvVpN549+tOKP/hNyrtGEm3fQxEm5Aw1x3vxmWzVskYWucsCFETzC7qJwFA7dRmac
         kjyXWBviiixdCmi/m3b9VpGdEzr9z2AYJMUHdEToyvXbWUz4cIzBd64Wruznhm8N6Gtf
         RBpb+s7bljpDT1JY2R2ty9//EtGZSy4qVvjjeu2LGQY64xV3eOFOAGL3+PX2NnrGMyVc
         Kh0+kVFoutiCMZiFLwyoIy5Ilz5fFhwqMCpbaYMsx/ZsX5WhHBvsQrXkNtTmMliJ6iFo
         xgbw==
X-Gm-Message-State: ABuFfoi1hHVyPSmV6lpqf5WdsWKpWXdIN4QFwqKNJF2SGsHDPZ4D8jVs
        SegGHps6V3y1q4ATzOhz4evubg==
X-Google-Smtp-Source: ACcGV63UZdxzfT1JG65wI1i05x8zgahoA5qW9lU5GZg5qEmKLT2APagXP/h1Z6esoAJFAh0uHQFlYA==
X-Received: by 2002:a1c:b20b:: with SMTP id b11-v6mr613454wmf.64.1537783925302;
        Mon, 24 Sep 2018 03:12:05 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-2-33.w90-86.abo.wanadoo.fr. [90.86.1.33])
        by smtp.gmail.com with ESMTPSA id o12-v6sm3291728wrj.58.2018.09.24.03.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 03:12:04 -0700 (PDT)
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
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 2/4] mm: move is_kernel_rodata() to asm-generic/sections.h
Date:   Mon, 24 Sep 2018 12:11:48 +0200
Message-Id: <20180924101150.23349-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180924101150.23349-1-brgl@bgdev.pl>
References: <20180924101150.23349-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export this routine so that we can use it later in devm_kstrdup_const()
and devm_kfree_const().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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

