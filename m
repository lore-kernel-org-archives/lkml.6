Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8B4C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C74121900
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358949;
	bh=EAQtuUOBC0vzOKhrKJJ5+TilfV1xu1i593QWkTHAubg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rp2ALzGnEIXGC3ucWMeLVM1RfMi6kpnWYJsDfZoOULjDHoLx4s1FuR3cE5fMtp0jd
	 rNF/bhc4B52L/BI3157keSe21DzrIwvejHEOEsH2+qAB5O244952LWUIFC7fd3vjjf
	 PrOQYtF5a8KmO/27UWaP5fvBD26LATTpQjlKoYQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbfAXTm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:42:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387775AbfAXTmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:42:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACFF820663;
        Thu, 24 Jan 2019 19:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358943;
        bh=EAQtuUOBC0vzOKhrKJJ5+TilfV1xu1i593QWkTHAubg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yLkGfNZM0D8uL2Yod17LifzzUz0kRiF2B6tZXxXSHmkYJKDdT3QocbT3ixtjYXm9B
         bw/vGuZleMtUkLULFHib8YUjfkmHcmIme2WLNSaccmp53/4QuYfn/XpWy5+4Jboe+P
         5BUTUCiIKkd58l8WU7JnwBPQn7t0z2sb8X10bnFk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 082/127] tools lib traceevent: Fix compile warnings in tools/lib/traceevent/event-parse.c
Date:   Thu, 24 Jan 2019 20:20:28 +0100
Message-Id: <20190124190215.600304401@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 70144b98141c..8ea1a02812b0 100644
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
 
@@ -5147,8 +5147,8 @@ void tep_data_lat_fmt(struct tep_handle *pevent,
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



