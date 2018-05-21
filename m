Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1304160-1526937296-2-9579142780789000204
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937296; b=WWjwbeBqpZE7SuM0BltyBmPRxpQQTjdETD4jtHL6PWmsi2/epb
    vwKsaloxADiYz7Wr2Gmps6A5wEnXSpeW5NMfQCYskbiSOxc19eAhbOkoQXshAmoH
    yJ9NmrpqDRpcdwijSAMNB6Qo0jK8ywtx7H5qGGW1116sZcVahOAGCDzmoAzv3Cwh
    /EFGetu+L+HsV5xor4QHOfShOWOCteJtgVtWb4RcQOt6VijjLPICzBv84YGz+vZ6
    iB+b9jMqYJw5D2yKzKCliVPEUp4/fdOw6++F6Ds3MtCC9/cPbsE3CF8HKsiVTHdH
    S2aAHrr2RuD+iNV0+9TSCca/sdt9KYD/bNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937296; bh=HcR7yWuNubzGkdAMrpIhuKbv3sjjcI
    ooFRFdwzI9WLI=; b=Q16yZhAi1hqUTdb12n5QdvW6Fn1sb7a0omGPkPuFweWvcE
    ggWqXbui7tIaZA+oBC5aI3CMLkhUGEHwqG1nlBTzkRXFEKiYs+nyVtsOVVZw6aRO
    jKV4vsST6PHmOJCqNvdzUXFqLp14rIu3Zs5rEYdGgO/X2ilwaj6IyARAqXSE6rga
    tJSJa4rdTcmM/lBD3EmF1z+FnFkwrbS3LPlqe2wDG596o7j8VFoWrljPMp9bHkm5
    VS373A5t6iXAvBhV7QAEaqsMrH9qkdAgekhJURBGxMpOdQSPxVLxeex2S4quOUjX
    Ne+mrmerKqchGqUGFmf/YAcDPzxq/qbpbhx6lEzg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=mLcI2vwx x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=mLcI2vwx x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNkNbAQR5INq2REq2oXhidEQbag/ou6Z1nfw26o5LVeqQe3kkN2wtLouXDh55HsZGL5RaloyHtHGHrJoLYf28muq2/7IIGjIQQO8yc2jOkhnxfwhx/5g
    jM1WyeBzOkzmD4sG2k9bz16+C62qVRQ9Xh3RYBssLggbFXq5dIhWoCD6MzQezNe8GShy8ZJr6afKLoVDE/vko1FDkuZcJdVeqkCGRqCFrRPkqp2kDQaCiToR
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=Z4Rwk6OoAAAA:8 a=1XWaLZrsAAAA:8 a=UqCG9HQmAAAA:8
    a=iyhmCyC8aMnclnDsskkA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751056AbeEUVOw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:14:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752525AbeEUVOu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:14:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poulson <jopoulso@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rakib Mullick <rakib.mullick@gmail.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH 4.9 28/87] tick/broadcast: Use for_each_cpu() specially on UP kernels
Date: Mon, 21 May 2018 23:11:04 +0200
Message-Id: <20180521210422.947603409@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

commit 5596fe34495cf0f645f417eb928ef224df3e3cb4 upstream.

for_each_cpu() unintuitively reports CPU0 as set independent of the actual
cpumask content on UP kernels. This causes an unexpected PIT interrupt
storm on a UP kernel running in an SMP virtual machine on Hyper-V, and as
a result, the virtual machine can suffer from a strange random delay of 1~20
minutes during boot-up, and sometimes it can hang forever.

Protect if by checking whether the cpumask is empty before entering the
for_each_cpu() loop.

[ tglx: Use !IS_ENABLED(CONFIG_SMP) instead of #ifdeffery ]

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poulson <jopoulso@microsoft.com>
Cc: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: stable@vger.kernel.org
Cc: Rakib Mullick <rakib.mullick@gmail.com>
Cc: Jork Loeser <Jork.Loeser@microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: KY Srinivasan <kys@microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Link: https://lkml.kernel.org/r/KL1P15301MB000678289FE55BA365B3279ABF990@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM
Link: https://lkml.kernel.org/r/KL1P15301MB0006FA63BC22BEB64902EAA0BF930@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/tick-broadcast.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -610,6 +610,14 @@ static void tick_handle_oneshot_broadcas
 	now = ktime_get();
 	/* Find all expired events */
 	for_each_cpu(cpu, tick_broadcast_oneshot_mask) {
+		/*
+		 * Required for !SMP because for_each_cpu() reports
+		 * unconditionally CPU0 as set on UP kernels.
+		 */
+		if (!IS_ENABLED(CONFIG_SMP) &&
+		    cpumask_empty(tick_broadcast_oneshot_mask))
+			break;
+
 		td = &per_cpu(tick_cpu_device, cpu);
 		if (td->evtdev->next_event.tv64 <= now.tv64) {
 			cpumask_set_cpu(cpu, tmpmask);
