Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC66C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FDD208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FDD208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbeGaHkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:40:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46215 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeGaHkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:40:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6V60r0G2594130
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 23:00:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6V60rrf2594127;
        Mon, 30 Jul 2018 23:00:53 -0700
Date:   Mon, 30 Jul 2018 23:00:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-o64mjoy35s9gd1gitunw1zg4@git.kernel.org>
Cc:     bhole_prashant_q7@lab.ntt.co.jp, peterz@infradead.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com, acme@redhat.com,
        alexander.shishkin@linux.intel.com, eranian@google.com,
        adrian.hunter@intel.com, namhyung@kernel.org, jolsa@kernel.org,
        wangnan0@huawei.com, tglx@linutronix.de, vincent.weaver@maine.edu,
        hpa@zytor.com, dsahern@gmail.com, mingo@kernel.org
Reply-To: vincent.weaver@maine.edu, hpa@zytor.com, dsahern@gmail.com,
          mingo@kernel.org, bhole_prashant_q7@lab.ntt.co.jp,
          acme@redhat.com, jpoimboe@redhat.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          eranian@google.com, namhyung@kernel.org, adrian.hunter@intel.com,
          wangnan0@huawei.com, jolsa@kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Update tools's copy of
 linux/perf_event.h
Git-Commit-ID: 2c3ee0e1779d2e08bc08734bc8475daaf94d0ba4
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

Commit-ID:  2c3ee0e1779d2e08bc08734bc8475daaf94d0ba4
Gitweb:     https://git.kernel.org/tip/2c3ee0e1779d2e08bc08734bc8475daaf94d0ba4
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 30 Jul 2018 11:41:56 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 30 Jul 2018 11:41:56 -0300

tools headers uapi: Update tools's copy of linux/perf_event.h

To get the changes in:

  6cbc304f2f36 ("perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)")

That do not imply any changes in the tooling side, the (ab)use of
sample_type is entirely done in kernel space, nothing for userspace to
witness here.

This cures the following warning during perf's build:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-o64mjoy35s9gd1gitunw1zg4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b8e288a1f740..eeb787b1c53c 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -143,6 +143,8 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 
 	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
+
+	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63,
 };
 
 /*
