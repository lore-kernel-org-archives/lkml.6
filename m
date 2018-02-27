Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-983322-1519719657-2-5291406970464915632
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519719656; b=lxY/iqXFnnBRnU8DZ7IEOIWwFj3YHuMSTYpJh4INn52Sji9
    7w+jxBGUIG4lEkHtekBdRjBrPZ29nRuDpHyg/IZFP08hRgR+6vi3V0z1EU1gQPaA
    UquLBnjfshivbEplI0o8GJS5qeIZJxojr0HtiuRDbFO8n5NzcohYsZwwTS/S28FB
    gl/Nw7RlDpBr4j0wW9jXMFIpq/PEk25EPI6/RkFZkZmprfx/tJ++yHUuZ/1qxcHk
    Wvk2hlDk5pjBtbTw+AJ5NltbTskJ36BdkJlzDW6EIU+oVU1T9WWfQniSvBI9UBXO
    s1quciibJA5a+yZJ7oQeGp7uqTD9kY/XdStBB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=arctest; t=1519719656;
    bh=dtQevLrrUnV4YQCld5XXvshNI5dMof/1Y15yOPvgrAM=; b=BPRAEw+gxQti
    NZ4uIXB6J6Qjr17v3KKvUu/7j7ZP5/sGYa0beMOjEXNrzXPJdV5D7snrNxuWJ2uw
    hW8Jd26dF6RUWEWSqQldrufSK2UUraIjuQkEHhXqTcqqzF3XxIU6YoMEMos+PtV4
    AT6uU00ImGu36XZ4RISLIN1yaNRU7RFnUAswjcb/4t9zTsHWZllcFK966HO/czzg
    bBbtqMHSHAKg+TC7kRf7si5rZdlEnydx8t3o4pYYgXw2akDMaHnNKFO2T1Mxf0ZV
    pP0hYfM8JiWmjidg0p5w59QeGMfc11unE4+SNVNTpxWIPODUVVZ4ApUKFjm9n64d
    BfXcF1t8CA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbeB0IUy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 03:20:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752152AbeB0IUE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Feb 2018 03:20:04 -0500
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-api <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, crml <criu@openvz.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 1/3] userfaultfd: introduce userfaultfd_init_waitqueue helper
Date: Tue, 27 Feb 2018 10:19:50 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519719592-22668-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1519719592-22668-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022708-0012-0000-0000-000005B5E072
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022708-0013-0000-0000-00001931E93A
Message-Id: <1519719592-22668-2-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802270100
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The helper can be used for initialization of wait queue entries for both
page-fault and non-cooperative events

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 fs/userfaultfd.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index cec550c8468f..b32c7aaeca6b 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -131,6 +131,15 @@ static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
 	return ret;
 }
 
+static inline void userfaultfd_init_waitqueue(struct userfaultfd_ctx *ctx,
+					      struct userfaultfd_wait_queue *uwq)
+{
+	init_waitqueue_func_entry(&uwq->wq, userfaultfd_wake_function);
+	uwq->wq.private = current;
+	uwq->ctx = ctx;
+	uwq->waken = false;
+}
+
 /**
  * userfaultfd_ctx_get - Acquires a reference to the internal userfaultfd
  * context.
@@ -444,12 +453,9 @@ int handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	/* take the reference before dropping the mmap_sem */
 	userfaultfd_ctx_get(ctx);
 
-	init_waitqueue_func_entry(&uwq.wq, userfaultfd_wake_function);
-	uwq.wq.private = current;
+	userfaultfd_init_waitqueue(ctx, &uwq);
 	uwq.msg = userfault_msg(vmf->address, vmf->flags, reason,
 			ctx->features);
-	uwq.ctx = ctx;
-	uwq.waken = false;
 
 	return_to_userland =
 		(vmf->flags & (FAULT_FLAG_USER|FAULT_FLAG_KILLABLE)) ==
-- 
2.7.4

