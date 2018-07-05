Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A718FC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EF7240CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3LwhsrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EF7240CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753699AbeGEVhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:37:02 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42681 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbeGEVg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:36:56 -0400
Received: by mail-pl0-f66.google.com with SMTP id y8-v6so1832993plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 14:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zWSQmObS54WYCOwnij14pXa5G0XaIWArfoHWFe6y/WE=;
        b=I3LwhsrZuf4PVSd9VVVu3o86OZf+UGiO68HFPE4zQIa74NAx2WtJE+woAbnzLM1HtR
         G/5oMIbE97uzgCNmOjE+C5OFUng1Ka3IiB5LqjBe19NwT4podYlk4uz3IvOLGUTfujpD
         IsRfYroYGdRavd1yQuHZy0GwxKZmuPX995qSpsfl/5Y84+PZ5CxPeJWqc3m8xR/OFeIJ
         pi2ZCDRCO3LiM/uX0kqMlXXeFk/AnS4KfnS6BbsQ4UEe/giJoGy7g2FVhr92cd4uOD2M
         Kr57q9uKmYEt9d7e1f4MRgDTh1DraXjxx2tydKqXJkynqwLZsg5xbXFOR59Upcqj6uhz
         DhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zWSQmObS54WYCOwnij14pXa5G0XaIWArfoHWFe6y/WE=;
        b=bmb9mL+EveWsCLl0Zt1shIl1X+fhkq1IhAL59gNeo/9U6J7c6j2F1y8BVpGa/VCydT
         B1FZrJykAS/r8T9/j24oTJCbgFIA+a2hvE6cq5v7iZ/BmCLWCi0cqGvGeVmKZTt5lFlO
         kukacXphU22sD12VoAis+QoJkcjISwhdkJM0KOv/qiDTU66RCUVYF6orI5YOyq8yOLBt
         4FzUa2TKIXfdnmcQLj8oC6emH6eLr40KLH5fnld6drdQRSgacR1HoK49FgA32KjHz+Sf
         /+MZgksiJulM7u5qXHrtMV+UI1+2u6n+8dD0Re18ViMbMgcsyZsrJJuEWwmHfH6theaD
         Hynw==
X-Gm-Message-State: APt69E3b/Umwh0zKtt0etfDBoGh6UTdqPpLJsQ/2LU78rTz6eyM9JGga
        NbzWDJiQt4SrdTXrqn962/I=
X-Google-Smtp-Source: AAOMgpfnrUW6UnOSupdz/8tiCVubNfvxAxdfOoUz5NkrZuzJOmcv4ONXApj9ZXx+zcs4Ielb+a0nSA==
X-Received: by 2002:a17:902:6b86:: with SMTP id p6-v6mr7813978plk.75.1530826615839;
        Thu, 05 Jul 2018 14:36:55 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id v89-v6sm20438290pfd.64.2018.07.05.14.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 14:36:55 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org, catalin.marinas@arm.com
Subject: [PATCH v2 1/7] arm64: Make basic compat_* types always available
Date:   Thu,  5 Jul 2018 14:35:58 -0700
Message-Id: <20180705213604.18883-2-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180705213604.18883-1-deepa.kernel@gmail.com>
References: <20180705213604.18883-1-deepa.kernel@gmail.com>
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

