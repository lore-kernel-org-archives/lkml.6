Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F33C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B7020659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="wxsB0wI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B7020659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeIFQ2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:28:17 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54216 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeIFQ2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:28:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id b19-v6so11136347wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zLTEo141ZE19pDg1bmWzzdSUO8eQ9ehKN/z9pGNtg9M=;
        b=wxsB0wI1hUOp69MNcGh0ykrOhk3nUyt6kionpwqOb8J0D4ZnYz/G/kxmEJ7wqwbkCr
         PPDrHK7BCNWi1giL54r3p07vTEeOaJi1d1h+baE8R9M4dR8EF3+9TaNFFcHFlbK14p0D
         O5tsHqc3SqeByqM0MTLU5XI1g2GWJW9eRofd8akJc6soEMHV1qiHDvaJ6t64lCZBS5Z1
         Fmrf2VILvdY9jE3QmzZG8BGaIVYm/Ui1SYAeTcmKj0W+DfW7QyXSM4qmDFbeZuwYrUB3
         K0XH3pv0fK7ptKWn3ocJOIH1DE2k4GkOSxIGeJ3S3qS32oHI+gtJQBWKjSawJy/k4bxL
         CGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zLTEo141ZE19pDg1bmWzzdSUO8eQ9ehKN/z9pGNtg9M=;
        b=lqlWKs1zX87eEEkQtc8+SkYxwKXcBa48CnPErKLPmF1XrInLMZOG8rxw60aKty6v46
         yuKlKoUV7QiKlujBBnBq9ZERuJqwQWJ8KpYv/D+C4vzrqJm6XwUk2cMtfMCYhOdALzTM
         Hlqmi79VFS+0I2ESLXu3lOulqJvzkFIfy3MbR3JOBVKbkwXh44TL5uEY+LxGxa3QkVFp
         Etwbm9/ZdApI7ATydBdmuRF+CsmfOWZWLPXU9IX1wbDvRNp3LWyxmmvoqqH9KUBDi0zW
         0OuhToy9GmW0PsL79RRrLKxmo7Ax766S5lli1Kcz04itrqOy8vQ1VVdbsoocbXu6Wbpu
         8jkA==
X-Gm-Message-State: APzg51A1T1eui2wKa9mo+2Xw+KOd+2FU2/N2Sf9TexBjsacH2fkuaFM8
        kBBwtbslQAlygBLBp+DDnP8288IgwCancQnLnzdJTg==
X-Google-Smtp-Source: ANB0VdbVNZxPmVCMF0GewxnS3F56rQaSLd4LwksL8dhZRSbudOpfw5K/CQXsL6j0IUZXiP2qa2FtPZPpRGSNLRqUr9g=
X-Received: by 2002:a1c:1745:: with SMTP id 66-v6mr1809461wmx.38.1536234788315;
 Thu, 06 Sep 2018 04:53:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 04:53:07 -0700 (PDT)
In-Reply-To: <20180905185838.GC15741@infradead.org>
References: <20180904124514.6290-1-anup@brainfault.org> <20180904124514.6290-5-anup@brainfault.org>
 <20180904185755.GD25119@infradead.org> <CAAhSdy3-mM-zyYOvQBR+JsRTZGZWUF=4Y=0jTKhVMAYPxOfJ6Q@mail.gmail.com>
 <20180905185838.GC15741@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 6 Sep 2018 17:23:07 +0530
Message-ID: <CAAhSdy2B3RTYKTsm+HrJfsC3dP3vZyT0VYi80h3pDVUxDCONwA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] irqchip: RISC-V Local Interrupt Controller Driver
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 12:28 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Sep 05, 2018 at 11:39:01AM +0530, Anup Patel wrote:
>> Previously submitted driver, registered separate irq_domain for
>> each CPU and local IRQs were registered as regular IRQs to IRQ
>> subsystem.
>> (Refer, https://www.spinics.net/lists/devicetree/msg241230.html)
>
> And we reject that driver approach for good reason and are now
> doing the architectualy low-level irq handling in common code
> without any need whatsover to duplicate information in the
> privileged spec in DT.

In other words, the whole idea of separate RISCV local interrupt
controller driver was dropped due duplicate information in privilege
spec DT ??

Anyway, I think we should certainly have RISCV local interrupt
controller driver to manage local IRQs using Linux IRQ
subsystem. This gives us future flexibility in having more
per-CPU IRQ without changing any arch/riscv code.

Based on ARM examples which I had provided, it is very
likely that we will see more per-CPU IRQs in future. Some of
these will be device IRQs and some will be CPU specific
per-CPU IRQs (such as bus error interrupts).

Regards,
Anup
