Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AFCC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F982086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F982086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeIKN72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:59:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbeIKN72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:59:28 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8B8xLW7146988
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 05:01:07 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2meabh0xq9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 05:01:07 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mamatha4@linux.vnet.ibm.com>;
        Tue, 11 Sep 2018 10:01:05 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Sep 2018 10:01:04 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8B913Id65536026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 09:01:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E5384C04E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 12:00:55 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38DD24C044
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 12:00:55 +0100 (BST)
Received: from localhost.localdomain (unknown [9.124.35.195])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 12:00:55 +0100 (BST)
Subject: [PATCH] selftest:powerpc:dscr:fix compile error in dscr_sysfs_test
From:   Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Date:   Tue, 11 Sep 2018 14:31:02 +0530
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18091109-0020-0000-0000-000002C484DA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091109-0021-0000-0000-00002111D3F3
Message-Id: <153665627544.24494.10063715137186643486.stgit@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=869 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809110095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to fix the following compile error ocured when building
with gcc7:

[stderr] dscr_sysfs_test.c: In function ‘dscr_sysfs’:
[stderr] dscr_sysfs_test.c:63:20: error: ‘%s’ directive writing up to 255 bytes

Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
---
 .../selftests/powerpc/dscr/dscr_sysfs_test.c       |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c
index 1899bd8..72e3af0 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c
+++ b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c
@@ -62,7 +62,7 @@ static int check_all_cpu_dscr_defaults(unsigned long val)
 		if (!strstr(dp->d_name, "cpu"))
 			continue;
 
-		len = snprintf(file, LEN_MAX, "%s%s/dscr", CPU_PATH, dp->d_name);
+		len = snprintf(file, LEN_MAX, "%scpu%ld/dscr", CPU_PATH, val);
 		if (len >= LEN_MAX)
 			continue;
 		if (access(file, F_OK))

