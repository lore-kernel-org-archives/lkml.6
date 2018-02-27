Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-757978-1519717680-2-15366722043852578221
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519717679; b=bm1tlZ0/s7xrCw4orq0frkzxC3yh7MhdB0rndmw2N6JyliR
    pYYd3nyyf5Y89Gjb0tmrGG8QSeTXShqC+nJbojnJKCSJWHpRy9yvPd0OoLw/A70l
    dJ7a8fr4DVxPvgMxfZ45DZz/13DgErXKyH293Ts1iysqiKK+h4y+upkLt8JC2gwt
    MKeo2DZ9LHTH1WkEpPU7xws8i6aeZPgljrDZa2o8v8JQZDZU3Z3t7eq9L79ohuYt
    nKoqVi5slLQdUj8imnwqyHwl/4JHKh4nLTNELT5kGvsO6Dcyn1xvlS+FW0NNNmM8
    d/tayh1Z2LUArQ9ZoinGpl8nxckQWgEFOpU1eOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:cc:subject:date:message-id
    :mime-version:content-type:to:sender:list-id; s=arctest; t=
    1519717679; bh=+UX6bdqp1OgqfHQPVinqBPd5Gn3j+xvd4iRYD7MQI64=; b=r
    agsgG/oVtaokzO2AMcm1G5eldvKYPRXOyThO6kp6J1b/WvisFqwhtt7Wn0TDXLNk
    UllEAXHHsLP6/nSqPM2oUh5kozGEZ3jkvHkbFuPC7loRWUqQvvs+7rAxuhFqVd7n
    +lGC3g5Ykq3qbKVGt0AcOLGfvSD6ttWKggqEFB0+CfpndkjVsIz9lNlV/NWgODDb
    fXYC0ICRLdc25/MkdSC4XQODJqZ6XfJ64D3oNdOB0pAaNY/4WoQUnL41+1WD+MVm
    /biGnN6Kvdz0WT0PurI4OffK+VoBIJxNHzhRk2Fya6r/Mm4VrTvgtN6YCgDyGegx
    TzW+HXLaAGsCe/IJoZ6Ag==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=discard (ADSP policy from amazon.de);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=amazon.de header.i=@amazon.de header.b=ngx3ZoOj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=discard (ADSP policy from amazon.de);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=amazon.de header.i=@amazon.de header.b=ngx3ZoOj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeB0Hr4 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 02:47:56 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:2617 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeB0Hr4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 02:47:56 -0500
X-IronPort-AV: E=Sophos;i="5.47,398,1515456000";
   d="scan'208";a="709712310"
From: Norbert Manthey <nmanthey@amazon.de>
CC: Norbert Manthey <nmanthey@amazon.de>,
        Michael Tautschnig <tautschn@amazon.co.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH] sched: label attributes require a ';'
Date: Tue, 27 Feb 2018 08:47:40 +0100
Message-ID: <1519717660-16157-1-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
To: unlisted-recipients:; (no To-header on input)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Due to using gcc defines for configuration, some labels might be unused in
certain configurations. While adding a __maybe_unused to the label is
fine in general, the line has to be terminated with ';'. This is also
reflected in the gcc documentation, but gcc parsed the previous variant
without an error message.

This has been spotted while compiling with goto-cc, the compiler for the
CPROVER tool suite.

Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
Signed-off-by: Michael Tautschnig <tautschn@amazon.co.uk>

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 26a71eb..3af8fb6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6716,7 +6716,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 
 	p = task_of(se);
 
-done: __maybe_unused
+done: __maybe_unused;
 #ifdef CONFIG_SMP
 	/*
 	 * Move the next running task to the front of
-- 
2.7.4

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
