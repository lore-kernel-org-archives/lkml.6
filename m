Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C02C46472
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2E421A73
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7Y24NcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2E421A73
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbeHGDfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 23:35:04 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:48034 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731331AbeHGDfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 23:35:03 -0400
Received: by mail-ua0-f201.google.com with SMTP id g19-v6so10262333uan.14
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 18:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EeM9pl7nl45D9C+13M38eu9VuNZcRlR9egYZrxuwyYM=;
        b=u7Y24NcD9NIt0JcxdraGBb4gYa4PIrSBLk5f/pcgg3hc8WdbhAr3zZtAsT6cYl6HXM
         Q0xtRU+800C2V88IYcQral504EqTMW/jZ6NoY5tnt6uj8MQgiJdOAB3vk4JGsiJV9KRj
         HJDH1Y7gIbQg/CvEUogC9F2zn5zDm2OMjm5JvAw4mJtTBvgfPy5Dvp5wlfXys1NtH+7w
         GJjX+MHaa+nclBKhSD0sZZ457WXR7JTDbkwB3XaudINjXLrvrv9j7JobPOLAcalYPpOW
         eNiaLBQQH1dfBsvl9YZq9MuJiKDxWCGP8AOBxziWnsLhvm6+3zkCOzcxp79TPmB74FC1
         +ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EeM9pl7nl45D9C+13M38eu9VuNZcRlR9egYZrxuwyYM=;
        b=F9miO9g5TB57CSFfjLjxSc7ihpTMxDCFNFcKOVjqNjVCV4UeDj63QLPJxJsBAO1gz6
         80qYYy4V1qjV2Cf2wROrcvbtUUoQuF+tgWBDBEgCQ1+iSFcVB60L+eG7xyDPlRgaCxrF
         KX8FOCG/5uBf6dRBEyxzCz5qsHxbCnvLuM8MYQi0JXDPKm0tEHbGG7iLBo/C4lfq9QYn
         xJQbyRt1rcRjhhnQCWlPOoZWFPUTPOM+PZvImxffgQ5CfF4r09CcTzcWFDtzRhj8+aCO
         np/a1UsZwRDzJ/rWxznrRZtIQLhA6b8PRW6QnQckeouNWRc8SNfyb+PUCzmGP8tgSV1s
         DDOg==
X-Gm-Message-State: AOUpUlEh/knKKN6Rcm2l9Lq+h6ZjC9pNDu0dM9eKQBSD0tOU3odyDqdD
        7suw95S4B7pilLYMubPCa5Z7GrBgZQ==
X-Google-Smtp-Source: AAOMgpfjq9p0WM8Uf/Iwew7A+yo9m73QyrbmhFOxtwn2BDzJksPRiBDDIHftMNJFhWPoFbVxXBJFZuB9NA==
X-Received: by 2002:a1f:a347:: with SMTP id m68-v6mr11036590vke.43.1533604994654;
 Mon, 06 Aug 2018 18:23:14 -0700 (PDT)
Date:   Tue,  7 Aug 2018 03:22:57 +0200
In-Reply-To: <20180807012257.20157-1-jannh@google.com>
Message-Id: <20180807012257.20157-2-jannh@google.com>
Mime-Version: 1.0
References: <20180807012257.20157-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [RFC PATCH 2/2] lkdtm: test copy_to_user() on bad kernel pointer
 under KERNEL_DS
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kernel-hardening@lists.openwall.com, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        dvyukov@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test whether the kernel WARN()s when, under KERNEL_DS, a bad kernel pointer
is used as "userspace" pointer. Test with "DIRECT" mode.

Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/misc/lkdtm/core.c     |  1 +
 drivers/misc/lkdtm/lkdtm.h    |  1 +
 drivers/misc/lkdtm/usercopy.c | 13 +++++++++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 2154d1bfd18b..5a755590d3dc 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -183,6 +183,7 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(USERCOPY_STACK_FRAME_FROM),
 	CRASHTYPE(USERCOPY_STACK_BEYOND),
 	CRASHTYPE(USERCOPY_KERNEL),
+	CRASHTYPE(USERCOPY_KERNEL_DS),
 };
 
 
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 9e513dcfd809..07db641d71d0 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -82,5 +82,6 @@ void lkdtm_USERCOPY_STACK_FRAME_TO(void);
 void lkdtm_USERCOPY_STACK_FRAME_FROM(void);
 void lkdtm_USERCOPY_STACK_BEYOND(void);
 void lkdtm_USERCOPY_KERNEL(void);
+void lkdtm_USERCOPY_KERNEL_DS(void);
 
 #endif
diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 9725aed305bb..389475b25bb7 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -322,6 +322,19 @@ void lkdtm_USERCOPY_KERNEL(void)
 	vm_munmap(user_addr, PAGE_SIZE);
 }
 
+void lkdtm_USERCOPY_KERNEL_DS(void)
+{
+	char __user *user_ptr = (char __user *)ERR_PTR(-EINVAL);
+	mm_segment_t old_fs = get_fs();
+	char buf[10] = {0};
+
+	pr_info("attempting copy_to_user on unmapped kernel address\n");
+	set_fs(KERNEL_DS);
+	if (copy_to_user(user_ptr, buf, sizeof(buf)))
+		pr_info("copy_to_user un unmapped kernel address failed\n");
+	set_fs(old_fs);
+}
+
 void __init lkdtm_usercopy_init(void)
 {
 	/* Prepare cache that lacks SLAB_USERCOPY flag. */
-- 
2.18.0.597.ga71716f1ad-goog

