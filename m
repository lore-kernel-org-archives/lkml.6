Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5ACC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AA421019
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfAHPhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:37:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47779 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfAHPhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:37:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x08FbVlC3566118
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 07:37:31 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x08FbV9T3566115;
        Tue, 8 Jan 2019 07:37:31 -0800
Date:   Tue, 8 Jan 2019 07:37:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-vvge5xh6ii12oszexqknbgwp@git.kernel.org>
Cc:     adrian.hunter@intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, namhyung@kernel.org, hpa@zytor.com,
        luto@kernel.org
Reply-To: adrian.hunter@intel.com, acme@redhat.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          tglx@linutronix.de, namhyung@kernel.org, hpa@zytor.com,
          luto@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers x86: Sync disabled-features.h
Git-Commit-ID: 94f45df8aaa35471ab3fc802c2cf1b75c8107500
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

Commit-ID:  94f45df8aaa35471ab3fc802c2cf1b75c8107500
Gitweb:     https://git.kernel.org/tip/94f45df8aaa35471ab3fc802c2cf1b75c8107500
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 3 Jan 2019 13:53:59 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 3 Jan 2019 13:53:59 -0300

tools headers x86: Sync disabled-features.h

To silence the following tools/perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h'
  diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/asm/disabled-features.h

Picking up the changes in dae0a1059300 ("x86/cpufeatures, x86/fault:
Mark SMAP as disabled when configured out") that didn't entail any
functionality change in the tooling side.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-vvge5xh6ii12oszexqknbgwp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/disabled-features.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 33833d1909af..a5ea841cc6d2 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -16,6 +16,12 @@
 # define DISABLE_MPX	(1<<(X86_FEATURE_MPX & 31))
 #endif
 
+#ifdef CONFIG_X86_SMAP
+# define DISABLE_SMAP	0
+#else
+# define DISABLE_SMAP	(1<<(X86_FEATURE_SMAP & 31))
+#endif
+
 #ifdef CONFIG_X86_INTEL_UMIP
 # define DISABLE_UMIP	0
 #else
@@ -68,7 +74,7 @@
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
 #define DISABLED_MASK8	0
-#define DISABLED_MASK9	(DISABLE_MPX)
+#define DISABLED_MASK9	(DISABLE_MPX|DISABLE_SMAP)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	0
 #define DISABLED_MASK12	0
