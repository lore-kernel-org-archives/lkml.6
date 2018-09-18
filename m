Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B2BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC2E2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+HVYIn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC2E2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbeIRNwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:52:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42894 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeIRNwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:52:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id f1-v6so922061ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 01:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b3NHlf4tlwaXHan7PZOUNKPyEn8GzuXDXyF0zdjzlbI=;
        b=E+HVYIn4YfI8wRA34VEnX2yRLhLVORXq3s+MY95mYxqd6RtdzfePTXdHx++KEVkTNZ
         c3z8rT2H89DtlblsdhmYodnpOWE5Br4CgBJKbofxGSR/o6rOvT1quGoM8/H1E6S9R80u
         feWVjrGMO+715qy1lArQrhMYfnX+a9i0Bx9P5BajSm+aEH+ONDc3Uadjy0AEwvdWW+z4
         7YN8wUuRqX/kyDM2Qf06/vqFgnm0fSJ1ZFVHenRi9skc9GBMCJWYC7kr3+xf9V7Lzsdk
         Zysn6eU+wT+JdTJhEYcZsVNj9ElPmiKhj7Us04vmDVIvWrKyjCgD3Hc4fPudXV3wRdi3
         Pjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b3NHlf4tlwaXHan7PZOUNKPyEn8GzuXDXyF0zdjzlbI=;
        b=VJvVM85vj4y4iAsZ617PWu7ayquxUipaR09mJTQGP6y601K+W2dH6SrQTUhZnfgeRd
         FH4flOaXNwmdNJUj45H40QOwcGtqHJVPI+IO+yUgnbPO9SZCdsPmBFnxu7BU87xH7ygt
         HnfrRJzMZIgj7tqgd6SD+9GWre/wWaDTnMt95Ns+s5oJaTsPBGTR+JR+sAaQ7yjQYzJL
         Z1M8OQ7qUAjd5uDrKY9NAw72vNu81DNwVJzlNy39B2SFfilu0lJkgau6W9NVKc1bASLW
         +920eWXIc0q6Yhnj7RUd64tLcrKiF+VOiVz4AmGtvhW4uihrncEMs6mZxWm6ctcHYRw7
         5cvA==
X-Gm-Message-State: APzg51BR7Nk+q3/+4ml7hqggIs1Yw2ev0Py9WhluiR9szd7fOHVDGof4
        dVLgi/Y3vqPOg+q1k0CaEx8FQl/vWptv3Mbbkns=
X-Google-Smtp-Source: ANB0VdadQxIaFH/L3E/HWYXVGm/HBLvQZfEkV4x1yT9FCmwFGtgfDgWCNyTR/ajqU+FmPxPDDamz4cRLzJH5oya5qBI=
X-Received: by 2002:a2e:4951:: with SMTP id b17-v6mr18971112ljd.31.1537258833390;
 Tue, 18 Sep 2018 01:20:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:5895:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 01:19:52
 -0700 (PDT)
In-Reply-To: <2915766.O3WEnikESX@wuerfel>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <1455804123-2526139-3-git-send-email-arnd@arndb.de> <20160218143709.GQ19428@n2100.arm.linux.org.uk>
 <2915766.O3WEnikESX@wuerfel>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 18 Sep 2018 16:19:52 +0800
Message-ID: <CAAfSe-vpRcpViY6AtkCLc1xyojNRDGzzBwVzMvMbxA7VhW=t5w@mail.gmail.com>
Subject: Re: [PATCH 2/9] ARM: change NR_IPIS to 8
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Jon Medhurst <tixy@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Nicolas Pitre <nico@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?T3Jzb24gWmhhaSAo57+f5LqsKQ==?= 
        <orson.zhai@spreadtrum.com>, zhaolin@spreadst.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any conclusion on this patch? The coverity tool is still complaining
error on the issue which this patch can fix.

Thanks,
Chunyan

On 18 February 2016 at 23:18, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 18 February 2016 14:37:09 Russell King - ARM Linux wrote:
>> On Thu, Feb 18, 2016 at 03:01:54PM +0100, Arnd Bergmann wrote:
>> > When function tracing for IPIs is enabled, we get a warning for an
>> > overflow of the ipi_types array with the IPI_CPU_BACKTRACE type
>> > as triggered by raise_nmi():
>> >
>> > arch/arm/kernel/smp.c: In function 'raise_nmi':
>> > arch/arm/kernel/smp.c:489:2: error: array subscript is above array bounds [-Werror=array-bounds]
>> >   trace_ipi_raise(target, ipi_types[ipinr]);
>>
>> We really don't want to treat the backtrace IPI as a normal IPI at all -
>> we want it to invoke the least amount of code possible.  Hence this code
>> which avoids the issue:
>>
>>         if ((unsigned)ipinr < NR_IPI) {
>>                 trace_ipi_entry_rcuidle(ipi_types[ipinr]);
>>                 __inc_irq_stat(cpu, ipi_irqs[ipinr]);
>>         }
>>
>> However, what's missing is that the addition of tracing here missed
>> that CPU_BACKTRACE is not to be traced.  The call in raise_nmi()
>> should have been converted to __smp_cross_call() to avoid the
>> tracing code.
>
> I've replaced the patch locally with the version below now, and
> will throw it into the randconfig build test infrastructure to
> make sure I didn't screw up in an obvious way here.
>
>         Arnd
>
> From 7528c9b0558fdf4de785e62e61f0dd2ffe874110 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Sun, 31 Jan 2016 22:26:21 +0100
> Subject: [PATCH] ARM: prevent tracing IPI_CPU_BACKTRACE
>
> When function tracing for IPIs is enabled, we get a warning for an
> overflow of the ipi_types array with the IPI_CPU_BACKTRACE type
> as triggered by raise_nmi():
>
> arch/arm/kernel/smp.c: In function 'raise_nmi':
> arch/arm/kernel/smp.c:489:2: error: array subscript is above array bounds [-Werror=array-bounds]
>   trace_ipi_raise(target, ipi_types[ipinr]);
>
> This is a correct warning as we actually overflow the array here.
>
> This patch raise_nmi() to call __smp_cross_call() instead of
> smp_cross_call(), to avoid calling into ftrace. For clarification,
> I'm also adding a two new code comments describing how this one
> is special.
>
> The warning appears to have shown up after patch e7273ff49acf
> ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI"), which
> changed the number assignment from '15' to '8', but as far as I can
> tell has existed since the IPI tracepoints were first introduced.
> If we decide to backport this patch to stable kernels, we probably
> need to backport e7273ff49acf as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: e7273ff49acf ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI")
> Fixes: 365ec7b17327 ("ARM: add IPI tracepoints") # v3.17
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
> index 3d7351c844aa..2fd0a2619b0b 100644
> --- a/arch/arm/include/asm/hardirq.h
> +++ b/arch/arm/include/asm/hardirq.h
> @@ -5,6 +5,7 @@
>  #include <linux/threads.h>
>  #include <asm/irq.h>
>
> +/* number of IPIS _not_ including IPI_CPU_BACKTRACE */
>  #define NR_IPI 7
>
>  typedef struct {
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index b4048e370730..9802a94260db 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -72,6 +72,10 @@ enum ipi_msg_type {
>         IPI_CPU_STOP,
>         IPI_IRQ_WORK,
>         IPI_COMPLETION,
> +       /*
> +        * CPU_BACKTRACE is special and not included in NR_IPI
> +        * or tracable with trace_ipi_*
> +        */
>         IPI_CPU_BACKTRACE,
>         /*
>          * SGI8-15 can be reserved by secure firmware, and thus may
> @@ -757,7 +761,7 @@ static void raise_nmi(cpumask_t *mask)
>         if (cpumask_test_cpu(smp_processor_id(), mask) && irqs_disabled())
>                 nmi_cpu_backtrace(NULL);
>
> -       smp_cross_call(mask, IPI_CPU_BACKTRACE);
> +       __smp_cross_call(mask, IPI_CPU_BACKTRACE);
>  }
>
>  void arch_trigger_all_cpu_backtrace(bool include_self)
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
