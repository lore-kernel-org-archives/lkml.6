Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65152C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA2720844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA2720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbeGYVz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:55:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37931 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730305AbeGYVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:55:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKfxnQ498581
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:41:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKfxMl498577;
        Wed, 25 Jul 2018 13:41:59 -0700
Date:   Wed, 25 Jul 2018 13:41:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-b8b5ab52bc3a0423080783ae563801077f7ea400@git.kernel.org>
Cc:     brueckner@linux.ibm.com, linux-kernel@vger.kernel.org,
        tmricht@linux.ibm.com, tglx@linutronix.de, mingo@kernel.org,
        schwidefsky@de.ibm.com, acme@redhat.com, hpa@zytor.com,
        brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com
Reply-To: acme@redhat.com, heiko.carstens@de.ibm.com,
          brueckner@linux.vnet.ibm.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tmricht@linux.ibm.com,
          brueckner@linux.ibm.com, mingo@kernel.org,
          schwidefsky@de.ibm.com, tglx@linutronix.de
In-Reply-To: <20180621080452.61012-1-tmricht@linux.ibm.com>
References: <20180621080452.61012-1-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] Revert "perf list: Add s390 support for
 detailed/verbose PMU event description"
Git-Commit-ID: b8b5ab52bc3a0423080783ae563801077f7ea400
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

Commit-ID:  b8b5ab52bc3a0423080783ae563801077f7ea400
Gitweb:     https://git.kernel.org/tip/b8b5ab52bc3a0423080783ae563801077f7ea400
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Thu, 21 Jun 2018 10:04:49 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:48:58 -0300

Revert "perf list: Add s390 support for detailed/verbose PMU event description"

This reverts commit 038586c34301578e538f6c5aa79ca82bce1b9152.

Fix the support of detailed/verbose PMU event description by using the
"Unit": keyword in the json files to address event names refering to the
/sys/devices/cpum_[cs]f devices.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180621080452.61012-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 3ba6a1742f91..afd68524ffa9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -652,12 +652,6 @@ static int is_arm_pmu_core(const char *name)
 	if (stat(path, &st) == 0)
 		return 1;
 
-	/* Look for cpu sysfs (specific to s390) */
-	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s",
-		  sysfs, name);
-	if (stat(path, &st) == 0 && !strncmp(name, "cpum_", 5))
-		return 1;
-
 	return 0;
 }
 
