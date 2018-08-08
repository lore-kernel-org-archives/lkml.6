Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDABC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C50721A27
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C50721A27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeHHS4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:56:25 -0400
Received: from verein.lst.de ([213.95.11.211]:38833 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbeHHS4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:56:25 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7823768D60; Wed,  8 Aug 2018 18:41:27 +0200 (CEST)
Date:   Wed, 8 Aug 2018 18:41:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Anup Patel <anup@brainfault.org>, atish.patra@wdc.com,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 6/8] dt-bindings: interrupt-controller: RISC-V PLIC
        documentation
Message-ID: <20180808164127.GA5733@lst.de>
References: <20180804082319.5711-1-hch@lst.de> <20180804082319.5711-7-hch@lst.de> <CAL_JsqKKCPhb1um_+68ya0ng_v2tSb5O+-8RQPqx7Od3sJ4FuA@mail.gmail.com> <20180808150448.GA31785@lst.de> <CAL_JsqKgawQA5V2W1e9QFb_Ri+Aka-08WizeSD9kdxyBdcwpEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKgawQA5V2W1e9QFb_Ri+Aka-08WizeSD9kdxyBdcwpEQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 10:15:58AM -0600, Rob Herring wrote:
> 'interrupts' (via
> interrupt-parent) or 'interrupts-extended' has to point to an
> 'interrupt-controller' node. I guess you could make the cpu nodes
> interrupt-controllers. That's a bit strange, but I can't think of a
> reason why that wouldn't work.

It could work, and would actually match how the hardware works
fairly closely.

> Just because the cpu-intc is not made to be an irqchip in the kernel
> doesn't mean it can't still be represented as an interrupt-controller
> in DT. It shouldn't be designed just around how some OS happens to
> implement things.

Independent of how you implement it, there isn't really such a thing
as the cpu-intc.  The CPU itself has a number of exceptions, that
are all handled the same way.  One of them just happens to be
the connection to an external interrupt controller.

That being said I'm fine with keeping up the pretence (at least in
DT) that it is a separate entity and resubmit the cpu-intc docs
given how widespread they exist already.
