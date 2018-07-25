Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8E7C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED07020852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED07020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbeGZAqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:46:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731640AbeGZAqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:46:08 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PNTQ59171837
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:32:09 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kewv6k5ky-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:32:09 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <erichte@linux.vnet.ibm.com>;
        Thu, 26 Jul 2018 00:32:07 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Jul 2018 00:32:04 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6PNW3k342401842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 23:32:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 135A3AE055;
        Thu, 26 Jul 2018 02:32:11 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44834AE051;
        Thu, 26 Jul 2018 02:32:09 +0100 (BST)
Received: from yorha.ibmmodules.com (unknown [9.80.225.100])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jul 2018 02:32:09 +0100 (BST)
From:   Eric Richter <erichte@linux.vnet.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Justin Forbes <jforbes@redhat.com>,
        Eric Richter <erichte@linux.vnet.ibm.com>
Subject: [PATCH 0/4] Add support for architecture-specific IMA policies
Date:   Wed, 25 Jul 2018 18:31:56 -0500
X-Mailer: git-send-email 2.14.4
X-TM-AS-GCONF: 00
x-cbid: 18072523-0028-0000-0000-000002E04225
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072523-0029-0000-0000-000023983098
Message-Id: <20180725233200.761-1-erichte@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=836 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMA can measure and appraise kernel images, but requires the appropriate
policy to be set to do so. This patch set adds the ability for different
architectures to define their own arch-specific default policies to be
loaded at run-time by implementing the arch_ima_get_policy() function.
This allows for the policy to be loaded based on the current system state,
such as secure boot state.

Included is an example patch that loads a set of IMA appraise rules
requiring the kexec kernel images to be measured and signed when EFI secure
boot is enabled. 

This set also contains a patch to IMA that adds a separate appraise func=
specifically for the kexec_load syscall. IMA cannot appraise images loaded
with kexec_load, and therefore automatically fails the signature check --
effectively disabling the syscall when the appropriate appraise rule is
set. This allows for the kexec_load syscall to be "disabled" via IMA
policy, but not conflict with the existing kexec_file_load signature
verification.

Eric Richter (2):
  ima: add support for KEXEC_ORIG_KERNEL_CHECK
  x86/ima: define arch_get_ima_policy() for x86

Nayna Jain (2):
  ima: add support for arch specific policies
  ima: add support for external setting of ima_appraise

 Documentation/ABI/testing/ima_policy  |   1 +
 arch/x86/kernel/Makefile              |   2 +
 arch/x86/kernel/ima_arch.c            |  27 +++++++++
 include/linux/ima.h                   |  13 +++++
 security/integrity/ima/Kconfig        |   8 +++
 security/integrity/ima/ima.h          |   7 +++
 security/integrity/ima/ima_appraise.c |  11 +++-
 security/integrity/ima/ima_main.c     |   3 +-
 security/integrity/ima/ima_policy.c   | 103 ++++++++++++++++++++++++++++++++++
 9 files changed, 172 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/kernel/ima_arch.c

-- 
2.14.4

