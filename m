Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8098C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA6521470
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TagNGS3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA6521470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389201AbeGKUvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:51:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeGKUvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:51:11 -0400
Received: from jouet.localdomain (unknown [71.46.56.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C76221473;
        Wed, 11 Jul 2018 20:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531341905;
        bh=taRIvwofRKEqG+ZO/yPYFRO8+dE8faZ7xyC3VT7TiH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TagNGS3ZR+KB+gZipM2JBx9mRjWKMAURWePy7XVcHacJvFNowbBXjtLg+oZ3xk173
         1AEqsCXONrKs7JpzQei65fYSBS6ErKO84IXBVVfKKnRAQhmzej/wMUDjL7fau0EQ+c
         NBM/Mw1Wpn+pJHhauRhZkvOiHdwp9Ba24eHUhlPg=
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
Subject: [PATCH 06/14] perf scripts python: Add Python 3 support to EventClass.py
Date:   Wed, 11 Jul 2018 16:42:57 -0400
Message-Id: <20180711204305.12924-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Cline <jeremy@jcline.org>

Support both Python 2 and Python 3 in EventClass.py. ``print`` is now a
function rather than a statement. This should have no functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/0100016341a73aac-e0734bdc-dcab-4c61-8333-d8be97524aa0-000000@email.amazonses.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
index 81a56cd2b3c1..21a7a1298094 100755
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
@@ -8,6 +8,7 @@
 # PerfEvent is the base class for all perf event sample, PebsEvent
 # is a HW base Intel x86 PEBS event, and user could add more SW/HW
 # event classes based on requirements.
+from __future__ import print_function
 
 import struct
 
@@ -44,7 +45,8 @@ class PerfEvent(object):
                 PerfEvent.event_num += 1
 
         def show(self):
-                print "PMU event: name=%12s, symbol=%24s, comm=%8s, dso=%12s" % (self.name, self.symbol, self.comm, self.dso)
+                print("PMU event: name=%12s, symbol=%24s, comm=%8s, dso=%12s" %
+                      (self.name, self.symbol, self.comm, self.dso))
 
 #
 # Basic Intel PEBS (Precise Event-based Sampling) event, whose raw buffer
-- 
2.14.4

