Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF44ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6C020665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6C020665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeJZQNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:13:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45079 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeJZQNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:13:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7bHYY137754
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:37:17 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7bHKn137751;
        Fri, 26 Oct 2018 00:37:17 -0700
Date:   Fri, 26 Oct 2018 00:37:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-3c4ef451506897a15aff76ff141c995c6cd32f4d@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com,
        ak@linux.intel.com, mingo@kernel.org, adrian.hunter@intel.com,
        hpa@zytor.com, jolsa@redhat.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          ak@linux.intel.com, mingo@kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, jolsa@redhat.com, hpa@zytor.com
In-Reply-To: <20181001062853.28285-4-adrian.hunter@intel.com>
References: <20181001062853.28285-4-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: call-graph-from-sql.py: Set
 a minimum window size
Git-Commit-ID: 3c4ef451506897a15aff76ff141c995c6cd32f4d
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

Commit-ID:  3c4ef451506897a15aff76ff141c995c6cd32f4d
Gitweb:     https://git.kernel.org/tip/3c4ef451506897a15aff76ff141c995c6cd32f4d
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 1 Oct 2018 09:28:37 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Oct 2018 14:19:30 -0300

perf scripts python: call-graph-from-sql.py: Set a minimum window size

Prevent weirdly small window size.

Committer testing:

Seems to work, but even before this patch, on my system, it always
started with:

xwininfo: Window id: 0x1e00002 "Call Graph: pt_example"
<SNIP>
  Width: 800
  Height: 600
<SNIP>

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index e1014f2628a7..68153fa1b4d1 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -274,6 +274,7 @@ class MainWindow(QMainWindow):
 		style = self.style()
 		icon = style.standardIcon(QStyle.SP_MessageBoxInformation)
 		self.setWindowIcon(icon);
+		self.setMinimumSize(200, 100)
 
 		self.model = TreeModel(db)
 
