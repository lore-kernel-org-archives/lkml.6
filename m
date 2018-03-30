Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbeC3BdM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 21:33:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:18372 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752072AbeC3BdK (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 21:33:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000";
   d="scan'208";a="212506324"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 3/6] perf config: Rename to HAVE_DWARF_GETLOCATIONS_SUPPORT
Date: Fri, 30 Mar 2018 17:27:13 +0800
Message-Id: <1522402036-22915-4-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522402036-22915-1-git-send-email-yao.jin@linux.intel.com>
References: <1522402036-22915-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Makefile.config, to make all libraries flags have _SUPPORT suffix,
rename HAVE_DWARF_GETLOCATIONS to HAVE_DWARF_GETLOCATIONS_SUPPORT

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Makefile.config  | 2 +-
 tools/perf/util/dwarf-aux.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index deb8fba..c7abd83 100644
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
index f5acda1..7eb7de5 100644
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
-- 
2.7.4
