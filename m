Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905F2C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EE720839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544581501;
	bh=aAyTLf6iYS04ZLetdR4VG1d3QjxY2OLu/T7oHBULPmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=emNdsI65DP/DwJOpj11UEpIKuqusrd7YFZXRdxqSLPfwZUz88dIH5gnK3lztXLX6X
	 AhpSH5NFP512IE8GMkV/6KzkRbyt6N6hNvEhNeKr+t98kTRZyACrML+aMbvK9WdvL3
	 cWGQC9RWGmYTy1ncgIi8LmsFSM3In8EMxLH3L4SE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EE720839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeLLCZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:25:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:58068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeLLCY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:24:59 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2096A2086D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 02:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544581498;
        bh=aAyTLf6iYS04ZLetdR4VG1d3QjxY2OLu/T7oHBULPmU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W6RjubWUCq6GohnybrEHhxFQqpkEbfIZJEDOxzfwuUjgzd4PD/U+xAx48M7lr6EEc
         GWCkXqdf1Kx12B27H6tqWt4iFNgLZ+c3JAM525n8PXzNGVY+I56xiR5DQDnHixdS/u
         BJVyES7Je3/V+bXmisWEkWFFU67G497F2yx+5g9o=
Received: by mail-wm1-f52.google.com with SMTP id r24so10319750wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 18:24:58 -0800 (PST)
X-Gm-Message-State: AA+aEWZM5VHdTzQvu5x6RFYmS81fyEoMyEXofcdKx/0QxAT8dEBzHe0s
        2pU8UxtSyG+8m/e+alW8l2jxQAJGmKcQZG+v6F2InQ==
X-Google-Smtp-Source: AFSGD/WpjM42HJG1K3JeUjk7vjgUcrj2qX5f4uu8TdojxErS8gK/635FfTH0iAz24wLoxGi5Yh26PcekPMQC1fbcRjA=
X-Received: by 2002:a1c:aa0f:: with SMTP id t15mr4396702wme.108.1544581496632;
 Tue, 11 Dec 2018 18:24:56 -0800 (PST)
MIME-Version: 1.0
References: <20181211222326.14581-1-bp@alien8.de> <20181211222326.14581-5-bp@alien8.de>
 <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
 <59aad362-4a5b-dd8b-642f-0dc3f83cf7ee@amd.com> <20181211233901.GV27375@zn.tnic>
In-Reply-To: <20181211233901.GV27375@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 11 Dec 2018 18:24:44 -0800
X-Gmail-Original-Message-ID: <CALCETrXvZ4avdUh2bTLVTTz3Jxogo3zK5akWTsJ=rkJpf1XiDg@mail.gmail.com>
Message-ID: <CALCETrXvZ4avdUh2bTLVTTz3Jxogo3zK5akWTsJ=rkJpf1XiDg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <Thomas.Lendacky@amd.com>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 11, 2018, at 3:39 PM, Borislav Petkov <bp@alien8.de> wrote:
>
>> On Tue, Dec 11, 2018 at 11:12:41PM +0000, Lendacky, Thomas wrote:
>> It does seem overloaded in that sense, but the feature means that LFENCE
>> is serializing and so can be used in rdtsc_ordered. In the same sense,
>> barrier_nospec is looking for whether LFENCE is serializing and preferri=
ng
>> that over MFENCE since it is lighter weight.
>>
>> In light of how they're being used now, they could probably stand to be
>> renamed in some way.
>
> Actually, come to think of it, what really matters here is whether
> LFENCE is serializing or not. Because if so, you wanna replace with LFENC=
E
> as it is lighter. And in that case a single alternative() - not _2() -
> should suffice.
>
> BUT(!), that still is not good enough if you do some qemu CPU models
> like pentium or so which don't even have MFENCE and cause stuff like
> this:
>
> https://lkml.kernel.org/r/20181123200307.GA6223@roeck-us.net
>
> Which means, that you *do* have to alternate between
>
> * no insn at all
> * MFENCE
> * LFENCE, if it is serializing
>
> so barrier_nospec() does the right thing, AFAICS. And this is why we
> need an ALTERNATIVE_3() to add RDTSCP into the mix too.
>
> WRT renaming, I guess we can do something like:
>
> * X86_FEATURE_MFENCE_RDTSC -> X86_FEATURE_MFENCE - to mean that CPU has
> MFENCE support.
>
> and
>
> * X86_FEATURE_LFENCE_RDTSC -> X86_FEATURE_LFENCE_SERIALIZING
>
> Or something to that effect.

This makes me nervous, since no one knows what =E2=80=9Cserializing=E2=80=
=9D means.
IIRC AMD specifically documents that MFENCE is required before RDTSC
to get sensible ordering.  So it=E2=80=99s entirely plausible to me that
LFENCE is okay for Spectre mitigation but MFENCE is needed for RDTSC
on some CPU.
