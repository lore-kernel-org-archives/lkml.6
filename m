Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346C9C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86992087E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="b+lonpRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86992087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeIEJUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 05:20:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35071 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbeIEJUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 05:20:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so6279602wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 21:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1cVziYfXelTgIKyWPsM/i/D1oks0SKgHyxEVB0eDUis=;
        b=b+lonpRcXRUaTUkODN+VMnDzj976yA4xyd+y7xj3GHLKnHK+bOrM9+LECGS9gURf8m
         HgbnOXwZwn+cS54oECuqe0ZP3Xo6R12hqDowzyPIdDGnwFXD1HNGZAZ29VZC7Q24Rw8f
         W3bBsWoCaKWp4hwof00lo3AtE5fNm3tQwu6omrmqpEMBt7dK6R4XTlpQkHgeT2KNJj1O
         E0Vo+Q21xmfJeDK0JG+jxBc+2BZvWf6Eao/JBDdCIwRrcue+/qfAPuXh8h2iybZcJ14e
         bV+Ftmb7HMNdKiynXJHlxrJ4XG3Ki6wn35PQglBsktR1ATUvnlWwm7Pzk0PQv+ktsj5C
         iYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1cVziYfXelTgIKyWPsM/i/D1oks0SKgHyxEVB0eDUis=;
        b=i1N9QgopXRYv4tsNnhjLrKMwyWbA8GD50jgj9fGzaSu562RWgSeYa53FCGOfBSAAgB
         et4XKXJZK/dLXGiTyBGzUovWEl41MzxlGxMakvjhDboa1y+/wYczl95BNwkGgsh0BW3E
         Cfw9LcEJt6RbpLx7C2yPPnnx4JwqZeY51MRyd+vIw3PULTBSluD04Egf0HnU6XhNbeJc
         7dYSZ8yXjssqzynF/P11BCmq3tKJUlU4JQ7yZSkAYS0xfiLleZWlD2lNa24KOJdydAlq
         XSAsgTBVj3e9BhgalCb5nDk3jZRY3cDFrJ4siQwQXJz2wGVbaakkXRO+mb18WNmM15G5
         +HlQ==
X-Gm-Message-State: APzg51AAsZ0I8/bQJlwE9HKHf/jpgK3na50JHeyyH49B9mc4p0+yF6ZV
        M0kq529D7eimYgdEksXtGOLkIRVwaWZQw6yoYdstoZ6zviQ=
X-Google-Smtp-Source: ANB0VdYYaIwzwh989LFc7xZatE0hCNOrjFeAeCcnISX67uKnbzMYwO/v6URsM6coQ1e6BX98TzK4cW3CIOSZFzmcIlM=
X-Received: by 2002:a1c:b707:: with SMTP id h7-v6mr4388204wmf.91.1536123148404;
 Tue, 04 Sep 2018 21:52:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 21:52:27 -0700 (PDT)
In-Reply-To: <20180904185629.GC25119@infradead.org>
References: <20180904124514.6290-1-anup@brainfault.org> <20180904124514.6290-4-anup@brainfault.org>
 <20180904185629.GC25119@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 5 Sep 2018 10:22:27 +0530
Message-ID: <CAAhSdy3qUkDmV5deoy9x3sqdv8xTq37od6SzgF0hmN1JPThGgw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] RISC-V: Select useful GENERIC_IRQ kconfig options
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 12:26 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Sep 04, 2018 at 06:15:12PM +0530, Anup Patel wrote:
>> This patch selects following GENERIC_IRQ kconfig options:
>> GENERIC_IRQ_MULTI_HANDLER
>
> This is already selected by arch/riscv/Kconfig.
>
>> GENERIC_IRQ_PROBE
>
> This is something only used by ISA drivers.  Why would we want that
> on RISC-V?

Yes, thanks for pointing. GENERIC_IRQ_PROBE is not required at
this time. I will drop this selection. May be will re-consider later.

>
>> GENERIC_IRQ_SHOW_LEVEL
>
> We don't really have any special level triggerd irq handling in
> RISC-V.  That being said this is trivial and I don't see why it
> even is a Kconfig option.  Please have a discussion with Thomas
> and Marc on why we have this option instead of a default.

Most of MMIO device interrupts are level-interrupts. In fact, all
HW interrupt lines coming to PLIC will be level-interrupts. It's
just that PLIC does not implement state machine to sample
Level-IRQs and Edge-IRQs differently. Even the interrupt-controller
virtualization in hypervisors deal with Level and Edge interrupts
differently.

I am sure we will see both Level and Edge triggered interrupts
in RISC-V system. The MMIO device interrupts will be mostly
Level triggered and PCI MSIs will be mapped as Edge triggered
by MSI controller.

We should definitely select GENERIC_IRQ_SHOW_LEVEL
so that nature of IRQ interrupt line is evident in /proc/interrupts.

>
>> HANDLE_DOMAIN_IRQ
>
> We aren't using handle_domain_irq anywhere in RISC-V, no need to
> build this.

The new RISC-V local interrupt controller driver introduced by
this patchset uses handle_domain_irq().

The main advantage of handle_domain_irq() is that it helps reduce
few lines of code which is otherwise common across interrupt-controller
drivers (mostly code related to irq_enter(), irq_exit(), and set_irq_regs()).

Regards,
Anup
