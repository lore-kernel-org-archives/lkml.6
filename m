Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7861C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2E620834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqovOV67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2E620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJYToJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeJYToI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:44:08 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FEBA2084A;
        Thu, 25 Oct 2018 11:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465910;
        bh=HlZcBDJKOWMiVJx2HzaDBAnwZ8gIfN2lxDTZrlSrx8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TqovOV67sry8z2YL4TLVeaexGDPo73qS4QCEherccGG0D5n228nmpch+ADnu1yBeQ
         RkGo594ArdN0NUNi2sTDUhLh8XFpBM7msOws93xsZLYX+hjLaj9yOHE9mkrp4Ncq91
         xV7zudHZdl603YGNoL8zi9oPJOerkFB17xEnjWwY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 23/37] perf scripts python: call-graph-from-sql.py: Remove use of setObjectName()
Date:   Thu, 25 Oct 2018 08:10:17 -0300
Message-Id: <20181025111031.3440-24-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The object name is never used, so don't bother setting it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index 0a4dc13d4818..65c18e351bc4 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -269,7 +269,6 @@ class MainWindow(QMainWindow):
 
 		self.glb = glb
 
-		self.setObjectName("MainWindow")
 		self.setWindowTitle("Call Graph: " + glb.dbname)
 		self.move(100, 100)
 		self.resize(800, 600)
-- 
2.14.4

