Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916C3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2DF2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2DF2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbeIGGNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 02:13:07 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:54023 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeIGGNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 02:13:07 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45b91d5b5a52-12d7d; Fri, 07 Sep 2018 09:34:45 +0800 (CST)
X-RM-TRANSID: 2ee45b91d5b5a52-12d7d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35b91d5b364b-0d2aa;
        Fri, 07 Sep 2018 09:34:45 +0800 (CST)
X-RM-TRANSID: 2ee35b91d5b364b-0d2aa
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf tools: use PTR_ERR_OR_ZERO inetead of return code
Date:   Fri,  7 Sep 2018 09:34:42 +0800
Message-Id: <1536284082-23466-2-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536284082-23466-1-git-send-email-dingxiang@cmss.chinamobile.com>
References: <1536284082-23466-1-git-send-email-dingxiang@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use PTR_ERR_OR_ZERO for bpf__setup_stdout return code,
it looks better.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 tools/perf/util/bpf-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 47aac41..f9ae1a9 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1615,7 +1615,7 @@ struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const cha
 int bpf__setup_stdout(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel = bpf__setup_output_event(evlist, "__bpf_stdout__");
-	return IS_ERR(evsel) ? PTR_ERR(evsel) : 0;
+	return PTR_ERR_OR_ZERO(evsel);
 }
 
 #define ERRNO_OFFSET(e)		((e) - __BPF_LOADER_ERRNO__START)
-- 
1.9.1



