Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id m7UeHndiGlu3GQAAmS7hNA
	; Fri, 08 Jun 2018 11:03:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 67504607DC; Fri,  8 Jun 2018 11:03:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EA6F5605A5;
	Fri,  8 Jun 2018 11:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA6F5605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751486AbeFHLDR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:03:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751056AbeFHLDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:03:15 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w58AxWKl127426
        for <linux-kernel@vger.kernel.org>; Fri, 8 Jun 2018 07:03:15 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jfqxhhjd5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 07:03:15 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Fri, 8 Jun 2018 12:03:12 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Jun 2018 12:03:09 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w58B38Kv35782746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jun 2018 11:03:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5AE5AE051;
        Fri,  8 Jun 2018 11:52:04 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1F8FAE059;
        Fri,  8 Jun 2018 11:52:02 +0100 (BST)
Received: from oc1548405160.ibm.com (unknown [9.79.185.147])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  8 Jun 2018 11:52:02 +0100 (BST)
From: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc: s1seetee@linux.vnet.ibm.com
Subject: [PATCH] perf script: Show hw-cache events
Date: Fri,  8 Jun 2018 16:32:28 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18060811-0012-0000-0000-0000027D3956
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060811-0013-0000-0000-000020AE3C40
Message-Id: <1528455748-20087-1-git-send-email-s1seetee@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806080127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf script fails to report hardware cache events (PERF_TYPE_HW_CACHE)
where as perf report shows the samples. Fix it. Ex,

 # perf record -e L1-dcache-loads ./a.out
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.008 MB perf.data (11 samples)]

Before patch:
 # perf script | wc -l
 0
After patch:
 # perf script | wc -l
 11

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
---
 tools/perf/builtin-script.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index cefc881..9e94bb7 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -180,6 +180,18 @@ enum {
 				  PERF_OUTPUT_EVNAME | PERF_OUTPUT_TRACE
 	},
 
+	[PERF_TYPE_HW_CACHE] = {
+		.user_set = false,
+
+		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
+			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
+			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
+			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
+			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD,
+
+		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
+	},
+
 	[PERF_TYPE_RAW] = {
 		.user_set = false,
 
-- 
1.8.3.1
