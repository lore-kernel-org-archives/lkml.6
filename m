Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBCFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108C5217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129780;
	bh=OjpO5ASP7PsC0A29U67UFHwnUxQPsJmSYM/WBsdNwzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vXPiCW2AInmp7A6BCGHXkOMLUGu328UBbbhWOJ5RlaigMX1Lk+pP/FclEo4QV3aMa
	 m+BtnGDtH+nlkYzRrB3aTl4g6TYuIzf8p6REN8jAMJiaF+TgwA52i0aPtTg0HfqGUL
	 uQ03SItATGQKrPeOKr5LBX2wBNrMGAbJCcuBJXEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbfBYVW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:22:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730975AbfBYVW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:56 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5061821850;
        Mon, 25 Feb 2019 21:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129775;
        bh=OjpO5ASP7PsC0A29U67UFHwnUxQPsJmSYM/WBsdNwzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qyngBKtKjD2Df4TQ5CG11M0EeK1zjFKz9Uh1xtWLdiWLxSLbSwmVj4B6EXThqaPSd
         7cLV/EknMKBWIQwzsy0cXUkjIx6U2yNhLoA1iYrEM6bA8+ioIJZYyWuKVS+EHtJvQ+
         ooT0v4O67kbcPk6LM1wmLBethB+SUAx0s4sNnt4Q=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 34/37] perf script python: Add Python3 support to stackcollapse.py
Date:   Mon, 25 Feb 2019 18:20:32 -0300
Message-Id: <20190225212035.24781-35-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Jones <tonyj@suse.de>

Support both Python2 and Python3 in the stackcollapse.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com> <pbonzini@redhat.com>
Link: http://lkml.kernel.org/r/20190222230619.17887-12-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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

