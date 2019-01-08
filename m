Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C106AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A7320883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfAHPkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:40:22 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51055 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbfAHPkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:40:22 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x08FdNok3566481
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 07:39:23 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x08FdMQA3566478;
        Tue, 8 Jan 2019 07:39:22 -0800
Date:   Tue, 8 Jan 2019 07:39:22 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-302df34c4e64b9e83ee31cbf508b38b62b428bd6@git.kernel.org>
Cc:     hpa@zytor.com, acme@redhat.com, mmayer@broadcom.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, computersforpeace@gmail.com,
        mingo@kernel.org, rui.zhang@intel.com, tglx@linutronix.de
Reply-To: rui.zhang@intel.com, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, computersforpeace@gmail.com,
          mingo@kernel.org, peterz@infradead.org, namhyung@kernel.org,
          acme@redhat.com, hpa@zytor.com, mmayer@broadcom.com,
          jolsa@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190103161350.11446-2-jolsa@kernel.org>
References: <20190103161350.11446-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools thermal tmon: Use -O3 instead of -O1 if
 available
Git-Commit-ID: 302df34c4e64b9e83ee31cbf508b38b62b428bd6
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

Commit-ID:  302df34c4e64b9e83ee31cbf508b38b62b428bd6
Gitweb:     https://git.kernel.org/tip/302df34c4e64b9e83ee31cbf508b38b62b428bd6
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 3 Jan 2019 17:13:49 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 4 Jan 2019 12:54:49 -0300

tools thermal tmon: Use -O3 instead of -O1 if available

Using -O3 instead of -O1 if it's supported by compiler.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Markus Mayer <mmayer@broadcom.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Link: http://lkml.kernel.org/r/20190103161350.11446-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/thermal/tmon/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
index 89a2444c1df2..59e417ec3e13 100644
--- a/tools/thermal/tmon/Makefile
+++ b/tools/thermal/tmon/Makefile
@@ -6,7 +6,7 @@ VERSION = 1.0
 
 BINDIR=usr/bin
 WARNFLAGS=-Wall -Wshadow -W -Wformat -Wimplicit-function-declaration -Wimplicit-int
-override CFLAGS+= -O1 ${WARNFLAGS}
+override CFLAGS+= $(call cc-option,-O3,-O1) ${WARNFLAGS}
 # Add "-fstack-protector" only if toolchain supports it.
 override CFLAGS+= $(call cc-option,-fstack-protector-strong)
 CC?= $(CROSS_COMPILE)gcc
