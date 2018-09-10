Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E2DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA8420865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA8420865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeIJPCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:02:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43753 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeIJPCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:02:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AA8vLc1807133
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:08:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AA8u5t1807130;
        Mon, 10 Sep 2018 03:08:56 -0700
Date:   Mon, 10 Sep 2018 03:08:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-da260fe12330be8b003c2ab07a112704163ea675@git.kernel.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de,
        peterz@infradead.org, rostedt@goodmis.org, bp@suse.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, jbaron@akamai.com,
        jpoimboe@redhat.com, hpa@zytor.com
Reply-To: bp@suse.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
          jpoimboe@redhat.com, jbaron@akamai.com, hpa@zytor.com,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          peterz@infradead.org, rostedt@goodmis.org
In-Reply-To: <20180907103521.31344-1-bp@alien8.de>
References: <20180907103521.31344-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] jump_label: Fix typo in warning message
Git-Commit-ID: da260fe12330be8b003c2ab07a112704163ea675
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

Commit-ID:  da260fe12330be8b003c2ab07a112704163ea675
Gitweb:     https://git.kernel.org/tip/da260fe12330be8b003c2ab07a112704163ea675
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 7 Sep 2018 12:35:21 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 10:15:48 +0200

jump_label: Fix typo in warning message

There's no 'allocatote' - use the next best thing: 'allocate' :-)

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180907103521.31344-1-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/jump_label.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 01ebdf1f9f40..2e62503bea0d 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -678,7 +678,7 @@ jump_label_module_notify(struct notifier_block *self, unsigned long val,
 	case MODULE_STATE_COMING:
 		ret = jump_label_add_module(mod);
 		if (ret) {
-			WARN(1, "Failed to allocatote memory: jump_label may not work properly.\n");
+			WARN(1, "Failed to allocate memory: jump_label may not work properly.\n");
 			jump_label_del_module(mod);
 		}
 		break;
