Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEFFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FF32087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJtCuA9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FF32087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeH2AIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:08:18 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:40286 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbeH2AIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:08:17 -0400
Received: by mail-qk0-f201.google.com with SMTP id 93-v6so2329884qkq.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=orkRpEOZI7lmcFqEOmIoRKnoNlpBSRaZPpEarFrxgn4=;
        b=dJtCuA9+jn3JAd7mRLBblEhQcu5ltG2x2ErJEb4AoFY6cAWBnnE9WrZUPagGV6lPS/
         Isk7kxKGsTe7qKU5K8pvQBCTBKDgZ5XoD3YU07b3hcWTCY5X5sEHOgV55KbG9jvGeTR8
         eNHoOcCNYhBrWY/AzOpz4S2FKOl5BFe2si0NqeWAuKLgg2t1/uK6xcvm6cfM6qBRP/1f
         B4mD/dy3Wxaa+EQA1v7Aan4ChgCArgOPGqmYLQWLUGrAkmZzY5klGbh6hqRbqutOWXQC
         ASj6uLgwRB23No3sHnOnXZRBTtHtxRjU4kG0N149tX+0ldcEBocZhrYIDAaMne6Nup0M
         8phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=orkRpEOZI7lmcFqEOmIoRKnoNlpBSRaZPpEarFrxgn4=;
        b=C55qODRbuX43/3oYsEJLbaK5OLSr+sRAcrk4OJp5Se5rm9Ysjr77qAdNsA7Wejhfil
         wnRziJtvBt234lw665IVxjaVoRPFP5AAOZSRRDGD0XnqulngDpZGE3RoKtEzUhSs/9gE
         7C2Df3o92XYCN5jgCzzZg43B5R/VzSdwoO1a8x7WMIx4WTuvnbsJ+7gd4jGMjduy+ByA
         9LX/QCrgy01ozRoPfyioRuGvfi0S5PPW+xjW+ceI62fwptMKz7hXfxG4GJoHcmRmgzYN
         ltJdfjyNFZGsTkrXok2WwjZeqL8bmXdI09kOlI4tmnbGrtTp/RsVbeTn7eE3c5fZVfBf
         DAGg==
X-Gm-Message-State: APzg51BCd0k9cl9MONm75xuq7qjF9yEY4qIzSIPGzAoSvBUybWhp0nUk
        WlGUVajZyHnT4ghrxYOC4VXy+2wN/Q==
X-Google-Smtp-Source: ANB0VdZBbCL7UFF1k+aW0ff9wf579S1iabnTvek8YhkrSkZNOC1Y6bJfoziFPHprHIkWIEL+QMDgVZmdfg==
X-Received: by 2002:a0c:c3cd:: with SMTP id p13-v6mr1692849qvi.22.1535487301486;
 Tue, 28 Aug 2018 13:15:01 -0700 (PDT)
Date:   Tue, 28 Aug 2018 22:14:21 +0200
In-Reply-To: <20180828201421.157735-1-jannh@google.com>
Message-Id: <20180828201421.157735-8-jannh@google.com>
Mime-Version: 1.0
References: <20180828201421.157735-1-jannh@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH v3 7/7] lkdtm: test copy_to_user() on bad kernel pointer under KERNEL_DS
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test whether the kernel WARN()s when, under KERNEL_DS, a bad kernel pointer
is used as "userspace" pointer. Should normally be used in "DIRECT" mode.

Acked-by: Kees Cook <keescook@chromium.org>
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

