Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754224AbeCGI11 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:27:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42631 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbeCGI1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:27:22 -0500
Date: Wed, 7 Mar 2018 00:27:04 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-mzmuxocrf96v922xkerey3ns@git.kernel.org>
Cc: adrian.hunter@intel.com, dsahern@gmail.com, mingo@kernel.org,
        dwmw@amazon.co.uk, acme@redhat.com, wangnan0@huawei.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        hpa@zytor.com, jolsa@kernel.org
Reply-To: dsahern@gmail.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        jolsa@kernel.org, namhyung@kernel.org, mingo@kernel.org,
        dwmw@amazon.co.uk, acme@redhat.com, wangnan0@huawei.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers: Sync x86's cpufeatures.h
Git-Commit-ID: 4caea0574c5009901d1976980579ccd26dbf358a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4caea0574c5009901d1976980579ccd26dbf358a
Gitweb:     https://git.kernel.org/tip/4caea0574c5009901d1976980579ccd26dbf358a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 5 Mar 2018 12:07:52 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 12:07:52 -0300

tools headers: Sync x86's cpufeatures.h

The changes in dd84441a7971 ("x86/speculation: Use IBRS if available
before calling into firmware") don't need any kind of special treatment
in the current tools/perf/ codebase, so just update the copy to get rid
of the perf build warning:

  BUILD:   Doing 'make -j4' parallel build
  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-mzmuxocrf96v922xkerey3ns@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 0dfe4d3f74e2..f41079da38c5 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -213,6 +213,7 @@
 #define X86_FEATURE_SEV			( 7*32+20) /* AMD Secure Encrypted Virtualization */
 
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
+#define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
