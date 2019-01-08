Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C47C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7548920660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977638;
	bh=xGU27Gu4KqxLr22Li6I6K+p2MSjbXJn9fRs1iQi0nK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EUhnZy/yCM+ICBWbuu5+sSott3k/vT6ZLbzMSM5yB8GZGh0EZ42SoxA+tOepGPugp
	 ogLBcabW55q8l7+7+T8eWqUHodHAdzcESf1HnSXpKFK56jqQmIhigeafQT1wi0DuaC
	 idux5rio8zbvRffcEoisXVZ9x9+44D/euL4RkFqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733035AbfAHUAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:00:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733018AbfAHT76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:59:58 -0500
Received: from quaco.ghostprotocols.net (unknown [177.135.9.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F89220827;
        Tue,  8 Jan 2019 19:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546977597;
        bh=xGU27Gu4KqxLr22Li6I6K+p2MSjbXJn9fRs1iQi0nK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJPYrcyQQK85ZxcMCXrvoIAuTtHrQVGHS+KONBwPnzpGnzLveDfXlbTL2NvuPTTIp
         By1YWOMVnVzetyzAg8LPmQGyBlS9Oq3VwGF4DHve/UJspksKITkRG4Mb8llR/Dklg/
         zXo9PI1Kq8oYAjYvyKoZp6JPQ5h+DXVxrK9iVKdI=
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
Subject: [PATCH 10/16] tools lib traceevent: Rename tep_is_file_bigendian() to tep_file_bigendian()
Date:   Tue,  8 Jan 2019 16:59:04 -0300
Message-Id: <20190108195910.17726-11-acme@kernel.org>
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
-- 
2.20.1

