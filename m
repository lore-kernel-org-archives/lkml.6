Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA73C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF9A20870
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF9A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeJZQU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:20:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51231 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeJZQU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:20:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7hs7t139463
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:43:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7hsgq139460;
        Fri, 26 Oct 2018 00:43:54 -0700
Date:   Fri, 26 Oct 2018 00:43:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-82f68e2898e634b8b0efc7ddd57e037ef75ea114@git.kernel.org>
Cc:     ak@linux.intel.com, adrian.hunter@intel.com, hpa@zytor.com,
        jolsa@redhat.com, mingo@kernel.org, acme@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: ak@linux.intel.com, adrian.hunter@intel.com, hpa@zytor.com,
          acme@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jolsa@redhat.com, mingo@kernel.org
In-Reply-To: <20181001062853.28285-16-adrian.hunter@intel.com>
References: <20181001062853.28285-16-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: exported-sql-viewer.py: Add
 ability to shrink / enlarge font
Git-Commit-ID: 82f68e2898e634b8b0efc7ddd57e037ef75ea114
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

Commit-ID:  82f68e2898e634b8b0efc7ddd57e037ef75ea114
Gitweb:     https://git.kernel.org/tip/82f68e2898e634b8b0efc7ddd57e037ef75ea114
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 1 Oct 2018 09:28:49 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Oct 2018 14:34:40 -0300

perf scripts python: exported-sql-viewer.py: Add ability to shrink / enlarge font

Shrinking the font allows more information to display.

Committer testing:

Works, tested with the convenient Control+Shift+'+' and Control+'-' as
well with the more cumbersome top menu "Edit" + "Enlarge/Shrink font"
options.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-16-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 0386a600ffc7..310ba7147583 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -706,6 +706,20 @@ class WindowMenu():
 	def setActiveSubWindow(self, nr):
 		self.mdi_area.setActiveSubWindow(self.mdi_area.subWindowList()[nr - 1])
 
+# Font resize
+
+def ResizeFont(widget, diff):
+	font = widget.font()
+	sz = font.pointSize()
+	font.setPointSize(sz + diff)
+	widget.setFont(font)
+
+def ShrinkFont(widget):
+	ResizeFont(widget, -1)
+
+def EnlargeFont(widget):
+	ResizeFont(widget, 1)
+
 # Unique name for sub-windows
 
 def NumberedWindowName(name, nr):
@@ -765,6 +779,8 @@ class MainWindow(QMainWindow):
 
 		edit_menu = menu.addMenu("&Edit")
 		edit_menu.addAction(CreateAction("&Find...", "Find items", self.Find, self, QKeySequence.Find))
+		edit_menu.addAction(CreateAction("&Shrink Font", "Make text smaller", self.ShrinkFont, self, [QKeySequence("Ctrl+-")]))
+		edit_menu.addAction(CreateAction("&Enlarge Font", "Make text bigger", self.EnlargeFont, self, [QKeySequence("Ctrl++")]))
 
 		reports_menu = menu.addMenu("&Reports")
 		reports_menu.addAction(CreateAction("Context-Sensitive Call &Graph", "Create a new window containing a context-sensitive call graph", self.NewCallGraph, self))
@@ -779,6 +795,14 @@ class MainWindow(QMainWindow):
 			except:
 				pass
 
+	def ShrinkFont(self):
+		win = self.mdi_area.activeSubWindow()
+		ShrinkFont(win.view)
+
+	def EnlargeFont(self):
+		win = self.mdi_area.activeSubWindow()
+		EnlargeFont(win.view)
+
 	def NewCallGraph(self):
 		CallGraphWindow(self.glb, self)
 
