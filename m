Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E491DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD32820834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LOcEA21O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD32820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbeLDTyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:54:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33078 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725875AbeLDTyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:54:16 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB4Jqtfg005137
        for <linux-kernel@vger.kernel.org>; Tue, 4 Dec 2018 11:54:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=QAlyF0rHDzJb/QvzTrRsT8sLE1JOpVlhHYCl4ng3EVU=;
 b=LOcEA21OME2LZJAbjCJtJXbvRRLxXSTpUPu22QCaPRy09TvckukXyqqdQ++aMS/1IUGn
 pEmNTwSp4ruPqlXH3cJuGqlLGF39pH2ILtTw/9V9ci+qsMrS9F9hYxTi7Hdm0UqFoDCf
 mY9pCt3HMYDoqSYucTH+qxfSgUjNh6MRtmM= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p5wxsrm7h-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:54:15 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Tue, 4 Dec 2018 11:54:07 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 9209262E18A8; Tue,  4 Dec 2018 11:54:02 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <acme@kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 perf,bpf 2/3] perf: sync tools/include/uapi/linux/perf_event.h
Date:   Tue, 4 Dec 2018 11:53:54 -0800
Message-ID: <20181204195355.4079788-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204195355.4079788-1-songliubraving@fb.com>
References: <20181204195355.4079788-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-04_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync changes for PERF_RECORD_BPF_EVENT.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/include/uapi/linux/perf_event.h | 35 ++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 9de8780ac8d9..0ae3dae55fa8 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -372,7 +372,8 @@ struct perf_event_attr {
 				context_switch :  1, /* context switch data */
 				write_backward :  1, /* Write ring buffer from end to beginning */
 				namespaces     :  1, /* include namespaces data */
-				__reserved_1   : 35;
+				bpf_event      :  1, /* include bpf events */
+				__reserved_1   : 34;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -965,9 +966,41 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_NAMESPACES			= 16,
 
+	/*
+	 * Record different types of bpf events:
+	 *  enum perf_bpf_event_type {
+	 *     PERF_BPF_EVENT_UNKNOWN		= 0,
+	 *     PERF_BPF_EVENT_PROG_LOAD		= 1,
+	 *     PERF_BPF_EVENT_PROG_UNLOAD	= 2,
+	 *  };
+	 *
+	 * struct {
+	 *	struct perf_event_header header;
+	 *	u32				type;
+	 *	u32				flags;
+	 *	u32				id; // prog_id or other id
+	 *	u32				sub_id; // subprog id
+	 *
+	 *	// for bpf_prog types, bpf prog or subprog
+	 *	u8				tag[BPF_TAG_SIZE];
+	 *	u64				addr;
+	 *	u64				len;
+	 *	char				name[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_BPF_EVENT			= 17,
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

