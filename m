Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0395C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2B8206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="LDRgqzle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2B8206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeI2MhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:37:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51941 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeI2MhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:37:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id y25-v6so4049247wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 23:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3D8Y6zyD7LVQkB9N5FDdMXNRGrFbt3AOb+aP/R6T8I=;
        b=LDRgqzlevwNnl/IivujS6Kcj+D/iT2Z5ZNCOwNFLw1mfz42gI8r7KSRVvslE256eIn
         sovi1XNlNoIrDIAj0BMC9p+8q891rQ48Or6H7d982EKapWpoTe6Y6J2wRBCEL2TIg+MK
         HWw3QooZUeNvTo7ryxts54EXhMc2btk0/d8HkIzE/0GcvBhWTh/xmxFuKObOHSfhg13m
         gNNqqEqqh2Poc5ixHAUFH3L9lAO52v0yXerpzfWW3uPb658t7dfb6AqtO+8pMESa17fV
         cUsGOBfXyp5miJ/M5OapPHQhuwiEQ6CTDI7gOYb4AEXgvT6OMX+dlhE4bP5vT+S9It18
         OE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3D8Y6zyD7LVQkB9N5FDdMXNRGrFbt3AOb+aP/R6T8I=;
        b=T6HhRJzwb6CNEhkVKBJH5kMmjMf5ibsO866K0WfTz2jj0/FlmLj3yqDUDeuMxjgHyM
         ayJNmo3c6jZlUEBUV8Svt/uomquV4msgxItY380KuHMjPuoxVFhNWN1dYQHs8MAXGfb+
         s412No8n8jKgsdn/9GSW1wfrmrWeOTrkre07QKAUExy6KMAxNlLKOP356m2cVJBlCGM1
         vI73SfII5q59Hevp7c94TdIlgeFvyu8hkPgbBoWcUdj8jSBBs229vn77CVu6X01kS8CU
         1Rw7YTG10GjQ2Bin38S2qoI8+tL36RGE7bH2F3wrhzb39rQUWM3ik9ikHYZxZQ49AMyV
         pfyA==
X-Gm-Message-State: ABuFfoiMf0K+Jc+Z1vafSzwtdJh+uoTz8Zd5Vdi232BB/wJTrcxamiuK
        kbl9sM6IPYkYUdhTykx+inupE69AENEk3ACYCNmX+g==
X-Google-Smtp-Source: ACcGV61r5ZlHdxtrbiVeVVAtGl90MQr+lTJXlhroo44wFv9EOnQX5ZjTtP4qmCPe2ki47KL3wg+yIvHiEnS8ZpLv/3k=
X-Received: by 2002:a1c:1fc2:: with SMTP id f185-v6mr737302wmf.18.1538201407189;
 Fri, 28 Sep 2018 23:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180910134659.GA30774@infradead.org> <mhng-2395876e-5470-45f9-83e1-4abae5188b0c@palmer-si-x1c4>
In-Reply-To: <mhng-2395876e-5470-45f9-83e1-4abae5188b0c@palmer-si-x1c4>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 29 Sep 2018 11:39:56 +0530
Message-ID: <CAAhSdy0wd7LN1tb5oRkgYbxeR=Yb3LomUtTcym1dhyO6wa+a9g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Show IPI stats
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 7:15 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 10 Sep 2018 06:46:59 PDT (-0700), Christoph Hellwig wrote:
> > On Fri, Sep 07, 2018 at 06:14:29PM +0530, Anup Patel wrote:
> >> This patch provides arch_show_interrupts() implementation to
> >> show IPI stats via /proc/interrupts.
> >>
> >> Now the contents of /proc/interrupts" will look like below:
> >>            CPU0       CPU1       CPU2       CPU3
> >>   8:         17          7          6         14  SiFive PLIC   8  virtio0
> >>  10:         10         10          9         11  SiFive PLIC  10  ttyS0
> >> IPI0:       170        673        251         79  Rescheduling interrupts
> >> IPI1:         1         12         27          1  Function call interrupts
> >> IPI2:         0          0          0          0  CPU wake-up interrupts
> >>
> >> Signed-off-by: Anup Patel <anup@brainfault.org>
> >
> > Thanks, this looks pretty sensible to me.  Maybe we want to also show
> > timer interrupts if we do this?
>
> IIRC we used to have some issue where the timer interrupt ID in
> /proc/interrupts aliased with a possible PLIC interrupt ID, but that was back
> when we had a big mess of chained interrupt drivers that didn't really talk to
> each other.  I think at some point I might have just removed the timer
> interrupt from /proc/interrupts as a hack, but now that our interrupt
> controller mess is sorted out it'd be better to have it.

If we have irqdomain and irqchip for HLIC then showing timer interrupts
becomes cleaner. My RISCV INTC patch achieves this.

>
> I'm fine taking this without the timer interrupts, as something is better than
> nothing.

Sure.

>
> >> --- a/arch/riscv/kernel/irq.c
> >> +++ b/arch/riscv/kernel/irq.c
> >> @@ -8,6 +8,7 @@
> >>  #include <linux/interrupt.h>
> >>  #include <linux/irqchip.h>
> >>  #include <linux/irqdomain.h>
> >> +#include <linux/seq_file.h>
> >>
> >>  /*
> >>   * Possible interrupt causes:
> >> @@ -24,6 +25,14 @@
> >>   */
> >>  #define INTERRUPT_CAUSE_FLAG        (1UL << (__riscv_xlen - 1))
> >>
> >> +int arch_show_interrupts(struct seq_file *p, int prec)
> >> +{
> >> +#ifdef CONFIG_SMP
> >> +    show_ipi_stats(p, prec);
> >> +#endif
> >> +    return 0;
> >> +}
> >
> > If we don't also add timer stats I'd just move arch_show_interrupts
> > to smp.c and make it conditional.  If we don't this split might make
> > more sense.
>
> Makes sense, but I think timer interrupts are more interesting to see than IPIs
> so we'll eventually pipe them through.  Might just be my workloads, though :)
>
> >> +static const char *ipi_names[IPI_MAX] = {
> >> +    [IPI_RESCHEDULE] = "Rescheduling interrupts",
> >> +    [IPI_CALL_FUNC] = "Function call interrupts",
> >> +    [IPI_CALL_WAKEUP] = "CPU wake-up interrupts",
> >> +};
> >
> > No need for the explicit array size.  Also please use a few tabs to
> > align this nicely:
> >
> > static const char *ipi_names[] = {
> >       [IPI_RESCHEDULE]        = "Rescheduling interrupts",
> >       [IPI_CALL_FUNC]         = "Function call interrupts",
> >       [IPI_CALL_WAKEUP]       = "CPU wake-up interrupts",
> > };
>
> I don't see a v2 of this, was there one?  If not then I'll just clean up
> ipi_names and drop this on for-next.
>
> Thanks for the patch!

I will send v3 patch because IPI_CALL_WAKEUP is not going to be available.

I will base v3 patch upon v5 of Atish's patchset. Atish will take v3 of this
patch and make it part of his v6 patchset so that it will be easy for you
to apply.

Regards,
Anup
