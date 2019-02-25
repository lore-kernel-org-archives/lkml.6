Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E62C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917C821850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129696;
	bh=bYZrcEFX3UVJ+7QTHzgZUltsTikCQ8Ea9kGGETAnuYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EZhMh68Aeca9+2sKEgB+pt51ym/1g7O4FtehSvmXWrxMpZc0xfHJG/GJe3ETTQEXP
	 0chdnS+KVpIm4JsqrLB1oPjqgptFerzc+5BTn8OnDMaezf9RocwOCWcV+MdtoB6cEk
	 xRez0eK8HB8B5/NOrvxVnenoJFRcFZqTXYco6UY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbfBYVVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:21:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730648AbfBYVVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:30 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D78A21850;
        Mon, 25 Feb 2019 21:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129689;
        bh=bYZrcEFX3UVJ+7QTHzgZUltsTikCQ8Ea9kGGETAnuYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ohmgYj6FoeYY5ZwZ+IHgUVK0nsbeT8hu2te6rEK3pVgZ9hj5UuiknZyApDuf5VazE
         zEbKHFsSklHHGNhcTBk5mzUdljpee0FZnjZptxKHUwdMmrvORTse3Yq919NaU3yvSa
         EH8Z/I4QVyQrrl0DB6ZdK2qXhSyxOWSOaDlpa2RU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/37] perf scripts python: exported-sql-viewer.py: Move report name into ReportVars
Date:   Mon, 25 Feb 2019 18:20:08 -0300
Message-Id: <20190225212035.24781-11-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The report name is a report variable so move it into into ReportVars.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 03428df8ddd5..ed39a0153dd3 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1402,7 +1402,8 @@ class BranchModel(TreeModel):
 
 class ReportVars():
 
-	def __init__(self, where_clause = ""):
+	def __init__(self, name = "", where_clause = ""):
+		self.name = name
 		self.where_clause = where_clause
 
 	def UniqueId(self):
@@ -1412,7 +1413,7 @@ class ReportVars():
 
 class BranchWindow(QMdiSubWindow):
 
-	def __init__(self, glb, event_id, name, report_vars, parent=None):
+	def __init__(self, glb, event_id, report_vars, parent=None):
 		super(BranchWindow, self).__init__(parent)
 
 		model_name = "Branch Events " + str(event_id) +  " " + report_vars.UniqueId()
@@ -1435,7 +1436,7 @@ class BranchWindow(QMdiSubWindow):
 
 		self.setWidget(self.vbox.Widget())
 
-		AddSubWindow(glb.mainwindow.mdi_area, self, name + " Branch Events")
+		AddSubWindow(glb.mainwindow.mdi_area, self, report_vars.name + " Branch Events")
 
 	def ResizeColumnToContents(self, column, n):
 		# Using the view's resizeColumnToContents() here is extrememly slow
@@ -1710,7 +1711,6 @@ class ReportDialogBase(QDialog):
 
 		self.glb = glb
 
-		self.name = ""
 		self.report_vars = ReportVars()
 
 		self.setWindowTitle(title)
@@ -1751,8 +1751,8 @@ class ReportDialogBase(QDialog):
 
 	def Ok(self):
 		vars = self.report_vars
-		self.name = self.data_items[0].value
-		if not self.name:
+		vars.name = self.data_items[0].value
+		if not vars.name:
 			self.ShowMessage("Report name is required")
 			return
 		for d in self.data_items:
@@ -2392,13 +2392,13 @@ class MainWindow(QMainWindow):
 		CallGraphWindow(self.glb, self)
 
 	def NewBranchView(self, event_id):
-		BranchWindow(self.glb, event_id, "", ReportVars(), self)
+		BranchWindow(self.glb, event_id, ReportVars(), self)
 
 	def NewSelectedBranchView(self, event_id):
 		dialog = SelectedBranchDialog(self.glb, self)
 		ret = dialog.exec_()
 		if ret:
-			BranchWindow(self.glb, event_id, dialog.name, dialog.report_vars, self)
+			BranchWindow(self.glb, event_id, dialog.report_vars, self)
 
 	def NewTableView(self, table_name):
 		TableWindow(self.glb, table_name, self)
-- 
2.20.1

