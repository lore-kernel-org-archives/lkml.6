Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FD3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E73217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="aYsUlbGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeLRIgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:36:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33236 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeLRIgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:36:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so14968532wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6xPOHkiFjAua7p3m3cOH8RbdrxMp2PAq5c5QrYtguc=;
        b=aYsUlbGgFWDEdTPnV0XlupgMvbbuBmYOMIqGPJhPE81Fbq+7a85inoth2jcqtjld65
         ifQGGizdmqfPBW4GCIt/7YJsK+C9gtdJCTcvUT7M4ncQP2Ul1zaSXqDBnUvd9p9zy61z
         6X5+M08//P845iFngS3zwQEnXc3zu6DdZkBmKPd5SaEt5OQYOKeRTVhgB21wniypvAtp
         jnEjOCL2va04n8mmgIUcOGRtQft+FhDtKeOvDL97c5QDoaQgDbFONqZVm7b1qONOnkB3
         Z59+Jhc4/JYWLYcMB7uBZWKuvrkFVtDm15abMr7TxlGgDhfz8w3ct5x+Ao17N9lgxxZM
         m2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6xPOHkiFjAua7p3m3cOH8RbdrxMp2PAq5c5QrYtguc=;
        b=Ll8hwb/uLgXxSTx3jnVpPqgRiijuWmIDqjbQqLW1cMwXYSQpVZlwRpRBJZQxFkk5Ee
         tweohvKZaU/KrxjB5/rGLDxFVLRixHxCU5YhapLjhiNxT2Dn27sxbO3s46z6ZzEt/KNM
         wYG9esamKuOFYg1a83QNoXEu4lC0tCVBdgl3FE3cRm2kzR+FrcWm3dUSXaWUk2twQrUh
         SCxAzz+g1B3zR8RDCpwZihBPAMVQg1Npqa2o+IdgYcVNS340ukb8mxhZOtBOkOEynOrE
         h1wLNBZu/R08otNC9Zw2DKc/KG6UFwikW1NjMeMVHT10a8NZUGTWW70O7qBbZDf6uYai
         mXQg==
X-Gm-Message-State: AA+aEWYAtEQ2PufU0TR+qwiurw+EjoC9EvRdS0IMuHa5oDVpRNihF0/p
        uBj3frugtHrU3f8s6FefJaH425XcZaunWpSd4tRjIQ==
X-Google-Smtp-Source: AFSGD/WzzYdKUiN+mHiqO1uy6kfTCG72BEYSfUHQGU+a9tzK8Rc55HM/2nSM418vT43qkyK3CtQhFQxDEfprdidy9P0=
X-Received: by 2002:adf:91a3:: with SMTP id 32mr12280891wri.99.1545122201042;
 Tue, 18 Dec 2018 00:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20181130080207.20505-1-anup@brainfault.org> <20181130080207.20505-5-anup@brainfault.org>
 <20181217182812.GD7086@infradead.org>
In-Reply-To: <20181217182812.GD7086@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 18 Dec 2018 14:06:29 +0530
Message-ID: <CAAhSdy05S1SSOC3e1r9ULrjFyGEquR50TKqvKQN8OFxVdgEdtg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] irqchip: sifive-plic: Add warning in plic_init()
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

On Mon, Dec 17, 2018 at 11:58 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Nov 30, 2018 at 01:32:05PM +0530, Anup Patel wrote:
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
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index d4433399eb89..3d4f205f8abe 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -234,6 +234,11 @@ static int __init plic_init(struct device_node *node,
> >
> >               cpu = riscv_hartid_to_cpuid(hartid);
> >               handler = per_cpu_ptr(&plic_handlers, cpu);
> > +             if (handler->present) {
> > +                     pr_warn("handler not available for context %d.\n", i);
> > +                     continue;
> > +             }
>
> Shouldn't this be something like "handler already present.."

OK, I will re-phrase it.

>
> Otherwise this looks fine:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Regards,
Anup
