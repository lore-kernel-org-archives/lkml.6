Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2390EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8E5218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfAaS4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:56:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727936AbfAaS4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:56:20 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VIs6BE036990
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 13:56:20 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qc67c9k1w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 13:56:18 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 31 Jan 2019 18:56:16 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 18:56:13 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0VIuCfr66519120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 18:56:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B20D4C050;
        Thu, 31 Jan 2019 18:56:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A825E4C04E;
        Thu, 31 Jan 2019 18:56:10 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.107.203])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 18:56:10 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        David Howells <dhowells@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 0/3] selftest/ima: add kexec_file_load test
Date:   Thu, 31 Jan 2019 13:55:33 -0500
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19013118-0008-0000-0000-000002B97B25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013118-0009-0000-0000-000022257F1A
Message-Id: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=688 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel can be configured to verify PE signed kernel images, IMA
kernel image signatures, both types of signatures, or none.  Verify
only properly signed kernel images are loaded into memory, based on
the kernel configuration and runtime policies.

Mimi Zohar (3):
  selftest/ima: cleanup the kexec selftest
  scripts/ima: define a set of common functions
  selftests/ima: kexec_file_load syscall test

 tools/testing/selftests/ima/Makefile               |   2 +-
 tools/testing/selftests/ima/common_lib.sh          |  20 ++
 .../testing/selftests/ima/test_kexec_file_load.sh  | 250 +++++++++++++++++++++
 tools/testing/selftests/ima/test_kexec_load.sh     |  31 +--
 4 files changed, 281 insertions(+), 22 deletions(-)
 create mode 100755 tools/testing/selftests/ima/common_lib.sh
 create mode 100755 tools/testing/selftests/ima/test_kexec_file_load.sh

-- 
2.7.5

