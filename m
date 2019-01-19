Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3054AC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 11:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7C72084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 11:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="OpIQBQ3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfASLpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 06:45:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37821 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfASLpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 06:45:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so18106046wrt.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 03:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+vwESvPsUPWdfsIpmSo7CLXk62e+AihcYNrgiKP4BLQ=;
        b=OpIQBQ3NSuf6//MCRyI6qaPtJyGFEDxT1a4VxytfAnf8yf8s1fUWao8ldyI+H9Vjud
         eNB0nlCawXuyFdY3BcVNx9O1QZnGHP0SvASh2yezB+c+GKKLxD+D+op3xfzs3AlvKwgG
         Ljd+GVWRq8La+o7AabLJSJK29D7rrWXaJ3NFeM7W2B9pcmtKO4GRJBqDo8xu6siEbqKQ
         hf7sJTp3Jdfvc88qSdmy1LeZOCCs6F5Q0j1ZwN/bIesN/5lfqhw5qWFVvA+gOH5TIsCA
         y1lvnpJzGZdeRLZP70fP0hnijSyRooLiebwZGX4oZ167UHO9lDOHvYXPkzyQ8J9aIudu
         /B2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vwESvPsUPWdfsIpmSo7CLXk62e+AihcYNrgiKP4BLQ=;
        b=lAbdGARLW6gYZxbBcSfagO6y4z9Jf/uUVhDR/jyzVxObZyPA+yl8WzH5lUsYzYwpY7
         O8ZHvYrVwQetsLPDuebn7kMrBIIhRz19W4r2EU7ILmY/6amV8ydymMMavuImPfBq1hmU
         LITZQpRJuv5BpGWWyYb2RApU4quKibBHSG7H366HhRoIxiVOIKR/zl6dnMUiccx3+4G1
         +VlMDJyAP55ZWTUh8UY7/pgYDZU18mdY4377YVT51cdUgDIlEjugq9Cw57wJF3dnHYXX
         CJP2NObWb8KOPhsV9b9QlTwvsOICii7rLhHkBDrKinlbILrucLPjtdffMOY+tOAZxtmw
         I29w==
X-Gm-Message-State: AJcUukfY2csEjBewrwUaQ7OqrWfrYCwcEXAxhgwnxa6JUcLA2OKrCVWh
        kluE+N7OzEZkUg5WaAMoFsIUIdG+6rI0oSnclJVdMQ==
X-Google-Smtp-Source: ALg8bN69SN2/62L2WE9uHPe+C1tCbhqKYQmuUgsN2yf0vNo5uCkeHMUuRGCD4glW1ctt9fG9CfepzW/OcOHFlV+1cxQ=
X-Received: by 2002:adf:f785:: with SMTP id q5mr19369498wrp.9.1547898306356;
 Sat, 19 Jan 2019 03:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20190107161047.10516-1-anup@brainfault.org> <20190107161047.10516-6-anup@brainfault.org>
 <20190115134746.GF13216@infradead.org>
In-Reply-To: <20190115134746.GF13216@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 19 Jan 2019 17:14:55 +0530
Message-ID: <CAAhSdy2Fzj08+Tdog1Z907=mr8Th0CYvE+fM1kFpii=GcTeTnw@mail.gmail.com>
Subject: Re: [PATCH 5/5] RISC-V: Implement compile-time fixed mappings
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 7:17 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jan 07, 2019 at 09:40:47PM +0530, Anup Patel wrote:
> > From: Anup Patel <anup.patel@wdc.com>
> >
> > This patch implements compile-time virtual to physical
> > mappings. These compile-time fixed mappings can be used
> > by earlycon, ACPI, and early ioremap for creating fixed
> > mappings when FIX_EARLYCON_MEM=y.
> >
> > To start with, we have enabled compile-time fixed
> > mappings for earlycon.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  arch/riscv/Kconfig              |  3 ++
> >  arch/riscv/include/asm/fixmap.h | 52 +++++++++++++++++++++++++++++++++
> >  arch/riscv/mm/init.c            | 32 ++++++++++++++++++++
> >  3 files changed, 87 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/fixmap.h
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index e0d7d61779a6..66094aba9a59 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -86,6 +86,9 @@ config GENERIC_CSUM
> >  config GENERIC_HWEIGHT
> >       def_bool y
> >
> > +config FIX_EARLYCON_MEM
> > +     def_bool y
> > +
>
> Can you please throw in a prep patch to move FIX_EARLYCON_MEM to
> drivers/tty/serial/Kconfig and only select it from the architectures
> that use it?

Implementing fixmap is totally optional for architectures so it
makes sense to have FIX_EARLYCON_MEM as architecture
specific kconfig option. There are many such architecture specific
options provided as "def_bool y" in arch/<xyz>/Kconfig. Also,
having such "def_bool y" kconfig options in arch/<xyz>/Kconfig
gives us idea about optional features implemented by <xyz>
arch support.

I don't agree with this suggestion. If you still feel this is right way
to go then please go ahead and send patch to move
FIX_EARLYCON_MEM option in drivers/tty/serial/Kconfig.

>
> > + * fixmap.h: compile-time virtual memory allocation
>
> No need to mention the header name.

Sure, will remove header name.

>
> > + */
> > +
> > +#ifndef _ASM_RISCV_FIXMAP_H
> > +#define _ASM_RISCV_FIXMAP_H
> > +
> > +#ifndef __ASSEMBLY__
>
> As far as I can tell we never include this header from assembly files,
> so this ifdef should not be needed.
>
> > +/*
> > + * Here we define all the compile-time 'special' virtual
> > + * addresses. The point is to have a constant address at
> > + * compile time, but to set the physical address only
> > + * in the boot process.
> > + *
> > + * These 'compile-time allocated' memory buffers are
> > + * page-sized. Use set_fixmap(idx,phys) to associate
> > + * physical memory with fixmap indices.
> > + */
>
> Please use up the available 80 chars per line for comments.

Regards,
Anup
