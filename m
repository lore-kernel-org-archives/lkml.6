Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3EFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A0B20652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A0B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeICRj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:39:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34099 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeICRj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:39:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83DJCRK3313900
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 06:19:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83DJCeW3313897;
        Mon, 3 Sep 2018 06:19:12 -0700
Date:   Mon, 3 Sep 2018 06:19:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-bef459026b161fbc39d20dcba698ed0cfffbac38@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        mhiramat@kernel.org, tglx@linutronix.de,
        naveen.n.rao@linux.vnet.ibm.com, mingo@kernel.org, luto@kernel.org,
        hpa@zytor.com, jannh@google.com, davem@davemloft.net, bp@alien8.de,
        anil.s.keshavamurthy@intel.com, viro@zeniv.linux.org.uk
Reply-To: luto@kernel.org, mingo@kernel.org, hpa@zytor.com,
          naveen.n.rao@linux.vnet.ibm.com, mhiramat@kernel.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          keescook@chromium.org, bp@alien8.de, viro@zeniv.linux.org.uk,
          anil.s.keshavamurthy@intel.com, jannh@google.com,
          davem@davemloft.net
In-Reply-To: <20180828201421.157735-8-jannh@google.com>
References: <20180828201421.157735-8-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/core] lkdtm: Test copy_to_user() on bad kernel pointer
 under KERNEL_DS
Git-Commit-ID: bef459026b161fbc39d20dcba698ed0cfffbac38
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bef459026b161fbc39d20dcba698ed0cfffbac38
Gitweb:     https://git.kernel.org/tip/bef459026b161fbc39d20dcba698ed0cfffbac38
Author:     Jann Horn <jannh@google.com>
AuthorDate: Tue, 28 Aug 2018 22:14:21 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 15:12:10 +0200

lkdtm: Test copy_to_user() on bad kernel pointer under KERNEL_DS

Test whether the kernel WARN()s when, under KERNEL_DS, a bad kernel pointer
is used as "userspace" pointer. Should normally be used in "DIRECT" mode.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kees Cook <keescook@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: kernel-hardening@lists.openwall.com
Cc: dvyukov@google.com
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/20180828201421.157735-8-jannh@google.com

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
@@ -322,6 +322,19 @@ free_user:
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
