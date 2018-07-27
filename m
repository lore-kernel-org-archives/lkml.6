Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54E7C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F20B208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F20B208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388619AbeG0QAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:00:09 -0400
Received: from verein.lst.de ([213.95.11.211]:41643 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388467AbeG0QAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:00:08 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DED0968D60; Fri, 27 Jul 2018 16:41:48 +0200 (CEST)
Date:   Fri, 27 Jul 2018 16:41:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
Subject: Re: [PATCH 9/9] clocksource: new RISC-V SBI timer driver
Message-ID: <20180727144148.GA29626@lst.de>
References: <20180726143723.16585-1-hch@lst.de> <20180726143723.16585-10-hch@lst.de> <972dacda-75d6-83cd-45e0-c7526a4e02ba@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <972dacda-75d6-83cd-45e0-c7526a4e02ba@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 11:51:56AM -0700, Atish Patra wrote:
> Should we follow the same prefix for these functions?
> either timer_riscv* or riscv_timer* ?
>
> Apologies for overlooking this in my timer patch as well.

riscv_timer_* sounds saner to me, I can update that.

>> +	struct clock_event_device *evdev = this_cpu_ptr(&riscv_clock_event);
>> +
>
> The comment about the purpose of clearing the interrupt in the original 
> patch is removed here. If that's intentional, it's fine.
>
> I thought having that comment helps understanding the distinction between 
> clearing the timer interrupt in SBI call & here.

Yes, that was intentional.  But given that I don't even understand why
not using an ABI for architectural interrupt source enable/disable maybe
I'm confused and should revisit that decision.
