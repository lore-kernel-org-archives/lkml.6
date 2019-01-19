Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76622C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6852084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ej3A4cbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfASFEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 00:04:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45741 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfASFEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 00:04:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so17397149wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 21:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9OqQUiReqIQ8YZUpta0SOLU8AXMnOYWaBGRv3HmoIA=;
        b=ej3A4cbVNw+WNEQRTqo4RQQTaDkUvo4lgXKqPYvJTPYt421Q+RMaDbVLxlZtJxHudm
         xigS9+qb1mi0V+nPUQ2Q8IdLQP1ADUqolewkmoLyWaASC+zPAa0xzlViJJZ0TrYfiZyr
         aF2aAWRKsSFoZ9a0VIaNPTc1p1diZLz0ynrn0u550LXBaWBewtf7PyI9DJElfKzEGdCJ
         m+62gjZ5N0FPtUwJloGjGv9r3jxehZh3v6gmaUxQGarDrO556NIdH7l2PNT9Ma2jygZn
         459lBhI1eLXbgjXBaAeEO2WhhXVDXvG8qY0ASPhirPF4YW3sCTTUsF0TmTQhLCvxiZ//
         2b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9OqQUiReqIQ8YZUpta0SOLU8AXMnOYWaBGRv3HmoIA=;
        b=HevcDgSyds8WLGMcPMXJnShXprHaAthtn0OrUKNI8TGM7oUU0AK3RJQUEHqRPKXL4T
         cP++WKskOfDChiziHXofdC/+HvjfmRrujzmt2pUHt0NSnSr0tDDhP1TfFBI3qu5mX+br
         BH9iiwVxsSNgYqa8DJeIztINlMWSscNd3MTXN6pn/jco5VoQfd47AJkurRcMdkO+r3GV
         dlBRVkvuQOpyFUeEzXumVJ2SeuJyvoKn1zNijYqJBXgSud0rPmdjTdmaxkRYLnJbU/hv
         drXkDBH7bQ9GdN2geajR2eLACSPHuZ7vHtqlTcPG4HqAZhO0lh1VXXKkxlu6oN6ELG5N
         RTdA==
X-Gm-Message-State: AJcUukf3erWt/6XIc8EoRaRAo4tN/FnLi/OggPjcJCrA545gtrUHDj10
        a6Be0vk1MULh5S7o2i7U+Fz9EAWTQzGaDosPPkvrZg==
X-Google-Smtp-Source: ALg8bN6hsLNOO2n706lYj/qXmaUAWBGbeNV8WrD9+iolzrSHI5TI3D/DCf9qcO9Q/ZfaT6FiGofkpIrYZBDrbymV/cg=
X-Received: by 2002:adf:ee07:: with SMTP id y7mr19817841wrn.187.1547874246381;
 Fri, 18 Jan 2019 21:04:06 -0800 (PST)
MIME-Version: 1.0
References: <20181227111821.80908-1-anup@brainfault.org> <20181227111821.80908-4-anup@brainfault.org>
 <20190115155453.GB13095@infradead.org>
In-Reply-To: <20190115155453.GB13095@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 19 Jan 2019 10:33:55 +0530
Message-ID: <CAAhSdy19yrGsXADNNSF8kuoUULqZCFdZ4JKc3_hxBZKHf=dJrg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] irqchip: sifive-plic: Add warning in plic_init()
 if handler already present
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

On Tue, Jan 15, 2019 at 9:24 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Dec 27, 2018 at 04:48:19PM +0530, Anup Patel wrote:
> > We have two enteries (one for M-mode and another for S-mode) in the
> > interrupts-extended DT property of PLIC DT node for each HART. It is
> > expected that firmware/bootloader will set M-mode HWIRQ line of each
> > HART to 0xffffffff (i.e. -1) in interrupts-extended DT property
> > because Linux runs in S-mode only.
> >
> > If firmware/bootloader is buggy then it will not correctly update
> > interrupts-extended DT property which might result in a plic_handler
> > configured twice. This patch adds a warning in plic_init() if a
> > plic_handler is already marked present. This warning provides us
> > a hint about incorrectly updated interrupts-extended DT property.
> >
> > Signed-off-by: Anup Patel <anup@brainfault.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index 01bbbbffbcae..b9a0bcefe426 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -229,6 +229,11 @@ static int __init plic_init(struct device_node *node,
> >
> >               cpu = riscv_hartid_to_cpuid(hartid);
> >               handler = per_cpu_ptr(&plic_handlers, cpu);
> > +             if (handler->present) {
> > +                     pr_warn("handler already present for context %d.\n", i);
> > +                     continue;
> > +             }
> > +
>
> Just use WARN_ON_ONCE?

WARN_ON_ONCE() is not suitable here because we want know
all the context IDs for which handler is already present.

Regards,
Anup
