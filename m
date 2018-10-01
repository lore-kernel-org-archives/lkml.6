Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433AAC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F001621477
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Tzat2iel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F001621477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbeJAXVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:21:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33606 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJAXVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:21:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id y18-v6so9885456pge.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=EP0D+xKiYmwTMZCIYZJa1cvzQbdjSkNEBgbTXnpOkDQ=;
        b=Tzat2iel/22ETgOGvxHN40ayowqas6whI2GcF79SC5nNGy2hli6VhX53kNSg5l00p6
         IWENyAtscnoAxesc7i3XtfYLboZVfh1uaDHcyLIGPkNVR61pCQ3oR5oqrDaH9PdQA8In
         PmslhSf5SfJsDsGbAbM1rtpVZJ4pkGmvUWCDswZD6tizL7bIE9/HPEBoYmH/Y+01aj4L
         SirZIOEvCue4di/jUh1ctkttvYye9iNkRBWhI6Ws18etEpM/qUlczUHssg+xx9RZYGcc
         hZPBrhQ6ExTaOZxZt8l5ItdU8VNDkO0QbP5NKgz9PGY2Tjh3uoEA6zsOte/cVaGSALn/
         UggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=EP0D+xKiYmwTMZCIYZJa1cvzQbdjSkNEBgbTXnpOkDQ=;
        b=tHo9JTUNziE6W/bct1A5Axr1Td9+Oir9wGVaMRZuZyPkhkFzrHSv6YUSmnhFzIxOAT
         SfGz+JiuBMgKbip/4P07zEjsMgE8eTTLSXyypAHRiwEKm0HFT3P1YcLbGnf+Ow6G9vAi
         1mNU5qW0Gb1DVO4/4FsWA7lDNiI8qTpXV5+oYmX3wjIVq3nZo0XN3OrjAWUhazJovHtf
         ls+V6pAVx2IdBZ/eb/D8hG/AWQeXbXMzvXHjxZKd1SlxzEhw10ZNEA+f6mQuyg9sZH7j
         QaFUSJ57CvBqneNqj31dZScrwQDYBfsnil+TXDQeuk2ffh55IMHaoAm2fhVHUBKfxv6f
         DyMA==
X-Gm-Message-State: ABuFfohBkpq6jGLifeE3tJD0khcdVdc0meS9oh4REAAcKrUEieUfiAgf
        AjMWhQZmZ1NOAQYGeVeElCXBaw==
X-Google-Smtp-Source: ACcGV62d1RM1Y93A+q9UiCoVughBP4r7XczJueKxfC0tE/W7/FZgzW0jcmZVeq63qRdt3GGNYKNkKg==
X-Received: by 2002:a17:902:6907:: with SMTP id j7-v6mr12627684plk.232.1538412159081;
        Mon, 01 Oct 2018 09:42:39 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id a1-v6sm28316459pfc.28.2018.10.01.09.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 09:42:37 -0700 (PDT)
Date:   Mon, 01 Oct 2018 09:42:37 -0700 (PDT)
X-Google-Original-Date: Mon, 01 Oct 2018 09:40:03 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Show IPI stats
In-Reply-To: <CAAhSdy0wd7LN1tb5oRkgYbxeR=Yb3LomUtTcym1dhyO6wa+a9g@mail.gmail.com>
CC:     Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-34a3263b-002e-4301-ae67-47e19c44449f@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 23:09:56 PDT (-0700), anup@brainfault.org wrote:
> On Sat, Sep 29, 2018 at 7:15 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Mon, 10 Sep 2018 06:46:59 PDT (-0700), Christoph Hellwig wrote:
>> > On Fri, Sep 07, 2018 at 06:14:29PM +0530, Anup Patel wrote:
>> >> This patch provides arch_show_interrupts() implementation to
>> >> show IPI stats via /proc/interrupts.
>> >>
>> >> Now the contents of /proc/interrupts" will look like below:
>> >>            CPU0       CPU1       CPU2       CPU3
>> >>   8:         17          7          6         14  SiFive PLIC   8  virtio0
>> >>  10:         10         10          9         11  SiFive PLIC  10  ttyS0
>> >> IPI0:       170        673        251         79  Rescheduling interrupts
>> >> IPI1:         1         12         27          1  Function call interrupts
>> >> IPI2:         0          0          0          0  CPU wake-up interrupts
>> >>
>> >> Signed-off-by: Anup Patel <anup@brainfault.org>
>> >
>> > Thanks, this looks pretty sensible to me.  Maybe we want to also show
>> > timer interrupts if we do this?
>>
>> IIRC we used to have some issue where the timer interrupt ID in
>> /proc/interrupts aliased with a possible PLIC interrupt ID, but that was back
>> when we had a big mess of chained interrupt drivers that didn't really talk to
>> each other.  I think at some point I might have just removed the timer
>> interrupt from /proc/interrupts as a hack, but now that our interrupt
>> controller mess is sorted out it'd be better to have it.
>
> If we have irqdomain and irqchip for HLIC then showing timer interrupts
> becomes cleaner. My RISCV INTC patch achieves this.
>
>>
>> I'm fine taking this without the timer interrupts, as something is better than
>> nothing.
>
> Sure.
>
>>
>> >> --- a/arch/riscv/kernel/irq.c
>> >> +++ b/arch/riscv/kernel/irq.c
>> >> @@ -8,6 +8,7 @@
>> >>  #include <linux/interrupt.h>
>> >>  #include <linux/irqchip.h>
>> >>  #include <linux/irqdomain.h>
>> >> +#include <linux/seq_file.h>
>> >>
>> >>  /*
>> >>   * Possible interrupt causes:
>> >> @@ -24,6 +25,14 @@
>> >>   */
>> >>  #define INTERRUPT_CAUSE_FLAG        (1UL << (__riscv_xlen - 1))
>> >>
>> >> +int arch_show_interrupts(struct seq_file *p, int prec)
>> >> +{
>> >> +#ifdef CONFIG_SMP
>> >> +    show_ipi_stats(p, prec);
>> >> +#endif
>> >> +    return 0;
>> >> +}
>> >
>> > If we don't also add timer stats I'd just move arch_show_interrupts
>> > to smp.c and make it conditional.  If we don't this split might make
>> > more sense.
>>
>> Makes sense, but I think timer interrupts are more interesting to see than IPIs
>> so we'll eventually pipe them through.  Might just be my workloads, though :)
>>
>> >> +static const char *ipi_names[IPI_MAX] = {
>> >> +    [IPI_RESCHEDULE] = "Rescheduling interrupts",
>> >> +    [IPI_CALL_FUNC] = "Function call interrupts",
>> >> +    [IPI_CALL_WAKEUP] = "CPU wake-up interrupts",
>> >> +};
>> >
>> > No need for the explicit array size.  Also please use a few tabs to
>> > align this nicely:
>> >
>> > static const char *ipi_names[] = {
>> >       [IPI_RESCHEDULE]        = "Rescheduling interrupts",
>> >       [IPI_CALL_FUNC]         = "Function call interrupts",
>> >       [IPI_CALL_WAKEUP]       = "CPU wake-up interrupts",
>> > };
>>
>> I don't see a v2 of this, was there one?  If not then I'll just clean up
>> ipi_names and drop this on for-next.
>>
>> Thanks for the patch!
>
> I will send v3 patch because IPI_CALL_WAKEUP is not going to be available.
>
> I will base v3 patch upon v5 of Atish's patchset. Atish will take v3 of this
> patch and make it part of his v6 patchset so that it will be easy for you
> to apply.

Thanks!
