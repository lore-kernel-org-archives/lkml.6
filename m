Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767D9C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8CA20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="VIpmZKbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8CA20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbeGZO4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:56:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52669 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbeGZO4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:56:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id o11-v6so2007231wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 06:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xMOR2WgETuk+l/2ixv/ujp7dV1nCPPTj2a9vKUM2xeM=;
        b=VIpmZKbeT2WlyE9bRV037mCWHY4sdxN6hB6wMUmtULH430dr4hX4Q5BOJ1M4mYZMFe
         d3SujetVHGkddbyh0dDmOsjZM1BVd3JlUz5nJTV0NDl2im/363gutsglDWSp+s2gE+78
         WiumUZ7u5pfGjRQN4JjbmuhEvWBWg85ERokTcBg3H/wGyzQvjdmNsAFGG9hoQgWx0+Si
         QwvO9C/wpRlFHYv/eT23L4NmsX7GbzUTWYIpIUwsuj1w4w8k8EpckTSkhBUIdZVkZzQu
         yWcgTu12cXKXvFZKy31K879rVMLdsiXGRzmkZEzOn2xt7wbWD4PazM4r90DKfosFvEBQ
         WSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xMOR2WgETuk+l/2ixv/ujp7dV1nCPPTj2a9vKUM2xeM=;
        b=FS1aCDoNXLjkd6MfdnOdOX4wZfHTbhInkt/eTgEjHaFvVxaOpEA7EgJ/+eUEE7sAKD
         D+ol5s8qyxpZ/4ij6LgG4PuZJZHB4W1UDWh3Mtnjso9Qd/cV2qeX4xLMztMhMCVxg6R4
         p4s9fQMO4sF0QB6VNo6tAycwEykKpwL+bQ9KwUDgXoQ34dWs70iEhzgnlrwis0aABlmD
         bvh4MdH3AxKXU3xXNcZNK3iW6Y9XZc16G/kQdDBaQrCnXx8+5AJ4zOTbJqfcw7BSZ/Q5
         gsrzQzXxO52/kqNX/TN+ii5fYkVHRE9DeVxicgkVSxEQGN43cGytR0Kcud18WNLofnL2
         1Rgw==
X-Gm-Message-State: AOUpUlHaJtPPl4m8PP1Z83+MH3dh0ETbGQcyqbz8H/YL4AnshHqOk/DF
        CggTa/CIFFav+Yd0nyvfhR7YNaVfh3mws713ZubnfHIfdhs=
X-Google-Smtp-Source: AAOMgpfacN7wbw82rf4rlWvHD2hyu8uhQ+BHVcAG1zent5unyIk4bQpW4tEktML7dvH/ICNLTuU25WIadya2dE9iteU=
X-Received: by 2002:a1c:8a04:: with SMTP id m4-v6mr1588088wmd.137.1532612397672;
 Thu, 26 Jul 2018 06:39:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dd2:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 06:39:57
 -0700 (PDT)
In-Reply-To: <20180726082706.GA22868@lst.de>
References: <20180725093649.32332-1-hch@lst.de> <20180725093649.32332-4-hch@lst.de>
 <c3ccb953-cd75-4a37-636a-ca643602053a@arm.com> <20180725112457.GA24502@lst.de>
 <CAAhSdy31=D3jOgvrc+Td-TeKQMazPA-suFjOy9XwEuima1WdeA@mail.gmail.com> <20180726082706.GA22868@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 26 Jul 2018 19:09:57 +0530
Message-ID: <CAAhSdy0JAmd=ma82yWTwQYMi2T-G8SLriV5tPyScWxOm8rCpjw@mail.gmail.com>
Subject: Re: [PATCH 3/6] irqchip: RISC-V Local Interrupt Controller Driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, palmer@sifive.com,
        jason@lakedaemon.net, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 1:57 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Thu, Jul 26, 2018 at 09:08:00AM +0530, Anup Patel wrote:
>> Actually, RISCV HLIC and PLIC are very similar to RPi2 and RPi3 SOCs.
>>
>> On RPi2 and RPi3, we have per-CPU BCM2836 local intc and the global
>> interrupts are managed using BCM2835 intc. You should certainly have
>> a look a this drivers because these very simple compared to GICv2 and
>> GICv3 drivers.
>
> Yes, using that model makes writing the per-cpu irq controller driver
> trivial.  But retrofitting it into the device tree, where the existing
> bootloader (bbl) assumes the old DT layout is a giant pain in the neck.

This can also be taken care in HLIC driver probe function with something
like below:

if (parent)
return 0;

if (of_is_compatible(parent, "riscv,cpu")) {
/*
* Legacy DT binding so we have HLIC DT node
* under each CPU DT node. To provide backwared
* compatiblity we go forward for only one HLIC
* DT node
*/
if (atomic_inc_return(&hlic_lottery) > 1)
return 0;
}

In PLIC driver probe, register nested IRQ handler for only first two
entries of interrupts-extended because it is HLIC IRQs are per-CPU. We
can happily ignore other entries in interrupts-extended of Legacy DTS.

>
> At the same time I'm still not conveninced RISC-V really needs a full
> irqchip driver for the per-cpu interrupt 'controller' really is nothing
> but 1 and a half architectural control registers:
>
>   - the scause register that contains the reason for an exception
>     (any exception including syscalls and page faults) for the entry
>     into supervisor mode.  This includes a bit to indicate interrupts,
>     and then logical interrupt reason, out of which only three are
>     interesting for supervisor mode (timer, software, external)
>   - the sie register that allows to to enable/disable each of the above
>     causes individually

Biggest plus is the ability show stats for per-CPU interrupts via
"cat /proc/interrupts" (just like other architectures).

Currently, we have only three per-CPU interrupts (timer, software,
and external) but in-future people might come-up with interesting
devices which might have per-CPU interrupts.

>
> So after burning out on DT hacking (never mind retrofitting that into
> actual shipping SOCs vs just qemu) I'm going to try a version that
> doesn't add an irqchip for this but just handles it hardcoded in
> RISC-V do_IRQ.  I'll still keep the irqchip for the PLIC, which while
> specificed in the RISC-V spec isn't architectural but an actual
> periphal.

I believe it possible to have RICV HLIC driver which maintains
backward compatibility with legacy DTS. I haven't tried above
approach myself on QEMU so I will let you decide.

Regards,
Anup
