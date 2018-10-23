Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B766C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF5C20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPSOrUgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF5C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeJXMRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:17:47 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37763 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeJXMRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:17:47 -0400
Received: by mail-pg1-f202.google.com with SMTP id u43-v6so1909208pgn.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 20:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AZXGizRDYB34OjNAQjmrfiUD+eNMXlsWMwWZ+590v6s=;
        b=WPSOrUggU3rnluD6CS22h/UnyXqz+yZgPhghBy1ulhS1ExIvkAlgrPhT2pxavu/1Yy
         /M40uBDuFS/4BLISVGD2wj64ZxwEpD2qeFrLkiswC9i0L9hxosRGOVWsaVfMHjE5FvGr
         g79xGMLyciKHemaRWT56krnP6UJujxt5kaMn8WSJaoJwxTiNjRukz0B1zjtDGsnlPF+j
         oGrxUJa7w0u2dw4cUSntMXlUdM2cO4WeX/hemjsNn3JuNvqsObmNw14i9i6V6bk2XlJ0
         eAUrn1wx5scw40yF22chLWPdwFc02fYz0s/RtLtbYteaFDBgQeDwtBEuaCIWIFNYKcah
         FQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AZXGizRDYB34OjNAQjmrfiUD+eNMXlsWMwWZ+590v6s=;
        b=mawlymbwIjXt5rgLgUzI6NyLz4OG3mV/1BBRpTKPIjnyhU0IRujPVbV7/1hM0agl2Z
         baSH+wt2Yv4XTGWWYkArjKdAg2NU2RlSGwDALR9wRwmm9SNh38B9UcoDdGumN0lJXY9J
         ZA5P013WbqcvVt7C+stp1Ec1CqMIX0OJC2NW0g80ZEux3HCo6Cr5Mo8zGTlVTxKEuMqA
         bF/fBz/t2Np/UipLW6oSt1lp/HRXsuNf/MyVGR5WaZhU+kp0IhacKuHwz3I85J/IZ+GS
         c6qtlOYgGn42d+b/G7vF76QHnpfExzX2BFlh10gN1KB3ag1Qy4MIiqcOUZefFRLaDYkE
         wNHQ==
X-Gm-Message-State: AGRZ1gKFOxQLJJMJbHaRCu6aMT5+U3sNc2z6Th3BjCJRb0pOF3+2B/AL
        QPlKOesrVIfN6EAkQq7aIec37EdbDOuAa0B9FrJKiQ==
X-Google-Smtp-Source: AJdET5eqXAp+/iws1KPP7vDDWFDc90iv2ui+fE+0/W/M6tvyz4dYd5p4tqPvTkGZUaE8z6wekIB4P0Fo77lczqOisUKd/Q==
X-Received: by 2002:a63:f1d:: with SMTP id e29-v6mr249762pgl.13.1540339197533;
 Tue, 23 Oct 2018 16:59:57 -0700 (PDT)
Date:   Tue, 23 Oct 2018 16:57:44 -0700
In-Reply-To: <20181023235750.103146-1-brendanhiggins@google.com>
Message-Id: <20181023235750.103146-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181023235750.103146-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [RFC v2 08/14] arch: um: add shim to trap to allow installing a fault
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
        kieran.bingham@ideasonboard.com,
        Brendan Higgins <brendanhiggins@google.com>
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
2.19.1.568.g152ad8e336-goog

