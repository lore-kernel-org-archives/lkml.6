Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F13C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA0D21470
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xWEfFC70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA0D21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbeGKUvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeGKUvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:51:06 -0400
Received: from jouet.localdomain (unknown [71.46.56.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE7132146F;
        Wed, 11 Jul 2018 20:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531341899;
        bh=mhXNdE3TR06Hs+D0AzLGsrQAAPeMAhpvNl6I8zCdylE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xWEfFC70xJdpUyaJ8V+jfDOeNwlhc+yJTi422zlZkSen1/PRgm4q03HcXrPOAjxwG
         Fa7iQbzEZ/NYysiSCMUfihx6xB0Ds3J8yzH+f437f5Q2HhcXcp9RPqoDy6j7msuC2O
         W7rW1oAbOuuGYEiiv+vJi+Ay+FSvs2lW+UePeyoM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Herton Krzesinski <herton@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/14] perf scripts python: Add Python 3 support to SchedGui.py
Date:   Wed, 11 Jul 2018 16:42:54 -0400
Message-Id: <20180711204305.12924-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Cline <jeremy@jcline.org>

Fix a single syntax error in SchedGui.py to support both Python 2 and
Python 3. This should have no functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/0100016341a72d26-75729663-fe55-4309-8c9b-302e065ed2f1-000000@email.amazonses.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
index fdd92f699055..cac7b2542ee8 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
@@ -11,7 +11,7 @@
 try:
 	import wx
 except ImportError:
-	raise ImportError, "You need to install the wxpython lib for this script"
+	raise ImportError("You need to install the wxpython lib for this script")
 
 
 class RootFrame(wx.Frame):
-- 
2.14.4

