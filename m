Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2126129-1523980881-2-3470870933732163769
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523980879; b=a6KfZBrcMNuIPjBu+XVCvXEo27XLQLgM3AAgQvP31vJH9h12Rw
    2CTXt9UpbLIAMw3qGI2oXcinIzkeF08ZrWk/pIdsw5gkABTHXWPKhYb634ZPuTLG
    txf8ChiBCWE0e4Gj/NCxQ18fcZyDPN6dO8DUTQC9uBwqr+chVCMDQgPW09cH+kl5
    /HMG5MGfWpM/za5r3ioGJp+4xKHX46wobpjM00h+A9ShV9Fm9Pg/ct8f2Ma8Sbdk
    Q6zj6BAq2bxrbNcamNBoXBicfG+MSHCEqh0Gea1g7zzvHtFraYasReAfnwCjYXOX
    CD60mQLSTuAUTnHuSrB++RQIucwXPnq1/yxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523980879; bh=MW4vZO8wR6+Mv5tIcADUAw/AYq22Kc
    5qo+ardkF+64U=; b=lO+Tv3AU2lSreiYY8DE+NRDsd46bfX4plDwUBBX/EAZyEC
    j8JMlXV7XRC/oE8ihufcUXfntoO4wkq5Uc1Da/QXtnOtaNIUBywDMef7BkzEDkr0
    8bNlTU9e1lCHckSHXBZunxqnCZDdTJW0gas4wBJZJ6H2hBMfKoVLa8Ehv+bnTgJ0
    oiWwCnzmR+6TgAbaI+OW4sQffmT+iUQExI/W5LD6VXk3o4aXXkeGZCSLDpPey8Kh
    +D2GxTNxQnq4oVILr8MYg50AKbFk8yEAY9RTOIFm3VeON1fEMi4Zq+h2/lUf8dWR
    PFTPYx0OfENb+WYBLlERcS2j3/+y9qeROtl00H7Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFOzI6J9ScJuAnWme6iUFnkNmYVl6jBhwOIm3HLcsF0K526ETaPBtB0BBlJP4dg7uGcAW7J2cjX8KapeA5kBvJv2Yolym/oM0hC3re40qFDEm3Y5ENxE
    o6+gZbOe5Uo2gKjLBjes0Z470efjH3qpasKLvzi6O6inidgmTj5Zr0x2fIopleebLZlv0clE78eYDHZbWwHn2cUHwzQoPHGwNZzMJ0s+s/HQ0PE3AevzpbtQ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=JF9118EUAAAA:8 a=07d9gI8wAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
    a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=PT_ESrKdyotKjZuhxdkA:9 a=QEXdDO2ut3YA:10
    a=xVlTc564ipvMDusKsbsT:22 a=e2CUPOnPG4QKp8I52DXD:22 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753602AbeDQQBR (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:01:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60364 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753595AbeDQQBP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:01:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 36/68] block: Change a rcu_read_{lock,unlock}_sched() pair into rcu_read_{lock,unlock}()
Date: Tue, 17 Apr 2018 17:57:49 +0200
Message-Id: <20180417155750.802123392@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 818e0fa293ca836eba515615c64680ea916fd7cd upstream.

scsi_device_quiesce() uses synchronize_rcu() to guarantee that the
effect of blk_set_preempt_only() will be visible for percpu_ref_tryget()
calls that occur after the queue unfreeze by using the approach
explained in https://lwn.net/Articles/573497/. The rcu read lock and
unlock calls in blk_queue_enter() form a pair with the synchronize_rcu()
call in scsi_device_quiesce(). Both scsi_device_quiesce() and
blk_queue_enter() must either use regular RCU or RCU-sched.
Since neither the RCU-protected code in blk_queue_enter() nor
blk_queue_usage_counter_release() sleeps, regular RCU protection
is sufficient. Note: scsi_device_quiesce() does not have to be
modified since it already uses synchronize_rcu().

Reported-by: Tejun Heo <tj@kernel.org>
Fixes: 3a0a529971ec ("block, scsi: Make SCSI quiesce and resume work reliably")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Martin Steigerwald <martin@lichtvoll.de>
Cc: stable@vger.kernel.org # v4.15
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -827,7 +827,7 @@ int blk_queue_enter(struct request_queue
 		bool success = false;
 		int ret;
 
-		rcu_read_lock_sched();
+		rcu_read_lock();
 		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
 			/*
 			 * The code that sets the PREEMPT_ONLY flag is
@@ -840,7 +840,7 @@ int blk_queue_enter(struct request_queue
 				percpu_ref_put(&q->q_usage_counter);
 			}
 		}
-		rcu_read_unlock_sched();
+		rcu_read_unlock();
 
 		if (success)
 			return 0;
