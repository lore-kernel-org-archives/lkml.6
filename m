Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86509C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 16:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4695D2178F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 16:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4695D2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbeHDSlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 14:41:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41778 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeHDSlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 14:41:52 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flzbR-0007fF-HM; Sat, 04 Aug 2018 18:40:29 +0200
Date:   Sat, 4 Aug 2018 18:40:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>
cc:     Christoph Hellwig <hch@lst.de>, marc.zyngier@arm.com,
        jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: Re: [PATCH 3/6] irqchip: RISC-V Local Interrupt Controller Driver
In-Reply-To: <mhng-f79111da-51d4-483e-86ce-ff0a41c3b5bc@palmer-si-x1c4>
Message-ID: <alpine.DEB.2.21.1808041837130.1658@nanos.tec.linutronix.de>
References: <mhng-f79111da-51d4-483e-86ce-ff0a41c3b5bc@palmer-si-x1c4>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2018, Palmer Dabbelt wrote:
> On Wed, 01 Aug 2018 11:55:06 PDT (-0700), tglx@linutronix.de wrote:
> > Is there some high level documentation about the design (or the lack of) or
> > can someone give a concise explanation how this stuff is supposed to work?
> As part of our original push to upstream the arch code it was suggested that
> we move this out to an irqchip driver, but after actually attempting to do
> that it appears that the mechanics of doing so have overshadowed the
> complexity of the actual interrupt handling code, which is only a dozen or so
> instructions.  In retrospect this is just another instance of me not knowing
> what I'm doing, sorry!
> 
> I like Christoph's approach of merging the ISA-mandated interrupt handling
> code back into arch/riscv, as it's much saner that way.  The one big headache
> is that because we special-cased timer interrupts in the ISA they now
> disappear from the standard Linux mechanisms for handling these.
> 
> That said, I'd rather have this warts and all then wait around for something
> perfect, as maintaining a dozen or so out of tree drivers that are tightly
> coupled to the core arch code has proven to be a mess.  If we can get the code
> upstream then everyone will be on the same page so we can work on actually
> improving this, as opposed to just spinning our wheels keeping this big mess
> alive.
> 
> Hopefully that makes some amount of sense...

Thanks for the detailed explanation. It's what I extracted from the
documents to which Christoph pointed me. And as I said in the other thread
it does not realiy make sense to force that low level mechanism into an irq
chip. That would be overkill for no real value.

Thanks,

	tglx

