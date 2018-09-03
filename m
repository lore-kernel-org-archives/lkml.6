Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580C3C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B4420867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B4420867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=BitWizard.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeICXqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:46:09 -0400
Received: from cust-95-128-94-82.breedbanddelft.nl ([95.128.94.82]:52824 "EHLO
        cust-95-128-94-82.breedbanddelft.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728276AbeICXqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:46:09 -0400
Received: by abra2.bitwizard.nl (Postfix, from userid 1000)
        id C46C313F78A; Mon,  3 Sep 2018 21:24:32 +0200 (CEST)
Date:   Mon, 3 Sep 2018 21:24:32 +0200
From:   Rogier Wolff <R.E.Wolff@BitWizard.nl>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: IRQ number question.
Message-ID: <20180903192432.GE11854@BitWizard.nl>
References: <20180903171639.GC16262@BitWizard.nl>
 <20180903190903.290fff01@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903190903.290fff01@alans-desktop>
Organization: BitWizard B.V.
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 07:09:03PM +0100, Alan Cox wrote:
> On Mon, 3 Sep 2018 19:16:39 +0200

> > irq 18: nobody cared (try booting with the "irqpoll" option)
> > 
> > I've been writing device drivers in the past, but in the past
> > when the lspci listed "IRQ 14" then I'd have to request_irq (14, ...
> 
> The IRQ number in the PCI configuration space is just a label really for
> legacy OS stuff. Nothing actually routes interrupts according to it (*).
> If it's coming up as 14 that looks more like the BIOS mislabelled it.
> Legacy PCI interrupts care about lines and pins not irq numbers.
> 
> Are you looking at values after things like pci_enable_device were called
> or before ? Are you also looking at what is in pcidev->irq after the
> enable ?

The driver used to be for an ISA card. But as the ISA hardware is
becoming less and less available, things were in need of an upgrade.

So... So far I was just doing
  inmod  mydriver.ko pci=1 irq=14 io=0xae00 mem=0xfda00000

keeping most of the ISA driver. (for testing I was able to run the ISA
card with the upgraded driver that does the PCI card as well...

So io= is the address I got from lspci, mem= and irq= the
same. Apparently All of them are accurate except for the IRQ?

So the answer is: No I wasn't doing pci_enable_device. I guess I'll 
have to make a proper PCI driver then. Hmm. OK. I'll look into it. 

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
**    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    **
*-- BitWizard writes Linux device drivers for any device you may have! --*
The plan was simple, like my brother-in-law Phil. But unlike
Phil, this plan just might work.
