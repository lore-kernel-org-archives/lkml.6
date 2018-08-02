Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC32C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2682146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2682146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbeHBKFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:05:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57253 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeHBKFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:05:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w728FjKD3431691
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:15:46 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w728FjvK3431688;
        Thu, 2 Aug 2018 01:15:45 -0700
Date:   Thu, 2 Aug 2018 01:15:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Michael Petlan <tipbot@zytor.com>
Message-ID: <tip-mlo850517m6u1rbjndvd1bwr@git.kernel.org>
Cc:     mpetlan@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, jolsa@kernel.org, kim.phillips@arm.com,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, mpetlan@redhat.com,
          mingo@kernel.org, acme@redhat.com, jolsa@kernel.org,
          kim.phillips@arm.com, hpa@zytor.com, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf list: Unify metric group description format
 with PMU event description
Git-Commit-ID: 95f04328e42dc7d1eb08f3cb38150c1f2ec09f57
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

Commit-ID:  95f04328e42dc7d1eb08f3cb38150c1f2ec09f57
Gitweb:     https://git.kernel.org/tip/95f04328e42dc7d1eb08f3cb38150c1f2ec09f57
Author:     Michael Petlan <mpetlan@redhat.com>
AuthorDate: Mon, 30 Jul 2018 17:35:04 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 31 Jul 2018 11:35:44 -0300

perf list: Unify metric group description format with PMU event description

PMU event descriptions use 7 spaces + '[' or 8 spaces as indentation.
Metric groups used a tab + '['. This patch unifies it to the way PMU
event descriptions are indented.

BEFORE:

  $ perf list
  [...]
  Metric Groups:

  DSB:
    DSB_Coverage
	  [Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)]
  [...]

AFTER:

  $ perf list
  [...]
  Metric Groups:

  DSB:
    DSB_Coverage
         [Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)]
  [...]

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
LPU-Reference: 771439042.22924766.1532986504631.JavaMail.zimbra@redhat.com
Link: https://lkml.kernel.org/n/tip-mlo850517m6u1rbjndvd1bwr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 96eab4ec34ff..a28f9b5cc4ff 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -326,8 +326,8 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 				if (raw)
 					s = (char *)pe->metric_name;
 				else {
-					if (asprintf(&s, "%s\n\t[%s]",
-						     pe->metric_name, pe->desc) < 0)
+					if (asprintf(&s, "%s\n%*s%s]",
+						     pe->metric_name, 8, "[", pe->desc) < 0)
 						return;
 				}
 
