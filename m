Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3127C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23FA2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23FA2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbeJZQOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:14:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35391 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeJZQOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:14:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7cLp2137990
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:38:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7cLpv137987;
        Fri, 26 Oct 2018 00:38:21 -0700
Date:   Fri, 26 Oct 2018 00:38:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-7e4fc93e2ade2b0c453a97e307203ffe3f930c98@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com,
        jolsa@redhat.com, ak@linux.intel.com
Reply-To: acme@redhat.com, ak@linux.intel.com, jolsa@redhat.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mingo@kernel.org, adrian.hunter@intel.com
In-Reply-To: <20181001062853.28285-6-adrian.hunter@intel.com>
References: <20181001062853.28285-6-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: call-graph-from-sql.py: Make
 a "Main" function
Git-Commit-ID: 7e4fc93e2ade2b0c453a97e307203ffe3f930c98
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

Commit-ID:  7e4fc93e2ade2b0c453a97e307203ffe3f930c98
Gitweb:     https://git.kernel.org/tip/7e4fc93e2ade2b0c453a97e307203ffe3f930c98
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 1 Oct 2018 09:28:39 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Oct 2018 14:22:54 -0300

perf scripts python: call-graph-from-sql.py: Make a "Main" function

Make a "Main" function so that the variables used do not pollute the global
namespace.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index 2e33540f3de0..2b74b94eeccc 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -284,7 +284,9 @@ class MainWindow(QMainWindow):
 
 		self.setCentralWidget(self.view)
 
-if __name__ == '__main__':
+# Main
+
+def Main():
 	if (len(sys.argv) < 2):
 		print >> sys.stderr, "Usage is: call-graph-from-sql.py <database name>"
 		raise Exception("Too few arguments")
@@ -331,3 +333,6 @@ if __name__ == '__main__':
 	err = app.exec_()
 	db.close()
 	sys.exit(err)
+
+if __name__ == "__main__":
+	Main()
