Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CA8C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D301A218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfAYPqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:46:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39437 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfAYPqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:46:53 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0PFjwNV177240
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 25 Jan 2019 07:45:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0PFjwsK177237;
        Fri, 25 Jan 2019 07:45:58 -0800
Date:   Fri, 25 Jan 2019 07:45:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-9359a8cbcc77d4afb07444f341e39015d232bd55@git.kernel.org>
Cc:     thomas.tai@oracle.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, tbaicar@codeaurora.org,
        tglx@linutronix.de, andriy.shevchenko@linux.intel.com, hch@lst.de,
        tony.luck@intel.com, rafael.j.wysocki@intel.com, bp@suse.de,
        rostedt@goodmis.org, hpa@zytor.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, tbaicar@codeaurora.org,
          linux-kernel@vger.kernel.org, bhelgaas@google.com,
          thomas.tai@oracle.com, mingo@kernel.org, hpa@zytor.com,
          rostedt@goodmis.org, bp@suse.de, rafael.j.wysocki@intel.com,
          tony.luck@intel.com, hch@lst.de,
          andriy.shevchenko@linux.intel.com
In-Reply-To: <20190125143035.81589-1-andriy.shevchenko@linux.intel.com>
References: <20190125143035.81589-1-andriy.shevchenko@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] RAS: Use consistent types for UUIDs
Git-Commit-ID: 9359a8cbcc77d4afb07444f341e39015d232bd55
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

Commit-ID:  9359a8cbcc77d4afb07444f341e39015d232bd55
Gitweb:     https://git.kernel.org/tip/9359a8cbcc77d4afb07444f341e39015d232bd55
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Fri, 25 Jan 2019 16:30:35 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 25 Jan 2019 16:40:40 +0100

RAS: Use consistent types for UUIDs

The commit

  297b64c74385 ("ras: acpi / apei: generate trace event for unrecognized CPER section")

brought inconsistency in UUID types which are used across the RAS
subsystem.

Fix this by using guid_t everywhere.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Tai <thomas.tai@oracle.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Link: https://lkml.kernel.org/r/20190125143035.81589-1-andriy.shevchenko@linux.intel.com
---
 drivers/ras/ras.c       | 2 +-
 include/ras/ras_event.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 3f38907320dc..95540ea8dd9d 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -14,7 +14,7 @@
 #define TRACE_INCLUDE_PATH ../../include/ras
 #include <ras/ras_event.h>
 
-void log_non_standard_event(const uuid_le *sec_type, const uuid_le *fru_id,
+void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 			    const char *fru_text, const u8 sev, const u8 *err,
 			    const u32 len)
 {
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index a0794632fd01..36c5c5e38c1d 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -27,7 +27,7 @@
 TRACE_EVENT(extlog_mem_event,
 	TP_PROTO(struct cper_sec_mem_err *mem,
 		 u32 err_seq,
-		 const uuid_le *fru_id,
+		 const guid_t *fru_id,
 		 const char *fru_text,
 		 u8 sev),
 
@@ -39,7 +39,7 @@ TRACE_EVENT(extlog_mem_event,
 		__field(u8, sev)
 		__field(u64, pa)
 		__field(u8, pa_mask_lsb)
-		__field_struct(uuid_le, fru_id)
+		__field_struct(guid_t, fru_id)
 		__string(fru_text, fru_text)
 		__field_struct(struct cper_mem_err_compact, data)
 	),
@@ -218,8 +218,8 @@ TRACE_EVENT(arm_event,
  */
 TRACE_EVENT(non_standard_event,
 
-	TP_PROTO(const uuid_le *sec_type,
-		 const uuid_le *fru_id,
+	TP_PROTO(const guid_t *sec_type,
+		 const guid_t *fru_id,
 		 const char *fru_text,
 		 const u8 sev,
 		 const u8 *err,
