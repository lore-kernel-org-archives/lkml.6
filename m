Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5807AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295172086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550665696;
	bh=mHPXvQXgi6PPrk87iod56gzaIhNLo/j/GmWEjxjWRbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tgY5ZaK+AmdFKnimYSvDWiaf2IG7J1nra0gf7XVcq/LgdZ4OxL4RfMaUUuHTv7gOa
	 5wPiVQhU5aPaQEATEcq4ZTHBFn9rgSotQPPlDybyhVv+++dy8D1iYCZlN5J8PB6H+s
	 Zd4aBkYLfASlhg7sAhLMGPQ9K9obVkh2vnQngdro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfBTM2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:28:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfBTM2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:28:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E29AD81F35;
        Wed, 20 Feb 2019 12:28:10 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40592600C0;
        Wed, 20 Feb 2019 12:28:09 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 4/6] perf tools: Add missing new line into pr_debug call
Date:   Wed, 20 Feb 2019 13:27:58 +0100
Message-Id: <20190220122800.864-5-jolsa@kernel.org>
In-Reply-To: <20190220122800.864-1-jolsa@kernel.org>
References: <20190220122800.864-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 20 Feb 2019 12:28:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding missing new line into pr_debug call in
perf_event__synthesize_bpf_events function,
so the error message does not screw the verbose
output.

Link: http://lkml.kernel.org/n/tip-z9h6x8v1mef0iqsfx6m28nf2@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/bpf-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 62dda96b0096..028c8ec1f62a 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -233,7 +233,7 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
 				err = 0;
 				break;
 			}
-			pr_debug("%s: can't get next program: %s%s",
+			pr_debug("%s: can't get next program: %s%s\n",
 				 __func__, strerror(errno),
 				 errno == EINVAL ? " -- kernel too old?" : "");
 			/* don't report error on old kernel or EPERM  */
-- 
2.17.2

