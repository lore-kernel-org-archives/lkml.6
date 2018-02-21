Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932913AbeBUKZt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:25:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43337 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932751AbeBUKZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:25:47 -0500
Date: Wed, 21 Feb 2018 02:25:13 -0800
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-47812e00910407a0f14906c0a3bf2d803a616c6f@git.kernel.org>
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, hpa@zytor.com,
        mingo@kernel.org, acme@redhat.com, heiko.carstens@de.ibm.com,
        linux-kernel@vger.kernel.org, tmricht@linux.vnet.ibm.com,
        tglx@linutronix.de
Reply-To: brueckner@linux.vnet.ibm.com, hpa@zytor.com, schwidefsky@de.ibm.com,
        mingo@kernel.org, heiko.carstens@de.ibm.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, tmricht@linux.vnet.ibm.com,
        tglx@linutronix.de
In-Reply-To: <20180219102444.96900-1-tmricht@linux.vnet.ibm.com>
References: <20180219102444.96900-1-tmricht@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf s390: Fix reading cpuid model information
Git-Commit-ID: 47812e00910407a0f14906c0a3bf2d803a616c6f
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

Commit-ID:  47812e00910407a0f14906c0a3bf2d803a616c6f
Gitweb:     https://git.kernel.org/tip/47812e00910407a0f14906c0a3bf2d803a616c6f
Author:     Thomas Richter <tmricht@linux.vnet.ibm.com>
AuthorDate: Mon, 19 Feb 2018 11:24:44 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 19 Feb 2018 09:16:01 -0300

perf s390: Fix reading cpuid model information

Commit eca0fa28cd0d (perf record: Provide detailed information on s390
CPU") fixed a  build error on Ubuntu. However the fix uses the wrong
size to print the model information.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Fixes: eca0fa28cd0d ("perf record: Provide detailed information on s390 CPU")
Link: http://lkml.kernel.org/r/20180219102444.96900-1-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
index 231294b..a4c30f1 100644
--- a/tools/perf/arch/s390/util/header.c
+++ b/tools/perf/arch/s390/util/header.c
@@ -81,7 +81,7 @@ int get_cpuid(char *buffer, size_t sz)
 			line2 = line + strlen(SYSINFO_MODEL);
 
 			while ((cp = strtok_r(line2, "\n ", &line2))) {
-				mdsize += scnprintf(model + mdsize, sizeof(type) - mdsize,
+				mdsize += scnprintf(model + mdsize, sizeof(model) - mdsize,
 						    "%s%s", model[0] ? "," : "", cp);
 			}
 			break;
