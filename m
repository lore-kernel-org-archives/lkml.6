Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701B4C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29935224D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+ISWbkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29935224D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752890AbeGGFng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 01:43:36 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34456 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbeGGFnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 01:43:33 -0400
Received: by mail-pf0-f194.google.com with SMTP id e10-v6so9997615pfn.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 22:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zWSQmObS54WYCOwnij14pXa5G0XaIWArfoHWFe6y/WE=;
        b=Z+ISWbkpykppveaWk6mQw3CcXj7+sl68y4/d/5OE6o+cHl44CUk6gQJwnLJg2b+8ME
         GRubC8Cp2LgNu4Nnml9W272SO+bkBflnsZ3+9bebHVqo0nHVMR/sNT1pVVEFI4r9XUv1
         SLIjX2LKE7MlJsNfjvQPBQcPsP3M5zSg5mdgWcmM8F4x61XjWpcW8aINqPIk1mgv4aUw
         3m+3715sWQ0m/661tsV5BJbcYDU8WyiuRo4Z+kDUzz2ZQG+IE6VByAcsAbnNui/+625A
         v2w9Yrxhok03WqA/rstiN3GBmChFfbXTsTEjF30q+rn3Q0qNgNfWYnp6owDauKf6ZL/E
         o5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zWSQmObS54WYCOwnij14pXa5G0XaIWArfoHWFe6y/WE=;
        b=oXHK0BFNdNnp4gdr9jWxoI5QwDpSDHZ3LRGJ+BssqK8fFA34O7vn0h8yp91la1TBo7
         vGpY02gLa6yGAdcOukh/REJQg9/nUEJeNhXwZujly/H125PQpcBzCEGt2y4oQ/Qwxcrc
         de2GyVMoKAkcMTq1x1iMxwrB83DNLaQOJWz/LJWwFJK/Yc8f49EnSKGKUwfL42Hpr/QX
         5qX4UCcQWCkj32w/ExDOtR8r+Mtzodt+VsISakcix5mGXzqMqi4PDE0b69cDn6RZ3i3w
         UQ3tU8DDOVipaY6N3zuwK4nOShzrfdHl2+WPqJ8X0PWTxIEO9+Ue+L/QEgiA23RuBrii
         y4ZQ==
X-Gm-Message-State: APt69E3/WjOMfPY2T2MOIc+zRB4lNbCV2PpAe6Q5AN7Bh1xRzpyLTMgR
        q8qsjM6MPISglBXXgWp+B5oHbQ==
X-Google-Smtp-Source: AAOMgpfoyTim0kO2GTkBgVjM7/Td7iHF+Gb+ZnH9m39fRDVgtOvoaktXWxc1m0n/KOJEayWsdohRFA==
X-Received: by 2002:a63:1a20:: with SMTP id a32-v6mr5449637pga.446.1530942213098;
        Fri, 06 Jul 2018 22:43:33 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id t192-v6sm16505083pgc.74.2018.07.06.22.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 22:43:32 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org, catalin.marinas@arm.com
Subject: [PATCH v3 1/7] arm64: Make basic compat_* types always available
Date:   Fri,  6 Jul 2018 22:42:41 -0700
Message-Id: <20180707054247.19802-2-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707054247.19802-1-deepa.kernel@gmail.com>
References: <20180707054247.19802-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we repurpose more compat syscalls to be used in non CONFIG_COMPAT
usecases as part of solving y2038, we need to make these basic types
available unconditionally.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: catalin.marinas@arm.com
---
 arch/arm64/include/asm/compat.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 1a037b94eba1..2dbb179b5dc4 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -16,21 +16,14 @@
 #ifndef __ASM_COMPAT_H
 #define __ASM_COMPAT_H
 #ifdef __KERNEL__
-#ifdef CONFIG_COMPAT
 
-/*
- * Architecture specific compatibility types
- */
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 
-#define COMPAT_USER_HZ		100
-#ifdef __AARCH64EB__
-#define COMPAT_UTS_MACHINE	"armv8b\0\0"
-#else
-#define COMPAT_UTS_MACHINE	"armv8l\0\0"
-#endif
+/*
+ * Architecture specific compatibility types
+ */
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
@@ -65,6 +58,15 @@ typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
 typedef u32		compat_uptr_t;
 
+#ifdef CONFIG_COMPAT
+
+#define COMPAT_USER_HZ		100
+#ifdef __AARCH64EB__
+#define COMPAT_UTS_MACHINE	"armv8b\0\0"
+#else
+#define COMPAT_UTS_MACHINE	"armv8l\0\0"
+#endif
+
 struct compat_stat {
 #ifdef __AARCH64EB__
 	short		st_dev;
-- 
2.17.1

