Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EB9C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EFE20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EFE20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeLKP0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:26:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60113 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeLKP0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:26:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFPXhG4040912
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:25:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFPX0e4040907;
        Tue, 11 Dec 2018 07:25:33 -0800
Date:   Tue, 11 Dec 2018 07:25:33 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-ac862d9b2fd084b50ee7a332a35d8d8d3228ce09@git.kernel.org>
Cc:     longman@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, sasha.levin@oracle.com, bvanassche@acm.org,
        torvalds@linux-foundation.org, johannes@sipsolutions.net
Reply-To: longman@redhat.com, peterz@infradead.org, tglx@linutronix.de,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          bvanassche@acm.org, sasha.levin@oracle.com, hpa@zytor.com,
          johannes@sipsolutions.net, torvalds@linux-foundation.org
In-Reply-To: <20181207011148.251812-7-bvanassche@acm.org>
References: <20181207011148.251812-7-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/lib/lockdep: Add dummy
 print_irqtrace_events() implementation
Git-Commit-ID: ac862d9b2fd084b50ee7a332a35d8d8d3228ce09
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

Commit-ID:  ac862d9b2fd084b50ee7a332a35d8d8d3228ce09
Gitweb:     https://git.kernel.org/tip/ac862d9b2fd084b50ee7a332a35d8d8d3228ce09
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 6 Dec 2018 17:11:30 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 14:54:50 +0100

tools/lib/lockdep: Add dummy print_irqtrace_events() implementation

This patch avoids that linking against liblockdep fails due to no
print_irqtrace_events() definition being available.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: johannes.berg@intel.com
Cc: tj@kernel.org
Link: https://lkml.kernel.org/r/20181207011148.251812-7-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/lib/lockdep/lockdep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/lockdep/lockdep.c b/tools/lib/lockdep/lockdep.c
index 6002fcf2f9bc..348a9d0fb766 100644
--- a/tools/lib/lockdep/lockdep.c
+++ b/tools/lib/lockdep/lockdep.c
@@ -15,6 +15,11 @@ u32 prandom_u32(void)
 	abort();
 }
 
+void print_irqtrace_events(struct task_struct *curr)
+{
+	abort();
+}
+
 static struct new_utsname *init_utsname(void)
 {
 	static struct new_utsname n = (struct new_utsname) {
