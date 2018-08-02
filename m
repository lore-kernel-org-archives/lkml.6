Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70583C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293C421509
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293C421509
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbeHBLfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:35:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36222 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeHBLfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:35:17 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flAA6-0002oQ-Rd; Thu, 02 Aug 2018 11:44:51 +0200
Date:   Thu, 2 Aug 2018 11:44:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@lst.de>
cc:     Marc Zyngier <marc.zyngier@arm.com>, palmer@sifive.com,
        jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 3/6] irqchip: RISC-V Local Interrupt Controller Driver
In-Reply-To: <20180802094300.GA14127@lst.de>
Message-ID: <alpine.DEB.2.21.1808021142350.2037@nanos.tec.linutronix.de>
References: <20180725093649.32332-1-hch@lst.de> <20180725093649.32332-4-hch@lst.de> <c3ccb953-cd75-4a37-636a-ca643602053a@arm.com> <20180725112457.GA24502@lst.de> <alpine.DEB.2.21.1808012049170.1835@nanos.tec.linutronix.de> <20180802073452.GA11693@lst.de>
 <alpine.DEB.2.21.1808021038260.2037@nanos.tec.linutronix.de> <20180802094300.GA14127@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018, Christoph Hellwig wrote:
> On Thu, Aug 02, 2018 at 11:35:43AM +0200, Thomas Gleixner wrote:
> > So that's the low level per cpu interrupt/exception distribution mechanism,
> > i.e. a distinct per cpu 'vector' space with fixed functionality. It does
> > not make sense to actually handle that as an irq chip. It has absolutely no
> > relevance. The software interrupts are enabled when the CPU is started and
> > the external ones as well as they are gated by the PLIC.
> > 
> > The only thing which might need to access the enable register is the local
> > timer interrupt. That really does not require an extra irq chip as the
> > enable/disable is really just at cpu up/down time and the magic happens on
> > the local CPU so no smp functional call hackery is required.
> > 
> > The PLIC is the beast which wants a proper irqdomain/irqchip
> > implementation.
> 
> And that is exactly what I've done in the repost.

Ok.

> I need to polish the DT binding a little more and will repost later today.

Lemme go through that reposted series quickly.

Thanks,

	tglx
