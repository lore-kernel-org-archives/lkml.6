Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1073259-1519980969-2-16960143795757359193
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519980968; b=E3vGsfw+sSSE++8Th/JGaSGOzbi97vt0jyPJRbOXF7S7R9A
    5pKVe4qohcdLE9Ac8A3A5YOl12lxDVR6SycKzoVgEbfvft8yJvV5SeqAYBpx8CIp
    kzWPloI+X+wyifX7V9w1WmUdpVrWF20gxDzSQ9bLQCYy/p+mEZyLntc0xF2hW9ra
    hbWUOC/I7hlqQrQ86nrtd9dfuBwwFSfaL3d0GSxW2ACXw21JSXBSIPMuY/4CMAXQ
    PgC1r/lY+r6P/TN+dYC0dZnLC5yGu22K3lBArb6yNQ/SEZcRJro4DSuAA/l1t1BV
    DWSscvRs1sDhkR7KFTOAE13LuIMcuE51AVh8a+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519980968; bh=Wvw8osYRItgYTwPxB9/1Yk82cw
    b/VB826H4NtMxGXok=; b=fpwrShLpQyaEybbUKUigE/YsifRh2M+rctmABMhIhy
    f7Q4NWUEZrrzMug0O+eSOU0BkTH0zy3OjizCjzVA6ZDRcUOuCo/rgLDW3OkbGTwR
    sryETLnUhX0sdvfIHgWNi2Tl55XotoP0yJjz0/vrMOx0qya2MplIMWY4fcqGlt2J
    PDmZ4Nk+03qIKIHsn61eKmsRtQ2RNElCpJyJn7hJUh9lG/Aa8wTMRAirrc3zz7VC
    /HPLzLwoMmcwAB4kzbkcbqL1i2/43XjYRj27s1zklu7h75fH9z5ziyMMelWBwlUd
    96ynGkxieMvGyIZgnIy/iH2tEb+sVp8ISV5zqGZL2Icw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423782AbeCBI4D (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:56:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423748AbeCBI4C (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:56:02 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        John Stultz <john.stultz@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, keescook@chromium.org,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>
Subject: [PATCH 4.9 01/56] hrtimer: Ensure POSIX compliance (relative CLOCK_REALTIME hrtimers)
Date: Fri,  2 Mar 2018 09:50:47 +0100
Message-Id: <20180302084449.690035246@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

commit 48d0c9becc7f3c66874c100c126459a9da0fdced upstream.

The POSIX specification defines that relative CLOCK_REALTIME timers are not
affected by clock modifications. Those timers have to use CLOCK_MONOTONIC
to ensure POSIX compliance.

The introduction of the additional HRTIMER_MODE_PINNED mode broke this
requirement for pinned timers.

There is no user space visible impact because user space timers are not
using pinned mode, but for consistency reasons this needs to be fixed.

Check whether the mode has the HRTIMER_MODE_REL bit set instead of
comparing with HRTIMER_MODE_ABS.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: keescook@chromium.org
Fixes: 597d0275736d ("timers: Framework for identifying pinned timers")
Link: http://lkml.kernel.org/r/20171221104205.7269-7-anna-maria@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Mike Galbraith <efault@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/hrtimer.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1134,7 +1134,12 @@ static void __hrtimer_init(struct hrtime
 
 	cpu_base = raw_cpu_ptr(&hrtimer_bases);
 
-	if (clock_id == CLOCK_REALTIME && mode != HRTIMER_MODE_ABS)
+	/*
+	 * POSIX magic: Relative CLOCK_REALTIME timers are not affected by
+	 * clock modifications, so they needs to become CLOCK_MONOTONIC to
+	 * ensure POSIX compliance.
+	 */
+	if (clock_id == CLOCK_REALTIME && mode & HRTIMER_MODE_REL)
 		clock_id = CLOCK_MONOTONIC;
 
 	base = hrtimer_clockid_to_base(clock_id);
