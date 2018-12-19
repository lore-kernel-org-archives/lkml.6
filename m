Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC85C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB4C217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PFcz9Dfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeLSGCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 01:02:48 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34796 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727931AbeLSGCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 01:02:45 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id wBJ62g3Q013616
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 22:02:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=KSZoaMUUYm7bYjwf8c1NpeReuEk9zp8DLbjCESJKmbk=;
 b=PFcz9Dfi4PDShcADLQIhDVFuC1YoKinA29dg0cHr66drVWvrpej5ZY5XvpZucaWSkbpT
 uH6DAqpprkmWAOJNQIBcz7MdxTiSELJksqnchx3FVE6UQVqEQ9LiDOOgZt6IZe5bgrNK
 41MrVLOG8s0b1O60xi2kSKr9wPgmbv9l024= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2pfeex07th-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 22:02:44 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Tue, 18 Dec 2018 22:02:38 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 53F8562E2012; Tue, 18 Dec 2018 22:02:37 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 perf, bpf-next 2/7] sync tools/include/uapi/linux/perf_event.h
Date:   Tue, 18 Dec 2018 22:02:21 -0800
Message-ID: <20181219060227.1057679-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181219060227.1057679-1-songliubraving@fb.com>
References: <20181219060227.1057679-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-19_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sync changes for PERF_RECORD_KSYMBOL

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/include/uapi/linux/perf_event.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 9de8780ac8d9..6c9e327e87ed 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -372,7 +372,8 @@ struct perf_event_attr {
 				context_switch :  1, /* context switch data */
 				write_backward :  1, /* Write ring buffer from end to beginning */
 				namespaces     :  1, /* include namespaces data */
-				__reserved_1   : 35;
+				ksymbol        :  1, /* include ksymbol events */
+				__reserved_1   : 34;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -648,11 +649,18 @@ struct perf_event_mmap_page {
  *   PERF_RECORD_MISC_COMM_EXEC  - PERF_RECORD_COMM event
  *   PERF_RECORD_MISC_FORK_EXEC  - PERF_RECORD_FORK event (perf internal)
  *   PERF_RECORD_MISC_SWITCH_OUT - PERF_RECORD_SWITCH* events
+ *   PERF_RECORD_MISC_KSYMBOL_*  - PERF_RECORD_KSYMBOL event
  */
 #define PERF_RECORD_MISC_MMAP_DATA		(1 << 13)
 #define PERF_RECORD_MISC_COMM_EXEC		(1 << 13)
 #define PERF_RECORD_MISC_FORK_EXEC		(1 << 13)
 #define PERF_RECORD_MISC_SWITCH_OUT		(1 << 13)
+
+#define PERF_RECORD_MISC_KSYMBOL_UNREGISTER	(1 << 3)
+#define PERF_RECORD_MISC_KSYMBOL_TYPE_MASK	(7 << 4)
+#define PERF_RECORD_MISC_KSYMBOL_TYPE_UNKNOWN	(0 << 4)
+#define PERF_RECORD_MISC_KSYMBOL_TYPE_BPF	(1 << 4)
+
 /*
  * These PERF_RECORD_MISC_* flags below are safely reused
  * for the following events:
@@ -965,6 +973,19 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_NAMESPACES			= 16,
 
+	/*
+	 * Record ksymbol register/unregister events:
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				addr;
+	 *	u64				len;
+	 *	char				name[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_KSYMBOL			= 17,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
-- 
2.17.1

