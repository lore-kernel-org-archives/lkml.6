Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8661C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F44A20C0A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F44A20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeIMAZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:25:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35183 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbeIMAZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:25:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8CJIrIm2743956
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Sep 2018 12:18:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8CJIrDP2743953;
        Wed, 12 Sep 2018 12:18:53 -0700
Date:   Wed, 12 Sep 2018 12:18:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-2vvwh2o19orn56di0ksrtgzr@git.kernel.org>
Cc:     dsahern@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@kernel.org,
        namhyung@kernel.org, mingo@kernel.org, acme@redhat.com,
        wangnan0@huawei.com, adrian.hunter@intel.com, peterz@infradead.org
Reply-To: peterz@infradead.org, adrian.hunter@intel.com,
          wangnan0@huawei.com, acme@redhat.com, mingo@kernel.org,
          namhyung@kernel.org, jolsa@kernel.org, hpa@zytor.com,
          dsahern@gmail.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Update tools's copy of
 linux/perf_event.h
Git-Commit-ID: 0ee03d936cbb300309ed6154ac1cc12b63e9785f
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

Commit-ID:  0ee03d936cbb300309ed6154ac1cc12b63e9785f
Gitweb:     https://git.kernel.org/tip/0ee03d936cbb300309ed6154ac1cc12b63e9785f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 11 Sep 2018 10:57:13 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 11 Sep 2018 10:57:13 -0300

tools headers uapi: Update tools's copy of linux/perf_event.h

To get the changes in:

	09121255c784 ("perf/UAPI: Clearly mark __PERF_SAMPLE_CALLCHAIN_EARLY as internal use")

This cures the following warning during perf's build:

	Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
	diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2vvwh2o19orn56di0ksrtgzr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index eeb787b1c53c..f35eb72739c0 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -144,7 +144,7 @@ enum perf_event_sample_format {
 
 	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
 
-	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63,
+	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
 
 /*
