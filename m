Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33E5C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C8F23F6F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C8F23F6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeFVJNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:13:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35921 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbeFVJNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:13:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5M9CrSu018024
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 02:12:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5M9Cqph018021;
        Fri, 22 Jun 2018 02:12:52 -0700
Date:   Fri, 22 Jun 2018 02:12:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Malaterre <tipbot@zytor.com>
Message-ID: <tip-57d6a7938a8fc6cee8420b40ca244220b41721f5@git.kernel.org>
Cc:     mingo@kernel.org, malat@debian.org, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        torvalds@linux-foundation.org, acme@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, malat@debian.org, tglx@linutronix.de,
          jolsa@redhat.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          acme@kernel.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org
In-Reply-To: <20180308202856.9378-1-malat@debian.org>
References: <20180308202856.9378-1-malat@debian.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/core: Move the inline keyword at the
 beginning of the function declaration
Git-Commit-ID: 57d6a7938a8fc6cee8420b40ca244220b41721f5
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

Commit-ID:  57d6a7938a8fc6cee8420b40ca244220b41721f5
Gitweb:     https://git.kernel.org/tip/57d6a7938a8fc6cee8420b40ca244220b41721f5
Author:     Mathieu Malaterre <malat@debian.org>
AuthorDate: Thu, 8 Mar 2018 21:28:56 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 22 Jun 2018 11:07:47 +0200

perf/core: Move the inline keyword at the beginning of the function declaration

When building perf with W=1 the following warning triggers:

  CC      kernel/events/ring_buffer.o
  kernel/events/ring_buffer.c:105:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
   static bool __always_inline
   ^~~~~~
  ...

Move the inline keyword to the beginning of the function declaration.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: trival@kernel.org
Link: http://lkml.kernel.org/r/20180308202856.9378-1-malat@debian.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/ring_buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 1d8ca9ea9979..d11f60cbe8ca 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -103,7 +103,7 @@ out:
 	preempt_enable();
 }
 
-static bool __always_inline
+static __always_inline bool
 ring_buffer_has_space(unsigned long head, unsigned long tail,
 		      unsigned long data_size, unsigned int size,
 		      bool backward)
@@ -114,7 +114,7 @@ ring_buffer_has_space(unsigned long head, unsigned long tail,
 		return CIRC_SPACE(tail, head, data_size) >= size;
 }
 
-static int __always_inline
+static __always_inline int
 __perf_output_begin(struct perf_output_handle *handle,
 		    struct perf_event *event, unsigned int size,
 		    bool backward)
@@ -414,7 +414,7 @@ err:
 }
 EXPORT_SYMBOL_GPL(perf_aux_output_begin);
 
-static bool __always_inline rb_need_aux_wakeup(struct ring_buffer *rb)
+static __always_inline bool rb_need_aux_wakeup(struct ring_buffer *rb)
 {
 	if (rb->aux_overwrite)
 		return false;
