Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC74C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8983620BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ta1Rlspy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8983620BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbeGLOAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:00:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33988 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeGLOAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:00:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id f8-v6so4352480ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 06:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AtkEJxT8mN/BeY1ItHRWhkM+ayj5VqKeLGM3V2DIujA=;
        b=ta1RlspyLyTLAW//graGPjOmHceIR7axuCsFqzap9zTaYi2ZoFUVin1jUCzoRNVSmy
         9tyiN/86vTUhB1DMMOdVXS6d1JeT6kefkocyvsy+Rl8jM9I7CrD0aT2UEz6Pm/roS38p
         jPaQOz5pv1PvXt5BcFpOzdNJIYDTARZpN48u9vHlJGzf7/HpuwA9juPQ+FMuJ6kjAfLy
         VV/L08XfWeMgi16Fh9qbey4cJZQCckWUmKwbai2wZANDpfjxt8IdUkir9Kw+yjIVHsWC
         Img+MH9tmDdMPG8FJiv1Ojvnm+DKP1LrKB1DVFN6mEN73i3Yc7UGorep2VcbpsPtqeSM
         PbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AtkEJxT8mN/BeY1ItHRWhkM+ayj5VqKeLGM3V2DIujA=;
        b=CP65BGNAnS41MPZJ3O8s+mBqrIHVpa5PhtItsZ6PG+XFPRbxjPsmE+aYjTvf/M6KZI
         zPVxmhi6EuDmXuV7E10kpbyakYYxVCMenDvIJeDWJeFKVEw30vK32ACHOoqQNBlgfC0w
         1VRA5ipE+K8GiOGrQ/8TUeJV/cS3jayBrzg4FysQuJnl8tPkCTzSKI5AkiLkYZFcD0u4
         f9Zf7pnW1aarkhPq1x6egyZT9mwHr3mK9/Za7t6DXIkR6aX7si29lzb5qm3nOcZvtFtD
         HbnLjCrksWk8oGKGkOG6kGC8/NKUOipH0+pRi6cWgTWutMEJqfxpVsp870Uygu2nj/wM
         6wfg==
X-Gm-Message-State: AOUpUlF1wKn6/xScTKY0e3YLdzDP2pZ4+xlbzV4ABnshiXsBIBN7mHd0
        2aMKie9PZIPnhu89iFyPdmoarnuxHu7zVSqWTgw=
X-Google-Smtp-Source: AAOMgpfjBD1jiMWZcZ4kByYeIOsVrQDeZ7bcXanKmyeCA/noVpTcK+9622XT3wCb5YqeLrAY2aMEnH6HUDnn/C0Q47I=
X-Received: by 2002:a2e:1207:: with SMTP id t7-v6mr703233lje.129.1531403471419;
 Thu, 12 Jul 2018 06:51:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 06:51:10
 -0700 (PDT)
In-Reply-To: <CAMuHMdUOVdmeM9GohMQ6Ass8hWVDxezA0f+bKqGyH1OanMJtXA@mail.gmail.com>
References: <20180705213604.18883-1-deepa.kernel@gmail.com>
 <20180705213604.18883-4-deepa.kernel@gmail.com> <20180705222110.GA5698@infradead.org>
 <CABeXuvoj_WwvnaqY1wao+axx1JLpPte-iXP=Ti7jsT+r6VrVUg@mail.gmail.com>
 <CAK8P3a2L9z+Ok1Wd0=5F=Xt7nvqL6be+AS++F3rZzByN+a+9QA@mail.gmail.com> <CAMuHMdUOVdmeM9GohMQ6Ass8hWVDxezA0f+bKqGyH1OanMJtXA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Jul 2018 15:51:10 +0200
X-Google-Sender-Auth: _86t2ls9UuAsRece1AJ-0vrCM9Q
Message-ID: <CAK8P3a0JS6Rc4FXKu80MHAxc4b8JGqEQ9M-=4gACRk4OQ+VN8Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] riscv: Include asm-generic/compat.h
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 2:42 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Jul 6, 2018 at 1:43 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Jul 6, 2018 at 1:56 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>> > On Thu, Jul 5, 2018 at 3:21 PM, Christoph Hellwig <hch@infradead.org> wrote:
>> >> On Thu, Jul 05, 2018 at 02:36:00PM -0700, Deepa Dinamani wrote:
>>
>> It would be easy to rename compat_time_t, compat_timespec and
>> compat_timeval to something else if we could come up with a good
>> name for them (we already have too many variants of each of
>> them though, otherwise we end up being more confusing rather
>> than less).
>
> legacy_time_t etc.?

I think it should have '32' in the name, otherwise it might lead to confusion
regarding the size, as we also need legacy types that use 'long' (either
32-bit or 64-bit) seconds, besides the modern types that are always
64-bit.

In the previous patches, we introduced in the uapi

__kernel_timespec:     always 64-bit (both seconds and nanoseconds)
__kernel_old_timeval: replaces timeval (variable 'long' seconds/nanoseconds)

The __kernel_ prefix here signifies structures that are used in the
uapi headers and are possibly included in user space but must not
conflict with user space defined types like 'timeval' that can use either
'long' or 'long long' seconds in user space.

I would suggest we use __kernel_old_timespec for the equivalent
timespec variant (long/long) for consistency. I originally thought we
wouldn't need that one, but now it looks more likely that we do.
I still think we won't need a 64-bit '__kernel_timeval' type, but
it depends on what we do about getrusage(), getitimer() and
adjtimex().

For the pure 32-bit types, I'd prefer 'old' over 'legacy', which is
similar to the existing  __kernel_old_dev_t, __kernel_gid_t, and
__kernel_old_uid_t types, but we don't need the __kernel_
prefix because we would not use them in uapi headers.

I don't see a need for replacing compat_time_t right now
(I may be missing something I had in mind earlier), but
for timespec/timeval/itimerspec, how about old_timespec32,
old_timeval32 and old_itimerspec32 to replace
compat_timespec, compat_timeval and compat_itimerspec?

For itimerval, we probably need a __kernel_old_itimerval,
but no __kernel_itimerval or old_itimerval, similar to what we
do for timeval.

      Arnd
