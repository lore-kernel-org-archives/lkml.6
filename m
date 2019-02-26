Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D74CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 01:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF29F21841
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 01:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goPSelBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfBZBWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 20:22:34 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37155 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfBZBWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 20:22:34 -0500
Received: by mail-it1-f193.google.com with SMTP id z124so1649579itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 17:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXP1J+cHQxI0b4CTcxiobw2lTVvZpzJW50/AN35NPKw=;
        b=goPSelBNIEDexjM/xmCW7PUFRr/1JFmebExiyzmoivtY4X8KtDFFO2V2CMbg9M5Ao/
         fJMg7IbuD0ZmDuD9fot5tP2v8E3WJYDZjWvjTjomestACIwJ5/yoAAh2HOybreU1ZtzK
         OUIh9pV/ZoZItIZj6bxqv8rsLdR5aqbLwCBpqpzjCsFdY3+hAMvp2XLRcB9B5+noF/Zx
         PbsJg7N1iXMbiRXfpu0PxO0knLujiarQ9aBNaUZ1RaPGFzhaycfkRjC1IxCPSCp6S5Em
         v+onesBQ6chZTV3oViwiUSckj8WUXypyIBmLtB1Qg05fCUP9GxWOy68eWej5FuX3Aiyy
         NwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXP1J+cHQxI0b4CTcxiobw2lTVvZpzJW50/AN35NPKw=;
        b=IHXJWBZOw6NjKU5ORoUT1TjC7hg9cJH5+3Foirbbafq/DXJTrAIDZe6RCadT3wwlDT
         OT9iJU6PWoPJLphhT+tLUpQyptEKr3Zf76yprpF6j+k5lhxIOigxclQgxGDclNfaUSps
         esP+JEWIGKi7KWyJAJnfXxQqvy50Axoip+EJBGDm15/4U8FrqrQwdIFIfMez2wfTDAd1
         q1UR2S8k6V07+6J6MC8SsxOjvUBwzkoPbyluh6lIVDBE9bV12HH5oBctRutpm5mfNoYZ
         +T1psps9pXj2BdYUjds5zkuB9ZXRPDS7N7Covu7N8vR+iHUP9RrY9PhbpMx8l+fshfeA
         VfIg==
X-Gm-Message-State: APjAAAU/BntIqkhRWwK2eha1GIvp8AgtOzmyEWdNn1zGaIjGY38Q3r17
        5+wJ0st5HG1o7Jg25isj3YychFXlP08J0rFcq5c=
X-Google-Smtp-Source: AHgI3IZu5ydEbTInkUL9VhRmDylGu7ycx6PdrWYZRRgL16emUmOy90p1RiK2Oe9T0ChdqbEVLg6WhapAvZSW4AwmZvw=
X-Received: by 2002:a24:3dd1:: with SMTP id n200mr1083197itn.61.1551144151466;
 Mon, 25 Feb 2019 17:22:31 -0800 (PST)
MIME-Version: 1.0
References: <20190225032619.17070-1-yaohongbo@huawei.com> <CABeXuvqOEqN7fRa1pkLKNhNckoUpCoyxKRdieD+UE8DFt+yQ+g@mail.gmail.com>
 <CAK8P3a0N7BpMwXfGtVcH3L40VqmPypvemPUC8_SEwSUinG-B8A@mail.gmail.com>
In-Reply-To: <CAK8P3a0N7BpMwXfGtVcH3L40VqmPypvemPUC8_SEwSUinG-B8A@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Mon, 25 Feb 2019 17:22:19 -0800
Message-ID: <CABeXuvrmLkrKf0MQr0qRPG_Th9=FMT1HxCgtHmzPm7RkiuJyBg@mail.gmail.com>
Subject: Re: [PATCH] time64: Avoid undefined behaviour in timespec64_add()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hongbo Yao <yaohongbo@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 1:02 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Feb 25, 2019 at 5:53 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > On Sun, Feb 24, 2019 at 7:13 PM Hongbo Yao <yaohongbo@huawei.com> wrote:
> > >
> > > I ran into this:
> > >         =========================================================================
> > >         UBSAN: Undefined behaviour in ./include/linux/time64.h:70:2
> > >         signed integer overflow:
> > >         1551059291 + 9223372036854775807 cannot be represented in type 'long
> > >         long int'
> > >         CPU: 5 PID: 20064 Comm: syz-executor.2 Not tainted 4.19.24 #4
> > >         Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > >         1.10.2-1ubuntu1 04/01/2014
> > >         Call Trace:
> > >          __dump_stack lib/dump_stack.c:77 [inline]
> > >          dump_stack+0xca/0x13e lib/dump_stack.c:113
> > >          ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
> > >          handle_overflow+0x193/0x1e2 lib/ubsan.c:190
> > >          timespec64_add include/linux/time64.h:70 [inline]
> ...
> > > Since lhs.tv_sec and rhs.tv_sec are both time64_t, this is a signed
> > > addition which will cause undefined behaviour on overflow.
>
> I wonder if we should treat this as undefined behavior in the kernel or not:
> The kernel is build with -fno-strict-overflow, so signed integer overflow
> is supposed to behave the same way as unsigned, and assume
> two's-complement arithmetic.

Another option is to saturate or return error when possible.
2's complement arithmetic lets us check for overflow. So I feel this
is nice for timespec64_add().

> > > @@ -67,7 +67,7 @@ static inline struct timespec64 timespec64_add(struct timespec64 lhs,
> > >                                                 struct timespec64 rhs)
> > >  {
> > >         struct timespec64 ts_delta;
> > > -       set_normalized_timespec64(&ts_delta, lhs.tv_sec + rhs.tv_sec,
> > > +       set_normalized_timespec64(&ts_delta, (timeu64_t)lhs.tv_sec + rhs.tv_sec,
> > >                                 lhs.tv_nsec + rhs.tv_nsec);
> > >         return ts_delta;
> > >  }
> >
> > There is already a timespec64_add_safe() to account for such
> > overflows. That assumes both the timespec64 values are positive.
> > But, timekeeping_inject_offset() cannot use that as one of the values
> > can be negative.
>
> We could perhaps extend timespec64_add_safe() to handle both
> overflow and underflow, and allow negative arguments. It would
> have to use some extra checks then.

I was thinking the reason for having just timespec64_add() is that the
caller makes these checks in case they want to return an error on
overflow. The safe version will just saturate and caller is unaware.

> There are actually only
> a very small number of callers to timespec64_add():
>
> arch/arm/xen/enlighten.c:       *ts = timespec64_add(now, ts_monotonic);
> arch/arm/xen/enlighten.c:       system_time = timespec64_add(now,
> tk->wall_to_monotonic);
> drivers/net/ethernet/cadence/macb_ptp.c:                now =
> timespec64_add(now, then);
> drivers/net/ethernet/intel/igb/igb_main.c:              ts =
> timespec64_add(adapter->perout[0].start,
> drivers/net/ethernet/intel/igb/igb_main.c:              ts =
> timespec64_add(adapter->perout[1].start,
> drivers/net/ethernet/intel/igb/igb_ptp.c:       now = timespec64_add(now, then);
> fs/cifs/dfs_cache.c:    return timespec64_add(now, ts);
> include/linux/rtc.h:    *to_set = timespec64_add(*now, delay);
> include/linux/time64.h:static inline struct timespec64
> timespec64_add(struct timespec64 lhs,
> kernel/time/timekeeping.c:      tmp = timespec64_add(tk_xtime(tk), *ts);
> kernel/time/timekeeping.c:
> timespec64_add(timekeeping_suspend_time, delta_delta);
> net/ceph/messenger.c:           ts =
> timespec64_add(con->last_keepalive_ack, ts);
>
> It looks like an actual overflow would be really bad in most of these,
> regardless
> of the undefined behavior.

I can look at sanitizing whatever you haven't started on.

> > Are you running some kind of a fuzzer that would cause a overflow?
> > You seem to be adding INT64_MAX here. Maybe the right thing to do is
> > to add a check at the syscall interface rather than here.
>
> Returning an error from the syscall here sounds like a good idea. I'm
> not sure what we should do about the time32 version of adjtimex though
> if we decide we want that. Should we just reject any times there that
> result in a time outside of the 1970..2038 range?

utimes_common() does not return an error right now and fails silently
when the filesystem is not able to represent times. And, POSIX seems
ambiguous here.
Should both these syscalls match in behavior?

-Deepa


-Deepa
