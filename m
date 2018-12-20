Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A15C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BD4218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388960AbeLTS0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:26:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388946AbeLTS0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:26:47 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIQcpB3686117
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:26:38 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIQcfv3686114;
        Thu, 20 Dec 2018 10:26:38 -0800
Date:   Thu, 20 Dec 2018 10:26:38 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-vu890pi18fpd4eyz61cazckj@git.kernel.org>
Cc:     jolsa@kernel.org, mingo@kernel.org, lclaudio@redhat.com,
        hpa@zytor.com, tglx@linutronix.de, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com, acme@redhat.com,
        namhyung@kernel.org
Reply-To: wangnan0@huawei.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, acme@redhat.com, mingo@kernel.org,
          jolsa@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
          hpa@zytor.com, lclaudio@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools include arch: Grab a copy of x86's prctl.h
Git-Commit-ID: c22e2683c0cbfb8dcac84529d29386b094cd78cf
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

Commit-ID:  c22e2683c0cbfb8dcac84529d29386b094cd78cf
Gitweb:     https://git.kernel.org/tip/c22e2683c0cbfb8dcac84529d29386b094cd78cf
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 17 Dec 2018 16:15:27 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:15:18 -0300

tools include arch: Grab a copy of x86's prctl.h

We need it to generate the tables for the 'code' arch_prctl's syscall
argument.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-vu890pi18fpd4eyz61cazckj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 {arch => tools/arch}/x86/include/uapi/asm/prctl.h | 0
 tools/perf/check-headers.sh                       | 1 +
 2 files changed, 1 insertion(+)

diff --git a/arch/x86/include/uapi/asm/prctl.h b/tools/arch/x86/include/uapi/asm/prctl.h
similarity index 100%
copy from arch/x86/include/uapi/asm/prctl.h
copy to tools/arch/x86/include/uapi/asm/prctl.h
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 9531f7bd7d9b..10d97dc632da 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -21,6 +21,7 @@ include/uapi/linux/hw_breakpoint.h
 arch/x86/include/asm/disabled-features.h
 arch/x86/include/asm/required-features.h
 arch/x86/include/asm/cpufeatures.h
+arch/x86/include/uapi/asm/prctl.h
 arch/arm/include/uapi/asm/perf_regs.h
 arch/arm64/include/uapi/asm/perf_regs.h
 arch/powerpc/include/uapi/asm/perf_regs.h
