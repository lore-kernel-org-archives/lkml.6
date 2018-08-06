Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A376C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB45A21A0F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZAC3Es9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB45A21A0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbeHFO2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:28:25 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35676 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731081AbeHFO2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:28:24 -0400
Received: by mail-io0-f196.google.com with SMTP id w11-v6so10834202iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 05:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dO7fODqdnaKG7aBGz/oJJSIFUHItJhIh2DWqbPdSuPQ=;
        b=WZAC3Es9/ACy7gqkHFyBuf6XIrOHcBXyUCidqMHHWZi3M0SUc4CmjLlgxpyJ3E+fcG
         i3cGOFc1ySuUChrDcoh1wBlHBw6Ocyvx8n23lXUsdPCkHRVQtAOFdbyfnLCl1HsnVYmS
         5tkC2GhFz5K60PE1kMYaVqepV/hZjdEsJtUYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dO7fODqdnaKG7aBGz/oJJSIFUHItJhIh2DWqbPdSuPQ=;
        b=QnDnjiknQRGIniJWpjapqedz4on1XnyAzpli3fH9MN2q+/vmcgP+l70Xs6/5Rb9/W1
         FJiW/DcO/V2FcsxM23eCPeWJxqCOpgxlPqHCIuxi26TNUcv3uC02+S9hz8UtbfWEchT/
         nFp0dy/gwEUj4mLkK8F4ovtDTuZyHFJ8zXEMtPjDP0fKQPKMHEM3Dg1losS474nZpBpL
         S/wWZEW/xzEqyJLuOVn0mHw6cglQ7XiEvGRiGum6YpfwCv5L2Fdrs+erLoU5B57BNcDC
         YbVE582aLmJ/qFknV7sVBnd/izzWbRM400/dOU05NJDRpn2mKjMZkilmMLFo3QcQVaR0
         h5HA==
X-Gm-Message-State: AOUpUlHDQWDkAE8RjA9+ABs/hvyFBEQdROnJ3aR5yRkL6GHZ6IwK0X8V
        TJEdWbbFqK7l/1ppLrU3omV9T7hO+TGgY2OTFuRVbA==
X-Google-Smtp-Source: AA+uWPwo/JZzbiVrAkNtZ2UXgP8yPh808nOpy7O5AnteeSJ81u+aBPbsP7/dmyO/mM4ldXfd+SVnPphvJHaw8CsMPJY=
X-Received: by 2002:a6b:5208:: with SMTP id g8-v6mr15521400iob.60.1533557972705;
 Mon, 06 Aug 2018 05:19:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 05:19:31 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.02.1808060700070.10220@file01.intranet.prod.int.rdu2.redhat.com>
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
 <CAKv+Gu8HyHX8qjg1qHV2M9Re+RGQJigjdAFVC_yR4niGkk2ikA@mail.gmail.com> <alpine.LRH.2.02.1808060700070.10220@file01.intranet.prod.int.rdu2.redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 6 Aug 2018 14:19:31 +0200
Message-ID: <CAKv+Gu8384LZwL898wJ8BKjmJNzvd+-cSFUp4X4OpfmRDCP4Ng@mail.gmail.com>
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

On 6 August 2018 at 14:09, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
> On Mon, 6 Aug 2018, Ard Biesheuvel wrote:
>
>> >> Are we talking about a quirk for the Armada 8040 or about PCIe on ARM
>> >> in general?
>> >
>> > I don't know - there are not any other easily available PCIe ARM boards
>> > except for Armada 8040.
>>
>> ... indeed, and sadly, the ones that are available all have this
>> horrible Synopsys DesignWare PCIe IP that does not implement a true
>> root complex at all, but is simply repurposed endpoint IP with some
>> tweaks so it vaguely resembles a root complex.
>>
>> But this is exactly why I am asking: I use a AMD Seattle Overdrive as
>> my main Linux development system, and it runs the gnome-shell stack
>> flawlessly (using the nouveau driver), as well as a UEFI framebuffer
>> using efifb. So my suspicion is that this is either a Synopsys IP
>> issue or an interconnect issue, and has nothing to do with the
>> impedance mismatch between AMBA and PCIe.
>
> If you run the program for testing memcpy on framebuffer that I posted in
> this thread - does it detect some corruption for you?
>

I won't be able to check that for a while - I'm currently travelling.

>
> BTW. does the Radeon GPU driver work for you?
>
> My observation is that OpenGL with Nouveau works, but it's slow and the
> whole system locks up when playing video in chromium.
>

No that works fine for me. VDPAU acceleration works as well, but it
depends on your chromium build whether it can actually use it, I
think? In any case, mplayer can use vdpau to play 1080p h264 without
breaking a sweat on this system.

Note that the VDPAU driver also relies on memory semantics, i.e., it
may use DC ZVA (zero cacheline) instructions which are not permitted
on device mappings. This is probably just glibc's memset() being
invoked, but I remember hitting this on another PCIe-impaired arm64
system with Synopsys PCIe IP

> Radeon HD 6350 (pre-GCN), doesn't lock up, but OpenGL (and Glamour) has
> many artifacts and corrupted textures. When I switch it to EXA
> acceleration and don't use OpenGL, it works.
>
> The artifacts are not fixed by preloading a glibc with fixed memcpy, so
> there's supposedly some other bug somewhere.
>

Yes, I have the same experience, and I have been meaning to report it
to the maintainers/developers. Good to have another data point.
