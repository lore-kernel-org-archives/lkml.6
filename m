Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A575BC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4102077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1aqf7K8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4102077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJLEb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeJLEbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:31:25 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8F48213A2;
        Thu, 11 Oct 2018 21:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539291745;
        bh=ni56dYnGEaaZIaG+hlhDb0XyGx6Zlpxng6nRb/x+NY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=1aqf7K8Cl9aHlnRCfheJQOfkuJNNKsra73CwmOoEdWpBNreFh9SsHWIw4WLwph6sO
         0wPolg3DEkAi7FsYeb08sCtXf/H79xhtZ7NnbrPKD5DArf4rWQh1cGNWBTCo/1KW8s
         zXNPrfevxwYS+8n8Q1tnMibHGPmWOqLk01Jso0j8=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v6 03/15] tracing: Add hist trigger handler.action documentation to README
Date:   Thu, 11 Oct 2018 16:02:00 -0500
Message-Id: <09c8327636ecfdc3afb10ca867d758d94a6c82ba.1539288364.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1539288364.git.tom.zanussi@linux.intel.com>
References: <cover.1539288364.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1539288364.git.tom.zanussi@linux.intel.com>
References: <cover.1539288364.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add abbreviated documentation for handlers and actions to README.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 147be8523560..fc0721b3e31d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4680,6 +4680,7 @@ static const char readme_msg[] =
 	"\t            [:size=#entries]\n"
 	"\t            [:pause][:continue][:clear]\n"
 	"\t            [:name=histname1]\n"
+	"\t            [:<handler>.<action>]\n"
 	"\t            [if <filter>]\n\n"
 	"\t    When a matching event is hit, an entry is added to a hash\n"
 	"\t    table using the key(s) and value(s) named, and the value of a\n"
@@ -4721,7 +4722,16 @@ static const char readme_msg[] =
 	"\t    The enable_hist and disable_hist triggers can be used to\n"
 	"\t    have one event conditionally start and stop another event's\n"
 	"\t    already-attached hist trigger.  The syntax is analagous to\n"
-	"\t    the enable_event and disable_event triggers.\n"
+	"\t    the enable_event and disable_event triggers.\n\n"
+	"\t    Hist trigger handlers and actions are executed whenever a\n"
+	"\t    a histogram entry is added or updated.  They take the form:\n\n"
+	"\t        <handler>.<action>\n\n"
+	"\t    The available handlers are:\n\n"
+	"\t        onmatch(matching.event)  - invoke on addition or update\n"
+	"\t        onmax(var)               - invoke if var exceeds current max\n\n"
+	"\t    The available actions are:\n\n"
+	"\t        <synthetic_event>(param list)        - generate synthetic event\n"
+	"\t        save(field,...)                      - save current event fields\n"
 #endif
 ;
 
-- 
2.14.1

