Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE92C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACAF20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691635;
	bh=fVQ5DIuzHOS2HNojPvjxUh3IhkOeynudRGNkP9epqcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=heRp7VQXIiLSuZmmRQgfTb9nU2XC+amFJmeFWTUAjhaWRfA6Wovwxhi0XAOhA8VCw
	 CeNuvihzmWZE1FH/J3Ljv5wwAX68929fFlCQ/yEsWF1BmVktqCk9V2isO3T6eSrXnu
	 e8SpyRlx+DLC5LProa9M16dEyQtjIyIbzDS6IU4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbfA1QHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:07:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:57286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731417AbfA1QHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:07:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253F220989;
        Mon, 28 Jan 2019 16:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691628;
        bh=fVQ5DIuzHOS2HNojPvjxUh3IhkOeynudRGNkP9epqcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQdYgJ1g/vf6hAImV9XDnDTriA+8YNwgkQHapoq97l2GWvJdEhvIe2rckV9TQCY20
         qBkS/V+8/7kj7i0bjC7uuix5J2V2CFsap6vnYA9l/u97zXPQwyiLF6azdPxFBBx1Be
         c39bx5y+01yUo3cqIKPjS4350LseCuHRr36MRx54=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 165/258] perf test: Fix perf_event_attr test failure
Date:   Mon, 28 Jan 2019 10:57:51 -0500
Message-Id: <20190128155924.51521-165-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 741dad88dde296999da30332157ca47f0543747d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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

