Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE6FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E50220844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E50220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbeIFRjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:39:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41861 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbeIFRjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:39:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86D2Y7V301227
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:02:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86D2Yc5301224;
        Thu, 6 Sep 2018 06:02:34 -0700
Date:   Thu, 6 Sep 2018 06:02:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-cb45302d7c5e20f0c0598cdbd7753fa44daceb2a@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, jolsa@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com, acme@redhat.com,
        oleg@redhat.com, chabbi.milind@gmail.com, frederic@kernel.org
Reply-To: mingo@kernel.org, jolsa@kernel.org, peterz@infradead.org,
          acme@redhat.com, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, dsahern@gmail.com,
          namhyung@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, chabbi.milind@gmail.com, frederic@kernel.org,
          oleg@redhat.com
In-Reply-To: <20180827091228.2878-4-jolsa@kernel.org>
References: <20180827091228.2878-4-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/hw_breakpoint: Remove superfluous
 bp->attr.disabled = 0
Git-Commit-ID: cb45302d7c5e20f0c0598cdbd7753fa44daceb2a
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

Commit-ID:  cb45302d7c5e20f0c0598cdbd7753fa44daceb2a
Gitweb:     https://git.kernel.org/tip/cb45302d7c5e20f0c0598cdbd7753fa44daceb2a
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 27 Aug 2018 11:12:26 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 14:49:23 -0300

perf/hw_breakpoint: Remove superfluous bp->attr.disabled = 0

Once the breakpoint was succesfully modified, the attr->disabled value
is in bp->attr.disabled. So there's no reason to set it again, removing
that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Milind Chabbi <chabbi.milind@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180827091228.2878-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/hw_breakpoint.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index fb229d9c7f3c..3e560d7609fd 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -526,10 +526,9 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
 	if (err)
 		return err;
 
-	if (!attr->disabled) {
+	if (!attr->disabled)
 		perf_event_enable(bp);
-		bp->attr.disabled = 0;
-	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(modify_user_hw_breakpoint);
