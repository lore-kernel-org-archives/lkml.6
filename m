Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D0BC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE2D2082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131721;
	bh=bRW8NYSpCUvrvT0lSgm+N/CTPB89IHxUIMFFRJSBVwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wnYETqbF/M2cJRPK8W+dkSxQNfkRCZ+A8pWcSoaLujq7QIfPOMQBXRGKVq+msvWuc
	 eMmY3X9huLWeSuWjEZneW2ZafdMftrUz+nABaImf3cBkrMIqzl8HrcdzQJ6SGefHuL
	 MtHNpTWTfWs8XdY8sMzjIjXna9/a7W6OG+qik2MM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE2D2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeLFV2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:28:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbeLFV2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:28:38 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 083072082B;
        Thu,  6 Dec 2018 21:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131718;
        bh=bRW8NYSpCUvrvT0lSgm+N/CTPB89IHxUIMFFRJSBVwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XlrOsJdFFtD1vxYcdVUkBQ4VqlOmnHHCkCdcoFo13SOs13qlrJH2wibMfCpcvZE8g
         C/EmQNE0urHKmQdZBfU3QUQfmmqv2c65I8Sd1NMJILBK12QmDiRCi8sAbdOfKwpHNT
         7Kx4anbPRdT9HxMqZ9Hk+Oa1605A7LNH1qt1JfKA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 31/75] tools lib traceevent: Rename tep_free_format() to tep_free_event()
Date:   Thu,  6 Dec 2018 18:25:18 -0300
Message-Id: <20181206212602.20474-32-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. This renames tep_free_format() to tep_free_event(), which
describes more closely the purpose of the function.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181130154647.591673556@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 6 +++---
 tools/lib/traceevent/event-parse.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 047be5f700b5..a3e7d0a75e11 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -6154,7 +6154,7 @@ __parse_event(struct tep_handle *pevent,
 	return 0;
 
 event_add_failed:
-	tep_free_format(event);
+	tep_free_event(event);
 	return ret;
 }
 
@@ -6763,7 +6763,7 @@ static void free_formats(struct tep_format *format)
 	free_format_fields(format->fields);
 }
 
-void tep_free_format(struct tep_event *event)
+void tep_free_event(struct tep_event *event)
 {
 	free(event->name);
 	free(event->system);
@@ -6849,7 +6849,7 @@ void tep_free(struct tep_handle *pevent)
 	}
 
 	for (i = 0; i < pevent->nr_events; i++)
-		tep_free_format(pevent->events[i]);
+		tep_free_event(pevent->events[i]);
 
 	while (pevent->handlers) {
 		handle = pevent->handlers;
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 2a1a644c5ec8..950ad185a5c4 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -475,7 +475,7 @@ enum tep_errno tep_parse_format(struct tep_handle *pevent,
 				struct tep_event **eventp,
 				const char *buf,
 				unsigned long size, const char *sys);
-void tep_free_format(struct tep_event *event);
+void tep_free_event(struct tep_event *event);
 void tep_free_format_field(struct tep_format_field *field);
 
 void *tep_get_field_raw(struct trace_seq *s, struct tep_event *event,
-- 
2.19.2

