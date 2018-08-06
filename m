Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645FDC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A93A21A0F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IM/x1VdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A93A21A0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbeHFOay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:30:54 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35891 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbeHFOay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:30:54 -0400
Received: by mail-it0-f66.google.com with SMTP id p81-v6so17857692itp.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 05:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tYIO4A7ou5+hf45teEkZ2sJsFMUgU4VM790JBwG2wAI=;
        b=IM/x1VdEMAmzTZIp7I6XPCKGfcCIXtJzPGmvp7BEOITXqJEO/D9AJr/Fz7r9z8x4ya
         Geq1q9u4VcteXlWKKCul8lD9lp507aASDUW0maK5PkZyWKHfkmrxe+qKa1V3Gkh6CEtJ
         INJjLN++a5fTBn5Bztz6/xHqGtxpadQ/x9aQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tYIO4A7ou5+hf45teEkZ2sJsFMUgU4VM790JBwG2wAI=;
        b=JLV3c9sVb3EpDlhoSGCcMiS95z147GN1cV036y/zhN9sI8jMozKuhais1NzDgjfUa3
         /rZf2YXbxGM8AhDio3CNinNGo0qg/gJqmHjIOMl1+Pj+s03kspZnnNWlPo9wBEVh/i9q
         ZuawZxZkGjdr2izZAziQf8lBy23n/wmmGJMj1rHuDH0jAHFX1l2DlRuUpiKmNRsmYRaq
         mDp4BJ3h1y4QtkEtnSdFPzh6cSqw2HF0zPhxq9D5NV4EiWryEvLl01/zx00XCMAGQmjj
         BeUv88JaYPeoW244DATdR0R+spQ31ZkqdwNM79nS6XlArCVU2zh94Y1SdQ+/kKz9JCbv
         h/8w==
X-Gm-Message-State: AOUpUlFZcjPR6tZOjX3QYrN4zqHlof1D+z0xIwcB/i7bXTldp9PlAjbV
        lB/wRLY4Ru1lLtWnQKQrjTKEvqyl1HyU+mp9KcproQ==
X-Google-Smtp-Source: AAOMgpfBbU/5rmjOQjNQmdQxWy+zCLqFpO400QKzdWHTnY+bi5TFU05IDygzJTG9XYGeEiSb7WktwcljQXkKbWUgIBM=
X-Received: by 2002:a24:148c:: with SMTP id 134-v6mr14812781itg.50.1533558121013;
 Mon, 06 Aug 2018 05:22:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 05:22:00 -0700 (PDT)
In-Reply-To: <CAKv+Gu8384LZwL898wJ8BKjmJNzvd+-cSFUp4X4OpfmRDCP4Ng@mail.gmail.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com> <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
 <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
 <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com> <alpine.LRH.2.02.1808060325110.3756@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_y6La77sWOSROrwfRy65jrFVYVvRZt+ewNheYhdhHCkQ@mail.gmail.com>
 <alpine.LRH.2.02.1808060626060.2986@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu87YqLM=FFZ6V8rHhuhskDdsBUuXFpqNKVbXWqdnuNEyA@mail.gmail.com>
 <alpine.LRH.2.02.1808060639200.2986@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8HyHX8qjg1qHV2M9Re+RGQJigjdAFVC_yR4niGkk2ikA@mail.gmail.com>
 <alpine.LRH.2.02.1808060700070.10220@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8384LZwL898wJ8BKjmJNzvd+-cSFUp4X4OpfmRDCP4Ng@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 6 Aug 2018 14:22:00 +0200
Message-ID: <CAKv+Gu9Sa0pPeKVYBcCF8w-4QYYtp0YhHArzL3F2bnfVqyBYYA@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Andrew Pinski <pinskia@gmail.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 August 2018 at 14:19, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 6 August 2018 at 14:09, Mikulas Patocka <mpatocka@redhat.com> wrote:
>>
>>
>> On Mon, 6 Aug 2018, Ard Biesheuvel wrote:
>>
>>> >> Are we talking about a quirk for the Armada 8040 or about PCIe on ARM
>>> >> in general?
>>> >
>>> > I don't know - there are not any other easily available PCIe ARM boards
>>> > except for Armada 8040.
>>>
>>> ... indeed, and sadly, the ones that are available all have this
>>> horrible Synopsys DesignWare PCIe IP that does not implement a true
>>> root complex at all, but is simply repurposed endpoint IP with some
>>> tweaks so it vaguely resembles a root complex.
>>>
>>> But this is exactly why I am asking: I use a AMD Seattle Overdrive as
>>> my main Linux development system, and it runs the gnome-shell stack
>>> flawlessly (using the nouveau driver), as well as a UEFI framebuffer
>>> using efifb. So my suspicion is that this is either a Synopsys IP
>>> issue or an interconnect issue, and has nothing to do with the
>>> impedance mismatch between AMBA and PCIe.
>>
>> If you run the program for testing memcpy on framebuffer that I posted in
>> this thread - does it detect some corruption for you?
>>
>
> I won't be able to check that for a while - I'm currently travelling.
>
>>
>> BTW. does the Radeon GPU driver work for you?
>>
>> My observation is that OpenGL with Nouveau works, but it's slow and the
>> whole system locks up when playing video in chromium.
>>

Are you setting the pstate to auto? That helps a lot in my experience.

I.e.,

echo auto > /sys/kernel/debug/dri/0/pstate
