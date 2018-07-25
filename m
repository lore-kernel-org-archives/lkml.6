Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B03EC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0933E20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0933E20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbeGYV6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:58:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51679 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbeGYV6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:58:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKiamt500464
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:44:36 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKiaXK500461;
        Wed, 25 Jul 2018 13:44:36 -0700
Date:   Wed, 25 Jul 2018 13:44:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sangwon Hong <tipbot@zytor.com>
Message-ID: <tip-6feb3fec519ed112f7a77af4e51e51a35148d01c@git.kernel.org>
Cc:     namhyung@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, tglx@linutronix.de, mingo@kernel.org,
        qpakzk@gmail.com, hpa@zytor.com, jolsa@kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, tglx@linutronix.de, acme@redhat.com,
          namhyung@kernel.org, jolsa@kernel.org, hpa@zytor.com,
          qpakzk@gmail.com
In-Reply-To: <20180717110738.10779-1-qpakzk@gmail.com>
References: <20180717110738.10779-1-qpakzk@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf list: Add missing documentation for --desc and
 --debug options
Git-Commit-ID: 6feb3fec519ed112f7a77af4e51e51a35148d01c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6feb3fec519ed112f7a77af4e51e51a35148d01c
Gitweb:     https://git.kernel.org/tip/6feb3fec519ed112f7a77af4e51e51a35148d01c
Author:     Sangwon Hong <qpakzk@gmail.com>
AuthorDate: Tue, 17 Jul 2018 20:07:38 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:49:57 -0300

perf list: Add missing documentation for --desc and --debug options

Add missing documentation for --desc and --debug options to the 'perf
list' man page.

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20180717110738.10779-1-qpakzk@gmail.com
[ Clarify that --desc is by default active ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 14e13512c05f..236b9b97dfdb 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -18,6 +18,10 @@ various perf commands with the -e option.
 
 OPTIONS
 -------
+-d::
+--desc::
+Print extra event descriptions. (default)
+
 --no-desc::
 Don't print descriptions.
 
@@ -25,11 +29,13 @@ Don't print descriptions.
 --long-desc::
 Print longer event descriptions.
 
+--debug::
+Enable debugging output.
+
 --details::
 Print how named events are resolved internally into perf events, and also
 any extra expressions computed by perf stat.
 
-
 [[EVENT_MODIFIERS]]
 EVENT MODIFIERS
 ---------------
