Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABB4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0759C2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550712388;
	bh=gDiFV1tzAnevHq45fbAKGeIdA9XpUp8HaYc3xXCg9GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aqRbvvOHfplRn/LAdLEzJ8oSgfClrjW83jdycLxiqcF0/Xf6DeQD2US12FSTCzehZ
	 yj1URLOE8fh3qpV6ioyyPL0IQH+ixu1RBS2fvBAcWOVSzJ/TVsArseESpeoJpT3QNW
	 lYixBlxA5X1qARkDRpaCbqsvhKNppD9nEng88ZhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfBUB01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:26:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbfBUB0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:26:25 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.102.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B07472146E;
        Thu, 21 Feb 2019 01:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550712384;
        bh=gDiFV1tzAnevHq45fbAKGeIdA9XpUp8HaYc3xXCg9GQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htqaZwVdCfo197IF6KfBLBwhxMEayR2Uf1L5OCG5V8HyjWKXzRDouT8AJqDm4UlaC
         qkXvuxEVcz3pt44+MM7+26IvhUqzm9aWifNd2k/c4mmSSRmaAqgspPvX2/+ema7JL0
         qbHqggnYr3eQVu7XqGktaCPq1ewDf7He8Wsuv74c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/17] perf doc: Fix HEADER_CMDLINE description in perf.data documentation
Date:   Wed, 20 Feb 2019 22:25:39 -0300
Message-Id: <20190221012549.4069-8-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

The content of the HEADER_CMDLINE feature header is a perf_header_string_list
of the argument vector and not a perf_header_string of the commandline.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190219154515.3954-1-jonas.rabenstein@studium.uni-erlangen.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index dfb218feaad9..5f9a3924830b 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -131,7 +131,7 @@ An uint64_t with the total memory in bytes.
 
 	HEADER_CMDLINE = 11,
 
-A perf_header_string with the perf command line used to collect the data.
+A perf_header_string_list with the perf arg-vector used to collect the data.
 
 	HEADER_EVENT_DESC = 12,
 
-- 
2.19.1

