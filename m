Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6792C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892752145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rv6sh9LI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892752145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeLAFhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:37:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbeLAFhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:37:50 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 979AC21473;
        Fri, 30 Nov 2018 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543602461;
        bh=l5cwSjWDWuRAYdE5cb3HZzmcVnnHzzDWTTiCX9luttw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rv6sh9LI6iEZVqis8SyWXmRXP1cfVySROFDGKU8b76BVM3uYtnI8M7xG96SKcGIxF
         xgMTQ8C+PvO0x91FLljaPor3mqdsgYdJ/ziODF/A0PT9ikcxe1KuVQ/eREjH5BEcRe
         3o4rU7OTwXpb/NRI4v+n8G65t38KNd1N27xuV0Ws=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/22] perf test: Fix perf_event_attr test failure
Date:   Fri, 30 Nov 2018 15:26:42 -0300
Message-Id: <20181130182652.23620-13-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130182652.23620-1-acme@kernel.org>
References: <20181130182652.23620-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181122140456.16817-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.19.1

