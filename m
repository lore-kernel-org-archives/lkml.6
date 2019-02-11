Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADA6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240C020863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfBKKGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:06:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725931AbfBKKGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:06:42 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BA63Vn106647
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 05:06:41 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qk4yfwtu6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 05:06:40 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 11 Feb 2019 10:06:38 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Feb 2019 10:06:35 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1BA6YkK47055086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Feb 2019 10:06:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D4C111C05E;
        Mon, 11 Feb 2019 10:06:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6207E11C04A;
        Mon, 11 Feb 2019 10:06:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Feb 2019 10:06:34 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf report: Add s390 diagnosic sampling descriptor size
Date:   Mon, 11 Feb 2019 11:06:27 +0100
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 19021110-0016-0000-0000-00000254F7B5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021110-0017-0000-0000-000032AF1247
Message-Id: <20190211100627.85714-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=964 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902110079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On IBM z13 machine types 2964 and 2965 the descriptor
sizes for sampling and diagnostic sampling entries
might be missing in the trailer entry and are set to zero.

This leads to a perf report failure when processing diagnostic
sampling entries.

This patch adds missing descriptor sizes when the trailer entry
contains zero for these fields.

Output before:
  [root@s38lp82 perf]#  ./perf report --stdio | fgrep Samples
  0xabbf0 [0x8]: failed to process type: 68
  Error:
  failed to process sample
  [root@s38lp82 perf]#

Output after:
  [root@s38lp82 perf]#  ./perf report --stdio | fgrep Samples
  # Total Lost Samples: 0
  # Samples: 3K of event 'SF_CYCLES_BASIC_DIAG'
  # Samples: 162  of event 'CF_DIAG'
  [root@s38lp82 perf]#

Fixes: 2b1444f2e28b ("perf report: Add raw report support for s390 auxiliary trace")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/util/s390-cpumsf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 68b2570304ec..08073a4d59a4 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -301,6 +301,11 @@ static bool s390_cpumsf_validate(int machine_type,
 			*dsdes = 85;
 			*bsdes = 32;
 			break;
+		case 2964:
+		case 2965:
+			*dsdes = 112;
+			*bsdes = 32;
+			break;
 		default:
 			/* Illegal trailer entry */
 			return false;
-- 
2.19.1

