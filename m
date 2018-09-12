Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE59C07520
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BAC2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Afb7smz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BAC2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeIMABV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbeIMABU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:01:20 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52D7820882;
        Wed, 12 Sep 2018 18:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536778529;
        bh=A/ZAcd9vwLhqeF8NfxvkuHI+mIc7xYiRdKXaGABFEI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Afb7smz8SEmUZO5jgGSAls1lp4Z46mWqqWwhP8K86mp1wwwvhN09pB+ZnrSxKf9j5
         B6wJqTzEM0KAAeUol8Hf8Ax/tk+gDyYvU3mlG9/rS/z28a/vWXRlCq+U5GYx3gBhk5
         b1DxwoQrDdwMdQkFBZ55jZyv90VI9DMAtdfxLpnk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 1/7] tools headers uapi: Update tools's copy of linux/perf_event.h
Date:   Wed, 12 Sep 2018 15:55:03 -0300
Message-Id: <20180912185509.32187-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180912185509.32187-1-acme@kernel.org>
References: <20180912185509.32187-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

