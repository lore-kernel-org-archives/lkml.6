Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90AAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41BE20660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977789;
	bh=ar8y1aH0j/j0M/XtmGDgNKY+a/PncTdx+pnn527WIKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eiTjb08dLcyYCMTQrC50fcvBoPXC+d7tXvxn0XljF6JqHIKN7O5UIvL+mqO06e9x0
	 wucSz5nHiYq0U4AQYq9djcag9QFbwt/spa43zf2gx/EVfngtMcbXlUEnXOjd937JMv
	 ZQVFD80W4gLZd1GvrfqCtsnYNbEGtxwy1JhdAUt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfAHT2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:28:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:35854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730142AbfAHT2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:28:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1400C20665;
        Tue,  8 Jan 2019 19:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975722;
        bh=ar8y1aH0j/j0M/XtmGDgNKY+a/PncTdx+pnn527WIKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMAXH4gseEBPrDMvqqBIGvRj+kS4N0YXlgcsVVb8p/sbvT5nvJXvxdyc/mQd6Rec1
         6kQrzWc89HLYCDG3E4mRI2U5gsEsTy10qm8T/0Cwz6AMksG54KKePB5iFxlhV16mwd
         Ds1tdpG1dW4WBSu/5Jkf8Nwtzzt6WpjKxLkf3DJ0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 078/117] tools lib traceevent: Fix compile warnings in tools/lib/traceevent/event-parse.c
Date:   Tue,  8 Jan 2019 14:25:46 -0500
Message-Id: <20190108192628.121270-78-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 0631ca3a6e6edd23a2ca7cab707d1abf291a097d ]

Fix following warnings:

  event-parse.c: In function ‘tep_find_event_by_name’:
  event-parse.c:3521:21: warning: ‘event’ may be used uninitialized in this function [-Wmaybe-uninitialized]
    pevent->last_event = event;
    ~~~~~~~~~~~~~~~~~~~^~~~~~~
    CC       ui/gtk/hists.o
    LINK     plugin_mac80211.so
    CC       nlattr.o
  event-parse.c: In function ‘tep_data_lat_fmt’:
  event-parse.c:5200:4: warning: ‘migrate_disable’ may be used uninitialized in this function [-Wmaybe-uninitialized]
      trace_seq_printf(s, "%d", migrate_disable);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  event-parse.c:5207:4: warning: ‘lock_depth’ may be used uninitialized in this function [-Wmaybe-uninitialized]
      trace_seq_printf(s, "%d", lock_depth);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    LINK     plugin_sched_switch.so
    LINK     plugin_function.so
    LINK     plugin_xen.so
  event-parse.c: In function ‘tep_event_info’:
  event-parse.c:5047:7: warning: ‘len_arg’ may be used uninitialized in this function [-Wmaybe-uninitialized]
         trace_seq_printf(s, format, len_arg, (char)val);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  event-parse.c:4884:6: note: ‘len_arg’ was declared here
    int len_arg;
        ^~~~~~~
  event-parse.c:4338:11: warning: ‘vsize’ may be used uninitialized in this function [-Wmaybe-uninitialized]
       val = tep_read_number(pevent, bptr, vsize);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  event-parse.c:4224:6: note: ‘vsize’ was declared here
    int vsize;
        ^~~~~

$ gcc --version
  gcc (Clear Linux OS for Intel Architecture) 8.2.1 20180502

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Link: http://lkml.kernel.org/r/20181122112937.10582-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/traceevent/event-parse.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 3692f29fee46..fbd6d6813fab 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -3498,7 +3498,7 @@ struct tep_event_format *
 tep_find_event_by_name(struct tep_handle *pevent,
 		       const char *sys, const char *name)
 {
-	struct tep_event_format *event;
+	struct tep_event_format *event = NULL;
 	int i;
 
 	if (pevent->last_event &&
@@ -4221,7 +4221,7 @@ static struct tep_print_arg *make_bprint_args(char *fmt, void *data, int size, s
 	unsigned long long ip, val;
 	char *ptr;
 	void *bptr;
-	int vsize;
+	int vsize = 0;
 
 	field = pevent->bprint_buf_field;
 	ip_field = pevent->bprint_ip_field;
@@ -4881,7 +4881,7 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct tep_e
 	char format[32];
 	int show_func;
 	int len_as_arg;
-	int len_arg;
+	int len_arg = 0;
 	int len;
 	int ls;
 
@@ -5146,8 +5146,8 @@ void tep_data_lat_fmt(struct tep_handle *pevent,
 	static int migrate_disable_exists;
 	unsigned int lat_flags;
 	unsigned int pc;
-	int lock_depth;
-	int migrate_disable;
+	int lock_depth = 0;
+	int migrate_disable = 0;
 	int hardirq;
 	int softirq;
 	void *data = record->data;
-- 
2.19.1

