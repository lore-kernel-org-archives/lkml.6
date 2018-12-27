Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5EEC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 05:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD94218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 05:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="2LHTUQma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbeL0F1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 00:27:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43370 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeL0F1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 00:27:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so17213037wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 21:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZzhCcAgXuw19vxX6fyr918Uz0Jrox7YQDyO5SQd/Ks=;
        b=2LHTUQmaZpLDzZob5MnpMtup26i4+NRGqEbSMZsqZo7CDD/MQP/e0Fr2NGvDG0zLNR
         jrHYViSl5KaV7af3Cgd5dYXSHlkn9TgsisDtKl3htS4XaJGJsuiC/NhVRw+pHy3DMYSK
         AC1FHjY8Gu7MDzCsY0R6skLZJuEnmxgDuSK4pdNDkcPyGtsZ0CPk0hHrXXREXOAewZGp
         Y3adL0QmZMGKp0w1I3GttHgRlCoxeqxfb4fHV8acs/PiSRHVaRg2zKjMntzAD0M1CU2v
         KIO9CvxjYJF4AxVuwaEly8Obu2us0lSlXbCLTO1k7aFPa7JN5wb+7sRWqoQBMqdP/Zy1
         wIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZzhCcAgXuw19vxX6fyr918Uz0Jrox7YQDyO5SQd/Ks=;
        b=el932CPqlsz2SgRy1iVn+W6SwODZ4I3iVfAVD6QIKr+xDKDullUOFTvQQpon7ULssW
         iCTgfJp+i9ri3WbAbAgUZgSc3lXMS6lvIQf6a+KJ7AKnlrcTaTPWTq36l+GyjR/+GGYC
         ScY5BPhwiVaZ53suQWK7gDxDz+2DwXCHXpfeCi6m9jquFjisgJo4mWL7MZCFCplVQpz1
         a8guDYJrqgeEvdGI8VwWxdBeDis3TifEPqLZwvALWoLGurXiCv/893smE5cdvkAB0RtZ
         0zOGP6RmlSngcbhL/x8JZqdIM/LCLKaJ8RZHlk7NcjpiNT0s4iglzXescn6mdZRaaU/j
         yxaw==
X-Gm-Message-State: AJcUuke1vXE1m5DLBhla5UqTPncd670OXqBqsDldg9RNvmFl81fEOqqd
        831mCgETgBT6DQCdNbjW/VpvMFNk6KTujBC/rqoAtg==
X-Google-Smtp-Source: ALg8bN5X4qQIE8YqMXg0ioz1s2ZXK0l2gAFN+G6fxA1BZnHy/bwupJfks8PTyvW4bjzCL08SxQsPreuvhhM6Q87abHI=
X-Received: by 2002:adf:91a3:: with SMTP id 32mr18886340wri.99.1545888463992;
 Wed, 26 Dec 2018 21:27:43 -0800 (PST)
MIME-Version: 1.0
References: <20181130080207.20505-1-anup@brainfault.org> <20181130080207.20505-4-anup@brainfault.org>
 <20181217182719.GC7086@infradead.org> <CAAhSdy3i+ap2J0By3nRqK6yvb8oD4-+2QwUO9PH9GM+0odKqSA@mail.gmail.com>
 <20181219162836.GA9224@infradead.org>
In-Reply-To: <20181219162836.GA9224@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 27 Dec 2018 10:57:33 +0530
Message-ID: <CAAhSdy2a6gs8o50afS_EpncinQvdUu--=a1PP5XfY8ZcJkWS2g@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] irqchip: sifive-plic: More flexible plic_irq_toggle()
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

On Wed, Dec 19, 2018 at 9:58 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Dec 18, 2018 at 02:20:10PM +0530, Anup Patel wrote:
> > Actually these functions should not be inline because plic_toggle() uses
> > raw_spin_lock() and plic_irq_toggle() uses for-loop.
>
> So?  It still inlines the all of two instances into each caller
> for slightly different but related work.  Not sure it is 100% worth
> it, but probably more than the one to move the calculations to init
> time..

Not just at init time but these functions will also be used when
irq_affinity is changed by IRQ balancer at runtime.

Regards,
Anup
