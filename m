Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AC2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9052A2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfAIHQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:16:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34481 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfAIHQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:16:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x097FajZ3856372
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 23:15:36 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x097FaxT3856369;
        Tue, 8 Jan 2019 23:15:36 -0800
Date:   Tue, 8 Jan 2019 23:15:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-4104e604277016b3e6a7d120368054f9d2716953@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tstoyanov@vmware.com,
        jolsa@redhat.com, hpa@zytor.com, mingo@kernel.org,
        rostedt@goodmis.org, namhyung@kernel.org, acme@redhat.com,
        akpm@linux-foundation.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          jolsa@redhat.com, tstoyanov@vmware.com, acme@redhat.com,
          akpm@linux-foundation.org, tglx@linutronix.de,
          rostedt@goodmis.org, namhyung@kernel.org
In-Reply-To: <20181201040852.767549746@goodmis.org>
References: <20181201040852.767549746@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent: Rename
 tep_is_file_bigendian() to tep_file_bigendian()
Git-Commit-ID: 4104e604277016b3e6a7d120368054f9d2716953
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

Commit-ID:  4104e604277016b3e6a7d120368054f9d2716953
Gitweb:     https://git.kernel.org/tip/4104e604277016b3e6a7d120368054f9d2716953
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 30 Nov 2018 23:08:12 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 8 Jan 2019 13:28:13 -0300

tools lib traceevent: Rename tep_is_file_bigendian() to tep_file_bigendian()

In order to make libtraceevent into a proper library, its API
should be straightforward.

After a discussion with Steven Rostedt, we decided to rename a few APIs,
to have more intuitive names.

This patch renames tep_is_file_bigendian() to tep_file_bigendian().

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181201040852.767549746@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse-api.c | 4 ++--
 tools/lib/traceevent/event-parse.h     | 2 +-
 tools/lib/traceevent/plugin_kvm.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/traceevent/event-parse-api.c b/tools/lib/traceevent/event-parse-api.c
index 8b31c0e00ba3..d463761a58f4 100644
--- a/tools/lib/traceevent/event-parse-api.c
+++ b/tools/lib/traceevent/event-parse-api.c
@@ -194,13 +194,13 @@ void tep_set_page_size(struct tep_handle *pevent, int _page_size)
 }
 
 /**
- * tep_is_file_bigendian - get if the file is in big endian order
+ * tep_file_bigendian - get if the file is in big endian order
  * @pevent: a handle to the tep_handle
  *
  * This returns if the file is in big endian order
  * If @pevent is NULL, 0 is returned.
  */
-int tep_is_file_bigendian(struct tep_handle *pevent)
+int tep_file_bigendian(struct tep_handle *pevent)
 {
 	if(pevent)
 		return pevent->file_bigendian;
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index ac377ae99008..bd1bd9a27839 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -559,7 +559,7 @@ int tep_get_long_size(struct tep_handle *pevent);
 void tep_set_long_size(struct tep_handle *pevent, int long_size);
 int tep_get_page_size(struct tep_handle *pevent);
 void tep_set_page_size(struct tep_handle *pevent, int _page_size);
-int tep_is_file_bigendian(struct tep_handle *pevent);
+int tep_file_bigendian(struct tep_handle *pevent);
 void tep_set_file_bigendian(struct tep_handle *pevent, enum tep_endian endian);
 int tep_is_host_bigendian(struct tep_handle *pevent);
 void tep_set_host_bigendian(struct tep_handle *pevent, enum tep_endian endian);
diff --git a/tools/lib/traceevent/plugin_kvm.c b/tools/lib/traceevent/plugin_kvm.c
index 754050eea467..64b9c25a1fd3 100644
--- a/tools/lib/traceevent/plugin_kvm.c
+++ b/tools/lib/traceevent/plugin_kvm.c
@@ -389,7 +389,7 @@ static int kvm_mmu_print_role(struct trace_seq *s, struct tep_record *record,
 	 * We can only use the structure if file is of the same
 	 * endianness.
 	 */
-	if (tep_is_file_bigendian(event->pevent) ==
+	if (tep_file_bigendian(event->pevent) ==
 	    tep_is_host_bigendian(event->pevent)) {
 
 		trace_seq_printf(s, "%u q%u%s %s%s %spae %snxe %swp%s%s%s",
