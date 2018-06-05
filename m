Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeFERuw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbeFERus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:50:48 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 02/46] perf probe: Use return of map__get() to make code more compact
Date: Tue,  5 Jun 2018 14:49:46 -0300
Message-Id: <20180605175030.32549-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The __get() idiom returns a reference count for the object passed, i.e.
all functions of this type return the object passed, so take advantage
of that to make the code more compact.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ds6vdm7clh070512rpydidsc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 3094f11e7d81..f119eb628dbb 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -165,8 +165,7 @@ static struct map *kernel_get_module_map(const char *module)
 		if (strncmp(pos->dso->short_name + 1, module,
 			    pos->dso->short_name_len - 2) == 0 &&
 		    module[pos->dso->short_name_len - 2] == '\0') {
-			map__get(pos);
-			return pos;
+			return map__get(pos);
 		}
 	}
 	return NULL;
-- 
2.14.3
