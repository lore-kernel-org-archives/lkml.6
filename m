Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE89C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C9120861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="PwmTdHfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C9120861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeIFPUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:20:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32798 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeIFPUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:20:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id v90-v6so10903298wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 03:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BqTeAkRMQmytqRPAe1z6pKoPYDWqrTtC8MO15hC2+6w=;
        b=PwmTdHfcAElGaLMUMd26iLG5b2wRT4TFbPGpPT3i0Pq5F8GY3qeUTibIMstSYFwWD0
         IuIkK89EChrElVh6EsxqMpKkWAjTjFSELmXALwN552ylg4V+uVyRfNwG3xdWwUL7oHgq
         bbGGrtD4LKfl+lCLpKsjhFxdOqIJ6FGSqH8Zhrwm68//PWDbI85Fva25RHFRWVdsy7Wl
         yQ4FqKq196QLAzcgLMs1niKwI/kkO+itrJSfj8YTC+QCAcTP4eRqMsi+d4UO9BkkOU3M
         n8QhobHVF1/udHM2Yw0vIE1OyuYiFMiJcWkKRWkVOtOUWXUi57g8YZItotazbYeVTE5F
         8bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BqTeAkRMQmytqRPAe1z6pKoPYDWqrTtC8MO15hC2+6w=;
        b=EPonFoCo4xeXga/mC4ROwnollaZXwo6V0vwUgOLHTdVOEaLyC8sJSQ9JoebcqBhzKM
         NsHY0QTZ0vLsv9c1LV3hfgXSX8vKb3ljshfqEYuxSe6ePnrYUAIOTVmtOUYoCRf2JHem
         iy6Ypalr4rhp7S5zg1eb4qJDXeWlXwpSi/74QHrae74P6Nq2tUZuUH7TVU4TSU8g9c6o
         o3U+x3zY/ZETTrMS7p/R0pINexdkfVIBI1bjFLHjpw7yNY5uk7zAEVm1W9lUAh+rdUy7
         H6tpli7MywFcSNwR13xXOshH6WEnmsrOuzvyrO3fHYFmK8ZYO0cCCbsEsuHZunF6fhoV
         EyVQ==
X-Gm-Message-State: APzg51DFxU3HeYHua7qg+SNwCQvYbtyYpsN9w75uXBDIbfSkHuUKaIZi
        s0cuqgst9J6NUamuRKUIQYA24emaTooXCXNHThwYzIEh
X-Google-Smtp-Source: ANB0VdbCQr8jCgiP0a+L6Z4JXUm1CZSwfUqca7Eg2T140r8sxiFWDU6mVqyYScxWioHd0Tfrast5yvDZzdUvp1wYMpY=
X-Received: by 2002:adf:8167:: with SMTP id 94-v6mr1879471wrm.127.1536230715091;
 Thu, 06 Sep 2018 03:45:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 03:45:14 -0700 (PDT)
In-Reply-To: <mhng-ba039ed5-dcff-41d3-b237-0708b5e117b2@palmer-si-x1c4>
References: <20180904185001.GA25119@infradead.org> <mhng-ba039ed5-dcff-41d3-b237-0708b5e117b2@palmer-si-x1c4>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 6 Sep 2018 16:15:14 +0530
Message-ID: <CAAhSdy3mOdxR9JpZyC9fCx5rphUBDxn2kbRpgtZp4h0_jYCxMA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] RISC-V: Make IPI triggering flexible
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
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

On Thu, Sep 6, 2018 at 3:15 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
> On Tue, 04 Sep 2018 11:50:02 PDT (-0700), Christoph Hellwig wrote:
>>
>> On Tue, Sep 04, 2018 at 06:15:10PM +0530, Anup Patel wrote:
>>>
>>> The mechanism to trigger IPI is generally part of interrupt-controller
>>> driver for various architectures. On RISC-V, we have an option to trigger
>>> IPI using SBI or SOC vendor can implement RISC-V CPU where IPI will be
>>> triggered using SOC interrupt-controller (e.g. custom PLIC).
>>
>>
>> Which is exactly what we want to avoid, and should not make it easy.
>>
>> The last thing we need is non-standard whacky IPI mechanisms, and
>> that is why we habe SBI calls for it.  I think we should simply
>> stat that if an RISC-V cpu design bypasse the SBI for no good reason
>> we'll simply not support it.
>
>
> I agree.  Hiding this sort of stuff is the whole point of the SBI.
>
> Anup: do you have some concrete reason for trying to avoid the SBI?  If it's
> just to add non-standard interrupt controllers then I don't think that's a
> sufficient reason, as you can just add support for whatever the non-standard
> interrupt mechanism is in the SBI implementation -- that's what we're doing
> with BBL's CLINT driver, though there's not a whole lot of wackiness there
> so at least the SBI implementation is pretty small.
>
>> So NAK for this patch.
>
>
> Certainly without a compelling reason, and even then I'd only want to take
> some standard interrupt controller -- for example, the CLIC (or whatever the
> result of the fast interrupts task group is called) could be a viable
> option.  Even with a standard interrupt controller, we'd need a really
> compelling reason to do so.

This patch is doing two things:
1. Allow IRQCHIP driver to provide IPI trigger mechanism
2. Have more generic IPI handler in arch/riscv so that IRQCHIP driver
can call it

The main intention behind point1 was to allow interrupt-controller
specific IPI triggering mechanism. I am totally fine in dropping changes
related to point1. May be we can revisit this if we find compelling use-case.

I will revise this patch to have changes related to point2 only. These
changes are required for the new RISCV local interrupt controller
driver introduced by this patchset.

Regards,
Anup
