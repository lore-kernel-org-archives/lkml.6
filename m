Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6E1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60532077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pat49Tyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60532077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeIEIUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 04:20:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36029 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeIEIUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 04:20:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1-v6so2715576pgo.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 20:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DwzSrIFFr2XEPRnAul1Xp/yAnzhrNDwD0KzCpbRM79Y=;
        b=pat49TyuEbVqzgknJRrAGxqMMYThHvyEcuZCVHeM1LCtWAW6QNe4mAK3rjnZLoOmxx
         uQc7Mh6Nv1lnqqzALoF7jgsZJjLSBMiMUPrm+M62excFLeaZklQ9TiE5j+Byr+szhPnw
         w6+UN0CPVtTDhrT5J4zWFEJbUMjeXP8cyUkqVtLlNXqY5eitnCAksn6LSAXTEJXsbX2u
         ZJVNzKgYJrKkibNuTbRO4V9l6KFsoZagLM+s2CHk8yX6MkTWmJ1abJNN0yRcIE8C0Fxp
         QAJN0KgZpF4GwK+cOVXD96mIR3Zk6jqbbWFTI7j7FG0CK+U4TnL2RsUbQLCJ9kXN93oq
         uADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DwzSrIFFr2XEPRnAul1Xp/yAnzhrNDwD0KzCpbRM79Y=;
        b=RpnzFPYgOZIx1Gaue0ue+O8RSe3cljzXiFm76ixJhdL+zpXS4PiilKBa2C75j9t6Dz
         WMpNS1yFqega1+5AND1Hb/zOqk/UcSgbjBqb4vwBqdx/g025/6Z388IkwRqMSiuE9U6h
         +XQ/qHJVHw5ruD3oYRgXZIl1LrN42YweahAOh3HJvWX04WUdrKV6iAcQXndzhaZ+zrqm
         RZv4MU5P2oUrQI60AdzQnQL+9ZMvpJMROYmyqPce3H8c0CQKvadYO478j0phKMHczgid
         SYwOU0U1Bgzalxae9LRL3xWDEQ3Rgd4UaqpVPGHf7WhopXmMNJ1hq+L93Oj7Z7G/JSVu
         H6qg==
X-Gm-Message-State: APzg51ABObiURutBRszwsKq20j6R2d0I8uka1NE00u8OECuYWkDHNV7V
        y437LdsvHqGZckE55vPL5iU=
X-Google-Smtp-Source: ANB0Vdau1n+6FlpzgeaJywtz8dmPFHCpT4kgxgYPt2vwR+DGgNObEv0p56xec4HuC5SOw6DVDEaIgw==
X-Received: by 2002:a63:c807:: with SMTP id z7-v6mr33602623pgg.77.1536119520116;
        Tue, 04 Sep 2018 20:52:00 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id l70-v6sm643863pge.36.2018.09.04.20.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 20:51:59 -0700 (PDT)
Date:   Wed, 5 Sep 2018 13:51:56 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: Regression from patch 'tty: hvc: hvc_poll() break hv read loop'
Message-ID: <20180905135156.7ac7727b@roar.ozlabs.ibm.com>
In-Reply-To: <20180904211635.GD335@mellanox.com>
References: <20180904174808.GS335@mellanox.com>
        <20180905071529.3b7a09c4@roar.ozlabs.ibm.com>
        <20180904211635.GD335@mellanox.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018 15:16:35 -0600
Jason Gunthorpe <jgg@mellanox.com> wrote:

> On Wed, Sep 05, 2018 at 07:15:29AM +1000, Nicholas Piggin wrote:
> > On Tue, 4 Sep 2018 11:48:08 -0600
> > Jason Gunthorpe <jgg@mellanox.com> wrote:
> >   
> > > Hi Nicholas,
> > > 
> > > I am testing 4.19-rc2 and I see bad behavior with my qemu hvc0
> > > console..
> > > 
> > > Running interactive with qemu (qemu-2.11.2-1.fc28) on the console
> > > providing hvc0, using options like:
> > > 
> > >         -nographic
> > >         -chardev stdio,id=stdio,mux=on,signal=off
> > >         -mon chardev=stdio
> > > 	-device isa-serial,chardev=stdio
> > >         -device virtio-serial-pci
> > > 	-device virtconsole,chardev=stdio
> > > 
> > > I see the hvc0 console hang regularly, ie doing something like 'up
> > > arrow' in bash causes the hvc0 console to hang. Prior kernels worked
> > > OK.
> > > 
> > > Any ideas? I'm not familiar with this code.. Thanks!  
> > 
> > Yes I have had another report, I'm working on a fix. Sorry it has taken
> > a while and thank you for the report.  
> 
> Okay, let me know when you have a fix and I will be able to test it
> for you!

Can you try this?

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
