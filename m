Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF535C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C8A20647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="qtVMd4zg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C8A20647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeGZEwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 00:52:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40508 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeGZEwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 00:52:47 -0400
Received: by mail-wm0-f68.google.com with SMTP id y9-v6so466615wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 20:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vbSlzqOTIYV4ZYP1HsjWbxsyNi/Vrqffqj98+AEo8+A=;
        b=qtVMd4zgDIxYm3I1oIWg4/HldJkKMV1pXhHiw+ZudZKnQcf1I5zFQux1ZGg1rcoPsG
         gitKaoIIptvbFROKTHVccLG+E7uYIGsRqw2fNS9QlYMn66i8RfLKPFyiIDCMvzMXCFOZ
         gr/8uTto8d4zvu4srSSwVA6DOSOdEOgh7PwZ/9ZCOEnAcaPsQqJA/+zISzChvJlbm3mA
         BEdO2e4rS1qXEDyq8ekISuV0Z0cF0ILGhlpisQabKV+na1kNJ7ULa8LWNZ34J0oAINHT
         bJVtm0U70OlULw6OaTXD9twaqB9dkM3c8H8g/4ZH1wFeBwbBLlTqR5zx4oX4u5KumEc5
         sWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vbSlzqOTIYV4ZYP1HsjWbxsyNi/Vrqffqj98+AEo8+A=;
        b=pAc/6kPC7qoY+jn21LaJVen7UqpIcbVbs+GrM7EGvxSiy2TB3HS865znGzfwaPiemU
         8c3JDD0Xj12fwU1jpg3tVP4sHF5d808tKwATieDElyqz2HoeBaMdhsna9rWV3PLUV2SW
         4uEJXv5KNECLxXuJrc9OR8G72up1pMXKOP/vjMQ6bdsiegW2/0EBLZPBVQGiksMEov33
         s37L1MbLXLjIcy2y9ABnwRTeRFox1zEszDFPHARlu6K4FGmuwt9oM1r0KtCjRrzW911e
         IzK2lX9guEPFL47GeScv/bTS00fXsuxVjTXPkl6cuuMK6ejmsff+cmGolHMxAyB9Nkss
         9epg==
X-Gm-Message-State: AOUpUlE4ZhkIUY9s0rMLQ6OESPsy4ttQNGjWcWbZJMcdGWrN5nOG660C
        Ps3BYEpfGzr/AV6RAhL3d4WRixh0B0WZZVGp5IydVg==
X-Google-Smtp-Source: AAOMgpeC/Sw2hBOpCTTR2Dprc1tDVKuKiHxhBOzTp1tVX2+VP5wkN0ogZ+N5Bmgv7h+XtS/z8vNH79mRDvy+IwfleCg=
X-Received: by 2002:a1c:8a04:: with SMTP id m4-v6mr307687wmd.137.1532576280888;
 Wed, 25 Jul 2018 20:38:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dd2:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 20:38:00
 -0700 (PDT)
In-Reply-To: <20180725112457.GA24502@lst.de>
References: <20180725093649.32332-1-hch@lst.de> <20180725093649.32332-4-hch@lst.de>
 <c3ccb953-cd75-4a37-636a-ca643602053a@arm.com> <20180725112457.GA24502@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 26 Jul 2018 09:08:00 +0530
Message-ID: <CAAhSdy31=D3jOgvrc+Td-TeKQMazPA-suFjOy9XwEuima1WdeA@mail.gmail.com>
Subject: Re: [PATCH 3/6] irqchip: RISC-V Local Interrupt Controller Driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, palmer@sifive.com,
        jason@lakedaemon.net, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, shorne@gmail.com,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 4:54 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Jul 25, 2018 at 12:18:39PM +0100, Marc Zyngier wrote:
>> This feels odd. It means that you cannot have the following sequence:
>>
>>       local_irq_disable();
>>       enable_irq(x); // where x is owned by a remote hart
>>
>> as smp_call_function_single() requires interrupts to be enabled.
>>
>> More fundamentally, why are you trying to make these interrupts look
>> global while they aren't? arm/arm64 have similar restrictions with GICv2
>> and earlier, and treats these interrupts as per-cpu.
>>
>> Given that the drivers that deal with drivers connected to the per-hart
>> irqchip are themselves likely to be aware of the per-cpu aspect, it
>> would make sense to align things (we've been through that same
>> discussion about the clocksource driver a few weeks back).
>
> Right now the only direct consumers are said clocksource, the PLIC
> driver later in this series and the RISC-V arch IPI code.  None of them
> is going to do a manual enable_irq, so I guess the remote case of the
> code is simply dead code.  I'll take a look at converting them to
> per-cpu.  I guess the GICv2 driver is the best template?

Actually, RISCV HLIC and PLIC are very similar to RPi2 and RPi3 SOCs.

On RPi2 and RPi3, we have per-CPU BCM2836 local intc and the global
interrupts are managed using BCM2835 intc. You should certainly have
a look a this drivers because these very simple compared to GICv2 and
GICv3 drivers.

Regards,
Anup
