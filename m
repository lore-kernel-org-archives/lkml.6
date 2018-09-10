Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31A4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DB72086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DB72086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeIJMs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:48:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52473 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeIJMs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:48:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8A7spdE1769825
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 00:54:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8A7sp861769821;
        Mon, 10 Sep 2018 00:54:51 -0700
Date:   Mon, 10 Sep 2018 00:54:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-34e12b864e617ca7e4f6a3108460aa143bf20056@git.kernel.org>
Cc:     jbaron@akamai.com, peterz@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org,
        bp@suse.de, hpa@zytor.com, jpoimboe@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de
Reply-To: jpoimboe@redhat.com, tglx@linutronix.de, rostedt@goodmis.org,
          bp@suse.de, torvalds@linux-foundation.org, mingo@kernel.org,
          paulmck@linux.vnet.ibm.com, hpa@zytor.com,
          akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
          jbaron@akamai.com, peterz@infradead.org
In-Reply-To: <20180909114252.17575-1-bp@alien8.de>
References: <20180909114252.17575-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] jump_label: Use static_key_linked() accessor
Git-Commit-ID: 34e12b864e617ca7e4f6a3108460aa143bf20056
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

Commit-ID:  34e12b864e617ca7e4f6a3108460aa143bf20056
Gitweb:     https://git.kernel.org/tip/34e12b864e617ca7e4f6a3108460aa143bf20056
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sun, 9 Sep 2018 13:42:52 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 08:23:37 +0200

jump_label: Use static_key_linked() accessor

... instead of open-coding it, in static_key_mod().

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180909114252.17575-1-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/jump_label.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 01ebdf1f9f40..61d1c0178731 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -455,7 +455,7 @@ struct static_key_mod {
 
 static inline struct static_key_mod *static_key_mod(struct static_key *key)
 {
-	WARN_ON_ONCE(!(key->type & JUMP_TYPE_LINKED));
+	WARN_ON_ONCE(!static_key_linked(key));
 	return (struct static_key_mod *)(key->type & ~JUMP_TYPE_MASK);
 }
 
