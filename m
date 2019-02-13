Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AA1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C9D222D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083304;
	bh=r2tn8ih7RzPnAcEBkXubSRTlq1K2qZwNow4iwMcLTEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qa5AdNa2x8HXN3xrpGcx9KAx0pln0hOTJF8CGvx134mUaUzcgPVnvb1WP4qxa69oV
	 8E6kD8ACWeW4GkTafZYcCJRuhJJk4fwXb7d5eVAVggX/UTRuDDLSCEU00D/wRfgtMh
	 cNPrEgiXwdNg0VPmzlOAjnkvzxtIw8anbMCg91VU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393894AbfBMSln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:41:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393881AbfBMSlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:41:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CE31222D6;
        Wed, 13 Feb 2019 18:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083301;
        bh=r2tn8ih7RzPnAcEBkXubSRTlq1K2qZwNow4iwMcLTEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FUoNivFkZcka/hattJRUFrgoFkgo7kkmJdNyAV6fjOYmoyLL1EQBkHOfIoBQnvpdW
         4hGCwwy9+P4QG9zx59IFx28LjlSHPXQhcTPEYVZxz9qOUuFzjIFLjpmY8lg2pGyp1C
         gFi2+TZtMgreipDupZP8HeZEIZsjxqCbLecIvN7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 27/35] perf tests attr: Make hw events optional
Date:   Wed, 13 Feb 2019 19:38:22 +0100
Message-Id: <20190213183707.320172962@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
References: <20190213183706.176685027@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit 692f5a22cd284bb8233a38e3ed86881d2d9c89d4 upstream.

Otherwise we fail on virtual machines with no support for specific HW
events.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171009130712.14747-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/tests/attr/test-stat-C0         |    1 +
 tools/perf/tests/attr/test-stat-basic      |    1 +
 tools/perf/tests/attr/test-stat-default    |    4 ++++
 tools/perf/tests/attr/test-stat-detailed-1 |    8 ++++++++
 tools/perf/tests/attr/test-stat-detailed-2 |   13 +++++++++++++
 tools/perf/tests/attr/test-stat-detailed-3 |   13 +++++++++++++
 tools/perf/tests/attr/test-stat-no-inherit |    1 +
 7 files changed, 41 insertions(+)

--- a/tools/perf/tests/attr/test-stat-C0
+++ b/tools/perf/tests/attr/test-stat-C0
@@ -7,3 +7,4 @@ ret     = 1
 # events are disabled by default when attached to cpu
 disabled=1
 enable_on_exec=0
+optional=1
--- a/tools/perf/tests/attr/test-stat-basic
+++ b/tools/perf/tests/attr/test-stat-basic
@@ -4,3 +4,4 @@ args    = -e cycles kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-stat]
+optional=1
--- a/tools/perf/tests/attr/test-stat-default
+++ b/tools/perf/tests/attr/test-stat-default
@@ -32,6 +32,7 @@ config=2
 fd=5
 type=0
 config=0
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_FRONTEND
 [event6:base-stat]
@@ -52,15 +53,18 @@ optional=1
 fd=8
 type=0
 config=1
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_INSTRUCTIONS
 [event9:base-stat]
 fd=9
 type=0
 config=4
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_MISSES
 [event10:base-stat]
 fd=10
 type=0
 config=5
+optional=1
--- a/tools/perf/tests/attr/test-stat-detailed-1
+++ b/tools/perf/tests/attr/test-stat-detailed-1
@@ -33,6 +33,7 @@ config=2
 fd=5
 type=0
 config=0
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_FRONTEND
 [event6:base-stat]
@@ -53,18 +54,21 @@ optional=1
 fd=8
 type=0
 config=1
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_INSTRUCTIONS
 [event9:base-stat]
 fd=9
 type=0
 config=4
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_MISSES
 [event10:base-stat]
 fd=10
 type=0
 config=5
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
@@ -74,6 +78,7 @@ config=5
 fd=11
 type=3
 config=0
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
@@ -83,6 +88,7 @@ config=0
 fd=12
 type=3
 config=65536
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
@@ -92,6 +98,7 @@ config=65536
 fd=13
 type=3
 config=2
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
@@ -101,3 +108,4 @@ config=2
 fd=14
 type=3
 config=65538
+optional=1
--- a/tools/perf/tests/attr/test-stat-detailed-2
+++ b/tools/perf/tests/attr/test-stat-detailed-2
@@ -33,6 +33,7 @@ config=2
 fd=5
 type=0
 config=0
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_FRONTEND
 [event6:base-stat]
@@ -53,18 +54,21 @@ optional=1
 fd=8
 type=0
 config=1
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_INSTRUCTIONS
 [event9:base-stat]
 fd=9
 type=0
 config=4
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_MISSES
 [event10:base-stat]
 fd=10
 type=0
 config=5
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
@@ -74,6 +78,7 @@ config=5
 fd=11
 type=3
 config=0
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
@@ -83,6 +88,7 @@ config=0
 fd=12
 type=3
 config=65536
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
@@ -92,6 +98,7 @@ config=65536
 fd=13
 type=3
 config=2
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
@@ -101,6 +108,7 @@ config=2
 fd=14
 type=3
 config=65538
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
@@ -120,6 +128,7 @@ optional=1
 fd=16
 type=3
 config=65537
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
@@ -129,6 +138,7 @@ config=65537
 fd=17
 type=3
 config=3
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
@@ -138,6 +148,7 @@ config=3
 fd=18
 type=3
 config=65539
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
@@ -147,6 +158,7 @@ config=65539
 fd=19
 type=3
 config=4
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
@@ -156,3 +168,4 @@ config=4
 fd=20
 type=3
 config=65540
+optional=1
--- a/tools/perf/tests/attr/test-stat-detailed-3
+++ b/tools/perf/tests/attr/test-stat-detailed-3
@@ -33,6 +33,7 @@ config=2
 fd=5
 type=0
 config=0
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_FRONTEND
 [event6:base-stat]
@@ -53,18 +54,21 @@ optional=1
 fd=8
 type=0
 config=1
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_INSTRUCTIONS
 [event9:base-stat]
 fd=9
 type=0
 config=4
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_MISSES
 [event10:base-stat]
 fd=10
 type=0
 config=5
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
@@ -74,6 +78,7 @@ config=5
 fd=11
 type=3
 config=0
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
@@ -83,6 +88,7 @@ config=0
 fd=12
 type=3
 config=65536
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
@@ -92,6 +98,7 @@ config=65536
 fd=13
 type=3
 config=2
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
@@ -101,6 +108,7 @@ config=2
 fd=14
 type=3
 config=65538
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
@@ -120,6 +128,7 @@ optional=1
 fd=16
 type=3
 config=65537
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
@@ -129,6 +138,7 @@ config=65537
 fd=17
 type=3
 config=3
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
@@ -138,6 +148,7 @@ config=3
 fd=18
 type=3
 config=65539
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
@@ -147,6 +158,7 @@ config=65539
 fd=19
 type=3
 config=4
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
@@ -156,6 +168,7 @@ config=4
 fd=20
 type=3
 config=65540
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
--- a/tools/perf/tests/attr/test-stat-no-inherit
+++ b/tools/perf/tests/attr/test-stat-no-inherit
@@ -5,3 +5,4 @@ ret     = 1
 
 [event:base-stat]
 inherit=0
+optional=1


