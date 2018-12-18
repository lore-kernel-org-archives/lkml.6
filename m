Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB5AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100A921871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeLRNwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:52:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36613 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeLRNwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:52:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIDqPGf2851021
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 05:52:25 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIDqPQ92851018;
        Tue, 18 Dec 2018 05:52:25 -0800
Date:   Tue, 18 Dec 2018 05:52:25 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-741dad88dde296999da30332157ca47f0543747d@git.kernel.org>
Cc:     adrian.hunter@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, acme@redhat.com
Reply-To: adrian.hunter@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, jolsa@redhat.com, hpa@zytor.com,
          tglx@linutronix.de, acme@redhat.com
In-Reply-To: <20181122140456.16817-1-adrian.hunter@intel.com>
References: <20181122140456.16817-1-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test: Fix perf_event_attr test failure
Git-Commit-ID: 741dad88dde296999da30332157ca47f0543747d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  741dad88dde296999da30332157ca47f0543747d
Gitweb:     https://git.kernel.org/tip/741dad88dde296999da30332157ca47f0543747d
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 22 Nov 2018 16:04:56 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:54:32 -0300

perf test: Fix perf_event_attr test failure

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
