Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068D3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B110920684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B110920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbeKWAqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:46:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:54414 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729117AbeKWAqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:46:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2018 06:06:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,266,1539673200"; 
   d="scan'208";a="110455325"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by orsmga001.jf.intel.com with ESMTP; 22 Nov 2018 06:06:29 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf test: Fix perf_event_attr test failure
Date:   Thu, 22 Nov 2018 16:04:56 +0200
Message-Id: <20181122140456.16817-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix inconsistent use of tabs and spaces error:

  # perf test 16 -v
  16: Setup struct perf_event_attr                          :
  --- start ---
  test child forked, pid 20224
    File "/usr/libexec/perf-core/tests/attr.py", line 119
      log.warning("expected %s=%s, got %s" % (t, self[t], other[t]))
                                                                 ^
  TabError: inconsistent use of tabs and spaces in indentation
  test child finished with -1
  ---- end ----
  Setup struct perf_event_attr: FAILED!

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/attr.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index ff9b60b99f52..44090a9a19f3 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -116,7 +116,7 @@ class Event(dict):
             if not self.has_key(t) or not other.has_key(t):
                 continue
             if not data_equal(self[t], other[t]):
-		log.warning("expected %s=%s, got %s" % (t, self[t], other[t]))
+                log.warning("expected %s=%s, got %s" % (t, self[t], other[t]))
 
 # Test file description needs to have following sections:
 # [config]
-- 
2.17.1

