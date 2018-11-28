Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3847EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F025F208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DUCrY0+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F025F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbeK2Gkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:40:49 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:34192 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeK2Gks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:40:48 -0500
Received: by mail-it1-f201.google.com with SMTP id j202so3601321itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 11:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9D74vhDKZ9zweNX8bjF2N0Y9OEVlGStLvbWGF8he3rU=;
        b=DUCrY0+bV3RwL0ek8kOGRSVO5v/D47qxtVHPVDyn/P0PBKfO7J+dAaLFJrHg6KA1H4
         scBxeWPlXg29nrqLVQjBexctKZKf4sJRPuMm2gWIyWNVYbIwQ8repGuBGke3MQgytZ0U
         0nWC9xlfOhMq9UV4wdHPOgiwRjjDbXnX672v/DOPwZrEL9SOKJro1mHudBWDcjR9XkAh
         xupw6E5Ty3A8oacOVm8zPZtMgBf2sTDwvSq0NPCwnsMtj+6r/YHj3x4778++02hbv/HY
         OApKXZoGIN/lngkLyyBTy92qH6Q1D1NtX26NvOt9gLsQtKYf2qXcWdbomlD1Lp1DPHVR
         leyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9D74vhDKZ9zweNX8bjF2N0Y9OEVlGStLvbWGF8he3rU=;
        b=L8uv3tAjfQioqxqxFfkptvMvKpmEffpSbq0Z0hPhlwA8EIzPOSwZZFGFa/nqihgpFg
         L/2m3YeIG1iQgwSuLSCFTL5Q5ndyHTrACETq2B5EKDg4ENeWhfUwHb+r7HDaikHMh2wY
         mhcykHDWSZrxD7smdfnl94pJRkAR13f2GfPNuC1wfkGcTRUjFdFMQfrAV7k1TjRGDDPy
         VbUjajLIvvrwN9f9Ope6UshAoi8WlH9iN5fPCMXahJeA0Guvmyph1uRhBfMjQvtEqxCZ
         zDpWtHj0eNDM/eWMoUOw9zL80rhU/yYZHkK3Ved0EewDYUExenPNpa0AaL10il0XzmyU
         RXKQ==
X-Gm-Message-State: AA+aEWaCUXSAeCt/NY9CQuAzDm36OnOZZQAnw7lH5H9n325C3rtgR1tX
        4bsriW68lUtCKBfob3EyAS29SNeynBnBmmWOg/5EBw==
X-Google-Smtp-Source: AFSGD/UMhQyCRg6KQGlfagnXK2iwxLqCIGZ8HodTaJ7DpYmtIhCG98itNlSoTEwnNmng08QDMUsUiZnMCHqxdM/0JGaFXw==
X-Received: by 2002:a24:74b:: with SMTP id f72-v6mr3353404itf.35.1543433883605;
 Wed, 28 Nov 2018 11:38:03 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:36:25 -0800
In-Reply-To: <20181128193636.254378-1-brendanhiggins@google.com>
Message-Id: <20181128193636.254378-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
Subject: [RFC v3 08/19] arch: um: add shim to trap to allow installing a fault
 catcher for tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, frowand.list@gmail.com,
        knut.omang@oracle.com, Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add context to current thread that allows a test to specify that it
wants to skip the normal checks to run an installed fault catcher.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/include/asm/processor-generic.h |  4 +++-
 arch/um/kernel/trap.c                   | 15 +++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index b58b746d3f2ca..d566cd416ff02 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -27,6 +27,7 @@ struct thread_struct {
 	struct task_struct *prev_sched;
 	struct arch_thread arch;
 	jmp_buf switch_buf;
+	bool is_running_test;
 	struct {
 		int op;
 		union {
@@ -51,7 +52,8 @@ struct thread_struct {
 	.fault_addr		= NULL, \
 	.prev_sched		= NULL, \
 	.arch			= INIT_ARCH_THREAD, \
-	.request		= { 0 } \
+	.request		= { 0 }, \
+	.is_running_test	= false, \
 }
 
 static inline void release_thread(struct task_struct *task)
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index cced829460427..bf90e678b3d71 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -201,6 +201,12 @@ void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
 }
 
+static void segv_run_catcher(jmp_buf *catcher, void *fault_addr)
+{
+	current->thread.fault_addr = fault_addr;
+	UML_LONGJMP(catcher, 1);
+}
+
 /*
  * We give a *copy* of the faultinfo in the regs to segv.
  * This must be done, since nesting SEGVs could overwrite
@@ -219,7 +225,10 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 	if (!is_user && regs)
 		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
 
-	if (!is_user && (address >= start_vm) && (address < end_vm)) {
+	catcher = current->thread.fault_catcher;
+	if (catcher && current->thread.is_running_test)
+		segv_run_catcher(catcher, (void *) address);
+	else if (!is_user && (address >= start_vm) && (address < end_vm)) {
 		flush_tlb_kernel_vm();
 		goto out;
 	}
@@ -246,12 +255,10 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 		address = 0;
 	}
 
-	catcher = current->thread.fault_catcher;
 	if (!err)
 		goto out;
 	else if (catcher != NULL) {
-		current->thread.fault_addr = (void *) address;
-		UML_LONGJMP(catcher, 1);
+		segv_run_catcher(catcher, (void *) address);
 	}
 	else if (current->thread.fault_addr != NULL)
 		panic("fault_addr set but no fault catcher");
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

