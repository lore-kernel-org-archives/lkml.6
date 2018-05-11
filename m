Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3090366-1526002665-2-4881786792206363548
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526002665; b=UCy49VvlMpGAGypxDB0q/+5U0Vfjh5X7IeeW3xoL0t29RB44rD
    Z9DwqEODP7nh1nt/TJnuyxVOlNo97yGXXT8S8gSXRS04qKaNn9M2FLkeeofW38A4
    ZpqEdkN+qPzd4puX8yZcpD6a7OY9vsvoAb566L8n8t0YY71fApgHJuFUyobMJmRj
    v2h92MP2dw1mJKeewep0cs5UGmyJRfzZ4jeEj5aignvN4DM8W9aGR/7QI27psxf4
    PwGd22vrnhoTaxXhti6coyH7F4n9zQF6CtoxRRSp9LAYCMGX54WoCAgzT1gb1O7V
    2UfSpKl2bTwYD6n7+TAVHrtF4O1LCrzN6pFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526002665; bh=dI05kw80FX3vHdyr5qpAlUEKvLk0kj
    IdQT9lKvr5zHk=; b=ZjPMlyAOei8IRFC4RD6XESqvAeUytSHP5BZwlUNMihfpUY
    xTZVa3M48XncRLgAmdF0+CCr87xX6RPxpyRHtgq7pgAk4s2ifP4uUEJrZ3zy2KgR
    MmbFduto/ccYWrEbs7BgjsCVcRx2FgbjjCgLzu1wuABSbXTR1w6RQpVW2/F6J+BB
    wCnaTGBly9Mzv5O2lFqIFLobg5VMh7S4/ykWxEVDLLJj7i98huZSNiKpo710cYU+
    Xjr1gLD7IPZZeH0Zhkgi7xA6TJ509iF32c08a7qe/vzEZu4Qbz2Ezmx8Z7U0ix4f
    JM4+9xHljaHi61dffZ2CjJ2xxbn0L4Wdkg2I/fsg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfPWR4yUc9gH7+V8FwiMet/xb4jjyghtwF/gtGVJQfzjJAGMvc6wLBTQP6ozlEtcSGvGfiaMru/lLSKGGe3N2gRYfTqjYimjmif4xPH5/InPO3018xZr2
    suEtRFwoabt9DjKciROT7fNcALgehnM/kHyFNu6+nQh5GeU58PEq+3dSWddHEYi9V5kRujEzwiwcUqUwlI6AyiwiBf702xb7ZV17a0jfn73dJYRqgG11JhWI
    psMr9XnQ4peXLfjG7+ZmSw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=4-kisMZZqFFhHg5z1fMA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeEKBhF (ORCPT <rfc822;linux@kroah.com>);
        Thu, 10 May 2018 21:37:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750805AbeEKBhD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 May 2018 21:37:03 -0400
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] kexec: limit kexec_load syscall 
Date: Thu, 10 May 2018 21:36:45 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 18051101-0040-0000-0000-000004585060
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051101-0041-0000-0000-000020FC62B7
Message-Id: <1526002608-27474-1-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110009
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
wide IMA runtime policy, such as requiring all kexec'ed images (or
firmware) to be signed, without being dependent on either the Kconfig
options or the userspace tools.

This patch set allows the customer to define a policy which requires
kexec'ed kernels to be signed.

Mimi Zohar (3):
  ima: based on the "secure_boot" policy limit syscalls
  kexec: call LSM hook for kexec_load syscall
  ima: based on policy require signed kexec kernel images

 include/linux/security.h            |  6 ++++++
 kernel/kexec.c                      | 11 +++++++++++
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_main.c   |  9 +++++++++
 security/integrity/ima/ima_policy.c | 27 ++++++++++++++++++++-------
 security/security.c                 |  6 ++++++
 6 files changed, 53 insertions(+), 7 deletions(-)

-- 
2.7.5

