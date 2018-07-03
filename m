Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8F9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80E221A41
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="TGGPLpEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80E221A41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932517AbeGCCeK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:34:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34430 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932309AbeGCCeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:34:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id l15-v6so9165216wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 19:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bgloRoVrRNkcn0xVljkCkBk+raAyGylNVWWmVAvG1Ks=;
        b=TGGPLpEfzZRJccF9PNEgL/d83UBZdJgJodcDdabBkY7V4ik3vmcIFgxFMn6iceCJOI
         ep/ToIyoeg4hCfslgZVleTxzSrTl9U8zIucWBNgC0rQid/nQfltTE11d+RLEdWqleVY2
         LN3vKCezk4Ud6eOhvHgrBrsqyZW5jskWDseKPCoWESkU1aoWRh6kY7E4XwGi3AFFsfXk
         ch25oiTksd0yMR8+N4quu0ZhOWUuWtnu+rJhqFi7BPI+v7STkt9v/6f2fyHhyTwf3U1J
         4jqeCQNa8ZTYOtJxo8xcUdrWun+Jusy17mmZt3Zakg5cNfNRES0U9dI4Jdz7OBW23y/u
         0TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bgloRoVrRNkcn0xVljkCkBk+raAyGylNVWWmVAvG1Ks=;
        b=ZwDLNzpxvTRt5z+l/5lWcwrFb+keQC1DvKLgcCvNJ1KAWCa6uGx9uPbatLyvaHtJkK
         vr3fVtV62Dv2cPKQiWktropfb5WxH42vy9uH0P1w9xmvaA5QxfML61r8Slmz0tFZ18Ut
         amZGOFMCBgRceWq4Z0BvauPwvfAMBhTheetaRjOzbnzIE4W/4wgJiDV4F2O2qs3ul590
         r9YdjQDrLNp9q5y4xPBYqU/TPKLop5Wrh7fj2ntC3prPruWUYsNaqLUx8RoVE556nGnw
         QcaYFNrJoQ7pEfBnGhsLLbSqDv/yCkR4NW3VOdGCQibMwvALf+d7TD5V9+yZ792nZRR2
         ZK1Q==
X-Gm-Message-State: APt69E32OTJ1rqNkhuszUclIJDcE0XwFmAQbkgXNcnGxwT9IgA986OFb
        TJajo1nB4McQrwKpkGr8ASQDWddOaZFYICIotBmWNg==
X-Google-Smtp-Source: AAOMgpd3BiGwo73AV48TyMhh9tq/4sxDyfhq0AvQ7gg/lYOwclfFUvyurj2rRDKVh1KVsAzvtVrYQQ4LqBYtXF0wgPw=
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr10070557wma.21.1530585247310;
 Mon, 02 Jul 2018 19:34:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7e92:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 19:33:46 -0700 (PDT)
In-Reply-To: <1776351430.10902.1530585009519.JavaMail.zimbra@efficios.com>
References: <20180702223143.4663-1-mathieu.desnoyers@efficios.com>
 <CA+55aFzZYOatOtjrm7fD7878_SzCAmEoEu74n0+pgd7faH-sTQ@mail.gmail.com>
 <825871008.10839.1530573419561.JavaMail.zimbra@efficios.com>
 <1959930320.10843.1530573742647.JavaMail.zimbra@efficios.com>
 <8B2E4CEB-3080-4602-8B62-774E400892EB@amacapital.net> <459661281.10865.1530580742205.JavaMail.zimbra@efficios.com>
 <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com>
 <CA+55aFxWMjwx-4TGBHt0H6bh6FXC3NKMsjp=eKGw5cgA4wMBUA@mail.gmail.com> <1776351430.10902.1530585009519.JavaMail.zimbra@efficios.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 2 Jul 2018 19:33:46 -0700
Message-ID: <CALCETrU0M1keBqeDyOsAEmgjY3p=JjD_rnt1Afnsdx2w3RE3hQ@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields, validate
 user inputs
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 7:30 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> ----- On Jul 2, 2018, at 10:18 PM, Linus Torvalds torvalds@linux-foundation.org wrote:
>
>> On Mon, Jul 2, 2018 at 7:01 PM Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>>>
>>> One thing to consider is how we will implement the load of that pointer
>>> on the kernel side.
>>
>> Use "get_user()". It works for 64-bit objects too, and it will be
>> atomic in the 32-bit sub-parts on a 32-bit architecture.
>
> Is it really ? Last time we had this discussion, not all architectures
> guaranteed that reading a 64-bit integer would happen in two atomic
> 32-bit sub-parts. This was the main motivation for the LINUX_FIELD_u32_u64()
> macro as it stands today (rather than using a union).
>

If you're nervous, you could do this by open-coding:

#if BITS_PER_LONG == 64
get_user(...)
#else
get_user(...);
get_user(...);
#endif

No need to make the header more complicated just for this.
