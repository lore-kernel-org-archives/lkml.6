Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617D5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D7E2174A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D7E2174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeH0MKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:10:10 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37998 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0MKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:10:10 -0400
Received: by mail-qt0-f193.google.com with SMTP id x7-v6so17035057qtk.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 01:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flskQjD0tJjIp9ULbdk6HEhIyDxKDBKlQwmnIqtgf04=;
        b=FneXHLZKx20/Xru+tCQni6ac4wK7srnloXvo7CbzUmPfxmnBVlU9yIORUBCAr0xlbG
         wcvAco+ssYzu81VqBJpcin/J7KuUxZvWzPlCUPuRrdVVMkMI8UjcHbdexOORHodbsip2
         IeQwlbDOTDMNKd3HMOPXSjHiT1PP2HgOWH54EDmKjg3IXxOrLUXeRL4ZZO8/MpaVhivM
         juEjE85Ay1tBCFWU2/B3aXzCwg/GMzRgma27lLAwrV1rpYKDs3Ziqg4RNZZgjmUXLzY3
         G4rWxBB7/2m5viKoNhg/A1MT00/y9ufnkP5fkw4TzcTOj60bR8nEhWIh/NaNkydEN/CV
         JF0w==
X-Gm-Message-State: APzg51BKcUVMz4fdFhjqjgfvOVQzzmF1py1zCO/2t5F1zPzJLliN5WKB
        NnyVM+sqQwODrO23Qxej/y5x7LpMytVJ0Ysf77s=
X-Google-Smtp-Source: ANB0VdY292lcjmG7DNevo/geTrofjAibR+lGwlfJWSJosX1muG1L2XnNHvtGXWtRTW3wOyk2hlCzU3aBXaj7QNQ+0h8=
X-Received: by 2002:a0c:885b:: with SMTP id 27-v6mr12514686qvm.115.1535358272355;
 Mon, 27 Aug 2018 01:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <153527451522.1785.1711099585239615812.tglx@nanos.tec.linutronix.de>
 <153527451524.1785.7684129956167424331.tglx@nanos.tec.linutronix.de> <CA+55aFwBRzrWDsyzQLLurET_cfD4JNRPddNmFnJJodtLdLpL4w@mail.gmail.com>
In-Reply-To: <CA+55aFwBRzrWDsyzQLLurET_cfD4JNRPddNmFnJJodtLdLpL4w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Aug 2018 10:24:15 +0200
Message-ID: <CAK8P3a28q8PrKGFzp7fS98sXP0ZH3QS8s9gEuZo2DYWQ2CfzTQ@mail.gmail.com>
Subject: Re: [GIT pull] timer updates for 4.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 7:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Aug 26, 2018 at 2:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > New defines for the compat time* types so they can be shared between 32bit
> > and 64bit builds. Not used yet, but merging them now allows the actual
> > conversions to be merged through different maintainer trees without
> > dependencies
>
> So I pulled this, then looked at it a bit more, and went "that's stupid".
>
> Why introduce a completely useless new name for something we already have?
>
> Why can't the 32-bit code just use the "compat" names instead? Even
> for 32-bit systems, it's about compatibility with the old world order.
>
> So what's the advantage of calling it "old" over just calling it "compat"?
>
> I do not for a *second* believe that "compat" is somehow confusing to
> 32-bit architectures. They all have the new 64-bit time code already,
> it's not like there is any confusion what-so-ever about what is going
> on here.

I'd argue that Christoph was demonstrably confused by the usage on
32-bit architectures, and then argued strongly against it [1].

I postponed the series for the remaining syscall conversion based
on his feedback, but didn't manage to get it all ready in time.
If you think we should go back to the previous version, that would
also work, though I still think the new version is somewhat clearer
now, having implemented both of them.

The difference is best demonstrated with a syscall that takes
both time_t and other incompatible arguments.

a) old method: share the compat syscall between 64-bit and 32-bit
architectures, three entry points for a few syscalls:

/* native syscall, always 64-bit time_t */
SYSCALL_DEFINE4(rt_sigtimedwait, const sigset_t __user *, uthese,
   siginfo_t __user *, uinfo, const struct __kernel_timespec __user *, uts,
   size_t, sigsetsize)

/* native/compat syscall, always 32-bit time_t, ugly and confusing */
#ifdef CONFIG_COMPAT_32BIT_TIME
#ifndef CONFIG_COMPAT
#define compat_siginfo siginfo
#define compat_sigset_t sigset_t
#define copy_siginfo_to_user32 copy_siginfo_to_user
static inline int get_compat_sigset(sigset_t *set, const sigset_t
__user *compat)
{
 if (copy_from_user(set, compat, sizeof *set))
       return -EFAULT;
 return 0;
}
#endif
COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait,
   const compat_sigset_t __user *, uthese,
   compat_siginfo_t __user *, uinfo,
   const struct compat_timespec __user *, uts,
   compat_size_t, sigsetsize)
#endif

/* compat syscall for 32-bit sigset_t with 64-bit time_t */
#ifdef CONFIG_COMPAT
COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait_time64,
   const compat_sigset_t __user *, uthese,
   compat_siginfo_t __user *, uinfo,
   const struct __kernel_timespec __user *, uts,
   compat_size_t, sigsetsize)
#endif


b) new method: 32-bit old_time32_t, never use compat identifiers
  on 32-bit architectures, four entry points for a few syscalls

/* native sigset, 32-bit time */
#ifdef CONFIG_COMPAT_32BIT_TIME
SYSCALL_DEFINE4(rt_sigtimedwait_time32, const sigset_t __user *, uthese,
   siginfo_t __user *, uinfo, const struct old_timespec32 __user *, uts,
   size_t, sigsetsize)
#endif

/* native sigset, 64-bit time */
SYSCALL_DEFINE4(rt_sigtimedwait, const sigset_t __user *, uthese,
   siginfo_t __user *, uinfo, const struct __kernel_timespec __user *, uts,
   size_t, sigsetsize)

#ifdef CONFIG_COMPAT
/* compat sigset, 32-bit time */
#ifdef CONFIG_COMPAT_32BIT_TIME
COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait_time32,
   const compat_sigset_t __user *, uthese,
   compat_siginfo_t __user *, uinfo,
   const struct old_timespec32 __user *, uts,
   compat_size_t, sigsetsize)
#endif

/* compat sigset, 64-bit time */
COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait,
   const compat_sigset_t __user *, uthese,
   compat_siginfo_t __user *, uinfo,
   const struct __kernel_timespec __user *, uts,
   compat_size_t, sigsetsize)
#endif

Only a handful of syscalls actually require that complexity, most of them
need only two entry points either way (32-bit time, and 64-bit time), the
question is what we call them. I have a mild preference for the second
version after the discussion with Christoph, but I'm also fine with going back
to the orignal plan if you like that better after all.

       Arnd

[1] https://lore.kernel.org/lkml/20180705213604.18883-2-deepa.kernel@gmail.com/
