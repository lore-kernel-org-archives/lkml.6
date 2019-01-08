Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B546FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2A2206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="aZdcNThX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfAHMOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:14:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44103 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHMOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:14:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so3780078wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 04:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H58GJbXTkYOWpGzunPY/zRGy+r/zK4zeENd9eaVqfA8=;
        b=aZdcNThXWO06NC8TfXwatRCZ2mF4uvIWZfYfPXcH4Zv2XZTyEe1MuGi1vITINS9O5/
         5d/0J7z9p2z4R6hPmcLioNAuzY+ETzMNcY5GbK7u/DaO8EsQ13EwM2x6zyntBvKxnuZW
         3l0ZIa61L94OyCBgnJBmkGfkpM/Lm3Ztwe8m33rtjZSUmT9PuePNaJk4DkrcCtWUOcMQ
         Qw6kLT9ktuCL7pbQwmIAG5ESaoBcsylmCnd37hbpRq9Bkf9MQv02Hrv0lp9HN8kye/ww
         p4Be/yetzJ22PmkHkuictC5AEMBbt4Xsmd5AUBO3dwCIdVbldnj2qWSj3M24CIGx+eeU
         vbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H58GJbXTkYOWpGzunPY/zRGy+r/zK4zeENd9eaVqfA8=;
        b=m2yJgQkbf6o3fM2SEe2cZIOBRpcryJlSfAK9H9urLQvQFyEJmiymJPbDdh5YXWh1g4
         JuNjLzb5+vaBfYZd6/+p7zyhK7M+f+5UCCnwjlTfsXMrDCOKbDZx3JGrf5+8Fod2G457
         eZcIlwBTwekuPcN0We+iQ9ERSnoz6d6mhB5Xhvljjgc2AEAKA68hMvVz8xPuU2iSlMAU
         z8CbFDUvRiNIezkFZ8/DM/7SJht3dlpieCVaDYHRt7O/mBflPPmqSNgQpBDlafRToq63
         0x7YOWXeAlUnbMRO8EAlE8wjgZWnBa2BpRPd1H/wyTS/FpMUHvZD5Sqqu0coP15G3gYE
         JPxw==
X-Gm-Message-State: AJcUukeDbPjoHflU9orbIngN1v+fdkr7VbUpEwTHD10CEqoJjj40bOZL
        N3wi3r3TDnXEEw0K4EFYOZUqd0KTgAm+Eo71V+KGbQ==
X-Google-Smtp-Source: ALg8bN5Mb3svnjAy8H2NU1gkpIfGnt3L63bKxV77vWm1+E+T5nJsTa0EGLbJZh8WoLD78cp3ruBM6NcDLSc4dqoFCok=
X-Received: by 2002:adf:f785:: with SMTP id q5mr1351829wrp.9.1546949656721;
 Tue, 08 Jan 2019 04:14:16 -0800 (PST)
MIME-Version: 1.0
References: <20181227111821.80908-1-anup@brainfault.org>
In-Reply-To: <20181227111821.80908-1-anup@brainfault.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 8 Jan 2019 17:44:05 +0530
Message-ID: <CAAhSdy0NYKgX0whXLF8h9Pjeg05D=pL8FcH674jTrTwUX3YX3Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] IRQ affinity support in PLIC driver
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 4:48 PM Anup Patel <anup@brainfault.org> wrote:
>
> This patchset primarily adds IRQ affinity support in PLIC driver and
> other improvements.
>
> It gives mechanism for explicitly route external interrupts to particular
> CPUs using smp_affinity attribute of each Linux IRQs. Also, we can now
> use IRQ balancer from kernel-space or user-space.
>
> The patchset is tested on QEMU virt machine. It is based on Linux-4.20
> and can be found at riscv_plic_irq_affinity_v4 branch of:
> https://github.com/avpatel/linux.git
>
> Changes since v3:
>  - Dropped PATCH2
>  - Added PATCH to not inline plic_toggle() and plic_irq_toggle()
>  - Moved PATCH3 changes to PATCH6
>  - Used WARN_ON_ONCE() instead of WARN_ON() in PATCH5
>
> Changes since v2:
>  - Fixed incorrect address of enable registers using sizeof(u32) in PATCH1
>  - Retained comment about need for locking in PATCH1
>  - Split PATCH2 into two patches
>  - Split PATCH3 into two patches
>  - Minor fix in commit description of PATCH4
>
> Changes since v1:
>  - Removed few whitspace changes from PATCH1
>  - Keep use of DEFINE_PER_CPU() as it is
>
> Anup Patel (5):
>   irqchip: sifive-plic: Pre-compute context hart base and enable base
>   irqchip: sifive-plic: Don't inline plic_toggle() and plic_irq_toggle()
>   irqchip: sifive-plic: Add warning in plic_init() if handler already
>     present
>   irqchip: sifive-plic: Differentiate between PLIC handler and context
>   irqchip: sifive-plic: Implement irq_set_affinity() for SMP host
>
>  drivers/irqchip/irq-sifive-plic.c | 110 +++++++++++++++++++-----------
>  1 file changed, 71 insertions(+), 39 deletions(-)
>
> --
> 2.17.1
>

Hi All,

Any comments on this series??

Regards,
Anup
