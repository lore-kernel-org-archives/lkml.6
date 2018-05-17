Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2691500-1526589511-5-10761881019551792995
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526589511; b=LstawH3CLTHZx+B15iRa3vUZq1lQcGJg9iM2XPprSZG12clqHG
    c0wQk9W8FIiCA8PTCOWXhcCus1DfW5ITsllRXBvG0tGp2putJihTg1JOkZY+OomP
    Guvx2rpgtdal3oieV2yfz4Ww9NKHIL6Lx1pdWQ0HTuByV1kS6IjInL0MNiCnUZeQ
    1t1rCPTvRgb48rUEPioft/XiLPhCKxO1bNfpa7x3DNMyLpkhxMHohYWBqf6u6pnf
    +ukpHvdZr7aVH38AepWCkIWKd6hOHAhX5Z2sZOZxi1gvLV/TW/LHAr5iV1+XCfir
    dBkHcXasyzrFrV/jKcwTcRI7tYsg+kK3wNQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526589511; bh=
    zGwzcU6GESUOWb7HAhBaAGNvEXoJlJgCHIbltzmOEtc=; b=ChRCIxzLP9ixTJIf
    sgj11XIW7MzfyXP5C2Nlf5m3q6yPQCA5QCn5JxRvF7OkzLhTHlVmWBQ8rB0ZvVZ0
    bWLba9fqgV680x3Zi/K3Yo6geCkaWiAtxVjf/dhoBi23zJZta5BpW0L3gobay+/j
    W1cAXgs3x1zteTmItX3+mZmAcn/aiwmgEzjcl46S7IZTR070LJipwgtOoOTpxWWE
    0eyQSOX/4nRYco6Mme/qnxjUok2JHKNztZsD6lh3iSY+k+zL0jTzFRoq5/VLB3tK
    dNNqOecvRVia8yv/bzXfRMA1BhCRPVUiN3n5X6O34iV0MHhYuwBV0p+mwPJl22sw
    Zi3XmQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=qseYRJGV x-bits=2048
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=qseYRJGV x-bits=2048
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
X-CM-Envelope: MS4wfI+2DEN3LqgeatuhRfw4BvHk1QT+yOnJuDjAO9TPmQLvPVK6/hkoCdqznYWVvAaFOzaLfdnvogZ4MnpPermOqigckJNi2zVnQAoyLlr+fWlYna1pwFT6
    Vyt6p4/5O3aXoOfoh7kpCa6xSRCyrkZVwoXVLKdfxZjFyOyIsn+e7YLQRYDWAjD4a7fw+EpvqPUBUJ2o7xsCWyACfyK14+DbbhtrzuqRsuioT9Sux/r0vNlJ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JF9118EUAAAA:8
    a=VwQbUJbxAAAA:8 a=t9nJ63vxK7AjtHBcOcwA:9 a=x8gzFH9gYPwA:10
    a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeEQUi2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 16:38:28 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:60847 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbeEQUi0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 May 2018 16:38:26 -0400
X-IronPort-AV: E=Sophos;i="5.49,412,1520870400";
   d="scan'208";a="78199742"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org
Cc: mingo@kernel.org, peterz@infradead.org, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v4 1/3] block: add ioprio_check_cap function
Date: Thu, 17 May 2018 13:38:01 -0700
Message-Id: <20180517203803.2664-2-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180517203803.2664-1-adam.manzanares@wdc.com>
References: <20180517203803.2664-1-adam.manzanares@wdc.com>
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

