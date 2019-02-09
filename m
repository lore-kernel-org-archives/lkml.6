Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80627C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AA4218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBIM3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:29:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47547 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfBIM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:29:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CSh682627483
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:28:43 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CSgqx2627480;
        Sat, 9 Feb 2019 04:28:42 -0800
Date:   Sat, 9 Feb 2019 04:28:42 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-vub5lp82wb7vy5wssfad0xu8@git.kernel.org>
Cc:     tglx@linutronix.de, suzuki.poulose@arm.com,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        acme@redhat.com, hpa@zytor.com, jolsa@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, gengdongjiu@huawei.com,
        namhyung@kernel.org, kim.phillips@arm.com, will.deacon@arm.com
Reply-To: mathieu.poirier@linaro.org, adrian.hunter@intel.com,
          suzuki.poulose@arm.com, tglx@linutronix.de,
          gengdongjiu@huawei.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, mingo@kernel.org, hpa@zytor.com,
          acme@redhat.com, kim.phillips@arm.com, namhyung@kernel.org,
          will.deacon@arm.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf arm pmu: Add missing linux/string.h header
Git-Commit-ID: af1db7f6b7323ab9f7beffe6028f421f4c398e7f
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

Commit-ID:  af1db7f6b7323ab9f7beffe6028f421f4c398e7f
Gitweb:     https://git.kernel.org/tip/af1db7f6b7323ab9f7beffe6028f421f4c398e7f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 5 Feb 2019 13:51:16 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:38 -0300

perf arm pmu: Add missing linux/string.h header

It uses strstarts(), that is defined in linux/string.h but that was
being including by sheer luck, indirectly, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/n/tip-vub5lp82wb7vy5wssfad0xu8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index e047571e6080..64a677b518d0 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -7,6 +7,7 @@
 #include <string.h>
 #include <linux/coresight-pmu.h>
 #include <linux/perf_event.h>
+#include <linux/string.h>
 
 #include "cs-etm.h"
 #include "arm-spe.h"
