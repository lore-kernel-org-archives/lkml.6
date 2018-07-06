Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA809C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B42923E8C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiEqRIkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B42923E8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932820AbeGFLmw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:42:52 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36493 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932325AbeGFLmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:42:49 -0400
Received: by mail-lf0-f68.google.com with SMTP id n24-v6so9568078lfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 04:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LZBCz23dTOvVMzAYZe/RAkNlW0rOVuwJMy5qhuhS73A=;
        b=BiEqRIkNyQrDvgz0aKGxUhEZ79OQTYy278xAyHLuF2mbvK0uL9xnkiyi5XMAfjGnaj
         QnzhWY0Kz1F8pu7GEEe52azEIrPL+s+twvaWSsztw0pDqFBQO/CX28xgVEkyNE5ngGuX
         lGbyCbc4t+PV0cmR4kt3hpDBS1mj9QkzyNEqE07LlZuKrwq0IwALv41LiKl1lu4ensKJ
         nnCAskFbYVt92m2zIP8Rdiodmtdx9Wimqd5DxaDjtHEqwz0DyBA3HilCe32PYBI+TQnY
         pqlLBsyr5Co9rPho8ZTGzcPvKrY+llF4J9xRVGG+6x+2TfzNTKQB3cyZnw2ZDrO8jlfH
         Q31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LZBCz23dTOvVMzAYZe/RAkNlW0rOVuwJMy5qhuhS73A=;
        b=ZpQw9cP1hmCHeTU7xhDi/2TCB8uZpfwTtr8hb1nAvZxArPzY3t8nAspzuGFFaYStdX
         OPBMShQuIYYnm3wZ1WqsWoumAN8F5u+EBV16SQCraSUdTn4ymGHlfJpEDH75M5Oq2N1l
         Gjsgn1U3pR22vP/7v8JnCVgZ9tpfz8qXJ6N3wbcfHgETV7LtQMVHNvEFNdVV+rL/WZzP
         22yqvHRdoOYJYn8oQtc6YguTj3yA801p0ikGT/b3Pmt8Ps4Buv5P6eY/c9QsDG935CXG
         0YHnVhNI1pDSw4fIW95oCTBFRQEbCAs+bA3ogPmsAzXKIJMHccxGlzd/sC7ohUdLhfnf
         bMwg==
X-Gm-Message-State: APt69E06MmSzEMzvOF8ObHDqBrX9h+DKsTwXNiF4w4/V2BNmYL69ZfKk
        5QJNXApokAW3PE4P4lkqSiqSOW2l7xKMyji8WCU=
X-Google-Smtp-Source: AAOMgpeKTZUThlJlIY2gloYA8mZm7CYd5eM1qemQOgd6mcDdpzMlE8GXFctdfU7DSbKE6bUObrF2HKR9LmtBLz/GoC8=
X-Received: by 2002:a19:7b08:: with SMTP id w8-v6mr4858508lfc.22.1530877367174;
 Fri, 06 Jul 2018 04:42:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 04:42:46 -0700 (PDT)
In-Reply-To: <CABeXuvoj_WwvnaqY1wao+axx1JLpPte-iXP=Ti7jsT+r6VrVUg@mail.gmail.com>
References: <20180705213604.18883-1-deepa.kernel@gmail.com>
 <20180705213604.18883-4-deepa.kernel@gmail.com> <20180705222110.GA5698@infradead.org>
 <CABeXuvoj_WwvnaqY1wao+axx1JLpPte-iXP=Ti7jsT+r6VrVUg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Jul 2018 13:42:46 +0200
X-Google-Sender-Auth: PV6g8XZxv0LYxzvukZTd8t-YX9w
Message-ID: <CAK8P3a2L9z+Ok1Wd0=5F=Xt7nvqL6be+AS++F3rZzByN+a+9QA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] riscv: Include asm-generic/compat.h
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 1:56 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> On Thu, Jul 5, 2018 at 3:21 PM, Christoph Hellwig <hch@infradead.org> wrote:
>> On Thu, Jul 05, 2018 at 02:36:00PM -0700, Deepa Dinamani wrote:
>>> defconfig, allmodconfig and nomodconfig.
>>> And hence does not inlude definitions for compat data types.
>>>
>>> Now that time syscalls are being reused in non CONFIG_COMPAT
>>> modes, include asm-generic definitions for riscv.
>>>
>>> Alternative would be to make compat_time.h to be conditional on
>>> CONFIG_COMPAT_32BIT_TIME. But, since riscv is already has an
>>> asm/compat.h include the generic version instead.
>>
>> Two comments here:
>>
>> First I think the current riscv compat.h is completely bogus.
>> As you mentioned riscv does not actually have a compat mode, so
>> having a compat.h makes no sensse at all, and the COMPAT_UTS_MACHINE
>> override which is the only thing implemented is included in that
>> statement.
>
> I was leaving the decision on how to clean up compat mode to the
> architecture maintainers.
> I wasn't sure if they were still in the middle of implementing it.

If we only need it for 32 bit time_t, we can probably just use the
asm-generic/compat.h for now.

>> Second I think abusing compat.h for old syscall compatibility of any
>> form is a really bad idea.  I think you need to split that part out,
>> and preferably not using compat in the name, but something like
>> old-time.h or time32.h for the name.
>
> Are you talking about just the header file or the way we are reusing
> compat syscalls?
> Either way, we have merged quite a few patches this way already.
> I agree that having something like time32.h might be less confusing.
> But, if you are worried about the former, then maybe we should propose
> a cleanup after we finish what we are doing or back out the merged
> patches.
> For instance, posix_clock apis have already been changed this way.

It would be easy to rename compat_time_t, compat_timespec and
compat_timeval to something else if we could come up with a good
name for them (we already have too many variants of each of
them though, otherwise we end up being more confusing rather
than less).

We can also rename all the compat syscalls that are now shared
with 32-bit, e.g. using sys_waitid_time32() instead of
compat_sys_waitid(), and that would be consistent with the
new _time64() naming that we are introducing for some of them.
Right now, this affects around 30 syscalls; with my test tree on
ARM, I have this set of calls, the exact set is architecture
dependent of course:

compat_sys_time
compat_sys_stime
compat_sys_utime
compat_sys_gettimeofday
compat_sys_settimeofday
compat_sys_old_select
compat_sys_setitimer
compat_sys_getitimer
compat_sys_select
compat_sys_sched_rr_get_interval
compat_sys_nanosleep
compat_sys_rt_sigtimedwait
compat_sys_futex
compat_sys_io_getevents
compat_sys_timer_settime
compat_sys_timer_gettime
compat_sys_clock_settime
compat_sys_clock_gettime
compat_sys_clock_getres
compat_sys_clock_nanosleep
compat_sys_utimes
compat_sys_mq_timedsend
compat_sys_mq_timedreceive
compat_sys_futimesat
compat_sys_pselect6
compat_sys_ppoll
compat_sys_utimensat
compat_sys_timerfd_settime
compat_sys_timerfd_gettime
compat_sys_recvmmsg
compat_sys_io_pgetevents

Completely separating them from the compat code
would add further complexity though, as some of the
system calls take another argument that is different
between 32-bit and 64-bit kernels, in particular
pselect6, ppoll, io_pgetevents, recvmmsg, and waitid.

       Arnd
