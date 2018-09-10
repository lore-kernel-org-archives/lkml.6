Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC50C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AC520870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="fK5qs4hv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AC520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbeIJTXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:23:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51416 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbeIJTXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:23:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so21797334wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 07:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GsC0rUuTcDSrDVGTfQfyVC933A4XKz/mIQXW48yj0Xk=;
        b=fK5qs4hvcdfHwZuulG2xzNBLyEX6S1bF0l2BIlIpwN3ZhKsXylvLspeUlJxTtyG0Lo
         oOufetNtbRSzWA4Apd3pC7jaCvR+jer5ArqbZc2/s66xAPCkBdDJncLO5OAYQ7MRbU+d
         ChHbv64G1QvNeIAHOtMFpfH4g9ZQ5M4jm83kJE6A3fMBVrHnZR4GJQNAsELPpWoUqKkG
         28Xsx7yyJCO1F5lJ+QTQ+BUHsqDKUPMlszORN+W82+mgM1Dwc7DdVwSTDrppyaY1RfmQ
         hYs802WDAf7k+my+7zfs1Hs842gPRYgXGPmulo6xIFuFWoOiRLoi894+1kQNLLCevEvg
         EYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GsC0rUuTcDSrDVGTfQfyVC933A4XKz/mIQXW48yj0Xk=;
        b=aT5skoCNb0TRnJSM9K6N4Olm1dZAuOQA26ASk3wGLOFoU2c623hKXUXM2eg5LCQY5N
         nQxlGEa3beowpXWkLjn0sv3PQqeKNYeqRPG1/jaY/AHkMcmQXif1jsMh0R2xr1DB8+D/
         N3EmqM4wNgwY7erDroaJBFZgOUZrBZaQFp/lh+v1rBEcPsp7IDRxsgCrwlNUv5yy1KiX
         sKkjzIfLanAdwx6/tuNRp0qQutaJAOOBZGey7djvKubdsz0lVRJZ3zF3QQxIDmgXpSOU
         nj+rKIf6FgYwcp3GEKqdJx+cuKvsJpTPdMIutyYLm4hChdWXJtI6N5iD/6Dn5wVCJbrh
         w+Vw==
X-Gm-Message-State: APzg51BlEQOYlOeTBW/OTZIwdrK3jP6D//ZHwx8JzSuLSWkOHOkFf5M8
        lOj2JLvrSctRnNZBj+zdVOYDIDicMvsD6FA+xRmYkw==
X-Google-Smtp-Source: ANB0VdZliRafk4Xyq1gemQB/K6mC41yYgyFGnJ+0CtK74cfv9rXfTDiYtwLh0YM4WSeq4ATACrAED0I3WVXOZPWkI7M=
X-Received: by 2002:a1c:752:: with SMTP id 79-v6mr892193wmh.59.1536589756597;
 Mon, 10 Sep 2018 07:29:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 07:29:15
 -0700 (PDT)
In-Reply-To: <20180910134915.GB30774@infradead.org>
References: <20180906123651.28500-1-anup@brainfault.org> <20180906123651.28500-4-anup@brainfault.org>
 <20180906140628.GA10580@infradead.org> <alpine.DEB.2.21.1809081241310.1402@nanos.tec.linutronix.de>
 <20180910132924.GA6987@infradead.org> <alpine.DEB.2.21.1809101533330.1292@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809101536410.1292@nanos.tec.linutronix.de>
 <20180910133902.GB21593@infradead.org> <alpine.DEB.2.21.1809101544560.1292@nanos.tec.linutronix.de>
 <20180910134915.GB30774@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 10 Sep 2018 19:59:15 +0530
Message-ID: <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller Driver
To:     Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 7:19 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Sep 10, 2018 at 03:45:42PM +0200, Thomas Gleixner wrote:
>> > He has an irqchip that is called from the RISC-V exception handler
>> > when the interrupt flag is set in scause and then dispatches to one
>> > of:  IPI, timer, actual irqchip.
>>
>> So the per cpu timer is the only per cpu interrupt and that thing is used
>> unconditionally, right?
>
> Yes.  external is chained and IPI is still handled explicitly.

On riscv64, there are 64 local interrupts (i.e. per-CPU interrupts).

Three of these local interrupts have clearly defined use:
1. Software interrupt (inter-processor interrupt)
2. External interrupt (interrupt from PLIC)
3. Timer interrupt (interrupt from per-CPU timer)

Other local interrupts are available for future use.

Taking inspiration from ARM world, I had give quite a few
examples how these RISC-V local interrupts can be used
for other purposes:
1. per-CPU interrupt for per-HART performance monitoring unit
2. interrupt controller virtualizaton extension can use per-CPU
interrupts for managing resources (just like ARM GICv2/v3 virt
extensions)
3. bus errors can be reported as per-CPU interrupts

Considering above, it is better to have a distinct irqchip and
irq_domain for all local interrupts (just like this patch).

Regards,
Anup
