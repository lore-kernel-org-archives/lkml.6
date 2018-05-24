Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527160367-2-11631548763773755119
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160367; b=M7hjZJOXlCchrqwuYl0SXGG3X0wd6Fojgvb+triDF3uoLjKInG
    ssLLOkbzU1l4ksh61A5BAd2tgYSvEcTPk/nPvGLltdAhuiHQ87j1rUuR50IMFw4i
    agboCBoD/ND6ae42bDNk/OFhLLQgcDqJ3Fb+cPEX8q1PJ+uyI/KHgbPmzKfh4Bbm
    LSXLpcZI+mzYdbcX2ct40eH9T2mr9kwZUC2fmln5LoY2sSbDnfIw12+dATpphymT
    YY1CjzaSWigsfShrfwoCVNDzJHqnui9KJvQ6e5ClhV4UtAfEUpOrz4jQuUsI4O5Z
    v3gTcp0MjAIhAcAct62HjKCx4ywxkYUz8Kfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527160367; bh=WZUF3nbU3t44RshYz3k1I4ISFudtpM
    KFnmaAC4KCn6w=; b=Oa8bAFmdZqoAES5eChiyFwaj9BQykDSAt3AG+JLQxPgp/R
    +7UP3ORUz5yT2/R8gDZN44PGuHGUM6ZtVbkBzHjHhzjs6VODebWvthDl2uOIyDNO
    GKtPolxtyF0dYawh7y87FhKfchjY5obv73DDMY1RO3XXnGUDFMiw6E+Mdq89FJzO
    WYbXGGQ3HG8f1OJ2qNqkVVzbsLSmHrmB+PmCrpns9M0KyAehUU2hggiPeeE2j0Qf
    /QD4984dmU4vljPGY1pSbVs5g3zbqaTmkBOWrXfFCRIeM0CS2g0/TTrnhbMzGh2/
    I5MkN0rCKzJEkYD0frAfV0428Gj+oc/eBPgKqCkg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEi73tFgk2y+FEn+5OnRKgbMrKwtxfQdlFdn+QkAuLyIsAenuvjI91h8bYJHqdnRMNSnzgwFPhwvkSpPKexQ4WOHA1+PhYbsby4jICQHivOKfaErli3x
    Y444agCU1LzMKUxZn8/utBn2Sz+kXXBqmFgefNrq0qbF3ivkss6MVyFawjCu55J3lTw0C9UqTo9nUKGtcta5BvMUT3vX+zZpq51at6nozbLLSNXZ4+mFG901
    KOL2vjou9shYxWumKIwEyg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=pfepmeDxbJN8zshhl1AA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968153AbeEXLMJ (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 07:12:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1033016AbeEXLKb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 May 2018 07:10:31 -0400
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v3 0/7] kexec/firmware: support system wide policy requiring signatures
Date: Thu, 24 May 2018 07:09:29 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 18052411-0012-0000-0000-000005DA20EA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052411-0013-0000-0000-000019576F9C
Message-Id: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805240132
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

IMA-appraisal is mostly being used in the embedded or single purpose
closed system environments.  In these environments, both the Kconfig
options and the userspace tools can be modified appropriately to limit
syscalls.  For stock kernels, userspace applications need to continue to
work with older kernels as well as with newer kernels.

In this environment, the customer needs the ability to define a system
wide IMA policy, such as requiring all kexec'ed images, firmware, kernel
modules to be signed, without being dependent on either the Kconfig
options or the userspace tools.[1]

This patch set allows the customer to define a policy which requires
the kexec'ed kernel images, firmware, and/or kernel modules to be
signed.

New to this patch set is the ability to configure a build time IMA policy,
which is automatically loaded at run time without needing to specify it
on the boot command line.  The build time policy rules persist after
loading a custom kernel policy.

[1] kexec-tools suupports the new syscall based on a flag (-s).

Changelog v3:
Based on James' feedback:
- Renamed security_kernel_read_file() to security_kernel_read_data().
- Cleaned up ima_read_data(), replacing if's with switch.

Changelog v2:
- combined "kexec: limit kexec_load syscall" and "firmware: kernel
signature verification" patch sets.
- add support for build time policy.
- defined generic security_kernel_read_blob() wrapper for
  security_kernel_read_file(). Suggested by Luis.
- removed the CONFIG_CFG80211_REQUIRE_SIGNED_REGDB ifdef.  If both REGDB
  and an IMA-appraisal policy require signed firmware, for now require
  both signatures.  Subsequent patches might change this.
- Still unclear if the pre-allocated firmware buffer can be accessed

Mimi Zohar (7):
  security: rename security_kernel_read_file() hook
  kexec: add call to LSM hook in original kexec_load syscall
  ima: based on policy require signed kexec kernel images
  firmware: add call to LSM hook before firmware sysfs fallback
  ima: based on policy require signed firmware (sysfs fallback)
  ima: add build time policy
  ima: based on policy prevent loading firmware (pre-allocated buffer)

 drivers/base/firmware_loader/fallback.c |  7 ++++
 fs/exec.c                               |  2 +-
 include/linux/fs.h                      |  1 +
 include/linux/ima.h                     |  4 +--
 include/linux/security.h                |  4 +--
 kernel/kexec.c                          |  8 +++++
 kernel/module.c                         |  2 +-
 security/integrity/ima/Kconfig          | 58 +++++++++++++++++++++++++++++++++
 security/integrity/ima/ima.h            |  1 +
 security/integrity/ima/ima_main.c       | 39 ++++++++++++++++++----
 security/integrity/ima/ima_policy.c     | 48 +++++++++++++++++++++++++--
 security/loadpin/loadpin.c              |  2 +-
 security/security.c                     |  6 ++--
 13 files changed, 162 insertions(+), 20 deletions(-)

-- 
2.7.5

