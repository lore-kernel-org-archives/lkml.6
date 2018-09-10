Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4611C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D872086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D872086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbeIJS21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:28:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39402 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbeIJS20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:28:26 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzMKH-0000VG-AZ; Mon, 10 Sep 2018 15:34:01 +0200
Date:   Mon, 10 Sep 2018 15:34:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller
 Driver
In-Reply-To: <20180910132924.GA6987@infradead.org>
Message-ID: <alpine.DEB.2.21.1809101533330.1292@nanos.tec.linutronix.de>
References: <20180906123651.28500-1-anup@brainfault.org> <20180906123651.28500-4-anup@brainfault.org> <20180906140628.GA10580@infradead.org> <alpine.DEB.2.21.1809081241310.1402@nanos.tec.linutronix.de> <20180910132924.GA6987@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018, Christoph Hellwig wrote:
> On Sat, Sep 08, 2018 at 12:46:35PM +0200, Thomas Gleixner wrote:
> > On Thu, 6 Sep 2018, Christoph Hellwig wrote:
> > 
> > > Just as before:  NAK to entirely pointless abstractions.  Please stop
> > > beating the dead horse.
> > 
> > I disagree. These interrupts very well fit into the percpu interupt
> > mechanics and that allows them to be handled by all the generic mechanisms
> > as any other interrupt.
> 
> Just a few weeks ago you said the contrary:
> 
> http://lists.infradead.org/pipermail/linux-riscv/2018-August/000943.html

Sigh. Yes. Now that you remind me. 
