Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0F8C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B5A2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbfACNUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:20:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39875 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfACNUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:20:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DK5dA1385008
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:20:05 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DK5JK1385004;
        Thu, 3 Jan 2019 05:20:05 -0800
Date:   Thu, 3 Jan 2019 05:20:05 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-f1770e3ca4ec10ce43825de2f855a1831c711195@git.kernel.org>
Cc:     acme@redhat.com, jolsa@kernel.org, mingo@kernel.org,
        len.brown@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, herton@redhat.com, hpa@zytor.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, herton@redhat.com,
          tglx@linutronix.de, len.brown@intel.com, jolsa@kernel.org,
          mingo@kernel.org, acme@redhat.com
In-Reply-To: <20181212102537.25902-2-jolsa@kernel.org>
References: <20181212102537.25902-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools power x86_energy_perf_policy: Override
 CFLAGS assignments and add LDFLAGS to build command
Git-Commit-ID: f1770e3ca4ec10ce43825de2f855a1831c711195
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

Commit-ID:  f1770e3ca4ec10ce43825de2f855a1831c711195
Gitweb:     https://git.kernel.org/tip/f1770e3ca4ec10ce43825de2f855a1831c711195
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 12 Oct 2018 07:20:16 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 28 Dec 2018 16:33:07 -0300

tools power x86_energy_perf_policy: Override CFLAGS assignments and add LDFLAGS to build command

So user could specify outside CFLAGS/LDFLAGS values.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Len Brown <len.brown@intel.com>
Link: https://lkml.kernel.org/r/20181212102537.25902-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/power/x86/x86_energy_perf_policy/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/Makefile b/tools/power/x86/x86_energy_perf_policy/Makefile
index f4534fb8b951..ae7a0e09b722 100644
--- a/tools/power/x86/x86_energy_perf_policy/Makefile
+++ b/tools/power/x86/x86_energy_perf_policy/Makefile
@@ -9,12 +9,12 @@ ifeq ("$(origin O)", "command line")
 endif
 
 x86_energy_perf_policy : x86_energy_perf_policy.c
-CFLAGS +=	-Wall
-CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
+override CFLAGS +=	-Wall
+override CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
 
 %: %.c
 	@mkdir -p $(BUILD_OUTPUT)
-	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@
+	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@ $(LDFLAGS)
 
 .PHONY : clean
 clean :
