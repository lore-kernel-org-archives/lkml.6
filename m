Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755024AbeDMOEm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754705AbeDMOBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:01:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7536D217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        William Cohen <wcohen@redhat.com>
Subject: [PATCH 06/17] perf jvmti: Give hints about package names needed to build
Date: Fri, 13 Apr 2018 11:01:00 -0300
Message-Id: <20180413140111.25313-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180413140111.25313-1-acme@kernel.org>
References: <20180413140111.25313-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Give as examples of package names to install to have this built for
fedora and debian, to help the user a bit.

The part from 'e.g.:' onwards:

  No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-edbi4r2pvzn7no6ebxbtczng@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c7abd83a8e19..6b307e97dc57 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -847,7 +847,7 @@ ifndef NO_JVMTI
   ifeq ($(feature-jvmti), 1)
     $(call detected_var,JDIR)
   else
-    $(warning No openjdk development package found, please install JDK package)
+    $(warning No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel)
     NO_JVMTI := 1
   endif
 endif
-- 
2.14.3
