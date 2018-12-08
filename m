Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F51CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178C42082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178C42082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeLHLbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 06:31:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56035 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLHLbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 06:31:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB8BVUWR2513199
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 8 Dec 2018 03:31:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB8BVUOd2513196;
        Sat, 8 Dec 2018 03:31:30 -0800
Date:   Sat, 8 Dec 2018 03:31:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-4b1bacab61aa252d15dde99cd0440a965bd863e5@git.kernel.org>
Cc:     mingo@kernel.org, bp@suse.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, mhiramat@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, bp@suse.de,
          mingo@kernel.org
In-Reply-To: <20181205162526.GB109259@gmail.com>
References: <20181205162526.GB109259@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/kprobes: Remove trampoline_handler()
 prototype
Git-Commit-ID: 4b1bacab61aa252d15dde99cd0440a965bd863e5
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

Commit-ID:  4b1bacab61aa252d15dde99cd0440a965bd863e5
Gitweb:     https://git.kernel.org/tip/4b1bacab61aa252d15dde99cd0440a965bd863e5
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 7 Dec 2018 20:38:09 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 8 Dec 2018 12:25:12 +0100

x86/kprobes: Remove trampoline_handler() prototype

... and make it static. It is called only by the kretprobe_trampoline()
from asm.

It was marked __visible so that it is visible outside of the current
compilation unit but that is not needed as it is used only in this
compilation unit.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/20181205162526.GB109259@gmail.com
---
 arch/x86/kernel/kprobes/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 6480056d370f..308bf103cc73 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -66,8 +66,6 @@
 
 #include "common.h"
 
-void *trampoline_handler(struct pt_regs *regs);
-
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
@@ -753,7 +751,7 @@ STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
 /*
  * Called from kretprobe_trampoline
  */
-__visible __used void *trampoline_handler(struct pt_regs *regs)
+static __used void *trampoline_handler(struct pt_regs *regs)
 {
 	struct kretprobe_instance *ri = NULL;
 	struct hlist_head *head, empty_rp;
