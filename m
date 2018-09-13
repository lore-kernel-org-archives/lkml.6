Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68779C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC2020854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC2020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeIMSEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:04:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbeIMSEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:04:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11BD6308338E;
        Thu, 13 Sep 2018 12:55:14 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 301D6600C6;
        Thu, 13 Sep 2018 12:55:12 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 09/48] perf tools: Make copyfile_offset global
Date:   Thu, 13 Sep 2018 14:54:11 +0200
Message-Id: <20180913125450.21342-10-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 13 Sep 2018 12:55:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be used outside of util object in following patches.

Link: http://lkml.kernel.org/n/tip-xgiypvcrmc12u7czcrc27en2@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/util.c | 2 +-
 tools/perf/util/util.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index eac5b858a371..093352e93d50 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -221,7 +221,7 @@ static int slow_copyfile(const char *from, const char *to, struct nsinfo *nsi)
 	return err;
 }
 
-static int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size)
+int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size)
 {
 	void *ptr;
 	loff_t pgoff;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index dc58254a2b69..7fc171b20671 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -80,4 +80,6 @@ void perf_set_multithreaded(void);
 #endif
 #endif
 
+int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size);
+
 #endif /* GIT_COMPAT_UTIL_H */
-- 
2.17.1

