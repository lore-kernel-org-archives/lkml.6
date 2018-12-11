Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3792EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF5E214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544486638;
	bh=nrdxOiF3/wOW+yKtLxbMgSydY9m3yAPgq3dT280hxdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=sI3VDRPslYijybkPG2m0VQ1h2oP2f0UkaKsx8Kg3M2KLTARBIhZuj4EnAX5JSPhJJ
	 fDkTcldaoaoD7gF6Kg+8T82DUkhlvi8VMDkSrRfE4EXbdlTc6N89QO0lXAV5u8srJ6
	 ApQI0TvLyNDTGQhDtkHzlwKpL/tLJee0YOLK6GWU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF5E214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbeLKABx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:01:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730235AbeLKABu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:01:50 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96D1C214ED;
        Tue, 11 Dec 2018 00:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544486509;
        bh=nrdxOiF3/wOW+yKtLxbMgSydY9m3yAPgq3dT280hxdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=eq/J6xcd5EJg4jaX4wr4caVWCMx4vTKwVqygl8EIf4hpYsH5BhseXgpNsix6Esmte
         fqe4+CkDvfxEjA12tYzSKp7eq4eaLhDiPacVSQ4NB8bIJvn8aG4JirfGAqyVry/9/9
         TJMHeboev1tPPOAxNh/CBmdcBQJtJ9tD2eyRrtC4=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v8 03/22] tracing: Add hist trigger handler.action documentation to README
Date:   Mon, 10 Dec 2018 18:01:17 -0600
Message-Id: <aed0a478f683ac4a7669c62d72e8a01d975e525b.1544483272.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
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
index 911470ad9e94..1abde13a7eab 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4698,6 +4698,7 @@ static const char readme_msg[] =
 	"\t            [:size=#entries]\n"
 	"\t            [:pause][:continue][:clear]\n"
 	"\t            [:name=histname1]\n"
+	"\t            [:<handler>.<action>]\n"
 	"\t            [if <filter>]\n\n"
 	"\t    When a matching event is hit, an entry is added to a hash\n"
 	"\t    table using the key(s) and value(s) named, and the value of a\n"
@@ -4739,7 +4740,16 @@ static const char readme_msg[] =
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

