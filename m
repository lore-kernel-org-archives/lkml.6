Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085DCECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B985820868
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B985820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbeGTLsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:48:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731470AbeGTLsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:48:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8097C40251D4;
        Fri, 20 Jul 2018 11:00:41 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33B1C111DCF5;
        Fri, 20 Jul 2018 11:00:40 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 3/4] perf tools: Fix check-headers.sh output file variables
Date:   Fri, 20 Jul 2018 13:00:35 +0200
Message-Id: <20180720110036.32251-3-jolsa@kernel.org>
In-Reply-To: <20180720110036.32251-1-jolsa@kernel.org>
References: <20180720110036.32251-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 20 Jul 2018 11:00:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 20 Jul 2018 11:00:41 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The warning message in check_w function uses wrongly
the $file variable instead of $file1 and $file2.

Fixes: 582472973593 ("perf check-headers.sh: Add support to check 2 independent files")
Link: http://lkml.kernel.org/n/tip-oh56ckqztoc07we7mtdphu7r@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/check-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 814aaf269949..73e723675c5f 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -67,7 +67,7 @@ check_2 () {
   cmd="diff $* $file1 $file2 > /dev/null"
 
   test -f $file2 &&
-  eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
+  eval $cmd || echo "Warning: Kernel ABI header at '$file1' differs from latest version at '$file2'" >&2
 }
 
 check () {
-- 
2.17.1

