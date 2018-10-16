Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDDAC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3932148E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YPx2z2OG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3932148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeJQHq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:46:57 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:52942 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeJQHqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:46:55 -0400
Received: by mail-vk1-f201.google.com with SMTP id o188-v6so6420367vke.19
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QsZ3was/QkGUo6BYsP86tczumclzu/oVJ8cXDvZ38AM=;
        b=YPx2z2OGVftv8Dgf9hsP/BheUOYZFFBIJGxjmrXiQJYj4a1tn1kaNN09vpi1NKcpm2
         JAZ8twZJiDMzSLhE+Mh397wmrl9kofyv/dOYsA4HBUqYXjYVAc0ZT6pON/EHIJaYUT2B
         9jwfmA2gJxOXt1amkDD6rO+kaCLxft4cJg2eyLovzY/K0a7FvFC2VmYJ/IRq8ioWyYER
         G+9z/EDxYQMHTe5+Ld4lCNch12O10HzHmHkaRi5j/bLIhl/lKlSYzqW2f10LyWJ4n3XD
         Uvj/JkYva3y5wiRudK4WLtPONTRM51xi4AMDENu5RyPMsKIxm3H8Dn2ACpQ9JTB3V+wW
         iB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QsZ3was/QkGUo6BYsP86tczumclzu/oVJ8cXDvZ38AM=;
        b=rsGJqtMknCMh8iom54n5zCkeh5NaQq1dse0qiTV2p30+bJnQTLciifGZNcSUJqmohV
         OIMI5cdS+AIEa7wA5el70M2jku1aEncf8+9PZURDB9fomylVP6g900n41TEmHXXPs2Fa
         e6u1A4JVNCs5zV3mAK33UqngWRdmhKFVI/NG4Zm8mLVGTC8iMTEv2w7E4Ep99jgqtGn4
         A9M8PF50cbmFC2quEDUw5K3l+p/l/sAnqXXBIb1qSZ9fMnsnJU6lW9v5/F3nDkQX86sW
         RMMQEc+xo3PyHFtQ6japjaDQIALfvAX9bYftd+i5WByyZHcGr9LIJJWmqRD7jKsTAbsR
         NnSg==
X-Gm-Message-State: ABuFfoge7KqWhkWmlfzFmuuckbEkQLZM7DXbri24oM4hFdpMzVn2wOWH
        2JK8JwNgdZUp12AFz0nYlBSBnoMzeGv65JeQ5oaNRQ==
X-Google-Smtp-Source: ACcGV60TLAfJsKdTy2qQsKGEQgz5iDLsnZOMXyseSry9uD/hbZHFRPqzws3bKPdJyVvsNAbfBdbXDALvGPxOk4AAqTFd0g==
X-Received: by 2002:a67:4551:: with SMTP id s78mr23044696vsa.12.1539734046197;
 Tue, 16 Oct 2018 16:54:06 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:50:57 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 08/31] arch: um: added shim to trap to allow installing a
 fault catcher for tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added context to current thread that allows a test to specify that it
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
index ec9a42c14c565..9b97712daf14f 100644
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
2.19.1.331.ge82ca0e54c-goog

