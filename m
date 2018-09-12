Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACD6C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5441E206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="U8FsUs6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5441E206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbeILJgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 05:36:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38213 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeILJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 05:36:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so464345wrc.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 21:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s5revAGdcgwwzMsVyObx5m2/n5lDDpzS9zyAF6+/hO4=;
        b=U8FsUs6B5hvnUlYGvqtbC0wz5oMC7Z0NR6ecUrmRCyQRJLitAUpExrzhiMF6gEJshy
         BYarh09g3OvkhkvzthjUtxI2X2xF3qJm2cUxrne5nElq1hnTPFighZKsbDEKAnBP5aLr
         QUIrykU/z808zhbSwA2TBYZR55hbN16YDyY6fVyGyoEBhkS4INw9X5xVRrrY8PV8gTsO
         9yXZIWl/VAyFBo90UmVnNkwRox03+ZSJm7NmMp1XovmnJ55q5fPEKbDoPwvqZFrEOStU
         9DVpdlvpZsimk6vVhvnPPxNpbB7KmdgbxAGImAet8g3L9VnNYkC93zRg1QqMKISJB47p
         Vgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s5revAGdcgwwzMsVyObx5m2/n5lDDpzS9zyAF6+/hO4=;
        b=RNa565ycO1Esx8hRP8ZlZe4qad4ajaBkOif08olXqWXDDEBFAtLBsolyDgl1UwiyPz
         +WAqE0yElXD6i7rfq/Ts89rvh+4SaRWEl8X7Y3ts/v+n6GelbHhLjvseSi7HvY2vYbXG
         JysJHbzCvwWMZX6/yPSmJxzwO8io5Ag0lkdPWOYjNljOZGHNlNZCRxvhZpeGkk2T13cW
         qnrYntkxTSQvTzgEeHSbuJmrhA9h9KZb+C7NEUgxdno+8aD30T1vMfqTAr+Bny21sksr
         3i46BuapNe2cZXVo5PIqUeBt6xylLI6b4gFEe2nvf845t98OduzJzHuHotUdadWlFLo4
         tNpQ==
X-Gm-Message-State: APzg51Bo4qkdYXnB5UXNPSJ8vmmULbuk2FaSb56dDAQvw3AA6Jto+7Cg
        Qqa1y77Py9Ba2IZyBffUaK+lBtIO4+vhAuEMYGBe7g==
X-Google-Smtp-Source: ANB0Vdaldu7SryLTsbNmMq+ah5TY62w305xuXDoclsELB0FDWCmcnH50QuAJr1o3Ec5yr5xzlaN2Rmgx0EJ38/IqdvQ=
X-Received: by 2002:a5d:6550:: with SMTP id z16-v6mr28352wrv.194.1536726837365;
 Tue, 11 Sep 2018 21:33:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 21:33:56
 -0700 (PDT)
In-Reply-To: <20180910134659.GA30774@infradead.org>
References: <20180907124429.31407-1-anup@brainfault.org> <20180910134659.GA30774@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 12 Sep 2018 10:03:56 +0530
Message-ID: <CAAhSdy3bGHdCX82r5FDqwRXUZZv-9DZDK9fNGVrxntdOGV36zA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Show IPI stats
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
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

On Mon, Sep 10, 2018 at 7:16 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Sep 07, 2018 at 06:14:29PM +0530, Anup Patel wrote:
>> This patch provides arch_show_interrupts() implementation to
>> show IPI stats via /proc/interrupts.
>>
>> Now the contents of /proc/interrupts" will look like below:
>>            CPU0       CPU1       CPU2       CPU3
>>   8:         17          7          6         14  SiFive PLIC   8  virtio0
>>  10:         10         10          9         11  SiFive PLIC  10  ttyS0
>> IPI0:       170        673        251         79  Rescheduling interrupts
>> IPI1:         1         12         27          1  Function call interrupts
>> IPI2:         0          0          0          0  CPU wake-up interrupts
>>
>> Signed-off-by: Anup Patel <anup@brainfault.org>
>
> Thanks, this looks pretty sensible to me.  Maybe we want to also show
> timer interrupts if we do this?

Let's not include timer stats here until RISCV INTC driver is
concluded. We can do it as separate patch if required.

>
>> --- a/arch/riscv/kernel/irq.c
>> +++ b/arch/riscv/kernel/irq.c
>> @@ -8,6 +8,7 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/irqchip.h>
>>  #include <linux/irqdomain.h>
>> +#include <linux/seq_file.h>
>>
>>  /*
>>   * Possible interrupt causes:
>> @@ -24,6 +25,14 @@
>>   */
>>  #define INTERRUPT_CAUSE_FLAG (1UL << (__riscv_xlen - 1))
>>
>> +int arch_show_interrupts(struct seq_file *p, int prec)
>> +{
>> +#ifdef CONFIG_SMP
>> +     show_ipi_stats(p, prec);
>> +#endif
>> +     return 0;
>> +}
>
> If we don't also add timer stats I'd just move arch_show_interrupts
> to smp.c and make it conditional.  If we don't this split might make
> more sense.

I understand you want to avoid #ifdef here. We can do same thing
by having empty inline function show_ipi_stats() in asm/smp.h for
!CONFIG_SMP case. This way we can keep arch_show_interrupts()
in kernel/irq.c which is intuitively correct location for
arch_show_interrupts().

>
>> +static const char *ipi_names[IPI_MAX] = {
>> +     [IPI_RESCHEDULE] = "Rescheduling interrupts",
>> +     [IPI_CALL_FUNC] = "Function call interrupts",
>> +     [IPI_CALL_WAKEUP] = "CPU wake-up interrupts",
>> +};
>
> No need for the explicit array size.  Also please use a few tabs to
> align this nicely:
>
> static const char *ipi_names[] = {
>         [IPI_RESCHEDULE]        = "Rescheduling interrupts",
>         [IPI_CALL_FUNC]         = "Function call interrupts",
>         [IPI_CALL_WAKEUP]       = "CPU wake-up interrupts",
> };

Sure, will do.

Regards,
Anup
