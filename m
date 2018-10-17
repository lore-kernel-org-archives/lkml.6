Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3617DECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3402151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3402151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeJQXVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:21:05 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44685 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:21:04 -0400
Received: by mail-qk1-f194.google.com with SMTP id y8-v6so16701169qka.11;
        Wed, 17 Oct 2018 08:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MaGRLek2OX0zEc2g5QRc22boZKv7PEzfJvudm/qjq4I=;
        b=F57Ltvsf1LVZ8+K6hI1OO8RnfZv9qsQY67XM1nalDcrdu/0q0OIWHP0yjKrXZmy51k
         RXaAPJovWzKV4K6AShnzT93tL3O7b8t6okbwcIMXMTa45tJyThwLJ7WpXQeBzIIUKXPN
         WpKvuWOLTK8IbFVll+p+kqr5kGSp4WOikexT+DOLgumxUw5Lw6zTOUbsZdB2SKjPE4IG
         wP/6VLcer/Ed2So+Y+nR1Pu91f/9chwje3Uj+uGdTHXu2NLKM8wOKSFPzMTXChKaehPE
         gwsUw+Ej+wgf8QNiiVVK1wAM/x2CR5nJrM2e9c6mZ8i1X7RnGu1B1iwm3Do/w9EhOPM2
         n2XQ==
X-Gm-Message-State: ABuFfojiusMgrWSx3dRpFTUk0Uq4GIjJK3j/4fnz5aYi9eERRQa0wzqy
        fAzCCGAdLd0Q3dEFzZFNncqufSrE/bGsa0eW30g=
X-Google-Smtp-Source: ACcGV610nGyt5yECRWz6iCgyMu18D+Y5I4e7XAO+VmaGq/lwkwLzPVGxLFggIVihNno2rBnGOrHk0ItQ5JmrN76V6O8=
X-Received: by 2002:a37:e21a:: with SMTP id g26-v6mr24536179qki.330.1539789892521;
 Wed, 17 Oct 2018 08:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <f884af8fffa1645c2650292a3001a2fbfc4cc390.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <f884af8fffa1645c2650292a3001a2fbfc4cc390.1539655732.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 17:24:36 +0200
Message-ID: <CAK8P3a3hJ+Xt2xfTg=bkDBfahk7Z-3+Unt1MqmMQrRnCeJhVtg@mail.gmail.com>
Subject: Re: [PATCH V9 13/21] csky: Library functions
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com,
        linfei_chen@c-sky.com, Mao Han <han_mao@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:02 AM Guo Ren <ren_guo@c-sky.com> wrote:

> +++ b/arch/csky/lib/delay.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +
> +void __delay(unsigned long loops)
> +{
> +       asm volatile (
> +               "mov r0, r0\n"
> +               "1:declt %0\n"
> +               "bf     1b"
> +               : "=r"(loops)
> +               : "0"(loops));
> +}
> +EXPORT_SYMBOL(__delay);
> +
> +void __const_udelay(unsigned long xloops)
> +{
> +       unsigned long long loops;
> +
> +       loops = (unsigned long long)xloops * loops_per_jiffy * HZ;
> +
> +       __delay(loops >> 32);
> +}
> +EXPORT_SYMBOL(__const_udelay);

I can't find any indication we discussed this part before. Can you
explain (in the
changelog and in a reply) if there is a reliable high-resolution clocksource
available in the architecture? If you can read the elapsed time here instead of
using the loops_per_jiffy estimate, that would make this more robust, as
well as speed up the boot.

If you can't do that in general, that's fine, and you can add my
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
