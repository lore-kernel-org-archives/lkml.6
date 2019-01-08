Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CA9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C39214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfAHPiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:38:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55015 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfAHPiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:38:17 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x08Fc6g93566162
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 07:38:06 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x08Fc6TU3566157;
        Tue, 8 Jan 2019 07:38:06 -0800
Date:   Tue, 8 Jan 2019 07:38:06 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-a1pahzc8lci0ey1fjvv1chdm@git.kernel.org>
Cc:     namhyung@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        jolsa@kernel.org, will.deacon@arm.com, acme@redhat.com,
        kristina.martsenko@arm.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org
Reply-To: kristina.martsenko@arm.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, mingo@kernel.org, acme@redhat.com,
          jolsa@kernel.org, will.deacon@arm.com, hpa@zytor.com,
          namhyung@kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Sync prctl.h with the kernel
 sources
Git-Commit-ID: 3d32c4531958c433a6ee087f31891cb02d6b68d9
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

Commit-ID:  3d32c4531958c433a6ee087f31891cb02d6b68d9
Gitweb:     https://git.kernel.org/tip/3d32c4531958c433a6ee087f31891cb02d6b68d9
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 3 Jan 2019 14:56:20 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 3 Jan 2019 14:56:20 -0300

tools headers uapi: Sync prctl.h with the kernel sources

To get the changes in ba8308856564 ("arm64: add prctl control for
resetting ptrauth keys"), that introduce a prctl with a name that needs
to be catch by the prctl cmd table generator, which will be done in the
next cset.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/n/tip-a1pahzc8lci0ey1fjvv1chdm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/prctl.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index b17201edfa09..b4875a93363a 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -220,4 +220,12 @@ struct prctl_mm_map {
 # define PR_SPEC_DISABLE		(1UL << 2)
 # define PR_SPEC_FORCE_DISABLE		(1UL << 3)
 
+/* Reset arm64 pointer authentication keys */
+#define PR_PAC_RESET_KEYS		54
+# define PR_PAC_APIAKEY			(1UL << 0)
+# define PR_PAC_APIBKEY			(1UL << 1)
+# define PR_PAC_APDAKEY			(1UL << 2)
+# define PR_PAC_APDBKEY			(1UL << 3)
+# define PR_PAC_APGAKEY			(1UL << 4)
+
 #endif /* _LINUX_PRCTL_H */
