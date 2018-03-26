Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeCZIMz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:12:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:56660 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752027AbeCZIMt (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:12:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="214862083"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 1/3] perf config: Add -DNO_GLIBC to CFLAGS
Date: Tue, 27 Mar 2018 00:07:02 +0800
Message-Id: <1522080424-12912-2-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
References: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For most of libraries, in perf.config, they can be recorded with
-DHAVE_XXX or -DNO_XXX in CFLAGS according to if they are compiled-in.
Then C code could know if the library is compiled-in or not.

While for glibc, no existing -DHAVE_XXX or -DNO_XXX.

This patch adds -DNO_GLIBC to CFLAGS.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Makefile.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 98ff736..5883dd6 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -324,6 +324,8 @@ else
       NO_LIBBPF := 1
       NO_JVMTI := 1
     else
+      CFLAGS += -DNO_GLIBC
+
       ifneq ($(filter s% -static%,$(LDFLAGS),),)
         msg := $(error No static glibc found, please install glibc-static);
       else
-- 
2.7.4
