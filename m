Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C7FC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889FF218A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889FF218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeHRPFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 11:05:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59937 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeHRPFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 11:05:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBvnpJ1291648
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:57:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBvmiV1291645;
        Sat, 18 Aug 2018 04:57:48 -0700
Date:   Sat, 18 Aug 2018 04:57:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kim Phillips <tipbot@zytor.com>
Message-ID: <tip-344353366591acf659a0d0dea498611da78d67e2@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, gengdongjiu@huawei.com,
        namhyung@kernel.org, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        tglx@linutronix.de, acme@redhat.com, kim.phillips@arm.com,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org
Reply-To: gengdongjiu@huawei.com, alexander.shishkin@linux.intel.com,
          namhyung@kernel.org, adrian.hunter@intel.com, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, kim.phillips@arm.com,
          acme@redhat.com, tglx@linutronix.de, peterz@infradead.org,
          hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20180810174512.52900813e57cbccf18ce99a2@arm.com>
References: <20180810174512.52900813e57cbccf18ce99a2@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf arm spe: Fix uninitialized record error
 variable
Git-Commit-ID: 344353366591acf659a0d0dea498611da78d67e2
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

Commit-ID:  344353366591acf659a0d0dea498611da78d67e2
Gitweb:     https://git.kernel.org/tip/344353366591acf659a0d0dea498611da78d67e2
Author:     Kim Phillips <kim.phillips@arm.com>
AuthorDate: Fri, 10 Aug 2018 17:45:12 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 14 Aug 2018 15:10:44 -0300

perf arm spe: Fix uninitialized record error variable

The auxtrace init variable 'err' was not being initialized, leading perf
to abort early in an SPE record command when there was no explicit
error, rather only based whatever memory contents were on the stack.
Initialize it explicitly on getting an SPE successfully, the same way
cs-etm does.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: ffd3d18c20b8 ("perf tools: Add ARM Statistical Profiling Extensions (SPE) support")
Link: http://lkml.kernel.org/r/20180810174512.52900813e57cbccf18ce99a2@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 1120e39c1b00..5ccfce87e693 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -194,6 +194,7 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 	sper->itr.read_finish = arm_spe_read_finish;
 	sper->itr.alignment = 0;
 
+	*err = 0;
 	return &sper->itr;
 }
 
