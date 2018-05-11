Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098225-1526049766-2-6178614721447291614
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526049766; b=Kbv0Tvv7Ved9qjzAtrTV7I5kmzltdPdgLPxDLVJa2V3rqahGd4
    avpESFCxyPSZ8NF1/7wNJS4jrCIyAcXEnuwddjgymGMVNnopaOBbuHuWNkpnVh2c
    qn167LTUTU9qPIidJMu4QjPpxtQdTvSGQNw3S3V8uSRoz0G+9XgIj0YHIATdC6ao
    FL6ejS3kwH343cttJRM1tn2kXTCqyCo0HW0bxMZJxAH0jbqqch8fnnapvwAp6Cre
    4+l8BPxjtWwVS8hHJlUC4T563385fVsy04YcZHdNce3uHJxiZNO+obdL/5rGCTrl
    EXf7SvyG9ZVlNGryIRHhErDIQ18bDF2JWjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526049766; bh=FKdwxb8NHHmk/lJTWSC0hnP03B0Ibw
    H6z7/HvpwTHn8=; b=k8fO++WIinEONUL+MOjCuoU0GrHcc+E06GYnUCXNTButTC
    ziu4JKVBcYmcfoJgynA9Bo58e1WzQpAKeJFu0uMwsoM8kmIFd2q/a0PPwPP8qEtX
    cvUOsQPt03eXaZG/3tlGIlEUltNP0Mf70wPvfz3RaI3QcE3zuV1NVBpsipjCIsKu
    w1H4DQjW6iZ/AGpLdDE99CN3QZUprddSFMX6VbFihE4lLgBF6qP33FtHLF6IA9ai
    OePKx/hzX+oUlZvl8vyT4lPn2cruxhPNBG6AS9dm4gdhHZfguD1czB1XOdGOu8qr
    Y+pf5t+T+XSM6qhcg/ltdg1Iik66SSQAAMs04S5Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFEqHzsG761B1QKuKbq8OPAmjOJC3CAozYgzJO7U/QGj4ol/XDD3bl8pZP+kjMj2xLAQBYi67M9DCKpfCMUJZYEre4p8CkK69LpFIA+sypjUpvo5EQ6Y
    NH9SIRy28Sc65JNzTPdxOyWgHYTKc/+Wp1O8A1NJ6/YQZozQ5OJXIa56aP8YE26vFhxGxudSIxIECh0iI9mHosm1amg4ruVuY/TalDF2O52Yh4iAyB7L9jiR
    66gxLanV8GT2GtwXaPz+IA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=U4E1U8oqYDepdjH3q94A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753217AbeEKOmm (ORCPT <rfc822;linux@kroah.com>);
        Fri, 11 May 2018 10:42:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752959AbeEKOmm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 May 2018 10:42:42 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: serge@hallyn.com, sunyuqiong1988@gmail.com, david.safford@ge.com,
        mkayaalp@cs.binghamton.edu, James.Bottomley@HansenPartnership.com,
        zohar@linux.vnet.ibm.com, ebiederm@xmission.com,
        john.johansen@canonical.com,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [RFC PATCH v4 0/5] ima: Namespacing IMA
Date: Fri, 11 May 2018 10:42:25 -0400
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18051114-0024-0000-0000-00001863801F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009006; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01030766; UDB=6.00526815; IPR=6.00809898;
 MB=3.00021049; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-11 14:42:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051114-0025-0000-0000-00004FED16AD
Message-Id: <20180511144230.75384-1-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110139
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch set implements an IMA namespace data structure that gets
created by first writing a '1' into IMA's securityfs unshare file at
/sys/kernel/security/ima/unshare and then by clone(). This patch set
lays down the foundation for namespacing the different aspects of IMA
(eg. IMA-audit, IMA-measurement, IMA-appraisal).

The original PoC patches created a new CLONE_NEWIMA flag to explicitly
control when a new IMA namespace should be created. The previously posted
version 2 of this series had it hooked on the mount namespace, which was
regarded as inappropriate. The subsequent v3 tied it to the creation of a
user namespace. Based on comments, we elected to now again create an
independent IMA namespace through the above mentioned securityfs file.

The first patch creates the ima_namespace data, while the second patch
puts the iint->flags in the namespace. The third patch introduces an
audit message type for  IMA policy rules. The fourth patch introduces
a new IMA policy rule attribute 'ns' making rules only applicable to child
IMA namespaces. The last patch uses the flags for namespacing the
IMA-audit messages, enabling the same file to be audited each time it
is accessed in a new namespace.

   Stefan

Mehmet Kayaalp (2):
  ima: Add ns_status for storing namespaced iint data
  ima: namespace audit status flags

Mimi Zohar (1):
  ima: differentiate auditing policy rules from "audit" actions

Stefan Berger (1):
  ima: extend IMA audit policy rules with attribute to audit namespaces

Yuqiong Sun (1):
  ima: Add IMA namespace support

 fs/proc/namespaces.c                     |   3 +
 include/linux/ima.h                      |  53 +++++++++
 include/linux/nsproxy.h                  |   2 +
 include/linux/proc_ns.h                  |   1 +
 include/linux/sched.h                    |   6 +
 include/linux/user_namespace.h           |   1 +
 include/uapi/linux/audit.h               |   3 +-
 init/Kconfig                             |  11 ++
 kernel/fork.c                            |   5 +
 kernel/nsproxy.c                         |  25 ++++-
 kernel/ucount.c                          |   1 +
 security/integrity/ima/Makefile          |   3 +-
 security/integrity/ima/ima.h             |  82 +++++++++++++-
 security/integrity/ima/ima_api.c         |  14 ++-
 security/integrity/ima/ima_appraise.c    |   2 +-
 security/integrity/ima/ima_fs.c          |  55 ++++++++++
 security/integrity/ima/ima_init.c        |   4 +
 security/integrity/ima/ima_init_ima_ns.c |  51 +++++++++
 security/integrity/ima/ima_main.c        |  18 ++-
 security/integrity/ima/ima_ns.c          | 183 +++++++++++++++++++++++++++++++
 security/integrity/ima/ima_ns_status.c   | 133 ++++++++++++++++++++++
 security/integrity/ima/ima_policy.c      |  77 ++++++++++++-
 22 files changed, 712 insertions(+), 21 deletions(-)
 create mode 100644 security/integrity/ima/ima_init_ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns_status.c

-- 
2.14.3

