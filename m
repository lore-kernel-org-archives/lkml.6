Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127F6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA9C2694F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA9C2694F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934735AbeFZKc6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:32:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36379 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933509AbeFZKcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:32:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5QAVviR1649072
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Jun 2018 03:31:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5QAVvsj1649069;
        Tue, 26 Jun 2018 03:31:57 -0700
Date:   Tue, 26 Jun 2018 03:31:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-26c6ccdf5c06aa83bb78518c72cb287f043db3df@git.kernel.org>
Cc:     benh@kernel.crashing.org, joel.opensrc@gmail.com,
        mark.rutland@arm.com, frederic@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, acme@kernel.org, peterz@infradead.org,
        will.deacon@arm.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        paulus@samba.org, mingo@kernel.org, acme@redhat.com,
        ysato@users.sourceforge.jp, dalias@libc.org, hpa@zytor.com,
        luto@kernel.org, chris@zankel.net, mpe@ellerman.id.au,
        torvalds@linux-foundation.org, jcmvbkbc@gmail.com,
        alexander.shishkin@linux.intel.com
Reply-To: alexander.shishkin@linux.intel.com, jcmvbkbc@gmail.com,
          torvalds@linux-foundation.org, mpe@ellerman.id.au,
          chris@zankel.net, luto@kernel.org, hpa@zytor.com,
          dalias@libc.org, ysato@users.sourceforge.jp, acme@redhat.com,
          mingo@kernel.org, paulus@samba.org, catalin.marinas@arm.com,
          linux-kernel@vger.kernel.org, jolsa@redhat.com,
          peterz@infradead.org, will.deacon@arm.com, acme@kernel.org,
          tglx@linutronix.de, namhyung@kernel.org, frederic@kernel.org,
          joel.opensrc@gmail.com, mark.rutland@arm.com,
          benh@kernel.crashing.org
In-Reply-To: <1529981939-8231-13-git-send-email-frederic@kernel.org>
References: <1529981939-8231-13-git-send-email-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/hw_breakpoint: Clean up and consolidate
 modify_user_hw_breakpoint_check()
Git-Commit-ID: 26c6ccdf5c06aa83bb78518c72cb287f043db3df
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

Commit-ID:  26c6ccdf5c06aa83bb78518c72cb287f043db3df
Gitweb:     https://git.kernel.org/tip/26c6ccdf5c06aa83bb78518c72cb287f043db3df
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 26 Jun 2018 04:58:59 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 26 Jun 2018 09:07:59 +0200

perf/hw_breakpoint: Clean up and consolidate modify_user_hw_breakpoint_check()

Remove the dance around old and new attributes. Just don't modify the
previous breakpoint at all until we have verified everything.

Original-patch-by: Andy Lutomirski <luto@kernel.org>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joel Fernandes <joel.opensrc@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Link: http://lkml.kernel.org/r/1529981939-8231-13-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/hw_breakpoint.c | 44 ++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 71387703b5f1..b3814fce5ecb 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -461,37 +461,43 @@ register_user_hw_breakpoint(struct perf_event_attr *attr,
 }
 EXPORT_SYMBOL_GPL(register_user_hw_breakpoint);
 
+static void hw_breakpoint_copy_attr(struct perf_event_attr *to,
+				    struct perf_event_attr *from)
+{
+	to->bp_addr = from->bp_addr;
+	to->bp_type = from->bp_type;
+	to->bp_len  = from->bp_len;
+	to->disabled = from->disabled;
+}
+
 int
 modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *attr,
 			        bool check)
 {
-	u64 old_addr = bp->attr.bp_addr;
-	u64 old_len  = bp->attr.bp_len;
-	int old_type = bp->attr.bp_type;
-	bool modify  = attr->bp_type != old_type;
 	struct arch_hw_breakpoint hw;
-	int err = 0;
+	int err;
 
-	bp->attr.bp_addr = attr->bp_addr;
-	bp->attr.bp_type = attr->bp_type;
-	bp->attr.bp_len  = attr->bp_len;
+	err = hw_breakpoint_parse(bp, attr, &hw);
+	if (err)
+		return err;
 
-	if (check && memcmp(&bp->attr, attr, sizeof(*attr)))
-		return -EINVAL;
+	if (check) {
+		struct perf_event_attr old_attr;
 
-	err = hw_breakpoint_parse(bp, attr, &hw);
-	if (!err && modify)
-		err = modify_bp_slot(bp, old_type, bp->attr.bp_type);
+		old_attr = bp->attr;
+		hw_breakpoint_copy_attr(&old_attr, attr);
+		if (memcmp(&old_attr, attr, sizeof(*attr)))
+			return -EINVAL;
+	}
 
-	if (err) {
-		bp->attr.bp_addr = old_addr;
-		bp->attr.bp_type = old_type;
-		bp->attr.bp_len  = old_len;
-		return err;
+	if (bp->attr.bp_type != attr->bp_type) {
+		err = modify_bp_slot(bp, bp->attr.bp_type, attr->bp_type);
+		if (err)
+			return err;
 	}
 
+	hw_breakpoint_copy_attr(&bp->attr, attr);
 	bp->hw.info = hw;
-	bp->attr.disabled = attr->disabled;
 
 	return 0;
 }
