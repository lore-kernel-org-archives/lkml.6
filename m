Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2671386-1527001681-2-10485395829487916889
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
    1527001680; b=LW1BD7zGCgX2NbC8fPctNAIOFXxs5olq/u6LIbGqxKdf+nDtYe
    G2j+BOOJsXj141ulkP04qSACNtlz1udRwSctnnx4on8wFLB+HLNl5gF4D0ujTYzW
    XvOjdH0+NqUbnoVx+sOVffW11zmEMyAFdSJskiGdq0PpqSyefXlQtywoNmQ5v11Z
    02vT/pcyleoGVk1QsiFHP8VA+bzRKdS1FzeLbjGkBBlJ3CFYwhKessZlwhwIil6z
    M527fvrZhCnj/UqDLNTgwP1h4T0FlBBJFFrSYCaEoqO+8mGx2QDC0GPwtt11BEw7
    2yGvTHbGTiJYIup1B7mad3YN28HImu7jRdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527001680; bh=
    VjVpS6Q7EEOvuv23SJ0ibwUYJkEzVhEf6ItTqeQ9DBE=; b=blcNAMiE4Autiy1Q
    izQl71v6fGSA/l4NeufevqMAwUEh96tWlpMRo+/yAThEnGTa3olHO6ml46VLLR2U
    F2XBBaukMxixSePBdxP68PWor7WFftsX8wU4F34tyLqhw9F+m6++djzj3hN0WDtf
    Ai3PVuYs9VgacxMOjpMgUXiQfi/p21KZ/meOQaa3RxcFdW1ubnkfrvEbO0acCSsR
    ckPKA7ImUBCd51iJw+P6ZyWPTr9rc0S+AgpOoPPR9un89jRc4heUxld+YRMRru79
    LVgbBnmCeej2GjfQPjINNT+rVLOItaKgX5C7p/yxTblnQgwpzYkjxICyaVz1tsvX
    ajIGZQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=nhBYGwNw x-bits=2048
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=nhBYGwNw x-bits=2048
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
X-CM-Envelope: MS4wfIoBGzJDeRD6KOQ3mObbT9ZkCfTs4ys6QdahHVkvj/fjxVDDe4Hg6pNoFAGoRA0RqetjRxvMHcNOlnV8ecHDINKSCIi5A63rKvrwWKrD9sSbv0/Jv+bG
    0QGjkvqOey1IegxlvjQOTMgJxF0fJxS0IU/0w3eber5qxtDASx2cTt61mE7XgHUO/9qLrGmFPiXlMONamnkzWywLqn4UamM/cHgIegxGTzVJGbyvVGDH/x33
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JF9118EUAAAA:8
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=t9nJ63vxK7AjtHBcOcwA:9 a=x8gzFH9gYPwA:10
    a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeEVPH6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 11:07:58 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26472 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbeEVPHy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 11:07:54 -0400
X-IronPort-AV: E=Sophos;i="5.49,430,1520870400";
   d="scan'208";a="79548762"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org
Cc: tglx@linutronix.de, mingo@kernel.org, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, jack@suse.cz, darrick.wong@oracle.com,
        rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, hch@infradread.org, jmoyer@redhat.com,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v6 1/5] block: add ioprio_check_cap function
Date: Tue, 22 May 2018 08:07:33 -0700
Message-Id: <20180522150737.9893-2-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180522150737.9893-1-adam.manzanares@wdc.com>
References: <20180522150737.9893-1-adam.manzanares@wdc.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adam Manzanares <adam.manzanares@wdc.com>

Aio per command iopriority support introduces a second interface between
userland and the kernel capable of passing iopriority. The aio interface also
needs the ability to verify that the submitting context has sufficient
privileges to submit IOPRIO_RT commands. This patch creates the
ioprio_check_cap function to be used by the ioprio_set system call and also by
the aio interface.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
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

