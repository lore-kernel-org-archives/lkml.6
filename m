Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB6DC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0834D218FC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfBZX1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:27:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727998AbfBZX1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:27:46 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QNO68p021186
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 18:27:45 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qwc6f171r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 18:27:45 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 26 Feb 2019 23:27:43 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 23:27:40 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1QNRdID27721782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 23:27:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C0C8A4053;
        Tue, 26 Feb 2019 23:27:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B43ADA4040;
        Tue, 26 Feb 2019 23:27:38 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.106.105])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Feb 2019 23:27:38 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v2 0/5] selftests/ima: add kexec and kernel module tests
Date:   Tue, 26 Feb 2019 18:26:55 -0500
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19022623-4275-0000-0000-000003145942
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022623-4276-0000-0000-000038229A64
Message-Id: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel can be configured to require kexec kernel images and kernel
modules are signed.  An IMA policy can be specified on the boot command
line or a custom IMA policy loaded requiring the kexec kernel image and
kernel modules be signed.  In addition, systems booted in secure boot
mode with the IMA architecture specific policy enabled, require validly
signed kexec kernel images and kernel modules.

There are two methods of signing kernel images and two methods of
signing kernel modules.  In addition, there are two syscalls for each.

kernel image:  PE signature, IMA signature
kexec syscalls: kexec_load, kexec_file_load

Both the PE and IMA kernel image signature can only be verified when
loaded via the kexec_file_load syscall.

kernel moodule: appended signature, IMA signature
kernel module syscalls: init_module, finit_module

The appended kernel module signature can be verified when the kernel
module is loaded via either syscall.  The IMA kernel module signature
can only be verified when the kernel module is loaded via the
finit_module syscall.

The selftests in this patch set verify that only signed kernel images
and kernel modules are loaded as required, based on the kernel config,
the secure boot mode, and the IMA runtime policy.

Loading a kernel image or kernel module requires root privileges.  To
run just the IMA selftests: sudo make TARGETS=ima kselftest

Mimi Zohar (5):
  selftests/ima: cleanup the kexec selftest
  selftests/ima: define a set of common functions
  selftests/ima: define common logging functions
  selftests/ima: kexec_file_load syscall test
  selftests/ima: loading kernel modules

 tools/testing/selftests/ima/Makefile               |   3 +-
 tools/testing/selftests/ima/common_lib.sh          | 154 ++++++++++++++++
 tools/testing/selftests/ima/test_kernel_module.sh  |  96 ++++++++++
 .../testing/selftests/ima/test_kexec_file_load.sh  | 195 +++++++++++++++++++++
 tools/testing/selftests/ima/test_kexec_load.sh     |  53 ++----
 5 files changed, 463 insertions(+), 38 deletions(-)
 create mode 100755 tools/testing/selftests/ima/common_lib.sh
 create mode 100755 tools/testing/selftests/ima/test_kernel_module.sh
 create mode 100755 tools/testing/selftests/ima/test_kexec_file_load.sh

-- 
2.7.5

