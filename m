Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86939C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5486C2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XHpoHXXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeLSGCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 01:02:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57558 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727994AbeLSGCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 01:02:52 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBJ5xlrD030482
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 22:02:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=I6aEBvXwol2rma2u2kJKPv1Pur2pgaJ+N8DpFrRQ03Q=;
 b=XHpoHXXWQiky+rUHfThqhQpA6fVHv/+Ph2vzYCNAQb5/oMYMpzctFFZnKjw5ftqHYCdL
 buETNu+HY2JocHMn6weWGtsmeTuYjd7mZGbWs7lVKVcm2emquXexojkkNnoeufkfLMpX
 9bs7Wx4FFUD4epu4oBJC1DbgKL47bzJvmHo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pff2c85hq-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 22:02:51 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Tue, 18 Dec 2018 22:02:42 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 6EF2A62E1FFC; Tue, 18 Dec 2018 22:02:37 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 perf, bpf-next 4/7] sync tools/include/uapi/linux/perf_event.h
Date:   Tue, 18 Dec 2018 22:02:23 -0800
Message-ID: <20181219060227.1057679-5-songliubraving@fb.com>
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

sync for PERF_RECORD_BPF_EVENT

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/include/uapi/linux/perf_event.h | 29 ++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 6c9e327e87ed..68db04058408 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -373,7 +373,8 @@ struct perf_event_attr {
 				write_backward :  1, /* Write ring buffer from end to beginning */
 				namespaces     :  1, /* include namespaces data */
 				ksymbol        :  1, /* include ksymbol events */
-				__reserved_1   : 34;
+				bpf_event      :  1, /* include bpf events */
+				__reserved_1   : 33;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -986,9 +987,35 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_KSYMBOL			= 17,
 
+	/*
+	 * Record bpf events:
+	 *  enum perf_bpf_event_type {
+	 *	PERF_BPF_EVENT_UNKNOWN		= 0,
+	 *	PERF_BPF_EVENT_PROG_LOAD	= 1,
+	 *	PERF_BPF_EVENT_PROG_UNLOAD	= 2,
+	 *  };
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u16				type;
+	 *	u16				flags;
+	 *	u32				id;
+	 *	u8				tag[BPF_TAG_SIZE];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_BPF_EVENT			= 18,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
+enum perf_bpf_event_type {
+	PERF_BPF_EVENT_UNKNOWN		= 0,
+	PERF_BPF_EVENT_PROG_LOAD	= 1,
+	PERF_BPF_EVENT_PROG_UNLOAD	= 2,
+	PERF_BPF_EVENT_MAX,		/* non-ABI */
+};
+
 #define PERF_MAX_STACK_DEPTH		127
 #define PERF_MAX_CONTEXTS_PER_STACK	  8
 
-- 
2.17.1

