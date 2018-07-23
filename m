Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF81ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E1820856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VRhkHCJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E1820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388916AbeGWNwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:52:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33832 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388489AbeGWNwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:52:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so81702pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 05:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SCT9++5AfU6k+3npbBmVGwepQIolQJ8h415Jc6mGBhA=;
        b=VRhkHCJxTXQowYmephY0QdjFDFLGdk+zF/CQdKVBQ7DP/qQkqnoDGBtz+URmXzyMUM
         3VfgoNFO4nn0dVB/JRXhSsfD8BoJvxMIiuroS1HQOlki/jaOxUOrBflAwIq65kDL82ZS
         TOvqA440Uu99oeQew8YKBszZAqG8oq971a9EK79Jx+mET7xYn4RbZhS+XTQjNlumXHFk
         nSIQTKFDrLMMnON+YWH7DR1ce1qSx+6qAW/RHUArYub/JtekwO97IfGFRwCN7Kflrrqd
         INc80fJTtc/GNPw4YTw12VW/Do9Ys+1D/c61tICvq7df4ocwag+GhRdN8RUjdbtvX3oY
         IF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SCT9++5AfU6k+3npbBmVGwepQIolQJ8h415Jc6mGBhA=;
        b=sue8anJfeI+fffl2mKhsQJVNTMko8W58Vq1XwiVVI1eEuMzPHtLgMA15hRuOSrbvi+
         oa5r/OTjNRb/zf/7O8IoMWQZ5YH9RtiV7Vfy9RO+a9RnoDWixWgqnx8Nu0uUDZAM4+6a
         9ms15e0seIfpH06SaE4l88c9YJwnHi3wlijITCRsQwHHn8XooTeBymFTq8mwTjqCYM6D
         GHjlFEr9cKAzdEdLYG/DeO+BaS309Hv/PxAy6YSXrSnjg8prg9WuoWMFcke0jKjeAlZc
         MmzseFipMsoyRwE+sNIieMwP8jw9OXTfY+P8hg8QR8TerqTn8aYY8oEhAp26yBXX0r2Y
         dxsQ==
X-Gm-Message-State: AOUpUlFdmsmRRjn6TW2Izi975tGFp7nSF/Sb9g2fwcsVno7Y/eINCTAb
        nJeDVDvNdR5kKIORYJDYVILbg3Iy9YN1FNOff7AwHA==
X-Google-Smtp-Source: AAOMgpddqzTuj5EQHn5zwAHj5lR9m+4ZwIhbNtB2hallaLmPDFcxEtccUxV/t6v3GTW2p5ktCxHQWFsmr13Z4qM8ucg=
X-Received: by 2002:a65:40cd:: with SMTP id u13-v6mr12368598pgp.334.1532350298031;
 Mon, 23 Jul 2018 05:51:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 23 Jul 2018 05:51:17
 -0700 (PDT)
In-Reply-To: <20180723124026.3uqc6r3mgge62onh@lakrids.cambridge.arm.com>
References: <CALCETrW4F33LWWA=cWYZ2N9=veCmVfjhCCLnSv2qh=32fOAf-w@mail.gmail.com>
 <CACT4Y+aP4QSGBiLWt0iNHVJ4nMc_phthK9P+gTMd4d=exaAKwA@mail.gmail.com>
 <20180723111813.vbnsmx2k45eqzdkc@lakrids.cambridge.arm.com>
 <CACT4Y+YMYogSo+Wq=29A7fKC9hufsc_DwLrneOKtsefZP-9h6g@mail.gmail.com> <20180723124026.3uqc6r3mgge62onh@lakrids.cambridge.arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 23 Jul 2018 14:51:17 +0200
Message-ID: <CACT4Y+ZN98Ti=zU6eWAUgNFchxENbz2EeeUtCcbMS9Lek-D9EA@mail.gmail.com>
Subject: Re: Making KASAN compatible with VMAP_STACK
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 2:42 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> >> > Hi all-
>> >> >
>> >> > It would be really nice to make KASAN compatible with VMAP_STACK.
>> >> > Both are valuable memory debugging features, and the fact that you
>> >> > can't use both is disappointing.
>> >> >
>> >> > As far as I know, there are only two problems:
>> >> >
>> >> > 1. The KASAN shadow population code is a mess, and adding *anything*
>> >> > to the KASAN shadow requires magical, fragile incantations.  It should
>> >> > be cleaned up so that ranges can be easily populated without needing
>> >> > to very carefully align things, call helpers in the right order, etc.
>> >> > The core KASAN code should figure it out by itself.
>> >> >
>> >> > 2. The vmalloc area is potentially extremely large.  It might be
>> >> > necessary to have a way to *depopulate* shadow space when stacks get
>> >> > freed or, more generally, when vmap areas are freed.  Ideally KASAN
>> >> > would integrate with the core vmalloc/vmap code and it would Just Work
>> >> > (tm).  And, as a bonus, we'd get proper KASAN protection of vmalloced
>> >> > memory.
>> >> >
>> >> > Any volunteers to fix this?
>> >>
>> >> Hi Andy,
>> >>
>> >> I understand that having most configs as orthogonal settings that can
>> >> be enabled independently is generally good in intself, but I would
>> >> like to understand what does VMAP_STACK add on top of KASAN in terms
>> >> of debugging capabilities?
>> >
>> > VMAP_STACK makes it possible to detect stack overflows reliably at the
>> > point of overflow.
>> >
>> > KASAN can't handle this reliably, even if it detects that an access is
>> > out of the stack bounds, since handling this requires stack space.
>> > Depending on a number of factors, this may be reported, might result in
>> > recursive exceptions, etc.
>>
>> Interesting. Does VMAP_STACK detect task_struct smashing today? As far
>> as I remember, the first version didn't.
>
> I assume you mean thread_info? Both arm64 and x86 moved the thread_info
> out of the stack region by moving it into task_struct, which has always
> been allocated separately. So thread_info smashing by stack overflow is
> not possible.
>
> Regardless of VMAP_STACK, the stack region is purely stack on arm64 and
> x86.
>
>> As an orthogonal measure we could add KASAN redzone between stack and
>> task_struct, and make KASAN instrumentation detect when the new frame
>> hits this redzone. We bump stack order under KASAN significantly, so
>> adding, say 128 byte redzone should not be a problem. Does it make any
>> sense?
>
> I don't think this is necessary since the two are allocated separately.


I see. Thanks.

So current KASAN failure mode would be silently smashing whatever page
happens to be after the stack. If so, I guess combining it with
VMAP_STACK would be useful, in particular, to prevent random assorted
crashes coming out of syzbot.

But I think I am not well qualified to actually do this.
