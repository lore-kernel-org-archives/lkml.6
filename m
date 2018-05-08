Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3181716-1525801361-2-14361569714608249303
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525801361; b=SZLKjNs2roHF/tDNHbLRksb7Jiy4swHt3h3ptcTL14n/SL3Wu9
    c+QnRJy2184liur6WXhGPcg5UJoAKxnbrkUFYdRqhkmlXGAuNCsYtzZOhrYDj2LC
    kmYzbblBz+KezNKvOdErFyt/Ohjs0oME4A2JjxB7uLIJQm2Q2KWldrN+eWPyAXMf
    +trQErez+zPdnsWF+PDo0wDrsoUCHW4IsEQmekdwbbiqQ0PIGU3eIe2RxEZQQ2qa
    0VKCl+lFgq3hgkWpfgTyvgRlDuRWRjfNeahYJW5YmZfEt2A0R36i0n+FcIftkKD4
    NGdNuludvXf/REgeVCV7WoA3HohczD+vluBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525801361; bh=
    zGwzcU6GESUOWb7HAhBaAGNvEXoJlJgCHIbltzmOEtc=; b=EreHoj6t4dxc4NG9
    G8o8dGlNPYVaXpF2lh+lEjGN1jZ/iNJFv3K+jYpwbWMU8mpgO5N9GcjSXi/u//8p
    0x5DYkz6CfD+kDHEDMwUJpB8U330atXPtpnHfeBJz6+Up3rlyzonZaWOH/x7h9bI
    fCBFJUgyoK8ZHUlW3GYXPZ3a/XWip83Kz0tfj8mr5MkcscrPIH9FKlr/bhg5zW2N
    xmuw/YO2I1EnmeTDUtxNj1gDSsFl0Rx81XQtd7xSmiXx3YEu9mlhPChkaEUCgHcm
    9QTac+Y/+1f3tDoh9iygHl9TMbSCx8WFV/KSfcyBb+zWUFSA8ktiLTIGJKX3DILs
    wzt2dw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=R/2bLjpy x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=R/2bLjpy x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIydCWxuoorsPtTShYHA37lJ7E806JpZpfdmcM2UX+cETDytOjs83egUQBSWm/bGuChW5c7ClbvvyL4/G/9n82dbc2cXwaZ0r8jLvjKSLAdMyaba+jVk
    OaGDsBeKXu1mZ+7TSBETPMbBLpR+b4IX+cCEQjXzYGxm1K+RFxEzDoQnfJDcn/rX7qvHD5xoC97e/9Z1ux6WnZ0FO3ossFeJXJn3yCcAnsN8sYypiVdV022J
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JF9118EUAAAA:8
    a=VwQbUJbxAAAA:8 a=t9nJ63vxK7AjtHBcOcwA:9 a=x8gzFH9gYPwA:10
    a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754900AbeEHRmh (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 13:42:37 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:39537 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752239AbeEHRmf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 8 May 2018 13:42:35 -0400
X-IronPort-AV: E=Sophos;i="5.49,379,1520870400";
   d="scan'208";a="180732631"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, bcrl@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v3 1/3] block: add ioprio_check_cap function
Date: Tue,  8 May 2018 10:42:00 -0700
Message-Id: <20180508174202.2537-2-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508174202.2537-1-adam.manzanares@wdc.com>
References: <20180508174202.2537-1-adam.manzanares@wdc.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adam Manzanares <adam.manzanares@wdc.com>

Aio per command iopriority support introduces a second interface between
userland and the kernel capable of passing iopriority. The aio interface also
needs the ability to verify that the submitting context has sufficient
priviledges to submit IOPRIO_RT commands. This patch creates the
ioprio_check_cap function to be used by the ioprio_set system call and also by
the aio interface.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
---
 block/ioprio.c         | 22 ++++++++++++++++------
 include/linux/ioprio.h |  2 ++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 6f5d0b6625e3..f9821080c92c 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -61,15 +61,10 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
 }
 EXPORT_SYMBOL_GPL(set_task_ioprio);
 
-SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
+int ioprio_check_cap(int ioprio)
 {
 	int class = IOPRIO_PRIO_CLASS(ioprio);
 	int data = IOPRIO_PRIO_DATA(ioprio);
-	struct task_struct *p, *g;
-	struct user_struct *user;
-	struct pid *pgrp;
-	kuid_t uid;
-	int ret;
 
 	switch (class) {
 		case IOPRIO_CLASS_RT:
@@ -92,6 +87,21 @@ SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
 			return -EINVAL;
 	}
 
+	return 0;
+}
+
+SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
+{
+	struct task_struct *p, *g;
+	struct user_struct *user;
+	struct pid *pgrp;
+	kuid_t uid;
+	int ret;
+
+	ret = ioprio_check_cap(ioprio);
+	if (ret)
+		return ret;
+
 	ret = -ESRCH;
 	rcu_read_lock();
 	switch (which) {
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 627efac73e6d..4a28cec49ec3 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -77,4 +77,6 @@ extern int ioprio_best(unsigned short aprio, unsigned short bprio);
 
 extern int set_task_ioprio(struct task_struct *task, int ioprio);
 
+extern int ioprio_check_cap(int ioprio);
+
 #endif
-- 
2.15.1

