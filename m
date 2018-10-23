Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DDBC7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798002075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etVVDgLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798002075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbeJXGB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:01:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41140 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbeJXGBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:01:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id c16so2330762lfj.8;
        Tue, 23 Oct 2018 14:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=pGpymzbPbfMd0UY2O/PnMm8wYTcULxEjQ2M1QiLWUtQ=;
        b=etVVDgLocA4AjN+jxAXLRtXyFmyCKDXzTHMYFdYt+3XfgEEQNZehB6ZAubiCYjyvy0
         C5GrkJFQrsxCI5EKgJi2Hh9syjIDh3WhQy6uGJipgVAL10O0CGT25+kfZsvBKU7+PtEs
         hAvdrW/iABvj+SaTIJ7FSEwZoqcJMNTTM7IyOYe6ITWgreOcX1fRhiAu4Aie0D3L+6Ah
         0CL0xm+qqL4/H+nxwdF5UjsZq5aTf3xxTf9y0JGxopS2MHxBOZ9aDWIX2bUY5gqeHeBx
         G6gvyawpjFtqRLlCBActSQCZFme72y8lx8IlyO4u8ngtDN4fbCBBViLuXUbGABcQ4L4f
         JH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=pGpymzbPbfMd0UY2O/PnMm8wYTcULxEjQ2M1QiLWUtQ=;
        b=Ruzpohh2T6U0cMZ3n0HJ7EoD8TpJWudXh71M/DLgIdLmOwImEz7Z7hzdr+x+dtwIEi
         xFWKtO/GH+rjvTrKHa9BzmTW/RoEgH1AOWjcYInXH6rtkG7qWSbaSeKdWFbZHShvORIl
         ly3I0ATgwrkgb7PHl4BhFJLfcHBim+SKpLVS4EEZFsiA1hHu7tLCWTHF7wr9BV6aJY2r
         kXDFbeTQ9K+9ve0t+BRZL+N21tgaGWZ1SQ6r/S667V/J571UZhoqA/XDu2o8uG6IWf/v
         8Pl9f3867foh/8UAOLNhyubX7lCQ6gd4YCANzLvKOaWaRKwN0rQT6kvchDIWdelvNiut
         vC5g==
X-Gm-Message-State: AGRZ1gIZQ0//VRyNnN+MGHDaWTtAvnnoGq8hOtJCG+NemZAvZjp4otex
        twp3roVtX/XDsmKg768auvE=
X-Google-Smtp-Source: AJdET5exRyQPy5ypGmiJjncDtEgR9KmCyJjS90PbVTRQUbcCgZs2pc0eSgkwJSERums9s+tyA2MWxw==
X-Received: by 2002:a19:3809:: with SMTP id f9mr170930lfa.148.1540330570334;
        Tue, 23 Oct 2018 14:36:10 -0700 (PDT)
Received: from localhost.localdomain (91-159-62-169.elisa-laajakaista.fi. [91.159.62.169])
        by smtp.gmail.com with ESMTPSA id y127-v6sm377950lfc.13.2018.10.23.14.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 14:36:09 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     igor.stoppa@huawei.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/17] prmem: hardened usercopy
Date:   Wed, 24 Oct 2018 00:34:56 +0300
Message-Id: <20181023213504.28905-10-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023213504.28905-1-igor.stoppa@huawei.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent leaks of protected memory to userspace.
The protection from overwrited from userspace is already available, once
the memory is write protected.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
CC: Kees Cook <keescook@chromium.org>
CC: Chris von Recklinghausen <crecklin@redhat.com>
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
---
 include/linux/prmem.h | 24 ++++++++++++++++++++++++
 mm/usercopy.c         |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/prmem.h b/include/linux/prmem.h
index cf713fc1c8bb..919d853ddc15 100644
--- a/include/linux/prmem.h
+++ b/include/linux/prmem.h
@@ -273,6 +273,30 @@ struct pmalloc_pool {
 	uint8_t mode;
 };
 
+void __noreturn usercopy_abort(const char *name, const char *detail,
+			       bool to_user, unsigned long offset,
+			       unsigned long len);
+
+/**
+ * check_pmalloc_object() - helper for hardened usercopy
+ * @ptr: the beginning of the memory to check
+ * @n: the size of the memory to check
+ * @to_user: copy to userspace or from userspace
+ *
+ * If the check is ok, it will fall-through, otherwise it will abort.
+ * The function is inlined, to minimize the performance impact of the
+ * extra check that can end up on a hot path.
+ * Non-exhaustive micro benchmarking with QEMU x86_64 shows a reduction of
+ * the time spent in this fragment by 60%, when inlined.
+ */
+static inline
+void check_pmalloc_object(const void *ptr, unsigned long n, bool to_user)
+{
+	if (unlikely(__is_wr_after_init(ptr, n) || __is_wr_pool(ptr, n)))
+		usercopy_abort("pmalloc", "accessing pmalloc obj", to_user,
+			       (const unsigned long)ptr, n);
+}
+
 /*
  * The write rare functionality is fully implemented as __always_inline,
  * to prevent having an internal function call that is capable of modifying
diff --git a/mm/usercopy.c b/mm/usercopy.c
index 852eb4e53f06..a080dd37b684 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -22,8 +22,10 @@
 #include <linux/thread_info.h>
 #include <linux/atomic.h>
 #include <linux/jump_label.h>
+#include <linux/prmem.h>
 #include <asm/sections.h>
 
+
 /*
  * Checks if a given pointer and length is contained by the current
  * stack frame (if possible).
@@ -284,6 +286,9 @@ void __check_object_size(const void *ptr, unsigned long n, bool to_user)
 
 	/* Check for object in kernel to avoid text exposure. */
 	check_kernel_text_object((const unsigned long)ptr, n, to_user);
+
+	/* Check if object is from a pmalloc chunk. */
+	check_pmalloc_object(ptr, n, to_user);
 }
 EXPORT_SYMBOL(__check_object_size);
 
-- 
2.17.1

