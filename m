Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D31FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1A52147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550712425;
	bh=fF8aET/NaVGy4XciD+dwF2gkaa2U+SpViMUC+pmL85o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xZk11J8wa5LUju+ACJaf3KOlq+eh5k5Ll4YfJKZY9O5nLtwpqgkPzFO3vbwdHRcQq
	 nOhud8luJJvW8/r38QMSMhXHBn7/dswqMQtC6ph4RdlsEDuA9bSSTaIT+qR0wEpxbe
	 vKmnnIAcA6OnuDiMNCOhSoXTPCtbBJED/340Ja28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfBUB1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:27:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbfBUB1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:27:02 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.102.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E4582089F;
        Thu, 21 Feb 2019 01:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550712421;
        bh=fF8aET/NaVGy4XciD+dwF2gkaa2U+SpViMUC+pmL85o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGrb0VeAxC3DW9fC4VVKa0L5hNU92jHA+QsoV6O/T8uKPwuQDchH2P1J95g4ozP6b
         jbb/wfBYZSiHVw0sAh4ymnoeUTWSBpxkH9tFnZk7CnjeoyEQw/cRFRfVMc6lVfmP3Z
         mAxtsQQymOYjFstt030BQ50f108aTTPtYBvOb5s0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/17] perf cpumap: Increase debug level for cpu_map__snprint verbose output
Date:   Wed, 20 Feb 2019 22:25:48 -0300
Message-Id: <20190221012549.4069-17-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So it does not screw up single -v verbose output.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190220122800.864-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.19.1

