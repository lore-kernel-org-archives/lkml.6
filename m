Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9CEC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CC0208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Inp3rDYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CC0208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeH0WqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:46:02 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:35250 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeH0WqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:46:02 -0400
Received: by mail-vk0-f74.google.com with SMTP id x125-v6so15019vke.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ycFD50Qbqy2nsG8VK8f/Mv9TVDy1OUIkLU31FaF+unc=;
        b=Inp3rDYfU183FlYE+NFUsy7ksvex6gl9N2We90XZsfgqClFLoFcriIVQcXEyyfEeZF
         WxFcaVIghxRt5djJfm3wc5G1w1KItP+zoql6wI+Rve/EEkf0bASuUvgGlPsVwrmDqa3c
         oNfZ4udfPhnb5FVZnP/tUIzGyQWIjre3LHDdkywsMGLYpdtmnJyqjd52VeI8L+i5ZpzW
         zfh8tsFrPRRCjm9a3zgXSqSVAajVT/wjOpaWjzYfa/tjiRllc4sMW3mdAI15jVQVXazM
         mIS8BU0Wto84H+0aZ3N1mgg/rWCQr10Xf/dvjKAwnd4oXMi/Qkd8XgmI9rI6BX6SqX+m
         qleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ycFD50Qbqy2nsG8VK8f/Mv9TVDy1OUIkLU31FaF+unc=;
        b=qlnbj5r1113KED7VXBxplHZfV/HcH8rXta1p5SY/gsJQ90O+OWj5sF7aWiW8zlthJs
         jgdO061OK/V7Ll38P6xQSxRBC8Y01D5tQ3JZ8mv8BMdilcrFjiauYpsdj08bZEqz3yxw
         JbXVdHOL9oF8DT+iQUWkdtK2BysWUZnCzZHPUTzCH6We1PA3N01LToZ1OgV/Hb5VmyKy
         K9HXy4ztM+GGy41Sf8Wvja3pfQUDp7k0S5r7g4kfUNil1kQnTymTjNYsSnP0PZnZVKzu
         LtbxQ5Rl7FVYK9EULvLTqMq3dKDa4mzFxmLrAAc1n4gLZqAXaokPJ5rRv4qOMkLNZrrq
         0HSw==
X-Gm-Message-State: APzg51B5eBKZnnrFjNoSIliOZM51HJ7IZlTUvGyjLhCbb84MyDSUTbX8
        B2/p04Hhj5xuSmSaNYRzh4I3qpo2RQ==
X-Google-Smtp-Source: ANB0VdaXjqOrrHANxz1rCv+tH9fays7AA2RAsMOahiQ8j6ctktmJS29FhFIfemOGyGe8R5FsvzGjCzFPjA==
X-Received: by 2002:a1f:a991:: with SMTP id s139-v6mr6956921vke.107.1535396292059;
 Mon, 27 Aug 2018 11:58:12 -0700 (PDT)
Date:   Mon, 27 Aug 2018 20:56:31 +0200
In-Reply-To: <20180827185631.163506-1-jannh@google.com>
Message-Id: <20180827185631.163506-8-jannh@google.com>
Mime-Version: 1.0
References: <20180827185631.163506-1-jannh@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH v2 7/7] lkdtm: test copy_to_user() on bad kernel pointer under KERNEL_DS
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test whether the kernel WARN()s when, under KERNEL_DS, a bad kernel pointer
is used as "userspace" pointer. Should normally be used in "DIRECT" mode.

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
2.19.0.rc0.228.g281dcd1b4d0-goog

