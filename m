Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E98C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30D020855
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30D020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbeKJNFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 08:05:42 -0500
Received: from air.basealt.ru ([194.107.17.39]:58768 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbeKJNFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 08:05:42 -0500
Received: by air.basealt.ru (Postfix, from userid 490)
        id 1C3F6589A9A; Sat, 10 Nov 2018 03:22:13 +0000 (UTC)
Received: from akathisia (ip4-83-240-49-150.cust.nbox.cz [83.240.49.150])
        by air.basealt.ru (Postfix) with ESMTPSA id 3D7B6589A97;
        Sat, 10 Nov 2018 03:22:11 +0000 (UTC)
Date:   Sat, 10 Nov 2018 04:22:09 +0100
From:   Elvira Khabirova <lineprinter@altlinux.org>
To:     oleg@redhat.com, mingo@redhat.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, ldv@altlinux.org
Subject: [PATCH] tracehook: fix documentation for
 tracehook_report_syscall_entry()
Message-ID: <20181110042209.26333972@akathisia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tracehook_report_syscall_entry() is called not only
if %TIF_SYSCALL_TRACE is set, but also if %TIF_SYSCALL_EMU is set,
as appears from x86's entry code.

Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
---
 include/linux/tracehook.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 40b0b4c1bf7b..df20f8bdbfa3 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -83,8 +83,8 @@ static inline int ptrace_report_syscall(struct pt_regs *regs)
  * tracehook_report_syscall_entry - task is about to attempt a system call
  * @regs:		user register state of current task
  *
- * This will be called if %TIF_SYSCALL_TRACE has been set, when the
- * current task has just entered the kernel for a system call.
+ * This will be called if %TIF_SYSCALL_TRACE or %TIF_SYSCALL_EMU have been set,
+ * when the current task has just entered the kernel for a system call.
  * Full user register state is available here.  Changing the values
  * in @regs can affect the system call number and arguments to be tried.
  * It is safe to block here, preventing the system call from beginning.
-- 
2.19.1

