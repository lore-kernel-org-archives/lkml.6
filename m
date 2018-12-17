Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A7BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EA6206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Fz9wPF+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbeLQJiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:38:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37965 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbeLQJiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:38:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so11873624wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJwrEhYVcOS1F6tTiFDPmQ6QHY/esy3VZ1Sp2iKa5mI=;
        b=Fz9wPF+NzOq5IGgIvRMui1XEQ4DJjdPDm4/lPjT6GkHtrXm9Sp1Ns/oVbrlLoTFWoO
         9X3bpJ10/dsPRQsILCXMEz6pBqfG0c+qleFDnEnSvpaGendtytS5ehJzC2q3mRHhuaPu
         Eo/hM92XCYmY8YSWm/ODlKjzj+MRUctzW/oytDatwm4/EVUdHJ7d257LcgQvLqt7xuJX
         o5qQA36rzocYuxe/CgHQayajH0AmSmfKQCtSyVxF1XkYAll51dX9bFHEvFkYDYReOoWG
         Y3kci7vNFjmSwY22etchyNOSspA/v5T57VTrxiXJigeOWROmG8amYSVCMaGWiz8PWSni
         vEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJwrEhYVcOS1F6tTiFDPmQ6QHY/esy3VZ1Sp2iKa5mI=;
        b=r8bbS6GxgzYNztHeZthsmOwWoBml70EhdTUt58BN16tlDKgYw+fnaAm/D5YE0TfahO
         iefNEuZURZfCDWFwU4GJaexCNk6dSYXEq+hIqabkCipZRFONIO/tuuev25TVR9rQ4cVo
         k77ovY1Q/gBn23Ka27IQagqfkIdW/0rsn6qNDFX/hnyrsnnn4vcijwiM7VKv4t6z68Q4
         j4/XIykQ8Pg1j5Vwc5n81JWmWdnstwzVD/qfa3tz0meTSU7oqhy6wm+nZHifLwNHPa8j
         a/cfUjEK1eIyKXexOsV9k81MQxexGIpx8u4cu+qMmGs4HBPVnxZfJ4xWE0yxtyY3F8PA
         TMGw==
X-Gm-Message-State: AA+aEWaYEHDuuxMRm98LIcJvijGdvap9ZOlZ6ZNOYLUgkkykJi91Bq8p
        AMLxZlbxLvaKkuwPnxVWDIuxzrnAYruH8Vo0GHSX4w==
X-Google-Smtp-Source: AFSGD/V24/x7B5xet2NxYUhGEwvBZdr9bJH2zjH4Q6wca2LGH3+YR66J6KpVcnWavGl/X8rCrAqXI8aI82YNN2WnqsA=
X-Received: by 2002:a1c:9a46:: with SMTP id c67mr10132126wme.21.1545039489764;
 Mon, 17 Dec 2018 01:38:09 -0800 (PST)
MIME-Version: 1.0
References: <20181130080207.20505-1-anup@brainfault.org>
In-Reply-To: <20181130080207.20505-1-anup@brainfault.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 17 Dec 2018 15:07:58 +0530
Message-ID: <CAAhSdy0t9H4VMSpoZy1Xt2caW_BxOfEA-x-QhnMsbzXned6AUA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] IRQ affinity support in PLIC driver
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

On Fri, Nov 30, 2018 at 1:32 PM Anup Patel <anup@brainfault.org> wrote:
>
> This patchset primarily adds IRQ affinity support in PLIC driver and
> other improvements.
>
> The patchset gives mechanism for explicitly routing external interrupts to
> particular CPUs using smp_affinity attribute of each Linux IRQs. Also, we
> can now use IRQ balancer from kernel-space or user-space.
>
> The patchset is tested on QEMU virt machine. It is based on Linux-4.20-rc4
> and can be found at riscv_plic_irq_affinity_v3 branch of:
> https://github.com/avpatel/linux.git
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
> Anup Patel (6):
>   irqchip: sifive-plic: Pre-compute context hart base and enable base
>   irqchip: sifive-plic: Add struct plic_hw for global PLIC HW details
>   irqchip: sifive-plic: More flexible plic_irq_toggle()
>   irqchip: sifive-plic: Add warning in plic_init() if handler already
>     present
>   irqchip: sifive-plic: Differentiate between PLIC handler and context
>   irqchip: sifive-plic: Implement irq_set_affinity() for SMP host
>
>  drivers/irqchip/irq-sifive-plic.c | 143 +++++++++++++++++++-----------
>  1 file changed, 90 insertions(+), 53 deletions(-)
>
> --
> 2.17.1
>

Hi All,

Any comments on this series?

Regards,
Anup
