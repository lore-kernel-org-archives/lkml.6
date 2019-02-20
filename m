Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BC5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F602086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550665704;
	bh=cSrex/i7Z1kunP7Vmq3IrO/U2yFgBeCHXeIFGluPM6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hh8Mqe8x0L8fbkFnrWIzHQCpn5CyFvjgmPD7DQcJ4UhgUTPxq0bNxmcdGNyMhQi38
	 9cZtE5lNsuzWYOVRm8hhlA8/0iye2Wn9vUbGL1/EIHfEv1vvpP3M9ibIi0FdaHQ230
	 n7d0tYE4OH+eq6+91Ckthg1N5Q+7NOV84ZnZufUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfBTM2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:28:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbfBTM2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:28:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7B893DDB3;
        Wed, 20 Feb 2019 12:28:12 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36BB4600C0;
        Wed, 20 Feb 2019 12:28:11 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 5/6] perf tools: Increase debug leve for cpu_map__snprint verbose output
Date:   Wed, 20 Feb 2019 13:27:59 +0100
Message-Id: <20190220122800.864-6-jolsa@kernel.org>
In-Reply-To: <20190220122800.864-1-jolsa@kernel.org>
References: <20190220122800.864-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 20 Feb 2019 12:28:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So it does not screw up single -v verbose output.

Link: http://lkml.kernel.org/n/tip-4ucm1kfmy1xwp9w8xohdzirq@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/cpumap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 0bbc3feb0894..0b599229bc7e 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -681,7 +681,7 @@ size_t cpu_map__snprint(struct cpu_map *map, char *buf, size_t size)
 
 #undef COMMA
 
-	pr_debug("cpumask list: %s\n", buf);
+	pr_debug2("cpumask list: %s\n", buf);
 	return ret;
 }
 
-- 
2.17.2

