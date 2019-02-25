Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E016C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C86421841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129676;
	bh=guQaLcqSYdqDYOkXxHkEYB2YalnBrvNATXyO7raGgqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FXh0vJxjWNJFduZQaykHPbljbqSwsk+1M3rDGmpelpieewpvjUou/pshNRCJkgTrM
	 WyfRK63zqVqUuzrtMjnFZyntMooKaaNMxX5AXP9xXJCPf1AWB6wxou6XCl0KXPJkn2
	 X5P+dshFjUnvYBtSqsqdmvrArFJpO0MV09ypJ5s0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbfBYVVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:21:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:54808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730571AbfBYVVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:12 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E67782184D;
        Mon, 25 Feb 2019 21:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129671;
        bh=guQaLcqSYdqDYOkXxHkEYB2YalnBrvNATXyO7raGgqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELbfC5vv/H5Gk2FWulceyGBM7MRJLzNSPI5mU5GSc5JIpypd2Purl1qTRlXa35D/6
         2ww2eiUsHPJaa8BUvznRJk113h2VVkjWwol62Doqr9VGtHx2zpcKhZR2m+myL7KddS
         I+PpwW7mvEAUN6jweQvtiXe0gA8Pblxe4ubZo/kg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/37] perf scripts python: exported-sql-viewer.py: Remove leftover debugging prints
Date:   Mon, 25 Feb 2019 18:20:03 -0300
Message-Id: <20190225212035.24781-6-acme@kernel.org>
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

Remove leftover debugging prints.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index b296028386a6..c20b510ace8f 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1560,7 +1560,6 @@ class SQLTableDialogDataItem():
 					return str(lower_id)
 
 	def ConvertRelativeTime(self, val):
-		print "val ", val
 		mult = 1
 		suffix = val[-2:]
 		if suffix == "ms":
@@ -1582,29 +1581,23 @@ class SQLTableDialogDataItem():
 		return str(val)
 
 	def ConvertTimeRange(self, vrange):
-		print "vrange ", vrange
 		if vrange[0] == "":
 			vrange[0] = str(self.first_time)
 		if vrange[1] == "":
 			vrange[1] = str(self.last_time)
 		vrange[0] = self.ConvertRelativeTime(vrange[0])
 		vrange[1] = self.ConvertRelativeTime(vrange[1])
-		print "vrange2 ", vrange
 		if not self.IsNumber(vrange[0]) or not self.IsNumber(vrange[1]):
 			return False
-		print "ok1"
 		beg_range = max(int(vrange[0]), self.first_time)
 		end_range = min(int(vrange[1]), self.last_time)
 		if beg_range > self.last_time or end_range < self.first_time:
 			return False
-		print "ok2"
 		vrange[0] = self.BinarySearchTime(0, self.last_id, beg_range, True)
 		vrange[1] = self.BinarySearchTime(1, self.last_id + 1, end_range, False)
-		print "vrange3 ", vrange
 		return True
 
 	def AddTimeRange(self, value, ranges):
-		print "value ", value
 		n = value.count("-")
 		if n == 1:
 			pass
-- 
2.20.1

