Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9yexCIElHlsiegAAmS7hNA
	; Mon, 11 Jun 2018 07:32:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0C1EF607A4; Mon, 11 Jun 2018 07:32:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 92E4560385;
	Mon, 11 Jun 2018 07:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92E4560385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932427AbeFKHcP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:32:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932385AbeFKHcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:32:13 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5B7ShE0030680
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 03:32:12 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jhmp78ab1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 03:32:12 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 11 Jun 2018 08:32:10 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Jun 2018 08:32:07 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5B7W6ZR28180642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jun 2018 07:32:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D9BE11C069;
        Mon, 11 Jun 2018 08:22:44 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE18E11C05C;
        Mon, 11 Jun 2018 08:22:43 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jun 2018 08:22:43 +0100 (BST)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/2] perf test: Fix test 39 Session topology for s390
Date: Mon, 11 Jun 2018 09:31:53 +0200
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180611073153.15592-1-tmricht@linux.ibm.com>
References: <20180611073153.15592-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061107-0028-0000-0000-000002CF6978
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061107-0029-0000-0000-000023867DF4
Message-Id: <20180611073153.15592-2-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806110092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On s390 this test case fails because the socket identifiction numbers
assigned to the CPU are higher than the CPU identification numbers.

Fix this by adding the platform architecture into the perf data header
flag information. This helps identifiing the test platform and handles
s390 specifics in process_cpu_topology().

Output before:
[root@p23lp27 perf]# ./perf test -vvvvv -F 39
39: Session topology                                      :
--- start ---
templ file: /tmp/perf-test-iUv755
socket_id number is too big.You may need to upgrade the perf tool.
---- end ----
Session topology: Skip
[root@p23lp27 perf]#

Output after:
[root@p23lp27 perf]# ./perf test -vvvvv -F 39
39: Session topology                                      :
--- start ---
templ file: /tmp/perf-test-8X8VTs
CPU 0, core 0, socket 6
CPU 1, core 1, socket 3
---- end ----
Session topology: Ok
[root@p23lp27 perf]#

Fixes: c84974ed9fb6 ("perf test: Add entry to test cpu topology")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/tests/topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 40e30a26b23c..9497d02f69e6 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -45,6 +45,7 @@ static int session_write_header(char *path)
 
 	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
 	perf_header__set_feat(&session->header, HEADER_NRCPUS);
+	perf_header__set_feat(&session->header, HEADER_ARCH);
 
 	session->header.data_size += DATA_SIZE;
 
-- 
2.14.3
