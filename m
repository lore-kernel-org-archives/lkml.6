Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613F4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A1E21527
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="QRriG82f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A1E21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbeKLOSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:18:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53819 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730558AbeKLOSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:18:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id f10-v6so7041540wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 20:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/sS9qOFTYQqdHnYlhyaiAgHwrmTJ+8DMJ1q1QxhUg5U=;
        b=QRriG82frU04AGrJaiFSzp+hEk19z0jPwwCzfmI8CQRiR3V7S5SAAehM15bJTJvIJv
         GQ+78OZAcasGnt2qonN20tjzJT8X+ZcuPoFDzrfiDmaVRJHGPFohd6NR/v4GNTAPqjrl
         mxz0khZV3JMCnDseVM6rBRMGHpS/U7cmbiLsmKW7EoKTby6lPdhdZHsxTInhERBJ0XTS
         g9uJl/go4UQXZB8GUJ7+62ObZUPv+6C51bSSi2D2KeOX6Co/z/mEwJKHZ9aJ6RtRLMf1
         CShlvTDLxiqVcablIHWzmQmyb8Xfxsz3Ze9J3ZQ6e4suYsGX6UCWwHgOwWh7QncPLl7C
         /ECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/sS9qOFTYQqdHnYlhyaiAgHwrmTJ+8DMJ1q1QxhUg5U=;
        b=iJkQcqgag+SeORyD2EIsk0tFRcc8HHv0LPeppbgElDhgUpEfGsIDmMgG3TjSSNZ27R
         xnfALRQ2CgtQqXS0BZC0Ars2pE2vh32+aaFMWP/HxZAOnkntG3/yxtWF+SSGsA/+ldKt
         q5mgmZ6svC4UxoNR0u/4ty8pZIa7qQaOp4pZ/csKFPor4qeAltrnzZtxzyVuBOaoD8GS
         yVdYivu8wWjLOtROVbAUbH+VFJsLEQ21k9JfgQQNigmiQmdSlvX4phfUSBT+qM/wxeAg
         Q6nys41c0rT2besHYZl36y0TDVxKPijXOv3UodGS+BPPhu+OxKtDMRvYVyTpBaWsCnxh
         P6vw==
X-Gm-Message-State: AGRZ1gKlfw4iNc5fe5AZSBx/fFjH8kQ9GR2BaQ4LYfrDOHLMtd9ZT10f
        aDs+gHbgINVl70UkuO0EIXorckfHFg8ug1MB0kR7Rg==
X-Google-Smtp-Source: AJdET5cMH0+g7JBAzS2J859iZLccU2w7wtag+dxlauCP9gsUSYyJc9YieoCOQViTKJ6WJe0mFpZg69/WzQQac7w6RRk=
X-Received: by 2002:a1c:d785:: with SMTP id o127-v6mr445176wmg.56.1541996831267;
 Sun, 11 Nov 2018 20:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20181022114517.22748-1-anup@brainfault.org> <20181022114517.22748-2-anup@brainfault.org>
 <20181109084256.GA6508@infradead.org>
In-Reply-To: <20181109084256.GA6508@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 12 Nov 2018 09:57:02 +0530
Message-ID: <CAAhSdy1dYGShvtUEdDARw_8viC5P5MdMLBQOhe56nu6TMNgGaA@mail.gmail.com>
Subject: Re: [PATCH 1/4] irqchip: sifive-plic: Pre-compute context hart base
 and enable base
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

On Fri, Nov 9, 2018 at 2:12 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Oct 22, 2018 at 05:15:14PM +0530, Anup Patel wrote:
> > This patch does following optimizations:
> > 1. Pre-compute hart base for each context handler
> > 2. Pre-compute enable base for each context handler
>
> Why?

This is micro-optimizations. We don't need to re-compute
hart base and hart enable base everytime.

>
> > 3. Have enable lock for each context handler instead
> > of global plic_toggle_lock
>
> Why?  Also even if you want this it should be a separate patch.

Well, the PLIC register space it a bit strange.

Most PLIC context specific registers are in one place
except context IRQ enable registers which are part of
global registers.

To handle this, we had a global plic_toggle_lock which
was taken whenever PLIC driver touched context IRQ
enable registers. Instead of this, we can have per-context
IRQ enable lock for more granular locking.

Later when we implement IRQ set_affinity, we touch
IRQ enable registers of each context whenever IRQ
affinity changes. This fine grained IRQ enable locking
helps when IRQ load-balancer is changing affinity of
different IRQs parallely on separate cores. Again this
is a micro-optimization.

>
> >  #define PRIORITY_BASE                        0
> > -#define     PRIORITY_PER_ID          4
> > +#define PRIORITY_PER_ID                      4
>
> Also please drop the random whitespace changes.

Instead of dropping I will make it separate patch because
we are replacing "\t" between #define and define_name
with a space.

Regards,
Anup
