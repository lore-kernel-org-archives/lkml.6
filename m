Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554E5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC0920859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="U9EJuoZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfAPAO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 19:14:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44384 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726860AbfAPAOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 19:14:25 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0G08UXP031518
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 16:14:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=WP64zRf4UnoCieOOZ+Q2rHf+h2+SK57dQ72xUL5PtBw=;
 b=U9EJuoZzZUVkJVoMElZDTHvllmLpDpAE4c6rUTa0qN/IU9m0CKvIKDC9un+eW+4c+0/Z
 kpi5Q9OMWUKdvVZJSRNnEo8q5CE7ZkwadLmjFguhR1uNpyJ5//iEP1vBltISbS2XIdSO
 7HpkF+gOz0e+IkHTmS7lW5dvBz/o+yfOfuw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q1qgh0f4m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 16:14:24 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Tue, 15 Jan 2019 16:14:17 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id E2BF462E1DFB; Tue, 15 Jan 2019 16:14:13 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <dsahern@gmail.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v9 perf, bpf-next 4/9] sync tools/include/uapi/linux/perf_event.h
Date:   Tue, 15 Jan 2019 16:14:05 -0800
Message-ID: <20190116001410.3522226-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190116001410.3522226-1-songliubraving@fb.com>
References: <20190116001410.3522226-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-15_08:,,
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
index 68c4da0227c5..8bd78a34e396 100644
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
@@ -981,6 +982,25 @@ enum perf_event_type {
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
 
@@ -992,6 +1012,13 @@ enum perf_record_ksymbol_type {
 
 #define PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER	(1 << 0)
 
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

