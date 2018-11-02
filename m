Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFA3C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5531120833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI73pyGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5531120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbeKBUFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:05:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34264 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBUFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:05:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so1555049wre.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 03:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version;
        bh=sW86KsqAsD63Ttmr4LxDMhbmg8nRrEnK66a/ifT6Enw=;
        b=gI73pyGI2IDJR+YiNSTCl5QDXxuUbFU+31znaGEAqovCpE8kDMwX3WH0myYAdNWxb6
         mzzyyR2QDCIfrZ2TfrSHKNx3jAG+RE6fvRltc/N+kTdC69JvL8m8P0hZWmN7uPLDbkKj
         YZW1plg0qv6lKb+ZxAvj8NvU4UCp+YoqMSpxy450cMoUcAM+dEOxq4+04sNF7Lrd0L8p
         sIi+Bak6pT/sZvlIn/ICejIzvn1fe4blZGB0gG/kYpuQIY+dNADcOgay/L3uIVWvqBn/
         c0fawyhGtyKbfR0fUnniniFlt01hng7+QUkPyYxLF4xpaFqT4nxkpYCyws9yzno0QJRq
         tv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version;
        bh=sW86KsqAsD63Ttmr4LxDMhbmg8nRrEnK66a/ifT6Enw=;
        b=dS15tDdE1k/cWFYGxoI/fDWCGbhqdbqPXI0Q9nGNftezA6ltWYBdGOc8JO20VLI5kL
         Qr2HdXkB9PI3/75IMR51gqG2sHbSYWPrzW8o6zWHgTTDATbGxLuvTwJocXZqJggepTw9
         k0YajUpne8Pg0z2O1sBi7X+DDsfWOWfms1Q0/0Yr1IN9Km41R81YJ8kTh8nWy7Iw3OFV
         H29c+pdJFrJGwBjYzzGKlOgi1JuzKtqZLJZltC4sf3Z53BtouSG29HjYh3STlstlH5Eq
         gA2Mo8ruKJLkx4fJUQg8bxhFEvC1AM3EKJBV5IrA1R31UmoXE6t7K7/DSnTS8y5rOO6+
         S7hw==
X-Gm-Message-State: AGRZ1gJkTcR+yAYKbuz3B4p2OiPMhHaNB4loGkuJ4Acd0sPtxx87U5nU
        UeO+hRFfGrqsciVbD1lGWJSGniO/
X-Google-Smtp-Source: AJdET5c+Hjz4GBDvmSKtej888x29y/o8zQ8Xltd7QiPf8q56brnRdwBrmrwdnLVz2YlcvpjzB/uCfg==
X-Received: by 2002:adf:e388:: with SMTP id e8-v6mr9819152wrm.321.1541156337226;
        Fri, 02 Nov 2018 03:58:57 -0700 (PDT)
Received: from localhost (p5B3F66DD.dip0.t-ipconnect.de. [91.63.102.221])
        by smtp.gmail.com with ESMTPSA id e11-v6sm5388006wrr.51.2018.11.02.03.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 03:58:56 -0700 (PDT)
From:   Holger Schurig <holgerschurig@gmail.com>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Subject: BUG: "do_IRQ: 0.39 No irq handler for vector" from a 16550 port
Date:   Fri, 02 Nov 2018 11:58:55 +0100
Message-ID: <87k1lvg2z4.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a weird bug on systems that uses Haswell Architecture and "real"
serial ports /dev/ttyS*.


Hardware: some embedded device with "Intel(R) Celeron(R) 2980U @
1.60GHz", I tried with microcode 0x23 and 0x24. Also on a HP Elite 840
G1". Both have Haswell architecture.

I can plug a different CPU module into the embedded device, then I have
an "Intel(R) Atom(TM) CPU N455 @ 1.66GHz", obviously no Haswell. With
identical kernel, I don't get the same error.



Kernel: happens with distro kernels (Debian, Ubuntu, Fedora). Common
factor seems that the kernels are >= 4.9.x. But also with upstream
stable kernels, I used 4.13.x, 4.14.x, 4.18.x, even with 4.18.16.




The embedded device also behaves strange (e.g. I had once MCEs with a
32bit kernel, which went away when using a 64bit kernel). We also
sometimes get an error in AUFS with the same timestamp as the
do_IRQ-message. I don't understand what AUFS has to do with hardware
interrupts. However, I don't want to concentrate on this yet, I think
that strange message in a mainland kernel in itself is worthwhile to be
tracked. If some interrupt get's haywire, there is certainly the chance
that some memory get's corrupted. Also, this might be something totally
different, because the HP Elite doesn't show this. Also, the MCE went
away after switching from 32bit kernel to 64bit kernel.

So, let's return to the better reproducible "do_IRQ: 0.39 No irq handler
for vector".


I'm happy that I found a way to reproduce it: the message triggers when
I close the serial port. printk's indicate that after the IER is
cleared, and even after synchronize_irq() in serial8250_do_shutdown()
the error happens.

Sometimes even a "stty </dev/ttyS1" is enough, because it already
opens/closes the port. But it happens only sometimes.

A better way is to use a tool called "stress-ng" in version with various
stressors. Some newer version (e.g. the one in Debian, 0.07.16-1) just
open all files in /dev, run an fstat() on them, and close them again.
All of this in a loop and very fast. This has the side-effect that
/ttyS* are opened/closed very fast. And that shows the error message
easily:

[    6.558244] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   17.048154] fuse init (API version 7.27)
[   17.248215] do_IRQ: 0.39 No irq handler for vector
[   17.249622] do_IRQ: 0.39 No irq handler for vector
[   17.252415] do_IRQ: 0.39 No irq handler for vector
[   17.253698] do_IRQ: 0.39 No irq handler for vector
[   18.528774] do_IRQ: 0.39 No irq handler for vector
[   18.532305] do_IRQ: 0.39 No irq handler for vector
[   18.532540] do_IRQ: 0.39 No irq handler for vector
[   18.606916] do_IRQ: 0.39 No irq handler for vector
[   20.227241] random: crng init done

Here I did run stress-ng just for some seconds. Unfortunately, from
time to time the exact same setup makes the error scarce, e.g. it can
happen that we don't see the error for 15 minutes.

So when running this for a night I had between 1500 and 30000 of this
messages in my dmesg/journal.


One thing that I noticed is that "noapic=1" makes the error go away.

Also using the Atom cpu with the older architecture makes the error go
away, but that one is no EOL. :-(



Any advice on how to proceed further?


Greetings,
Holger
