Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57454C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DE321A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RwCd3xD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DE321A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbeHFNhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:37:40 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:39877 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeHFNhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:37:40 -0400
Received: by mail-io0-f175.google.com with SMTP id o22-v6so10703441ioh.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 04:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m1KMX+JoFcnHvYpU+Aijx6fvUy7LX2CAFu0WyQMBZYo=;
        b=RwCd3xD/jK7XmGY1L5XvvgdjxMzGzvnviE6enN85wHopYVzGgEVZ6be7Yr0Pi7Tpti
         VH25aR7L9VIlFeQ+K+OoIi3lR8J4zBDzBeQ+iFXNaT/2pHVwnGhNiUiZV9mUfEKQLJA3
         LZUcdBJVrth2QDlMlh8mkaOOG7Dw2A6UPZZik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m1KMX+JoFcnHvYpU+Aijx6fvUy7LX2CAFu0WyQMBZYo=;
        b=WM9VsKMMelG/ut79NQ7f+nwwKfEhkAHcwKqgpeJSgR1WapidjUml6+VAFVbfHwNArV
         9UGEosps4vpL2qC6xsOPi7kRXVrtMr+b1N/xvIO/ne5QTu8GsVWoU0PU61OjP++RON3e
         23Nad/qRYc/sZYg/5pTU479pagvsT1xLgziPpkICGdBbqWYh81/ugaQft7Kr0KXjA6IL
         7J6RmUDvl8/xOXmAMQfJi78rdfpXX3MkjKvcpwIjLuL3Wu3dsCcf9zVavbNgIglLlga2
         z8ghrXv9YtNbR5iBbW79nKvT2mmNKb+vGsuRPYB/Nnyp9puVOTH0MFzY2Hu6Xj2cqg18
         KbOQ==
X-Gm-Message-State: AOUpUlE8gscID3EemTb8UDhWiFox+ow13ltTlkcmffl0xG/oDgLQUFGi
        uS4/q7QeLHW7zqyUHi6Mpos9m3jSPRV6pjWXBVhC9w==
X-Google-Smtp-Source: AA+uWPyxl3KRbNCGqBVLPDzhOUEv8zG6aCi8TinUlRbG+lbvr2/y6HHPEu1WM0VfqESIDoW893GfWKzJmfUiPcAHrTw=
X-Received: by 2002:a6b:5208:: with SMTP id g8-v6mr15365004iob.60.1533554941432;
 Mon, 06 Aug 2018 04:29:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 04:29:00 -0700 (PDT)
In-Reply-To: <df77857e-1674-38ea-2337-366182afb41e@gotplt.org>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com> <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com> <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
 <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
 <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com> <alpine.LRH.2.02.1808060325110.3756@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_y6La77sWOSROrwfRy65jrFVYVvRZt+ewNheYhdhHCkQ@mail.gmail.com>
 <alpine.LRH.2.02.1808060626060.2986@file01.intranet.prod.int.rdu2.redhat.com> <df77857e-1674-38ea-2337-366182afb41e@gotplt.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 6 Aug 2018 13:29:00 +0200
Message-ID: <CAKv+Gu_Qo+VJMBg0WxzR49oqTv+8nw-1Z+uOOeFV0cduCO8a_A@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Siddhesh Poyarekar <siddhesh@gotplt.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Andrew Pinski <pinskia@gmail.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Tulio Magno Quites Machado Filho <tuliom@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 August 2018 at 13:19, Siddhesh Poyarekar <siddhesh@gotplt.org> wrote:
> On 08/06/2018 04:01 PM, Mikulas Patocka wrote:
>>
>> I think there are three possible solutions:
>>
>> 1. provide an alternative memcpy implementation that doesn't do unaligned
>> accesses and recompile the graphics software with -mstrict-align
>
>
> Given that there's already a tunable glibc.cpu.cached_memopt for powerpc
> that (as Tulio clarified elsewhere) essentially does the same thing for
> cache-inhibited memory, it wouldn't be too much of an overhead to put in
> another ifunc implementation that gets chosen only when one sets this
> tunable.  In fact, we could reuse the C string routines for this to avoid
> adding yet another assembly implementation to have to support. That way we
> can minimally fix the issue at hand without regressing existing uses.
>
> You can then set the glibc.cpu.cached_memopt tunable in the default
> environment for your board[1] or for applications that need it (e.g.
> whenever DISPLAY is exported or something like that).
>
> The only difference from Power would be that cpu.noncached==0 for Power by
> default whereas for aarch64 it will be the other way around.  It shouldn't
> be too hard to enhance the framework to set platform-specific defaults.
>

Thanks Siddhesh,

But we don't need another memcpy(). We need outbound PCIe windows that
tolerate being mapped as normal non-cacheable memory.

And if this is fundamentally impossible, can someone please try
explaining it again? (apologies for being thick)
