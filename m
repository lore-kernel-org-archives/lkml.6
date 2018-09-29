Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905B7C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6012B2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6012B2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeI2N3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 09:29:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54259 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbeI2N3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 09:29:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8T71uX5726385
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 29 Sep 2018 00:01:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8T71uwR726382;
        Sat, 29 Sep 2018 00:01:56 -0700
Date:   Sat, 29 Sep 2018 00:01:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-0a701c9dd5351cbaef1677a0c8d37950e158cd55@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        reinette.chatre@intel.com, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org
Reply-To: peterz@infradead.org, reinette.chatre@intel.com,
          tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <1822f6164e221a497648d108913d056ab675d5d0.1537377064.git.reinette.chatre@intel.com>
References: <1822f6164e221a497648d108913d056ab675d5d0.1537377064.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Create required perf event
 attributes
Git-Commit-ID: 0a701c9dd5351cbaef1677a0c8d37950e158cd55
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

Commit-ID:  0a701c9dd5351cbaef1677a0c8d37950e158cd55
Gitweb:     https://git.kernel.org/tip/0a701c9dd5351cbaef1677a0c8d37950e158cd55
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Wed, 19 Sep 2018 10:29:09 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Sep 2018 22:48:27 +0200

x86/intel_rdt: Create required perf event attributes

A perf event has many attributes that are maintained in a separate
structure that should be provided when a new perf_event is created.

In preparation for the transition to perf_events the required attribute
structures are created for all the events that may be used in the
measurements. Most attributes for all the events are identical. The
actual configuration, what specifies what needs to be measured, is what
will be different between the events used. This configuration needs to
be done with X86_CONFIG that cannot be used as part of the designated
initializers used here, this will be introduced later.

Although they do look identical at this time the attribute structures
needs to be maintained separately since a perf_event will maintain a
pointer to its unique attributes.

In support of patch testing the new structs are given the unused attribute
until their use in later patches.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: acme@kernel.org
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/1822f6164e221a497648d108913d056ab675d5d0.1537377064.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 8ad83eb3fc89..33d7968f152a 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -17,6 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/kthread.h>
 #include <linux/mman.h>
+#include <linux/perf_event.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -915,6 +916,31 @@ static int measure_cycles_lat_fn(void *_plr)
 	return 0;
 }
 
+/*
+ * Create a perf_event_attr for the hit and miss perf events that will
+ * be used during the performance measurement. A perf_event maintains
+ * a pointer to its perf_event_attr so a unique attribute structure is
+ * created for each perf_event.
+ *
+ * The actual configuration of the event is set right before use in order
+ * to use the X86_CONFIG macro.
+ */
+static struct perf_event_attr __attribute__((unused)) perf_miss_attr = {
+	.type		= PERF_TYPE_RAW,
+	.size		= sizeof(struct perf_event_attr),
+	.pinned		= 1,
+	.disabled	= 0,
+	.exclude_user	= 1,
+};
+
+static struct perf_event_attr __attribute__((unused)) perf_hit_attr = {
+	.type		= PERF_TYPE_RAW,
+	.size		= sizeof(struct perf_event_attr),
+	.pinned		= 1,
+	.disabled	= 0,
+	.exclude_user	= 1,
+};
+
 static int measure_cycles_perf_fn(void *_plr)
 {
 	unsigned long long l3_hits = 0, l3_miss = 0;
