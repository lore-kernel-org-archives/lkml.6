Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VaI9ISjpGFuOUwAAmS7hNA
	; Thu, 07 Jun 2018 08:14:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DB7CD6089E; Thu,  7 Jun 2018 08:14:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6BB2B607E7;
	Thu,  7 Jun 2018 08:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6BB2B607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932399AbeFGIOF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:14:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54531 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932102AbeFGIOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:14:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578Dtf32125139
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:13:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578DsxK2125136;
        Thu, 7 Jun 2018 01:13:54 -0700
Date: Thu, 7 Jun 2018 01:13:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-e9ee0dce45e522221c18b2f24621a0d00d0bff40@git.kernel.org>
Cc: schwidefsky@de.ibm.com, brueckner@linux.vnet.ibm.com,
        hpa@zytor.com, acme@redhat.com, tglx@linutronix.de,
        tmricht@linux.ibm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Reply-To: heiko.carstens@de.ibm.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, tmricht@linux.ibm.com,
          mingo@kernel.org, acme@redhat.com, hpa@zytor.com,
          brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com
In-Reply-To: <20180528134817.36643-1-tmricht@linux.ibm.com>
References: <20180528134817.36643-1-tmricht@linux.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf test: Use header file util/debug.h
Git-Commit-ID: e9ee0dce45e522221c18b2f24621a0d00d0bff40
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

Commit-ID:  e9ee0dce45e522221c18b2f24621a0d00d0bff40
Gitweb:     https://git.kernel.org/tip/e9ee0dce45e522221c18b2f24621a0d00d0bff40
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Mon, 28 May 2018 15:48:17 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:53 -0300

perf test: Use header file util/debug.h

Use the header file util/debug.h instead of declaration of verbose
variable.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180528134817.36643-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/python-use.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.c
index 5d2df65ada6a..40ab72149ce1 100644
--- a/tools/perf/tests/python-use.c
+++ b/tools/perf/tests/python-use.c
@@ -7,8 +7,7 @@
 #include <stdlib.h>
 #include <linux/compiler.h>
 #include "tests.h"
-
-extern int verbose;
+#include "util/debug.h"
 
 int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
