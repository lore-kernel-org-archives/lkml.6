Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806A9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468AC2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129701;
	bh=7UArT9M7ZQ2EPflPfWQ/d9Omy7iptVhVnMd3rBXfuug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GLHTa+bR9PrOiHpyOXQNkSS7UnYRhgRwau2A3qK9U4gTbRVxqNEEu3xFEHavum9hC
	 tBNzwedrcc2s+bRKYSYYFvJ8H+NdP9rmKd2A7JjH/Nskxx/5F7IjloBwzMyQEEdj59
	 SGnd2ODiJnNd078bkvXUAkToQOm/lM7JVOWC4Xy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbfBYVVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:21:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730672AbfBYVVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:36 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 942B82184D;
        Mon, 25 Feb 2019 21:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129694;
        bh=7UArT9M7ZQ2EPflPfWQ/d9Omy7iptVhVnMd3rBXfuug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pDIZ0NboLiRitWUoM6m056fbASG1YuljqXXZoXI+c1hvFdWJpBgSX97idHT49Qsux
         3g8KBYMjnarBigs/3G3wZqlwhJkOJP13wBzwDqGUngqsevpszEKpF839uTLuazBPh2
         hq8MOqKov8Bp8K1l9dr1L5oS6ddtyh/HkBx0lEW8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/37] perf scripts python: exported-sql-viewer.py: Remove SQLTableDialogDataItem
Date:   Mon, 25 Feb 2019 18:20:10 -0300
Message-Id: <20190225212035.24781-13-acme@kernel.org>
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

Remove SQLTableDialogDataItem as it is no longer used.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 221 ------------------
 1 file changed, 221 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 63b14b80ebcd..e1c2f9e54238 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1481,227 +1481,6 @@ class BranchWindow(QMdiSubWindow):
 		else:
 			self.find_bar.NotFound()
 
-# Dialog data item converted and validated using a SQL table
-
-class SQLTableDialogDataItem():
-
-	def __init__(self, glb, label, placeholder_text, table_name, match_column, column_name1, column_name2, parent):
-		self.glb = glb
-		self.label = label
-		self.placeholder_text = placeholder_text
-		self.table_name = table_name
-		self.match_column = match_column
-		self.column_name1 = column_name1
-		self.column_name2 = column_name2
-		self.parent = parent
-
-		self.value = ""
-
-		self.widget = QLineEdit()
-		self.widget.editingFinished.connect(self.Validate)
-		self.widget.textChanged.connect(self.Invalidate)
-		self.red = False
-		self.error = ""
-		self.validated = True
-
-		self.last_id = 0
-		self.first_time = 0
-		self.last_time = 2 ** 64
-		if self.table_name == "<timeranges>":
-			query = QSqlQuery(self.glb.db)
-			QueryExec(query, "SELECT id, time FROM samples ORDER BY id DESC LIMIT 1")
-			if query.next():
-				self.last_id = int(query.value(0))
-				self.last_time = int(query.value(1))
-			QueryExec(query, "SELECT time FROM samples WHERE time != 0 ORDER BY id LIMIT 1")
-			if query.next():
-				self.first_time = int(query.value(0))
-			if placeholder_text:
-				placeholder_text += ", between " + str(self.first_time) + " and " + str(self.last_time)
-
-		if placeholder_text:
-			self.widget.setPlaceholderText(placeholder_text)
-
-	def ValueToIds(self, value):
-		ids = []
-		query = QSqlQuery(self.glb.db)
-		stmt = "SELECT id FROM " + self.table_name + " WHERE " + self.match_column + " = '" + value + "'"
-		ret = query.exec_(stmt)
-		if ret:
-			while query.next():
-				ids.append(str(query.value(0)))
-		return ids
-
-	def IdBetween(self, query, lower_id, higher_id, order):
-		QueryExec(query, "SELECT id FROM samples WHERE id > " + str(lower_id) + " AND id < " + str(higher_id) + " ORDER BY id " + order + " LIMIT 1")
-		if query.next():
-			return True, int(query.value(0))
-		else:
-			return False, 0
-
-	def BinarySearchTime(self, lower_id, higher_id, target_time, get_floor):
-		query = QSqlQuery(self.glb.db)
-		while True:
-			next_id = int((lower_id + higher_id) / 2)
-			QueryExec(query, "SELECT time FROM samples WHERE id = " + str(next_id))
-			if not query.next():
-				ok, dbid = self.IdBetween(query, lower_id, next_id, "DESC")
-				if not ok:
-					ok, dbid = self.IdBetween(query, next_id, higher_id, "")
-					if not ok:
-						return str(higher_id)
-				next_id = dbid
-				QueryExec(query, "SELECT time FROM samples WHERE id = " + str(next_id))
-			next_time = int(query.value(0))
-			if get_floor:
-				if target_time > next_time:
-					lower_id = next_id
-				else:
-					higher_id = next_id
-				if higher_id <= lower_id + 1:
-					return str(higher_id)
-			else:
-				if target_time >= next_time:
-					lower_id = next_id
-				else:
-					higher_id = next_id
-				if higher_id <= lower_id + 1:
-					return str(lower_id)
-
-	def ConvertRelativeTime(self, val):
-		mult = 1
-		suffix = val[-2:]
-		if suffix == "ms":
-			mult = 1000000
-		elif suffix == "us":
-			mult = 1000
-		elif suffix == "ns":
-			mult = 1
-		else:
-			return val
-		val = val[:-2].strip()
-		if not self.IsNumber(val):
-			return val
-		val = int(val) * mult
-		if val >= 0:
-			val += self.first_time
-		else:
-			val += self.last_time
-		return str(val)
-
-	def ConvertTimeRange(self, vrange):
-		if vrange[0] == "":
-			vrange[0] = str(self.first_time)
-		if vrange[1] == "":
-			vrange[1] = str(self.last_time)
-		vrange[0] = self.ConvertRelativeTime(vrange[0])
-		vrange[1] = self.ConvertRelativeTime(vrange[1])
-		if not self.IsNumber(vrange[0]) or not self.IsNumber(vrange[1]):
-			return False
-		beg_range = max(int(vrange[0]), self.first_time)
-		end_range = min(int(vrange[1]), self.last_time)
-		if beg_range > self.last_time or end_range < self.first_time:
-			return False
-		vrange[0] = self.BinarySearchTime(0, self.last_id, beg_range, True)
-		vrange[1] = self.BinarySearchTime(1, self.last_id + 1, end_range, False)
-		return True
-
-	def AddTimeRange(self, value, ranges):
-		n = value.count("-")
-		if n == 1:
-			pass
-		elif n == 2:
-			if value.split("-")[1].strip() == "":
-				n = 1
-		elif n == 3:
-			n = 2
-		else:
-			return False
-		pos = findnth(value, "-", n)
-		vrange = [value[:pos].strip() ,value[pos+1:].strip()]
-		if self.ConvertTimeRange(vrange):
-			ranges.append(vrange)
-			return True
-		return False
-
-	def InvalidValue(self, value):
-		self.value = ""
-		palette = QPalette()
-		palette.setColor(QPalette.Text,Qt.red)
-		self.widget.setPalette(palette)
-		self.red = True
-		self.error = self.label + " invalid value '" + value + "'"
-		self.parent.ShowMessage(self.error)
-
-	def IsNumber(self, value):
-		try:
-			x = int(value)
-		except:
-			x = 0
-		return str(x) == value
-
-	def Invalidate(self):
-		self.validated = False
-
-	def Validate(self):
-		input_string = self.widget.text()
-		self.validated = True
-		if self.red:
-			palette = QPalette()
-			self.widget.setPalette(palette)
-			self.red = False
-		if not len(input_string.strip()):
-			self.error = ""
-			self.value = ""
-			return
-		if self.table_name == "<timeranges>":
-			ranges = []
-			for value in [x.strip() for x in input_string.split(",")]:
-				if not self.AddTimeRange(value, ranges):
-					return self.InvalidValue(value)
-			ranges = [("(" + self.column_name1 + " >= " + r[0] + " AND " + self.column_name1 + " <= " + r[1] + ")") for r in ranges]
-			self.value = " OR ".join(ranges)
-		elif self.table_name == "<ranges>":
-			singles = []
-			ranges = []
-			for value in [x.strip() for x in input_string.split(",")]:
-				if "-" in value:
-					vrange = value.split("-")
-					if len(vrange) != 2 or not self.IsNumber(vrange[0]) or not self.IsNumber(vrange[1]):
-						return self.InvalidValue(value)
-					ranges.append(vrange)
-				else:
-					if not self.IsNumber(value):
-						return self.InvalidValue(value)
-					singles.append(value)
-			ranges = [("(" + self.column_name1 + " >= " + r[0] + " AND " + self.column_name1 + " <= " + r[1] + ")") for r in ranges]
-			if len(singles):
-				ranges.append(self.column_name1 + " IN (" + ",".join(singles) + ")")
-			self.value = " OR ".join(ranges)
-		elif self.table_name:
-			all_ids = []
-			for value in [x.strip() for x in input_string.split(",")]:
-				ids = self.ValueToIds(value)
-				if len(ids):
-					all_ids.extend(ids)
-				else:
-					return self.InvalidValue(value)
-			self.value = self.column_name1 + " IN (" + ",".join(all_ids) + ")"
-			if self.column_name2:
-				self.value = "( " + self.value + " OR " + self.column_name2 + " IN (" + ",".join(all_ids) + ") )"
-		else:
-			self.value = input_string.strip()
-		self.error = ""
-		self.parent.ClearMessage()
-
-	def IsValid(self):
-		if not self.validated:
-			self.Validate()
-		if len(self.error):
-			self.parent.ShowMessage(self.error)
-			return False
-		return True
-
 # Line edit data item
 
 class LineEditDataItem(object):
-- 
2.20.1

