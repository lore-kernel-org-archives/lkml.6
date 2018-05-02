Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbeEBR4h (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:56:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57939 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeEBR4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:56:35 -0400
Date: Wed, 2 May 2018 10:56:27 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-1hcgu3k7vxdy4vknqf3kbtzt@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        hpa@zytor.com, adrian.hunter@intel.com, wangnan0@huawei.com,
        dsahern@gmail.com, acme@redhat.com, mingo@kernel.org,
        namhyung@kernel.org
Reply-To: hpa@zytor.com, jolsa@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org,
        namhyung@kernel.org, dsahern@gmail.com, wangnan0@huawei.com,
        adrian.hunter@intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Use machine__find_kernel_function()
 instead of open coded version
Git-Commit-ID: 128cde3379358d43c3cf2cb5ea00bac8bf9cf1cf
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

Commit-ID:  128cde3379358d43c3cf2cb5ea00bac8bf9cf1cf
Gitweb:     https://git.kernel.org/tip/128cde3379358d43c3cf2cb5ea00bac8bf9cf1cf
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 25 Apr 2018 18:04:45 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:16 -0300

perf machine: Use machine__find_kernel_function() instead of open coded version

We have that equivalent, shorter helper, use it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-1hcgu3k7vxdy4vknqf3kbtzt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 10364e829aba..a00e82b83e0a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2367,7 +2367,7 @@ char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, ch
 {
 	struct machine *machine = vmachine;
 	struct map *map;
-	struct symbol *sym = map_groups__find_symbol(&machine->kmaps, MAP__FUNCTION, *addrp, &map);
+	struct symbol *sym = machine__find_kernel_function(machine, *addrp, &map);
 
 	if (sym == NULL)
 		return NULL;
