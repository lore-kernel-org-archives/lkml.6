Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D10FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B992077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLoGBl0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B992077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeIEIWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 04:22:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44320 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeIEIWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 04:22:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so2691298pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 20:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jQVX6hBdJO3tDWFUBrLxMrXMOOALVnaSBB/f/gzrDhM=;
        b=FLoGBl0fnR3Bli0rfO18ejh6SGdqOvYV6FeJOn2MWjbHwP1mkKyIMdq5SmHr2hpH6l
         CUT97ajCG2Kh9/vmcxMOpZon2N/lZG3ETU6zcn+IMKIDgmJA6mpdci+X0sSIspNEaTIe
         zE71NQcXbmrvUyYT485ZIwO+xN3jh8NWXHKjGWFw5nsFgrAw79Gq98qXvQR8TyFQmFaX
         kCMWgnUdCacrlziHYiJ6XVz+8miVhiX4RoZgPAlhDNd0GUXBJ0jCP35D6N/zVxJjlw5Y
         SN8yqfX+y8NpmzQFjjbgtvjzvmGnyOcM9fJsagGKXaV2h84NmO37jgsS9PFEHk1wivTi
         qlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQVX6hBdJO3tDWFUBrLxMrXMOOALVnaSBB/f/gzrDhM=;
        b=C/BuRHlzN8iKRtirbVcX6apWPx8Lw/1X2PAkq+f5zWnMoMnGd53cTmNaFQmL74UG3B
         UOUlZmiXWxLMrkEMrhuetDRwwDz3g2OM39vhhZbmnsx7y9ofVF07+PpRTdffoXtDpUoG
         fn+YOQTV+EvYG/fXN6BRgAiRA+p75WNxcKycpSIwz2h224w4+zy0XDEgXrxl0GvyZYe8
         FWWl92wVQJEwqarlX56hdc7/dJ5aYJjE/QhNJoI1ZbCOqL8fJqJgrGBFwBlstQwD98MH
         wNtC+hloZp/MKusCGPuCFA6jrcNX18lM9nKAGyN8k4aRXQ81i1ZMgXVtqlK3PTIze2vt
         PzMQ==
X-Gm-Message-State: APzg51BA3A95Uv9QiuOTGaXwCoSG9UOmbuSy6PXZ12KGmNz+jJehBU7/
        x2YWNmDbE1SuT+Q1NRG5HAc=
X-Google-Smtp-Source: ANB0Vdb3AZhiilBCmk55HhJpHVgNKtGMsGAMIi02cA0cHauE0S03mnCrWExP5b1k0PZxoHvRMxCrCw==
X-Received: by 2002:a63:170b:: with SMTP id x11-v6mr18083257pgl.364.1536119644775;
        Tue, 04 Sep 2018 20:54:04 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id u11-v6sm687987pfd.117.2018.09.04.20.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 20:54:04 -0700 (PDT)
Date:   Wed, 5 Sep 2018 13:53:59 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: VirtIO console hangs
Message-ID: <20180905135359.26992d29@roar.ozlabs.ibm.com>
In-Reply-To: <CAGnkfhy9okKAfZVkbO3YWPVmWgVm2LFzR-8=S73OfJ3bK_1FxQ@mail.gmail.com>
References: <CAGnkfhzjeYU_jmhNkLEayL1FSq5rWkT7T+Nm1ky9QS-vWHUhyw@mail.gmail.com>
        <20180829003539.668e514c@roar.ozlabs.ibm.com>
        <CAGnkfhxhV_4JNhCm2s=XP15sp3bKax9O1R+nFwA+oRJXQ53xsg@mail.gmail.com>
        <20180831134943.7f516fed@roar.ozlabs.ibm.com>
        <CAGnkfhy9okKAfZVkbO3YWPVmWgVm2LFzR-8=S73OfJ3bK_1FxQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018 15:17:44 +0000
Matteo Croce <mcroce@redhat.com> wrote:

> On Fri, Aug 31, 2018 at 3:49 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On Tue, 28 Aug 2018 15:00:14 +0000
> > Matteo Croce <mcroce@redhat.com> wrote:
> >  
> > > On Tue, Aug 28, 2018 at 2:35 PM Nicholas Piggin <npiggin@gmail.com> wrote:  
> > > >
> > > > On Tue, 28 Aug 2018 12:54:08 +0000
> > > > Matteo Croce <mcroce@redhat.com> wrote:
> > > >  
> > > > > With kernel 4.19.0-rc1 virtio_console hangs very often.
> > > > > I can always trigger the bug by pasting some characters in the
> > > > > terminal window, the console will stop receiving keypresses, but I can
> > > > > still see output from the console.
> > > > > Stangely, logging in the VM via SSH and sending lot of data to hvc0,
> > > > > like 'dmesg >/dev/hvc0' will fix the issue until the next paste.
> > > > >
> > > > > I did a git bisect and I've found that this is the offending commit,
> > > > > reverting it fixes it.
> > > > >
> > > > > Cheers,
> > > > >
> > > > > commit ec97eaad1383ab2500fcf9a07ade6044fbcc67f5
> > > > > Author: Nicholas Piggin <npiggin@gmail.com>
> > > > > Date:   Tue May 1 00:55:54 2018 +1000
> > > > >
> > > > >     tty: hvc: hvc_poll() break hv read loop  
> > > >
> > > > Thanks for the report. I can't immediately see what the problem
> > > > is. Can you try get a stack trace of where it is stuck?
> > > >  
> > >
> > > I tried but didn't get one.
> > >  
> > > > Perhaps try this patch if you have time (it's a bit of a shot
> > > > in the dark).
> > > >  
> > >
> > > Yes it seems to fix. Thanks!  
> >
> > Okay sorry for the delay, I can reproduce it here and found a better
> > fix, if I could trouble you to test again.
> >
> > [PATCH] tty: hvc: hvc_poll() fix read loop hang
> >  
> 
> Hi Nicholas,
> 
> the patch works, but now pasting text inside the terminal is extremely
> slow, it feels worse than a 9600 baud serial line.
> 
> Btw, I had to apply the patch by hand as it was corrupted, some lines
> were collapsed into one.

Not sure why that happened, I seem to be able to send myself
uncorrupted patches...

Can you try this patch for performance? Hopefully it applies.
--

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 5414c4a87bea..f5fc3ba49130 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -49,6 +49,8 @@
 #define N_OUTBUF	16
 #define N_INBUF		16
 
+#define HVC_ATOMIC_READ_MAX	128
+
 #define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))
 
 static struct tty_driver *hvc_driver;
@@ -522,6 +524,8 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
 		return -EIO;
 
 	while (count > 0) {
+		int ret;
+
 		spin_lock_irqsave(&hp->lock, flags);
 
 		rsize = hp->outbuf_size - hp->n_outbuf;
@@ -537,10 +541,13 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
 		}
 
 		if (hp->n_outbuf > 0)
-			hvc_push(hp);
+			ret = hvc_push(hp);
 
 		spin_unlock_irqrestore(&hp->lock, flags);
 
+		if (!ret)
+			break;
+
 		if (count) {
 			if (hp->n_outbuf > 0)
 				hvc_flush(hp);
@@ -669,8 +676,8 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 	if (!hp->irq_requested)
 		poll_mask |= HVC_POLL_READ;
 
+ read_again:
 	/* Read data if any */
-
 	count = tty_buffer_request_room(&hp->port, N_INBUF);
 
 	/* If flip is full, just reschedule a later read */
@@ -717,9 +724,23 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 #endif /* CONFIG_MAGIC_SYSRQ */
 		tty_insert_flip_char(&hp->port, buf[i], 0);
 	}
-	if (n == count)
-		poll_mask |= HVC_POLL_READ;
-	read_total = n;
+	read_total += n;
+
+	if (may_sleep) {
+		/* Keep going until the flip is full */
+		spin_unlock_irqrestore(&hp->lock, flags);
+		cond_resched();
+		spin_lock_irqsave(&hp->lock, flags);
+		goto read_again;
+	} else if (read_total < HVC_ATOMIC_READ_MAX) {
+		/* Break and defer if it's a large read in atomic */
+		goto read_again;
+	}
+
+	/*
+	 * Latency break, schedule another poll immediately.
+	 */
+	poll_mask |= HVC_POLL_READ;
 
  out:
 	/* Wakeup write queue if necessary */
