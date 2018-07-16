Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EECECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9AB20B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9AB20B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbeGPLu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:50:28 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:60146 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726602AbeGPLu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:50:27 -0400
Received: from faui49t (faui49t.informatik.uni-erlangen.de [131.188.42.17])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 9BFA958C4F4;
        Mon, 16 Jul 2018 13:23:25 +0200 (CEST)
Received: by faui49t (sSMTP sendmail emulation); Mon, 16 Jul 2018 13:23:25 +0200
From:   Andreas Ziegler <andreas.ziegler@fau.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Changbin Du <changbin.du@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Ziegler <andreas.ziegler@fau.de>
Subject: [PATCH 1/2] Documentation: {u,k}probes: fix filename for event enabling
Date:   Mon, 16 Jul 2018 13:05:57 +0200
Message-Id: <1531739158-31133-2-git-send-email-andreas.ziegler@fau.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531739158-31133-1-git-send-email-andreas.ziegler@fau.de>
References: <1531739158-31133-1-git-send-email-andreas.ziegler@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per-event files to enable or disable kprobes and uprobes
are named 'enable', not 'enabled'. Fix the corresponding
documentation.

Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
---
 Documentation/trace/kprobetrace.rst  | 6 +++---
 Documentation/trace/uprobetracer.rst | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 3e0f971..c4aaef7d 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -18,7 +18,7 @@ To enable this feature, build your kernel with CONFIG_KPROBE_EVENTS=y.
 Similar to the events tracer, this doesn't need to be activated via
 current_tracer. Instead of that, add probe points via
 /sys/kernel/debug/tracing/kprobe_events, and enable it via
-/sys/kernel/debug/tracing/events/kprobes/<EVENT>/enabled.
+/sys/kernel/debug/tracing/events/kprobes/<EVENT>/enable.
 
 
 Synopsis of kprobe_events
@@ -81,9 +81,9 @@ Per-probe event filtering feature allows you to set different filter on each
 probe and gives you what arguments will be shown in trace buffer. If an event
 name is specified right after 'p:' or 'r:' in kprobe_events, it adds an event
 under tracing/events/kprobes/<EVENT>, at the directory you can see 'id',
-'enabled', 'format' and 'filter'.
+'enable', 'format' and 'filter'.
 
-enabled:
+enable:
   You can enable/disable the probe by writing 1 or 0 on it.
 
 format:
diff --git a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
index 98d3f69..d082281 100644
--- a/Documentation/trace/uprobetracer.rst
+++ b/Documentation/trace/uprobetracer.rst
@@ -13,7 +13,7 @@ To enable this feature, build your kernel with CONFIG_UPROBE_EVENTS=y.
 Similar to the kprobe-event tracer, this doesn't need to be activated via
 current_tracer. Instead of that, add probe points via
 /sys/kernel/debug/tracing/uprobe_events, and enable it via
-/sys/kernel/debug/tracing/events/uprobes/<EVENT>/enabled.
+/sys/kernel/debug/tracing/events/uprobes/<EVENT>/enable.
 
 However unlike kprobe-event tracer, the uprobe event interface expects the
 user to calculate the offset of the probepoint in the object.
-- 
2.7.4

