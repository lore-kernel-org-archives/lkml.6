Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F3FC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D24825357
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D24825357
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934080AbeF0JK1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:10:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52635 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932187AbeF0JKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:10:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5R9A1KM2025976
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Jun 2018 02:10:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5R9A1NM2025973;
        Wed, 27 Jun 2018 02:10:01 -0700
Date:   Wed, 27 Jun 2018 02:10:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Malaterre <tipbot@zytor.com>
Message-ID: <tip-9331510135640429711afbd0c810686100824a79@git.kernel.org>
Cc:     namhyung@kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, jolsa@redhat.com, malat@debian.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Reply-To: mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, namhyung@kernel.org,
          jolsa@redhat.com, malat@debian.org,
          torvalds@linux-foundation.org, peterz@infradead.org,
          acme@kernel.org, alexander.shishkin@linux.intel.com
In-Reply-To: <20180626202301.20270-1-malat@debian.org>
References: <20180626202301.20270-1-malat@debian.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/core: Move inline keyword at the beginning
 of declaration
Git-Commit-ID: 9331510135640429711afbd0c810686100824a79
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

Commit-ID:  9331510135640429711afbd0c810686100824a79
Gitweb:     https://git.kernel.org/tip/9331510135640429711afbd0c810686100824a79
Author:     Mathieu Malaterre <malat@debian.org>
AuthorDate: Tue, 26 Jun 2018 22:23:00 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 27 Jun 2018 09:55:58 +0200

perf/core: Move inline keyword at the beginning of declaration

Fix non-fatal warning triggered during compilation with W=1:

  kernel/events/core.c:6106:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
   static void __always_inline
   ^~~~~~

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180626202301.20270-1-malat@debian.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80cca2b30c4f..8f0434a9951a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6482,7 +6482,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 		data->phys_addr = perf_virt_to_phys(data->addr);
 }
 
-static void __always_inline
+static __always_inline void
 __perf_event_output(struct perf_event *event,
 		    struct perf_sample_data *data,
 		    struct pt_regs *regs,
