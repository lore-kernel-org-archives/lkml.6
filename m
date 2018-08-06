Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766DDC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1951921916
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9isvjqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1951921916
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbeHFPCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:02:07 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:37275 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeHFPCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:02:07 -0400
Received: by mail-io0-f169.google.com with SMTP id z19-v6so10914071ioh.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 05:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8IZgJnrHcdBF9vNwG3q57EF9HztlMG74k7CuyBh3X+E=;
        b=V9isvjqXYX8Lb27pqy4AfCOn1QNi6VWUos1xyOjv/69KcmWbZfILLf5Qobf8NgBDU8
         1zpxFMvXZKmcbZK/i0363B/4ZNiw91IKPgXBgW9dd0vGstxGydCBNRoasAvTXOnGAhV6
         Bxxr3FvzOMatFQylJYF6i8HwHTxx/skZ5tMF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8IZgJnrHcdBF9vNwG3q57EF9HztlMG74k7CuyBh3X+E=;
        b=arizgIutWfBUj6FlVFA3G5a7jO7g0R2F396o0NgI368bPCoBDolmokzKWGnDLjnC8I
         VGjBak5wYgRYpof9IYNDKopxl2XJlvdbPBUY2g8Sl83vjEosDrBFdfNnX8BpAUK20ivm
         OvKAZRloR6LKHMaXUcTot1RtUO0O5dFfKByIW73T7Gl6TVGU7Ea/ZgzrIl+OQLxlmn3D
         cVccHfx30jHKwWtoFuOLg+Eof7g307K6piUU+/Kkz/Kka4NOWfhLm6avnQTatiRDGkf8
         sGcW7oc3zLrMaBVS5F0MHvUCA1Hjm9VkmKDdJNlSUiSObU9mhYRIz7Jnpyk4VCUh1Fus
         cCZw==
X-Gm-Message-State: AOUpUlFhH5pqlrQYXulEgUrCVkVuBH3ufOmQ1IQeQhi+AnvBM3RXd57B
        +Zx2CfQbyT0tf2+S/nC6ivbsafilACjghMVMB9tH8w==
X-Google-Smtp-Source: AA+uWPyUUvBCGn/xQYbXj2+sJ7ZVr7caQdgZcV8Qiy5uSm9DrtujyeCsvARmsNrLx9E5ky7w2/xDoBiqIsYKhD8MKyY=
X-Received: by 2002:a6b:5208:: with SMTP id g8-v6mr15623883iob.60.1533559988112;
 Mon, 06 Aug 2018 05:53:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 05:53:07 -0700 (PDT)
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
Date:   Mon, 6 Aug 2018 14:53:07 +0200
Message-ID: <CAKv+Gu_UZmq=6juE98ceXgJ1KCgvzncYbzYiC2Uz+6mhf6yMpw@mail.gmail.com>
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
>> I observe these kinds of corruptions:
>> - failing to write a few bytes
>
>
> That could potentially be explained by the reordering/atomicity issues Matt
> mentioned, i.e. the load is observing part of the store, before the store
> has fully completed.
>

OK, so that means the unaligned transaction gets split, and the
subtransactions are reordered with the aligned transaction so that the
sub-writes contain stale values from the sub-reads?

>> - writing a few bytes that were written 16 bytes before
>> - writing a few bytes that were written 16 bytes after
>
>
> Those sound more like the interconnect or root complex ignoring the byte
> strobes on an unaligned burst, of which I think the simplistic view would be
> "it's broken".
>
> FWIW I stuck my old Nvidia 7600GT card in my Arm Juno r2 board (2x
> Cortex-A72), built your test program natively with GCC 8.1.1 at -O2, and
> it's still happily flickering pixels in the corner of the console after
> nearly an hour (in parallel with some iperf3 just to ensure plenty of PCIe
> traffic). I would strongly suspect this issue is particular to Armada 8k, so
> its' probably one for the Marvell folks to take a closer look at - I believe
> some previous interconnect issues on those SoCs were actually fixable in
> firmware.
>

IIRC that was DVM dropping a few VA bits at the top, and a single MMIO
control bit to put it back into 'non-broken' mode.
