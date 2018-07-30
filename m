Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58148160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0192720893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="alhZxdVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0192720893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeG3R1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:27:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54445 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbeG3R1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:27:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so218258wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zMcV2pEUxU82PnPrKt6uCMXutcYUkQcb2DXcPuXXXgM=;
        b=alhZxdVKX3+lP73DfSAAeDkPirWBh4hOv0+tfHF+L/HMdILpBcVQRGOJJcd0O2Uq0Q
         d2kXskkjXeGiFN7UPhtkW4u+2WfpLzd5IlCFoaIOr83YZyHK0jj7W4RHi7HyvQ8jA5Dy
         ShjPnLyA8dKwEATJ/uBAjDgAjG0R1ewD4t9G/EseDAeeB8qq7V3AyNSxxnTwBwgZYIKI
         k5AAouv0LqyR9a3Tksj0ahhTaDg5sQmUs98E4ZzQaPolmBp7NMfzWsymD/r5qaIh2idU
         GIRqtgQxSTUSzrkxox+9EsN0UjeyIXDUlYoZj1nbnaAjlhlUlGw8RXOQQHa3xJTO9tiT
         JUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zMcV2pEUxU82PnPrKt6uCMXutcYUkQcb2DXcPuXXXgM=;
        b=NdpSTVuQGFKrxW0BnS39UoEBqhIodsgrt4hsQOmiid96aZ6+SIK7EnBSy1Tswyw5uz
         XUYFOGbsIMlnARl7sg137FQ6wdWoWOkEumqvSRXfF80thcyh6BwVfFm/V8atS5dhjlZn
         PquF0wq+MjnQjuKkhuEG5IxfqMl+RDUZZNMMQ7wtvfZtgYWR+LuleNR0n/CB4aSJOnNz
         e91KX5N5kVpKIAzdP6IniJmxWhrxvIO6mA17CnFEn91NLpWfaTuwl1X+XmmGdF3rXVG5
         Xg22ixwk6529K+phgM1vpyjNkfo6DrLxSQPh+ZYiNPYU4fIZPFNvYtC2N8TB45QqTwIh
         Vjaw==
X-Gm-Message-State: AOUpUlFV5D0UpePonwB/6F+nHSvvbr8McY8cWU7Ue+yurDs1GDtPrR6i
        jhMMcwm1Ezn8AqwNGZ02vjkVYw2p8XzJDR5AKcUTMQ==
X-Google-Smtp-Source: AAOMgpeWU2FOhQKVIgedCY9MI/e8SJkB0PO4vbFueMZ65yzdy0K0nUG35tmx95Rm6KN42KVGMzE1q1LreT6kUrjvHtI=
X-Received: by 2002:a1c:ee5d:: with SMTP id m90-v6mr15743175wmh.107.1532965918964;
 Mon, 30 Jul 2018 08:51:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dd2:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 08:51:58
 -0700 (PDT)
In-Reply-To: <1b3f6066-0c7c-a5f5-75ad-559fe81091ee@wdc.com>
References: <20180726143723.16585-1-hch@lst.de> <20180726143723.16585-8-hch@lst.de>
 <1b3f6066-0c7c-a5f5-75ad-559fe81091ee@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 30 Jul 2018 21:21:58 +0530
Message-ID: <CAAhSdy1rGMqhLDKMipGgP+4sYyNc_ckuHREy+Y8zb-hJeeZPog@mail.gmail.com>
Subject: Re: [PATCH 7/9] irqchip: add a RISC-V PLIC driver
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 28 Jul, 2018, 5:34 AM Atish Patra, <atish.patra@wdc.com> wrote:
>
> On 7/26/18 7:38 AM, Christoph Hellwig wrote:
> > This patch adds a driver for the Platform Level Interrupt Controller (PLIC)
> > specified as part of the RISC-V supervisor level ISA manual, in the memory
> > layout implemented by SiFive and qemu.
> >
> > The PLIC connects global interrupt sources to the local interrupt controller
> > on each hart.
> >
> > This driver is based on the driver in the RISC-V tree from Palmer Dabbelt,
> > but has been almost entirely rewritten since.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> I tried to boot HighFive Unleashed with the patch series after applying
> all the patches from riscv-all branch except timer & irq patches. It
> gets stuck pretty early.
>
> Here is my github repo with all the changes:
> https://github.com/atishp04/riscv-linux/commits/master_chris_cleanup_hifive
>
> I am still looking into it.
> Palmer: Did I miss something?
>
> FWIW, here is the boot log.
> --------- Boot log -------------------------------------------
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=5
> [    0.000000] NR_IRQS: 0, nr_irqs: 0, preallocated irqs: 0
> [    0.000000] plic: mapped 53 interrupts to 4 (out of 9) handlers.
> [    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff
> max_cycles: 0x1d854df40, max_idle_ns: 3526361616960 ns
> [    0.000000] Calibrating delay loop (skipped), value calculated using
> timer frequency.. 2.00 BogoMIPS (lpj=10000)
> [    0.010000] pid_max: default: 32768 minimum: 301
> [    0.010000] Mount-cache hash table entries: 16384 (order: 5, 131072
> bytes)
> [    0.020000] Mountpoint-cache hash table entries: 16384 (order: 5,
> 131072 bytes)
> [    0.020000] Hierarchical SRCU implementation.
> [    0.030000] smp: Bringing up secondary CPUs ...

I have noticed following:

1. plic_irq_toggle() works on all present CPUs which means an
IRQ will be enabled/disabled for all present CPUs. This further
imply that whenever an IRQ is triggered, all online CPUs will take
the interrupt but only one CPU will be successful in claiming the
IRQ and other CPUs will check for IRQ in vain.

2. irq_set_affinity() is not available which means IRQ balancing
will not work.

3. A PLIC context is for a particular HART+MODE. A HW designer
can choose to connect PLIC context only for particular MODE of
HART/CPU whereas this driver assumes that we have context
available for both M-mode and S-mode of all HARTs/CPUs.

Regards,
Anup
