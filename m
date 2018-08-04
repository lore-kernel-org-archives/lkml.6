Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AF3C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0F520837
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="e804wXND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0F520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeHDGCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 02:02:13 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42466 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbeHDGCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 02:02:13 -0400
Received: by mail-pl0-f68.google.com with SMTP id z7-v6so3374704plo.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 21:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=i//pQXbiTnNo1wSdUz63ibVBaCoYgtheVQMJs01mUiA=;
        b=e804wXND0RyXDX7rD+Ot4teLUP51p5G16UPZ+llWNKFUg0HILge2fztnhhVzqct6em
         rSrAh+exEAc0xuCjrUtxGevSv0X7brjr3r/MkN1Mvvwj3BzBIWYgbqRo7uDoP48gUyPa
         Wl773AphFs39/qct9mtB/uGzbu3Ua5Q3g4LMJQl7EtBoEaN8FEZxug7d0i3aKpRKtyTu
         Jm390udVXgQUqTadKITEMGgJ5LR399dyanL8adgPH3hIA5E9A+2eqbALTzyzcLOyb1oO
         xzXn8fZEqNNLCGMyDi9Q/+kixP7K+llKwv0frmxAqPoPKShvrsyMAibJjPWwcrk6Qj0D
         zfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=i//pQXbiTnNo1wSdUz63ibVBaCoYgtheVQMJs01mUiA=;
        b=fTiZPWHgtrZNCH5pyFE5ztazn582jWgKLUG/kZXYWz2OiVnjhcRZdKMwsrkRPhHrGl
         tAM+trTJWORs5vniFgRIfw0lrNKMGhPwrl7sgem+ghrl6QIp6Cu+xJdyOImiodZIPZ+C
         2ysoIQVYt+30s71BwFEUMqGSCReck474KDsfqcZC0SeVjyzDv2vY+1ixXmQMPFIAfhdA
         kGINhLUUfg9rkyi8kunkKv91WDxdtMBzY+zTY0epPhRplVAQF5/lXQuHHa/ASLE3XJ11
         tCJSy5KO1Ps/7uuM1GbNpe401coRFhSZiXk62CrGUbnZh5weagQ3VTCqg+3V7WUpems1
         8TYg==
X-Gm-Message-State: AOUpUlHyEtpkJsuxEmOnZq+3kwDO+2hsO2lV+e9lNrWntsCgGADnH7cU
        cCArYcoILsOwRXailLriI75zCA==
X-Google-Smtp-Source: AAOMgpe93qpTxi9pTdqpP9iis6Ld23fNZ90xBqtT2W3v/oQaZNKeaUSEbD/n95nK7QsuMprC8woMsQ==
X-Received: by 2002:a17:902:6907:: with SMTP id j7-v6mr5895214plk.323.1533355384016;
        Fri, 03 Aug 2018 21:03:04 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id r23-v6sm13548091pfj.5.2018.08.03.21.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 21:03:02 -0700 (PDT)
Date:   Fri, 03 Aug 2018 21:03:02 -0700 (PDT)
X-Google-Original-Date: Fri, 03 Aug 2018 21:02:31 PDT (-0700)
Subject:     Re: [PATCH 3/6] irqchip: RISC-V Local Interrupt Controller Driver
In-Reply-To: <alpine.DEB.2.21.1808012049170.1835@nanos.tec.linutronix.de>
CC:     Christoph Hellwig <hch@lst.de>, marc.zyngier@arm.com,
        jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     tglx@linutronix.de
Message-ID: <mhng-f79111da-51d4-483e-86ce-ff0a41c3b5bc@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Aug 2018 11:55:06 PDT (-0700), tglx@linutronix.de wrote:
>
> On Wed, 25 Jul 2018, Christoph Hellwig wrote:
>
>> On Wed, Jul 25, 2018 at 12:18:39PM +0100, Marc Zyngier wrote:
>> > This feels odd. It means that you cannot have the following sequence:
>> >
>> > 	local_irq_disable();
>> > 	enable_irq(x); // where x is owned by a remote hart
>> >
>> > as smp_call_function_single() requires interrupts to be enabled.
>> >
>> > More fundamentally, why are you trying to make these interrupts look
>> > global while they aren't? arm/arm64 have similar restrictions with GICv2
>> > and earlier, and treats these interrupts as per-cpu.
>> >
>> > Given that the drivers that deal with drivers connected to the per-hart
>> > irqchip are themselves likely to be aware of the per-cpu aspect, it
>> > would make sense to align things (we've been through that same
>> > discussion about the clocksource driver a few weeks back).
>>
>> Right now the only direct consumers are said clocksource, the PLIC
>> driver later in this series and the RISC-V arch IPI code.  None of them
>> is going to do a manual enable_irq, so I guess the remote case of the
>> code is simply dead code.  I'll take a look at converting them to
>> per-cpu.  I guess the GICv2 driver is the best template?
>
> Confused. The timer and the IPI are separate causes and have nothing to do
> with the per cpu irq domain. That's what the low level interrupt handling
> code tells me.
>
> If I understand correctly then the per cpu irq domain is for device
> interrupts, right? If so, then this simply cannot work and there is no way
> to make it work with per cpu interrupts either.
>
> Is there some high level documentation about the design (or the lack of) or
> can someone give a concise explanation how this stuff is supposed to work?

The ISA spec defines this, and I'm not sure I can be a whole lot more concise 
than what's there but I'll try:

This driver is for the ISA-mandated interrupts present on all RISC-V systems.  
These interrupts are tracked on a per-hart (hart is a RISC-V term that means 
hardware thread, it a hyperthread in Intel land) basis.

On RISC-V systems there is a set of CSRs (control and status registers) local 
to each hart.  These registers can be accessed by special instructions, and are 
used to perform hart-local actions that are of a medium speed: things like 
accessing the floating point exception state or changing the page table base 
pointer.  When a hart is in supervisor mode, it has access to a handful of CSRs 
that are related to interrupts:

* stvec: The trap vector, which is the entry point for both interrupts and 
  exceptions.
* sie: Supervisor Interrupts Enabled.  This is a bit mask of enabled 
  interrupts.
* sip: Supervisor Interrupts Pending.  This is a bit mask of pending 
  interrupts, which can be polled when interrupts are disabled (or I guess when 
  they're enabled too, but that's not particularly useful).
* scause: Supervisor Trap Cause.  This allows code to determine what sort of 
  trap was taken.
* sepc: Supervisor Exception PC (actually the PC for all traps).  This allows 
  code to determine how to get back to where it needs to continue after 
  handling a trap.
* stval: Supervisor Trap VALue.  This provides additional trap-specific 
  information: for example, if a trap says "you attempted to write to an 
  address that isn't mapped or is read only" then stval contains the address 
  that the write was directed at.

As such, the ISA itself doesn't really differentiate between exceptions and 
interrupts: they both cause a privilege transition to happen, redirect 
execution to stvec, and write a handful of CSRs as side effects.  It's up to 
software to determine the difference.

In order to make it fast for software to determine if a scause value is an 
exception or an interrupt that is encoded in the high bit.  There are 11 
defined exceptions, which include system calls, breakpoints, page faults, and 
access faults -- that's all handled in core RISC-V arch code.  Additionally, 
there are 6 defined interrupt types:

* User software interrupt
* User timer interrupt
* User external interrupt
* Supervisor software interrupt
* Supervisor timer interrupt
* Supervisor external interrupt

The user interrupts are unsupported by Linux and thus never happen -- they're 
really designed for real-time embedded code, in POSIX land we use the standard 
signal delivery mechanisms as it'd be insane to put that in an ISA.  Thus, 
functionally there are three interrupt types:

* Supervisor software interrupt: These are never triggered by a hardware 
  device, and are therefor left for software use.  On Linux we use these to 
  indicate that a message may have arrived in the per-hart message queue, which 
  is used to implement IPIs.
* Supervisor timer interrupt: When the RISC-V ISA was originally defined we 
  thought that it was important to mandate that accurate real-time facilities 
  exist, so there's a handful of time-related bits encoded into the ISA.  In 
  retrospect it seems like this didn't end up being so clean as it's becoming a 
  burden when doing things like formally specifying the ISA, but we have 
  workarounds for these issues so we don't deem it worth re-spinning the ISA.  
  On Linux this is attached to a clocksource driver, with the only extant 
  example being SiFive's clock driver.
* Supervisor external interrupt: Essentially all the interrupts, aside from the 
  timer being a special case.  This is what's attached to the proper interrupt 
  controller, with the only extant example being SiFive's PLIC (which was 
  mistakenly called a RISC-V plic in the device tree, but there's another 
  thread going about fixing that).

Originally this hart-local interrupt code was included in the RISC-V arch port, 
right along our exception handling code.  This matches up well because RISC-V 
systems don't really differentiate between interrupts and exceptions, so it 
fits in well.  The trouble is that it smells like an interrupt controller and 
doesn't follow the standard mechanisms in Linux.

As part of our original push to upstream the arch code it was suggested that we 
move this out to an irqchip driver, but after actually attempting to do that it 
appears that the mechanics of doing so have overshadowed the complexity of the 
actual interrupt handling code, which is only a dozen or so instructions.  In 
retrospect this is just another instance of me not knowing what I'm doing, 
sorry!

I like Christoph's approach of merging the ISA-mandated interrupt handling code 
back into arch/riscv, as it's much saner that way.  The one big headache is 
that because we special-cased timer interrupts in the ISA they now disappear 
from the standard Linux mechanisms for handling these.

That said, I'd rather have this warts and all then wait around for something 
perfect, as maintaining a dozen or so out of tree drivers that are tightly 
coupled to the core arch code has proven to be a mess.  If we can get the code 
upstream then everyone will be on the same page so we can work on actually 
improving this, as opposed to just spinning our wheels keeping this big mess 
alive.

Hopefully that makes some amount of sense...
