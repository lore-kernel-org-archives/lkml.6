Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1B1ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E81D208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do0nsgQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E81D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeJRLbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:31:35 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44420 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeJRLbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:31:35 -0400
Received: by mail-lf1-f65.google.com with SMTP id m18-v6so21456131lfl.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 20:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9O8iT8L/QZEnXX5xUcU73VZOMJh/Rn1/4MXgA4Q8wBE=;
        b=do0nsgQ6MyI3VNdTm5EVp8ag6hV1V8PyieN++JTeVvuBGU1cNU/BlB5/KHJ1ZWsbo2
         LaT7qc30f9SlSkf3y58EqVMMpEQ/y519s4/apB5TlKRAZ0/llWYlmUtgDt+ZmYpH+nHH
         q9M/sWPIB3qDVU4W/zfVEYhhplhNiWtsD9ydwDll3dhHZE47yWml8zkAVphrSa1jOZUf
         rteKZE19kKP/IBXF+xOCCPEwq0UCWhkCNzpiZL2+365MGiEeAHlP5IjA8+QdyJmmSuM8
         7agh/eDiKm8LYxMieMSq+AXAb6I88A3Q/clxNxGDd10vH4SYdrBHdrvcLBaG1R8QTDwQ
         YBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9O8iT8L/QZEnXX5xUcU73VZOMJh/Rn1/4MXgA4Q8wBE=;
        b=ihC8wycKIf/vg011EVIPY05Nplm7eM5cz6HxsyxTmjGmkQcqAzIlbqQAIvB3qoGnfx
         jPrbsjDwzmAGdOhHpN8aBsV/U5ocHTXzSvIj+flWldPEd8uS1n/PaA+9fFa+D00jWXkB
         a67trTgspLAKOfBb21H8v9s0vEB79OJDA90n/64AzVagXlc3P9ol0fbprw3seQu8CxY5
         JraJkhisD4vnFFUnEntr04WT8vAC/0K0ay00yR/+dl6hg1NDAUqnSdEM/GqUooNSp9jd
         QGiToCFUnQLjxFmcdVjqxVGnWQTLmzYsbXv9a1KddhtEdZE8MuiWicMDR7ZNxae2O8pG
         pueA==
X-Gm-Message-State: ABuFfoglaAX4IlW5GYV2N+gnxD/Ud4oBXPWiTVBnBuZ2p4+1lhzRtCaM
        TSd2xNMr5HzNjojjyDcwKCUBdg3WwiGi9dv/Ul0=
X-Google-Smtp-Source: ACcGV60wTw2G6SgFMkLC2QzHd4JlI8qCsggGPlsFU23J4/AoCKcuaC/5ZMCeDr2ZkkC0aTNwIvOXKaV1qyXTZTAgND8=
X-Received: by 2002:a19:8d11:: with SMTP id p17-v6mr16386994lfd.116.1539833563517;
 Wed, 17 Oct 2018 20:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <1538019697-14673-1-git-send-email-chunyan.zhang@unisoc.com>
In-Reply-To: <1538019697-14673-1-git-send-email-chunyan.zhang@unisoc.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 18 Oct 2018 11:32:07 +0800
Message-ID: <CAAfSe-sd9Zzh3Oz-fUSz-ssEpSYPYE7mbhFUuyim3V-62=sPXQ@mail.gmail.com>
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

On Thu, 27 Sep 2018 at 11:42, Chunyan Zhang <chunyan.zhang@unisoc.com> wrote:
>
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

Here should be double underline, i.e.

> +       __smp_cross_call(mask, IPI_CPU_BACKTRACE);

>  }
>
>  void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
> --
> 2.7.4
>
