Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CF8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48DC2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48DC2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=BitWizard.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeICVo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:44:28 -0400
Received: from cust-95-128-94-82.breedbanddelft.nl ([95.128.94.82]:50292 "EHLO
        cust-95-128-94-82.breedbanddelft.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728357AbeICVo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:44:28 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Sep 2018 17:44:27 EDT
Received: by abra2.bitwizard.nl (Postfix, from userid 1000)
        id 6AEB513FCFC; Mon,  3 Sep 2018 19:16:39 +0200 (CEST)
Date:   Mon, 3 Sep 2018 19:16:39 +0200
From:   Rogier Wolff <R.E.Wolff@BitWizard.nl>
To:     linux-kernel@vger.kernel.org
Subject: IRQ number question.
Message-ID: <20180903171639.GC16262@BitWizard.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: BitWizard B.V.
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I'm writing a kernel driver. It is not going to be widely used, so I'm
not motivated to make things nice enough for inclusion in the standard
kernel.

But lspci shows my device: 

03:01.0 Serial bus controller [0c80]: Phoenix Contact GmbH & Co. Device 0002 (rev b7)
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 14
        I/O ports at e070 [size=16]
        Memory at f7d00000 (32-bit, non-prefetchable) [size=256K]

Now when I start my module and prod the device a bit, it will generate
an interrupt. (in this case the monitor program needs to start sending
messages to the card.)

Then the kernel reports: 

irq 18: nobody cared (try booting with the "irqpoll" option)

I've been writing device drivers in the past, but in the past
when the lspci listed "IRQ 14" then I'd have to request_irq (14, ...

Has this changed? Or is this hardware "odd"/"bad"/"broken" in that it
initializes the PCI devices wrong? (*)

My driver now works with the interrupts coming in nicely on IRQ18...

I have this card where I'm writing my own driver, and another PCI card
that uses an "included-in-the-kernel" driver, and it too behaves as if
it doesn't get any interrupts.

	Roger. 

(*) Obviously according to everybody "windows works", so could it be
that modern windows simply activates an irq and polls to see what
driver handles it? Or something like that? Ah! That would be somewhat
similar to what "irqpoll" does on Linux!

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
**    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    **
*-- BitWizard writes Linux device drivers for any device you may have! --*
The plan was simple, like my brother-in-law Phil. But unlike
Phil, this plan just might work.
