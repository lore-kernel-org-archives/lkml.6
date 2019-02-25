Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD28BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D80E20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131760;
	bh=kTTpSZ9K+IXu4GdC7YM6XCzGbiCTa0EzYqm+NCjvFhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nEtesmp/Jz1MJ8teWxZkxa0ntyzsalXX+ZsEzEr3bsyBQfb8XaWb0t8XM7Wzo5KqP
	 6zJVUvqhw+tU5mmeRrXs2uvEs4JHTBFxQHYyYKYjS8cnoZ3GTtAB95YdVdE0f6nHHj
	 CGDKW8n/8uN7SA4ZCwB8rABUfl7mzIMNn8fT6b6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfBYVz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:55:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:55470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730676AbfBYVVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:37 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4848321841;
        Mon, 25 Feb 2019 21:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129697;
        bh=kTTpSZ9K+IXu4GdC7YM6XCzGbiCTa0EzYqm+NCjvFhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=18PV5HrYFXEkbSv5GzFpoNw6JXpnd6ZjzlJbh8HvUQky24zapvn9Rs487YMd82mUg
         M+oUXufYyUzvb36hZQvDI8FyXC56MLk582yL5jOCYECLb1RFkLWBhnyQd3g54OarV6
         UTf2A+hhHnkrAZk2bJl7bPo+ZEq3g/aDEM5hJHuw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/37] perf scripts python: exported-sql-viewer.py: Remove no selection error
Date:   Mon, 25 Feb 2019 18:20:11 -0300
Message-Id: <20190225212035.24781-14-acme@kernel.org>
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

If no selection is made on the 'Selected branches' dialog, then the
output is the same as the 'All branches' report. That is not really an
error, and is not desirable for future reports, so remove it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index e1c2f9e54238..728200e3a691 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1808,9 +1808,6 @@ class ReportDialogBase(QDialog):
 				vars.where_clause = " AND ( " + vars.where_clause + " ) "
 			else:
 				vars.where_clause = " WHERE " + vars.where_clause + " "
-		else:
-			self.ShowMessage("No selection")
-			return
 		self.accept()
 
 	def ShowMessage(self, msg):
-- 
2.20.1

