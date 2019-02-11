Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261BEC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE7F206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896457;
	bh=MkQ0q1MrgfKnGfPQIhUCSTDoBmwcEmndmY0fEo3RyF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vh0QRTgT7R8ZOd78LK9qkhN8XaaJJa0ZGBt9SzgiJ/KBSiLKbjZGukb9IJMn8vZ50
	 FSiwa+rro+GGLaNgQmGqx4xqYoTZMVZmGqI4+O7Pl4UGljHBOCx4iCNv4kO4CgNe6Z
	 eB1uiBHXGRFGhjKUw6Ag+EO/1aPnNtl28CtqQ/xE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbfBKOrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:47:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733027AbfBKOrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:47:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AF7D206BA;
        Mon, 11 Feb 2019 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896451;
        bh=MkQ0q1MrgfKnGfPQIhUCSTDoBmwcEmndmY0fEo3RyF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sWLZrMBtmnryCmDtdL8iCGj4k5heZwjO/4iYBonKepJIzLj8MEaRNkD6X59XciR5o
         mtTAaueaGQ4UdZ8yFBwFmiC2XuHEet/suSL4nxFgyjILzo37cqYf4cmhF3tdtRPEoi
         nUgk/EvKxsId6ZVYccIT/odYS53k9DOfdqT6KklE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 157/313] perf test: Fix perf_event_attr test failure
Date:   Mon, 11 Feb 2019 15:17:17 +0100
Message-Id: <20190211141903.992994466@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



