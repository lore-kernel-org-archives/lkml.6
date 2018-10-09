Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D49C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE3E2086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTzx94dQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE3E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJIJfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 05:35:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41989 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeJIJfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 05:35:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id y71-v6so28864lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 19:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=19Hdi7klKgMFb9ldNOiHfrhBJs5CZ78jkkStyPMZ3XQ=;
        b=GTzx94dQqrhZJbTrVFUuvx175/655VSHSWv09ropqCQUz93e+s9qimDnlfUcJZ0aob
         81y6YOXdmRoAwym5Gfb62I0kBe+Ag6zjFd8ur254IMYA7vr3nah1DACAIYMTgAIzUCW2
         FvpR54vf0AQvKet7nJh6L0NfMxXkR9EwUkn938tMZlTk8c2kraCLZjE711mxVhl/613J
         Y0kv3jV8olrtR9HViVuklttlde+jVGgcpUSUg6lLVLWFF5DLHI5Pzmw9R67Oy7qlMd/2
         Dmdmpdoy3aN4o0WuB4xD4JpZ/w95WXjd/IxvnqJMhEQ3hZgZ8E957HS+T5Kfkb/EEh4x
         UQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=19Hdi7klKgMFb9ldNOiHfrhBJs5CZ78jkkStyPMZ3XQ=;
        b=F3Qh9OPDHSoAw+KHoB4dQAqEDGziRukm8jN2r1bRiVVqFQsHLk4k23sz+oxLxHi0QU
         3V1SJP1yxXR8XgYTjPsLn2D8/cZCUbB0xNhc+Z1QEuYJKHyBbuQQQQJZVkcO8Y3Dsioa
         uIEhE8F02T1YIIgUf1VbiOuh/wtrJ4/GeKu9tVuxRMXO08ues/Ee2SOxqYy6OSiwUrpE
         Qef7yvxGYMsbWYNYxOOJusU7Hol9rFNEdcL68HPXYzCo6wFpg3IaXxp74ssjc2nQmoNy
         EdKTyiHyfudJdAtqkmYcQ/LjLJF8zGyyaPbr13oETMC+2ADtZt1LNSCoAervG5euTSI6
         t0uw==
X-Gm-Message-State: ABuFfoh0UCwFULFthb3O1bILgMTvh56Dn4LaIqRaY5OHmujjuZoF6TZR
        cQqzT5+IYXUr8L+9F3jNxS6K8kbGu9OCvkgLuE7aUTEC
X-Google-Smtp-Source: ACcGV60Sq9vn6s/+zJ297sMaTmUM70xkCBwDDMIpWpMM7DXFqLsNYa3j7JPSW8x6aNE+VmtTxSIktLjfX1XCOH9kyZI=
X-Received: by 2002:a2e:8981:: with SMTP id c1-v6mr9922102lji.124.1539051643065;
 Mon, 08 Oct 2018 19:20:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:4984:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 19:20:02 -0700 (PDT)
In-Reply-To: <1538019697-14673-1-git-send-email-chunyan.zhang@unisoc.com>
References: <1538019697-14673-1-git-send-email-chunyan.zhang@unisoc.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 9 Oct 2018 10:20:02 +0800
Message-ID: <CAAfSe-ugVfdsSf_jQBYH8QObbjJJpBE+QcN75VzgS9eczbOdyA@mail.gmail.com>
Subject: Re: [RESEND PATCH] ARM: prevent tracing IPI_CPU_BACKTRACE
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

If there's no comments, should I submit this patch on RMK's Patch system?

Thanks,
Chunyan

On 27 September 2018 at 11:41, Chunyan Zhang <chunyan.zhang@unisoc.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> When function tracing for IPIs is enabled, we get a warning for an
> overflow of the ipi_types array with the IPI_CPU_BACKTRACE type
> as triggered by raise_nmi():
>
> arch/arm/kernel/smp.c: In function 'raise_nmi':
> arch/arm/kernel/smp.c:489:2: error: array subscript is above array bounds [-Werror=array-bounds]
>         trace_ipi_raise(target, ipi_types[ipinr]);
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
> Resubmiting this patch is because that I found coverity is complaining
> the issue this patch fixed, and also I got the traces like below:
> "ipi_raise: target_mask=00000001 (machine_suspend)" which actually was
> the TPS of suspend_resume[1] rather than ipi_raise.
>
> [1]
> https://elixir.bootlin.com/linux/latest/source/kernel/power/suspend.c#L80
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: e7273ff49acf ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI")
> Fixes: 365ec7b17327 ("ARM: add IPI tracepoints") # v3.17
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  arch/arm/include/asm/hardirq.h | 1 +
>  arch/arm/kernel/smp.c          | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
> index cba23ea..7a88f16 100644
> --- a/arch/arm/include/asm/hardirq.h
> +++ b/arch/arm/include/asm/hardirq.h
> @@ -6,6 +6,7 @@
>  #include <linux/threads.h>
>  #include <asm/irq.h>
>
> +/* number of IPIS _not_ including IPI_CPU_BACKTRACE */
>  #define NR_IPI 7
>
>  typedef struct {
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 0978282..123be77 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -75,6 +75,10 @@ enum ipi_msg_type {
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
> @@ -755,7 +759,7 @@ core_initcall(register_cpufreq_notifier);
>
>  static void raise_nmi(cpumask_t *mask)
>  {
> -       smp_cross_call(mask, IPI_CPU_BACKTRACE);
> +       _smp_cross_call(mask, IPI_CPU_BACKTRACE);
>  }
>
>  void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
> --
> 2.7.4
>
