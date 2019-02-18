Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E414C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6305C21901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbfBROS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:18:58 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:60174 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729530AbfBROS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:18:57 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4435Zl3Tm1z20YZ;
        Mon, 18 Feb 2019 15:18:55 +0100 (CET)
Authentication-Results: mx-rz-3.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.21.16.14
Received: from fau.de (faustud-010-021-016-014.pool.uni-erlangen.de [10.21.16.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18PaRWTgCmy6H93imKo++b70HiFiXKgrYg=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4435Zj2hZLz20Yq;
        Mon, 18 Feb 2019 15:18:53 +0100 (CET)
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To:     linux-perf-users@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf: fix documentation of the Flags section in perf.data
Date:   Mon, 18 Feb 2019 15:18:46 +0100
Message-Id: <20190218141846.2995-1-jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190217232246.GB26460@krava>
References: <20190217232246.GB26460@krava>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the current documentation the flags section is placed after
the file header itself but the code assumes to find the flags section
after the data section. This change updates the documentation to that
assumption.
---
 tools/perf/Documentation/perf.data-file-format.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 5f9a3924830b..593ef49b273c 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -43,11 +43,10 @@ struct perf_file_section {
 
 Flags section:
 
-The header is followed by different optional headers, described by the bits set
-in flags. Only headers for which the bit is set are included. Each header
-consists of a perf_file_section located after the initial header.
-The respective perf_file_section points to the data of the additional
-header and defines its size.
+For each of the optional features a perf_file_section it placed after the data
+section if the feature bit is set in the perf_header flags bitset. The
+respective perf_file_section points to the data of the additional header and
+defines its size.
 
 Some headers consist of strings, which are defined like this:
 
-- 
2.19.2

