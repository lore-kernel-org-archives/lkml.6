Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C48EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F44420675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbeLNUhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:37:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35059 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730739AbeLNUhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:37:23 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKbFI81455422
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:37:15 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKbFcT1455419;
        Fri, 14 Dec 2018 12:37:15 -0800
Date:   Fri, 14 Dec 2018 12:37:15 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-9f8e7683d1f54bed7d7cd33391ca9e31d24c942d@git.kernel.org>
Cc:     namhyung@kernel.org, tstoyanov@vmware.com, jolsa@redhat.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, acme@redhat.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
          hpa@zytor.com, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
          akpm@linux-foundation.org, namhyung@kernel.org,
          tstoyanov@vmware.com, jolsa@redhat.com
In-Reply-To: <20181130154647.743979275@goodmis.org>
References: <20181130154647.743979275@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: traceevent API cleanup, remove
 __tep_data2host*()
Git-Commit-ID: 9f8e7683d1f54bed7d7cd33391ca9e31d24c942d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9f8e7683d1f54bed7d7cd33391ca9e31d24c942d
Gitweb:     https://git.kernel.org/tip/9f8e7683d1f54bed7d7cd33391ca9e31d24c942d
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 30 Nov 2018 10:44:09 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 30 Nov 2018 17:15:06 -0300

perf tools: traceevent API cleanup, remove __tep_data2host*()

In order to make libtraceevent into a proper library, its API should be
straightforward. The __tep_data2host*() functions are going to no longer
be available as a libtraceevent API, tep_read_number() should be used
instead. This patch replaces __tep_data2host*() usage with
tep_read_number() in perf.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181130154647.743979275@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/trace-event-read.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 76f12c705ef9..efe2f58cff4e 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -102,7 +102,7 @@ static unsigned int read4(struct tep_handle *pevent)
 
 	if (do_read(&data, 4) < 0)
 		return 0;
-	return __tep_data2host4(pevent, data);
+	return tep_read_number(pevent, &data, 4);
 }
 
 static unsigned long long read8(struct tep_handle *pevent)
@@ -111,7 +111,7 @@ static unsigned long long read8(struct tep_handle *pevent)
 
 	if (do_read(&data, 8) < 0)
 		return 0;
-	return __tep_data2host8(pevent, data);
+	return tep_read_number(pevent, &data, 8);
 }
 
 static char *read_string(void)
