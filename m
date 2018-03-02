Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1073259-1519980851-2-14277196179527629843
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
    t=1519980850; b=BmeudyJ0dBjvS/dVCRuN9o99BvE21OHC6sI3xmBQlmT3Dm4
    WAzgO3o/Pl0b9oIJ8odu90b5+HqdqnxpxRoy48kcW32tCoWRW/Tf9O5k/xik76aj
    r0c4a85O66+nVVeg6feCxTthg9f0p7obgK4OMus2FaefU3LudQ7n92wHM6sMjNbB
    ewixFr8FB8yGJp5xu9BG6ZHqYUF0ZqRDt4btqhMRJdomglCAOcA8tXmg9tm2Pr5+
    daVL1MW6pZyWmgJuwpCd0XGU1bhhumMfo0zBqueWJn2O9PUTkQKdMMJ28PP9vhsm
    P4da3978qPvQQAkgl8/0Pa7Glf1prdccnI+1a8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519980850; bh=EX8RGO8lLjyApK9KzUrhJv/Trn
    iGcT/BQSZFl8qu5t8=; b=Y7oGcsB21SRuE2YqVCEX6EowTwSOnOu602ogoF3FGO
    QrHSN00QIMMMgSr/sZri2m+XXL/VaWQbfehJaLkg/0EIHjnHkAwzhD076ly7k1JC
    XY/XEhVw3uR6vnTBImDTwG4F/ZQY2FkcbHFrLRwJQ7YMtMpRhV8LG+ecNhwUowxw
    Ber9dCcHWUkaA5FXHPBmyUpPywnjRv6FJjerTQ+ixPSdE5msgE0VGfISGWsAB19Q
    hlkQtRBtjJ6eL7PS6MO45WWaeeueAia0DzSeY2SF5VqPBNiZIxOqtXGJPoYfAB16
    TvC5iPMTOgLx1t5NpqjaLA9zCXjMMschxcksjeXx3h6g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423049AbeCBIyG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:54:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50308 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423387AbeCBIyF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:54:05 -0500
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
Subject: [PATCH 4.4 01/34] hrtimer: Ensure POSIX compliance (relative CLOCK_REALTIME hrtimers)
Date: Fri,  2 Mar 2018 09:50:57 +0100
Message-Id: <20180302084436.004061183@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1139,7 +1139,12 @@ static void __hrtimer_init(struct hrtime
 
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
