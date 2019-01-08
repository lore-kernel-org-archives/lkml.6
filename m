Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00334C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C41218A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977603;
	bh=V3/7k5EO22ZWVB1B62XA+2038ThUlMpBAjuw+2mgVHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iZp8Nz6N4f0x769NxI1ffSmYS2q0Ll24kO5x0X5OHYYG8gOk63rUJ4J8yY8CuLpos
	 /+ivRtNa6tC3nLfrZnUKCrKoMzwQzyIPKlNIuknAtFjGzQYx1pngxaZ7t5puRiIGcY
	 BT3ZsCDCh8ebMbCKbu0zGCK6QTQl1+uUpmc+/Dns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733045AbfAHUAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:00:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733030AbfAHUAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:00:00 -0500
Received: from quaco.ghostprotocols.net (unknown [177.135.9.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6B04217D9;
        Tue,  8 Jan 2019 19:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546977600;
        bh=V3/7k5EO22ZWVB1B62XA+2038ThUlMpBAjuw+2mgVHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIe+ggaDsGaOE105uhSTdecWExRkZ4/bjyE4tLQA4MigVVHVl0Ik3zkcO+iEfPwEP
         M4xdZNfQuit8ZwFBMfS1oYvQtpsGjDUjnaBckuLuW/enjXg91CHA+GwBZpm/EupHia
         r0GdVg3oyetiJrOqzYtifOnUarShPf4+7bT2/z88=
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
Subject: [PATCH 11/16] tools lib traceevent: Remove tep_data_event_from_type() API
Date:   Tue,  8 Jan 2019 16:59:05 -0300
Message-Id: <20190108195910.17726-12-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

In order to make libtraceevent into a proper library, its API
should be straightforward.

After discussion with Steven Rostedt, we decided to remove the
tep_data_event_from_type() API and to replace it with tep_find_event(),
as it does the same.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181201040852.913841066@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 12 ------------
 tools/lib/traceevent/event-parse.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 54d94054eef0..abd4fa5d3088 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5265,18 +5265,6 @@ int tep_data_type(struct tep_handle *pevent, struct tep_record *rec)
 	return trace_parse_common_type(pevent, rec->data);
 }
 
-/**
- * tep_data_event_from_type - find the event by a given type
- * @pevent: a handle to the pevent
- * @type: the type of the event.
- *
- * This returns the event form a given @type;
- */
-struct tep_event *tep_data_event_from_type(struct tep_handle *pevent, int type)
-{
-	return tep_find_event(pevent, type);
-}
-
 /**
  * tep_data_pid - parse the PID from record
  * @pevent: a handle to the pevent
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index bd1bd9a27839..aec48f2aea8a 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -526,7 +526,6 @@ tep_find_event_by_record(struct tep_handle *pevent, struct tep_record *record);
 void tep_data_lat_fmt(struct tep_handle *pevent,
 		      struct trace_seq *s, struct tep_record *record);
 int tep_data_type(struct tep_handle *pevent, struct tep_record *rec);
-struct tep_event *tep_data_event_from_type(struct tep_handle *pevent, int type);
 int tep_data_pid(struct tep_handle *pevent, struct tep_record *rec);
 int tep_data_preempt_count(struct tep_handle *pevent, struct tep_record *rec);
 int tep_data_flags(struct tep_handle *pevent, struct tep_record *rec);
-- 
2.20.1

