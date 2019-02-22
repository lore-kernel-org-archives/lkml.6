Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7192EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B552070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfBVXHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:07:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:52570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbfBVXHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:07:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE155B60F;
        Fri, 22 Feb 2019 23:07:01 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        Tony Jones <tonyj@suse.de>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 11/15] perf script python: add Python3 support to stackcollapse.py
Date:   Fri, 22 Feb 2019 15:06:15 -0800
Message-Id: <20190222230619.17887-12-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222230619.17887-1-tonyj@suse.de>
References: <20190222230619.17887-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python2 and Python3 in the stackcollapse.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/perf/scripts/python/stackcollapse.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/stackcollapse.py b/tools/perf/scripts/python/stackcollapse.py
index 1697b5e18c96..5e703efaddcc 100755
--- a/tools/perf/scripts/python/stackcollapse.py
+++ b/tools/perf/scripts/python/stackcollapse.py
@@ -19,6 +19,8 @@
 # Written by Paolo Bonzini <pbonzini@redhat.com>
 # Based on Brendan Gregg's stackcollapse-perf.pl script.
 
+from __future__ import print_function
+
 import os
 import sys
 from collections import defaultdict
@@ -120,7 +122,6 @@ def process_event(param_dict):
     lines[stack_string] = lines[stack_string] + 1
 
 def trace_end():
-    list = lines.keys()
-    list.sort()
+    list = sorted(lines)
     for stack in list:
-        print "%s %d" % (stack, lines[stack])
+        print("%s %d" % (stack, lines[stack]))
-- 
2.20.1

