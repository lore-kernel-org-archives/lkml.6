Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8E9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 03:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E262083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 03:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGg0ca8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E262083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeHaHzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 03:55:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35117 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeHaHzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 03:55:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so4860441pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 20:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JnzZTNwm0KxZndR9Wyi/0X0W9XERF0usnWDQzFxLzQo=;
        b=JGg0ca8w7F1MQfZwodFAiOlcja1xPSgnj7p4t6P3qQqQE4hEvbr15Eh4c+ZBRvqdoF
         DWfNDVeOKCGI7hNzhXUua9zYjvlKL0N8P910V3vJRdMwl0f4BE7ks8E+SQzo3Mp3XBcn
         bu4o+P+aoiO4xrWaB6N2A3GoxnHejRiavCpJUQU+ktp8Cvaou7AA1zFNNnvCgQUXWcSw
         pVOw1aDJ8vRHjF8lrc5G9neHZeUpL9iqBM/v33a1tGfjI5Im9q5I8SurQaK87Q98BnRD
         Y8I4rh3ZoS/2+b80zZeYwX7ZyKzRXLuzhL69wHueEVbpBbVV+FHmBGuYFAa68NQoYh4J
         l11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnzZTNwm0KxZndR9Wyi/0X0W9XERF0usnWDQzFxLzQo=;
        b=REMUcYIcm8h2Uc9+A5+1rJWdn44fwjp7zu6/ZBrZ3d1VpGZ9dpp0Bv7XagpNGd30uK
         xON/z5Y7R/2n3AooP2IANPA9+KVNQ9QnBPHd8uE0EAUnZcfEyHANTrF6CsMualO+a4Xo
         DTyNRdfrTijXKZmuUbhe7wiUBW4WNmmWGRUzD+at/zpcNtXXknfw6twX7VhynyMwu+K3
         aeXRVmeok9VQuxojmaW59lUAFlA5G/QmfYchb0ZVVU1gbQcvSOgFqDi22gf3HGAIzbmi
         luf8o2C+LwLnnCszqfzDgWbfL4PEk5zcTC58JwdrtARf9wSveFrDfubfw0ZEuwvVgmAl
         fSKw==
X-Gm-Message-State: APzg51Bev63PFmC2ZgxgSNyMyb8T6OC3ZEZgLv1ZmJDsfoVlab/hsrHB
        7aGNUN2FViCl/8ywKXm8fNs=
X-Google-Smtp-Source: ANB0VdZobyUWPfl0OOqPNQ8FpLEc9F9hPBWVrA5LDeR0jqZCy0dBiXNYs51Zp4zrB3Zk3Ts1maOZwQ==
X-Received: by 2002:a63:3741:: with SMTP id g1-v6mr12684689pgn.59.1535687390460;
        Thu, 30 Aug 2018 20:49:50 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id h12-v6sm11454902pfo.135.2018.08.30.20.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 20:49:49 -0700 (PDT)
Date:   Fri, 31 Aug 2018 13:49:43 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: Re: VirtIO console hangs
Message-ID: <20180831134943.7f516fed@roar.ozlabs.ibm.com>
In-Reply-To: <CAGnkfhxhV_4JNhCm2s=XP15sp3bKax9O1R+nFwA+oRJXQ53xsg@mail.gmail.com>
References: <CAGnkfhzjeYU_jmhNkLEayL1FSq5rWkT7T+Nm1ky9QS-vWHUhyw@mail.gmail.com>
        <20180829003539.668e514c@roar.ozlabs.ibm.com>
        <CAGnkfhxhV_4JNhCm2s=XP15sp3bKax9O1R+nFwA+oRJXQ53xsg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 15:00:14 +0000
Matteo Croce <mcroce@redhat.com> wrote:

> On Tue, Aug 28, 2018 at 2:35 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On Tue, 28 Aug 2018 12:54:08 +0000
> > Matteo Croce <mcroce@redhat.com> wrote:
> >  
> > > With kernel 4.19.0-rc1 virtio_console hangs very often.
> > > I can always trigger the bug by pasting some characters in the
> > > terminal window, the console will stop receiving keypresses, but I can
> > > still see output from the console.
> > > Stangely, logging in the VM via SSH and sending lot of data to hvc0,
> > > like 'dmesg >/dev/hvc0' will fix the issue until the next paste.
> > >
> > > I did a git bisect and I've found that this is the offending commit,
> > > reverting it fixes it.
> > >
> > > Cheers,
> > >
> > > commit ec97eaad1383ab2500fcf9a07ade6044fbcc67f5
> > > Author: Nicholas Piggin <npiggin@gmail.com>
> > > Date:   Tue May 1 00:55:54 2018 +1000
> > >
> > >     tty: hvc: hvc_poll() break hv read loop  
> >
> > Thanks for the report. I can't immediately see what the problem
> > is. Can you try get a stack trace of where it is stuck?
> >  
> 
> I tried but didn't get one.
> 
> > Perhaps try this patch if you have time (it's a bit of a shot
> > in the dark).
> >  
> 
> Yes it seems to fix. Thanks!

Okay sorry for the delay, I can reproduce it here and found a better
fix, if I could trouble you to test again.

[PATCH] tty: hvc: hvc_poll() fix read loop hang

Patch ec97eaad1383 ("tty: hvc: hvc_poll() break hv read loop") causes
the virtio console to hang if you paste a bunch of characters to it.

The reason is that get_chars must return 0 before we can be sure the
driver will kick or poll input again, but this patch only scheduled a
poll if get_chars had returned a full count. Change this to poll on
> 0 count.

Fixes: ec97eaad1383 ("tty: hvc: hvc_poll() break hv read loop")
Reported-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c
b/drivers/tty/hvc/hvc_console.c index 5414c4a87bea..219369aebb1f 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -717,10 +717,13 @@ static int __hvc_poll(struct hvc_struct *hp, bool
may_sleep) #endif /* CONFIG_MAGIC_SYSRQ */
 		tty_insert_flip_char(&hp->port, buf[i], 0);
 	}
-	if (n == count)
-		poll_mask |= HVC_POLL_READ;
 	read_total = n;
 
+	/* Activity is occurring, so reset the polling backoff value to
+	   a minimum for performance. */
+	timeout = MIN_TIMEOUT;
+	poll_mask |= HVC_POLL_READ;
+
  out:
 	/* Wakeup write queue if necessary */
 	if (hp->do_wakeup) {
@@ -730,13 +733,8 @@ static int __hvc_poll(struct hvc_struct *hp, bool
may_sleep) bail:
 	spin_unlock_irqrestore(&hp->lock, flags);
 
-	if (read_total) {
-		/* Activity is occurring, so reset the polling backoff
value to
-		   a minimum for performance. */
-		timeout = MIN_TIMEOUT;
-
+	if (read_total)
 		tty_flip_buffer_push(&hp->port);
-	}
 	tty_kref_put(tty);
 
 	return poll_mask;
-- 
2.18.0

