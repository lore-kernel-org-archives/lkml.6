Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C8EC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCA32070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519711;
	bh=pWCct1XCvn44I5PL+6MlX+KQ/YGb4znnEOCW4WdawtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HTmx+l7sGHXF/Z5mKzK38IriYEx24/i48tyGSA1aXWC3Rk9laT+gE9lgWP4KeTFLv
	 I4MYQEZ8k7KjHx7GHokMerNh3ufmvYtvWTmPWwhlMzj6p1QITh9T9Hl9EwhqOUM51j
	 IQgKz6TzWPThmjN/MxUmzBTwFzaLJ0b9LmD9yQhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbfACMrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730156AbfACMrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:13 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E44452184B;
        Thu,  3 Jan 2019 12:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519632;
        bh=pWCct1XCvn44I5PL+6MlX+KQ/YGb4znnEOCW4WdawtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGFlHKsXLm+Em8M2KT8Pf5MG9X+sd/1498exP7XZTQohH03MkW3/6Nfkx+szgFJDr
         s0jCrx+V3pQ8g1ioBLKiHTa5DfpBc/wSqSol1lVGMemw4BvzmcZHH/f1IPShm+WyPD
         8hB+lBYsutdVaanv8jbVZ/iLGkkAmffRRbMSErAc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Joe Mario <jmario@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/29] perf c2c: Increase the HITM ratio limit for displayed cachelines
Date:   Thu,  3 Jan 2019 09:45:57 -0300
Message-Id: <20190103124609.29672-18-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The cachelines being reported are the ones with percentages all the way
down to 0.05%.  That makes for very long output files. Raising that to
0.1%.  The user can always specify --show-all if they want all the
cachelines with hits.

Suggested-by: Joe Mario <jmario@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181228101820.28010-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 964f3f5ef420..d340d2e42776 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1878,7 +1878,7 @@ static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
 	return hpp_list__parse(&c2c_hists->list, output, sort);
 }
 
-#define DISPLAY_LINE_LIMIT  0.0005
+#define DISPLAY_LINE_LIMIT  0.001
 
 static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 {
-- 
2.19.2

