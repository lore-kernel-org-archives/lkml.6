Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753034AbeDDFbg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:31:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36701 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbeDDFbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:31:35 -0400
Date: Tue, 3 Apr 2018 22:31:14 -0700
From: tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-a36ebe4e242a2f6818f424b03a5e8dae3964e458@git.kernel.org>
Cc: tglx@linutronix.de, kan.liang@intel.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, peterz@infradead.org, jolsa@kernel.org,
        acme@redhat.com, alexander.shishkin@linux.intel.com, hpa@zytor.com,
        mingo@kernel.org, yao.jin@intel.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, yao.jin@intel.com, hpa@zytor.com,
        mingo@kernel.org, alexander.shishkin@linux.intel.com, acme@redhat.com,
        jolsa@kernel.org, peterz@infradead.org, yao.jin@linux.intel.com,
        ak@linux.intel.com, kan.liang@intel.com, tglx@linutronix.de
In-Reply-To: <1522402036-22915-4-git-send-email-yao.jin@linux.intel.com>
References: <1522402036-22915-4-git-send-email-yao.jin@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf config: Rename to
 HAVE_DWARF_GETLOCATIONS_SUPPORT
Git-Commit-ID: a36ebe4e242a2f6818f424b03a5e8dae3964e458
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

Commit-ID:  a36ebe4e242a2f6818f424b03a5e8dae3964e458
Gitweb:     https://git.kernel.org/tip/a36ebe4e242a2f6818f424b03a5e8dae3964e458
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 30 Mar 2018 17:27:13 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 2 Apr 2018 13:50:24 -0300

perf config: Rename to HAVE_DWARF_GETLOCATIONS_SUPPORT

In Makefile.config, to make all libraries flags have _SUPPORT suffix,
rename HAVE_DWARF_GETLOCATIONS to HAVE_DWARF_GETLOCATIONS_SUPPORT

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Suggested-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1522402036-22915-4-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config  | 2 +-
 tools/perf/util/dwarf-aux.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index deb8fba2f4f1..c7abd83a8e19 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -346,7 +346,7 @@ else
       ifneq ($(feature-dwarf_getlocations), 1)
         msg := $(warning Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.157);
       else
-        CFLAGS += -DHAVE_DWARF_GETLOCATIONS
+        CFLAGS += -DHAVE_DWARF_GETLOCATIONS_SUPPORT
       endif # dwarf_getlocations
     endif # Dwarf support
   endif # libelf support
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index f5acda13dcfa..7eb7de5aee44 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -979,7 +979,7 @@ int die_get_varname(Dwarf_Die *vr_die, struct strbuf *buf)
 	return ret < 0 ? ret : strbuf_addf(buf, "\t%s", dwarf_diename(vr_die));
 }
 
-#ifdef HAVE_DWARF_GETLOCATIONS
+#ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
 /**
  * die_get_var_innermost_scope - Get innermost scope range of given variable DIE
  * @sp_die: a subprogram DIE
