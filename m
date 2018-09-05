Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB82DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4C72075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="nG74PNJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4C72075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeIEKhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:37:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44239 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIEKhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:37:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so6208821wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 23:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IvmUAAUT8/qI4YTPxpazomEvBxwGX+6cS44ofRLL81I=;
        b=nG74PNJv8kYf0hvhnFp4++M3NSH3nO36L4kwUbcr269MRhQiBjqt5/1ZziBulCWUhU
         1nIhwicvd/w+Rwoq396T80TNBrrmBrR+vNJhsvl33Im3mSz6H4LfM+1wSh/l7OdK1SG6
         VzAhi7QVZ94J8TgFGv5DLUoUMAsFzP/Toct2dvQdshP0bHFL2cBUj1QtfOcBlGEM/z+j
         b77EPyTWw2hxxhuhMcArqRRDYrDVHeyIBE4f6Nai5NncaHlzheaHdZDthSMG5DBtbCSm
         ElmSwpVCVhcTs64doq4suoI/BA2UdlEkUgwDYBVDqlTNIDta0S9m+cDZfBXnP9r4sopU
         zhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IvmUAAUT8/qI4YTPxpazomEvBxwGX+6cS44ofRLL81I=;
        b=NWQM4hVVJYuK7VJtG5dtkt/jDap4L7Hqhwr1DieHOc/tL0VFIZZoUPJWV8zenaTvfe
         CwlLuCqF0xD08pvv91IYMVKsRgYDuIRfIZIPIjpS1R7zkwtTw8bw6beHjGEWSl/zq1Zg
         jf/zP6WM61wZWpxOQsl5h7eYtOaLPmxgpnWAmVpHNQ1DfL7e1/g6WWK3Fq9fUMr/HgMZ
         oGwum7UHX7h/CdBuDa1F+ICMoghJg6Fb3AOvRu3Glwva9BYo0WJEWkW6EROy5a6l+mVh
         6M89NjhXJWCpLuebS/dazPvq72yeVby3M0kA7pE5UVCkCiZ+P44srBg0GjQmPTSEs+o1
         hFkw==
X-Gm-Message-State: APzg51BxU49W/7EOHFEYFcDWezwQnbxdUtiJO/AKgthGBDDUwqNWulWn
        QuFPc/dRJBjG6Nw1sjjQjL8+Xu/ZWYDDWts2+6RNyg==
X-Google-Smtp-Source: ANB0VdYRWxHzUCwQL8Gcp8Z95TaNziP3fWH/lf+p/6XXi39f+OpjGSDXDih/VW2nTfYnbaEq8BsslLcF6xZNPKBg/nU=
X-Received: by 2002:adf:9f13:: with SMTP id l19-v6mr26356794wrf.206.1536127742080;
 Tue, 04 Sep 2018 23:09:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 23:09:01 -0700 (PDT)
In-Reply-To: <20180904185755.GD25119@infradead.org>
References: <20180904124514.6290-1-anup@brainfault.org> <20180904124514.6290-5-anup@brainfault.org>
 <20180904185755.GD25119@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 5 Sep 2018 11:39:01 +0530
Message-ID: <CAAhSdy3-mM-zyYOvQBR+JsRTZGZWUF=4Y=0jTKhVMAYPxOfJ6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] irqchip: RISC-V Local Interrupt Controller Driver
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 12:27 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Sep 04, 2018 at 06:15:13PM +0530, Anup Patel wrote:
>> Few advantages of this new driver over previous one are:
>> 1. It registers all local interrupts as per-CPU interrupts
>
> Please explain why this is an advantage.

Previously submitted driver, registered separate irq_domain for
each CPU and local IRQs were registered as regular IRQs to IRQ
subsystem.
(Refer, https://www.spinics.net/lists/devicetree/msg241230.html)

The previously submitted driver had following sort-comings:
1. Required separate interrupt-controller DT node for each CPU
2. Wasted lot of IRQ numbers because each CPU will has its
own IRQ domain
3. irq_enable()/irq_disable() had to explicitly use smp_call_function_single()
to disable given IRQ on all CPUs

Instead of above, the new driver (this patch) registers only single
irq_domain common for each CPU and local IRQs are registered
as per-CPU IRQs to IRQ subsystem. Due to this we only need one
DT node for local interrupt controller and if multiple DT nodes are
present then we ignore them using atomic counter. We use same
IRQ number for local interrupts for all CPUs. Further, irq_enable()/
irq_disable() of per-CPU interrupts is handled internally by Linux
IRQ subsystem.

>
>> 2. We can develop drivers for devices with per-CPU local interrupts
>> without changing arch code or this driver
>
> Please explain why this is a good thing and not just a workaround for
> the fact that some moron decided they need non-standard interrupts
> and should only be done as a last resort.

Let me give you few examples of per-CPU interrupts from ARM world:

1. CPU PMU IRQs: Lot of ARM SoCs have PMU IRQ of a CPU mapped
as PPI (i.e. Per-CPU IRQ). This means PMU events on ARM generate
per-CPU IRQs

2. GICv2/GICv3 maintenance IRQs: The virtualization extensions in
GICv2/GICv3 help hypervisor inject virtual IRQs. The list registers using
which virtual IRQs are injected is limited resource and GICv2/GICv3
provides per-CPU maintenance IRQ to manage list registers. It is quite
possible that RISC-V SOC vendors will come-up with PLIC++ which
has virtualization extension requiring per-CPU IRQs.

3, MSI to local IRQs; The GICv3 has separate module called ITS which
implements a HW MSI controller. The GICv3 ITS translates MSI writes
from PCI devices to per-CPU interrupts called LPIs. It is quite possible
that RISC-V SOC vendors will come-up with PLIC++ which allows
mapping MSI writes to local per-CPU IRQ.

Apart from above, it is possible to have a CPU interconnect which
report bus errors of a CPU as per-CPU IRQs.

If you still think above examples are moronic then I cannot help
improve your understanding of per-CPU IRQs.

>
>> 3. It allows local interrupt controller DT node under each CPU DT node
>> as well as single system-wide DT node for local interrupt controller.
>
> Please explain why this is can't happen right now.

Currently, we don't have any local interrupt controller driver so
DT nodes for local interrupt controller are ignored.

The advantage point3 (above) is in-comparison to previously
submitted driver for RISC-V local interrupt controller.
(Refer, https://www.spinics.net/lists/devicetree/msg241230.html)

>
> Downsides are that it is a heck lot more code and introduces indirect
> calls in the interrupt fast path.

Without this patch IRQ handling flow is:
RISC-V entry.S --> do_IRQ() --> plic_handle_irq()

With this patch IRQ handling flow is:
RISC-V entry.S --> do_IRQ() --> riscv_intc_irq() --> plic_handle_irq()

I have an optimisation lined-up where RISC-V entry.S can
directly call handle_arch_irq (just like Linux ARM64). With
this optimisation IRQ handling flow will be:
RISC-V entry.S --> riscv_intc_irq() --> plic_handle_irq()

As you can see it is not "lot more code". In return, we get
to use per-CPU IRQs via Linux IRQ subsystem.

>
> So for now a clear NAK.
>

Again, you NAKed it too early without letting me provide
explanation.

Regards,
Anup
