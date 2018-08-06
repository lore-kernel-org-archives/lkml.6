Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94228C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5DE21A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RRuS1JA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5DE21A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbeHFR5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:57:20 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:50366 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeHFR5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:57:20 -0400
Received: by mail-it0-f51.google.com with SMTP id j81-v6so16270024ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H2CzqvJKjXzXYMVy3svae+zgTT/t2E6Ky/lfqJ+uo0Y=;
        b=RRuS1JA1QS1V6gB10KpcBMPjuYnhBy2ZSLs7/SkyL5kUJ5wmQ0CfK3RT94iFxgqhAK
         t7VLXlz2POQY8SY7eqcCMIzrYs9ifyI5N4d+BtfhA6WSJ+kI58rAslNdMDqyF3f4FASq
         kL3Fy2ljwKAF1EzjSz58J1M1TLErVMvuq7Pgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H2CzqvJKjXzXYMVy3svae+zgTT/t2E6Ky/lfqJ+uo0Y=;
        b=QDyV4rAo/fWuM+oMFdh48wGmmZ7jtlmQuyuyCjQtgVfEzyf+hbRGfZihpy8VRNK3RR
         OOqgqD3nF/yfCt7ui94eYD9gd+9/4iMHpj7PU9tZdH8bwPNsh0/k32plGvoPEmaQD959
         dXdDCHz/FmxGK8dfg8QW5mLE78/IITGKSVpMAJEZLqtps/mAYccZtkWv3Gnp/rr0WX83
         rIUfb8VNPjsExOuqRllFYW53CIYaB9l66VLTlOUktJvvgvcAKYk6/taYOy/gtRbScXI5
         wrs5SSWgUTD3iPFIlw/zRHLZED4ZV2Ry6EwOJwBnjntrB1CpjMdOIxJmE/xa9gBKdo9l
         ksMA==
X-Gm-Message-State: AOUpUlHvA4rntaF7yFfLRYIi3u/q0caZXbhCqE0XcuxFyXwXIfbVQu8n
        r2AIeYPW5hcSK41PxLKwofpXbjilB1RYejeQTDgGUA==
X-Google-Smtp-Source: AAOMgpdhYsxphREPEUfXZ/VzZUfjFolVHsbiX72R+rrQUxHPOzZd11rTdgmYAEzcnruoQbHMGaur5CDC3OLhtv2kUWA=
X-Received: by 2002:a02:35a:: with SMTP id y87-v6mr13463167jad.2.1533570457733;
 Mon, 06 Aug 2018 08:47:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 08:47:36 -0700 (PDT)
In-Reply-To: <99fff4fe-afa9-f12f-a518-472a9dd1c530@arm.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com> <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <CAKv+Gu9_h-WFi1j4+DWUN_dMj75SKKHxWoDH8WQ9P7S7MNpZQg@mail.gmail.com>
 <alpine.LRH.2.02.1808060553130.30832@file01.intranet.prod.int.rdu2.redhat.com>
 <99fff4fe-afa9-f12f-a518-472a9dd1c530@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 6 Aug 2018 17:47:36 +0200
Message-ID: <CAKv+Gu_C2g=C=gMpk4a5jpDORnxZY6t1v=HDoy59m5vwNBxBBg@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Sealey <neko@bakuhatsu.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 August 2018 at 14:42, Robin Murphy <robin.murphy@arm.com> wrote:
> On 06/08/18 11:25, Mikulas Patocka wrote:
> [...]
>>>
>>> None of this explains why some transactions fail to make it across
>>> entirely. The overlapping writes in question write the same data to
>>> the memory locations that are covered by both, and so the ordering in
>>> which the transactions are received should not affect the outcome.
>>
>>
>> You're right that the corruption couldn't be explained just by reordering
>> writes. My hypothesis is that the PCIe controller tries to disambiguate
>> the overlapping writes, but the disambiguation logic was not tested and it
>> is buggy. If there's a barrier between the overlapping writes, the PCIe
>> controller won't see any overlapping writes, so it won't trigger the
>> faulty disambiguation logic and it works.
>>
>> Could the ARM engineers look if there's some chicken bit in Cortex-A72
>> that could insert barriers between non-cached writes automatically?
>
>
> I don't think there is, and even if there was I imagine it would have a
> pretty hideous effect on non-coherent DMA buffers and the various other
> places in which we have Normal-NC mappings of actual system RAM.
>

Looking at the A72 manual, there is one chicken bit that looks like it
may be related:

CPUACTLR_EL1 bit #50:

0 Enables store streaming on NC/GRE memory type. This is the reset value.
1 Disables store streaming on NC/GRE memory type.

so putting something like

mrs x0, S3_1_C15_C2_0
orr x0, x0, #(1 << 50)
msr S3_1_C15_C2_0, x0

in __cpu_setup() would be worth a try.
