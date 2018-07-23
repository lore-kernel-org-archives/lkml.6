Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0953EECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75BA20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NN+a4vYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75BA20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbeGWM5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:57:02 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40590 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbeGWM5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:57:01 -0400
Received: by mail-pl0-f66.google.com with SMTP id s17-v6so128260plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 04:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u2wbrpMf3BwwUyLR5tju9pXaDLmbGmxF2b//ab05B1o=;
        b=NN+a4vYcMk1yLl/xJEEmX9LTYn+uEQJl/5LfoWkQPgt8hFhjhKAs6L7IrkmdESIRF6
         CbutcHhtW7eyD04z8936PWkXwlAQSueSIDegJ8FDGo2Q+aF54//LJOiAC++vvxr1rkL0
         f1HhEy+IgCNSfhOsUWgUDg6kwmHy7xYZ4Hz/gS2N6oplGxHOThfUR6ePGD1PX4f1zyuC
         sgBQouTGJIsx3l8q/sP0HchEoCj+kRvxsxULIP88lSP/ae+QgEQcXVIJ8qnhnPyjI8cK
         JuXs6SNtKDox9x7GxBwURBnCVf4uCCxBczmZ1rJVb0xX0doqOadMlzfBA0R/tlI8UKW6
         eI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u2wbrpMf3BwwUyLR5tju9pXaDLmbGmxF2b//ab05B1o=;
        b=nakrugBNveEOT9dPpZ7DBZO9ku0gpop6U9c+vBufY3hk3CkR4zA4L4OnP0LZRGdPmK
         s4kEQy8FEhT/Fi9QaiAFL/IjabaSH87cYqW7WfWiOufDV+XRNdLS8RKKoM/cTCKz16oS
         1qU3nmvGW21//REeoIA0iPBgaFezm6cjZjJP4eOl+6A7v2mibogVeTADnrxpDpqcwdcE
         qxeg6rH5v1qYFNlk7x260c4v25hrbNv+2TKj9Dd2cjnPgwLSAc/UsdL9ovrdb+FrQ1Qn
         JX3b5Ht+0UEntGV3onk2pIaAu0FOsz2cH7OYB0L0D121dwCSNqiTRf1BNR484baYW1lf
         H1bQ==
X-Gm-Message-State: AOUpUlECPSyvLSn3iI+cTYXnLFDdss+OvZnno280yyE4kSeJDe8SadGZ
        A+4jO87SsXiCzkATftXK9gLpa2RjHamsguJM9rWgwA==
X-Google-Smtp-Source: AAOMgpefroFWWJoGVh4sJMGS18a0xHg6JihMUgnSpyR1Dnfj05lV63Jkj1Re2b+AjuHJP/bQs6N1haFofv5eWrhvKK8=
X-Received: by 2002:a17:902:d710:: with SMTP id w16-v6mr12666378ply.93.1532346969776;
 Mon, 23 Jul 2018 04:56:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 23 Jul 2018 04:55:49
 -0700 (PDT)
In-Reply-To: <20180723111813.vbnsmx2k45eqzdkc@lakrids.cambridge.arm.com>
References: <CALCETrW4F33LWWA=cWYZ2N9=veCmVfjhCCLnSv2qh=32fOAf-w@mail.gmail.com>
 <CACT4Y+aP4QSGBiLWt0iNHVJ4nMc_phthK9P+gTMd4d=exaAKwA@mail.gmail.com> <20180723111813.vbnsmx2k45eqzdkc@lakrids.cambridge.arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 23 Jul 2018 13:55:49 +0200
Message-ID: <CACT4Y+YMYogSo+Wq=29A7fKC9hufsc_DwLrneOKtsefZP-9h6g@mail.gmail.com>
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

On Mon, Jul 23, 2018 at 1:18 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Jul 23, 2018 at 09:40:36AM +0200, Dmitry Vyukov wrote:
>> On Sun, Jul 22, 2018 at 7:52 PM, Andy Lutomirski <luto@kernel.org> wrote:
>> > Hi all-
>> >
>> > It would be really nice to make KASAN compatible with VMAP_STACK.
>> > Both are valuable memory debugging features, and the fact that you
>> > can't use both is disappointing.
>> >
>> > As far as I know, there are only two problems:
>> >
>> > 1. The KASAN shadow population code is a mess, and adding *anything*
>> > to the KASAN shadow requires magical, fragile incantations.  It should
>> > be cleaned up so that ranges can be easily populated without needing
>> > to very carefully align things, call helpers in the right order, etc.
>> > The core KASAN code should figure it out by itself.
>> >
>> > 2. The vmalloc area is potentially extremely large.  It might be
>> > necessary to have a way to *depopulate* shadow space when stacks get
>> > freed or, more generally, when vmap areas are freed.  Ideally KASAN
>> > would integrate with the core vmalloc/vmap code and it would Just Work
>> > (tm).  And, as a bonus, we'd get proper KASAN protection of vmalloced
>> > memory.
>> >
>> > Any volunteers to fix this?
>>
>> Hi Andy,
>>
>> I understand that having most configs as orthogonal settings that can
>> be enabled independently is generally good in intself, but I would
>> like to understand what does VMAP_STACK add on top of KASAN in terms
>> of debugging capabilities?
>
> VMAP_STACK makes it possible to detect stack overflows reliably at the
> point of overflow.
>
> KASAN can't handle this reliably, even if it detects that an access is
> out of the stack bounds, since handling this requires stack space.
> Depending on a number of factors, this may be reported, might result in
> recursive exceptions, etc.

Interesting. Does VMAP_STACK detect task_struct smashing today? As far
as I remember, the first version didn't.
As an orthogonal measure we could add KASAN redzone between stack and
task_struct, and make KASAN instrumentation detect when the new frame
hits this redzone. We bump stack order under KASAN significantly, so
adding, say 128 byte redzone should not be a problem. Does it make any
sense?
