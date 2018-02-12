Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbeBLUcu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:32:50 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38511 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753193AbeBLUco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:32:44 -0500
X-Google-Smtp-Source: AH8x227H05fQSQmrzdHQKFbkem5pZLjEpO+lq0nTMLpGaspqhPoQIsjqYyytmn5ax8fi9r7x64a7zA==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        yao.jin@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf tools: Fixing uninitialised variable
Date: Mon, 12 Feb 2018 13:32:37 -0700
Message-Id: <1518467557-18505-4-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518467557-18505-1-git-send-email-mathieu.poirier@linaro.org>
References: <1518467557-18505-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When working natively on arm64 the compiler gets pesky and complains
that variable 'i' is uninitialised, something that breaks the
compilation.  Here no further checks are needed since variable 'found_spe'
can only be true if variable 'i' has been initialised as part of the for
loop.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/auxtrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 2323581b157d..fa639e3e52ac 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -68,7 +68,7 @@ struct auxtrace_record
 	bool found_spe = false;
 	static struct perf_pmu **arm_spe_pmus = NULL;
 	static int nr_spes = 0;
-	int i;
+	int i = 0;
 
 	if (!evlist)
 		return NULL;
-- 
2.7.4
