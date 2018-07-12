Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63442C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2738520875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2738520875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbeGLMvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:51:55 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:39996 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbeGLMvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:51:54 -0400
Received: by mail-ua0-f194.google.com with SMTP id p22-v6so7738682uao.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 05:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zeaJtmgS1URhbdJjPKHXx7AB5HLwy9a9Vc28w77bx14=;
        b=Tp+8N+IO2YwYQaAqGpUuNJaZ7EVmy4cQK3lBWMT90krGnVYV+d7z2GxGpB+9yYA61W
         zbWdyY72Q65qVNUNY156u91iCCC7Wk1S8w4+ZeLO8nTeSsjh0x/e0ANv3+VM73RoceHt
         H/dClkRuZvtWrM5qoHgoh7eut3fn+imH2NX0U3o3beAIcTybmezTqeMnLzIkGAXLBgxw
         NOM4uZNkERThjtiSCx/MPWoitBh1wqklOBPcTrg0Q4af5wa8OtMqTvznDYe3Mitvjp8y
         eRJc0b+idmZfFEO8fOCenh7iJ9qZsYXjtsgeRrnzHQ/Am4yv4bmB1iU01use88T8QQoB
         houg==
X-Gm-Message-State: AOUpUlHPRV/2dYMVthcBZJuN/O6Zc4J6Zk/Y7ddsGDWnKPCiS+Akbi8q
        J471TKFKFd02z//qBkQN9CSQzZSDUr0erTqCoGA=
X-Google-Smtp-Source: AAOMgpdnaIVNC43jraH+i+6K8LQMBFd+8Oh32FdsLPk+PEZwHKv289MhlFViNtd6TpWdt8DBveK1noTgd+lBDCbMZes=
X-Received: by 2002:ab0:72d1:: with SMTP id g17-v6mr1354494uap.33.1531399349841;
 Thu, 12 Jul 2018 05:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180705213604.18883-1-deepa.kernel@gmail.com>
 <20180705213604.18883-4-deepa.kernel@gmail.com> <20180705222110.GA5698@infradead.org>
 <CABeXuvoj_WwvnaqY1wao+axx1JLpPte-iXP=Ti7jsT+r6VrVUg@mail.gmail.com> <CAK8P3a2L9z+Ok1Wd0=5F=Xt7nvqL6be+AS++F3rZzByN+a+9QA@mail.gmail.com>
In-Reply-To: <CAK8P3a2L9z+Ok1Wd0=5F=Xt7nvqL6be+AS++F3rZzByN+a+9QA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Jul 2018 14:42:17 +0200
Message-ID: <CAMuHMdUOVdmeM9GohMQ6Ass8hWVDxezA0f+bKqGyH1OanMJtXA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] riscv: Include asm-generic/compat.h
To:     Arnd Bergmann <arnd@arndb.de>
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

Hi Arnd,

On Fri, Jul 6, 2018 at 1:43 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jul 6, 2018 at 1:56 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > On Thu, Jul 5, 2018 at 3:21 PM, Christoph Hellwig <hch@infradead.org> wrote:
> >> On Thu, Jul 05, 2018 at 02:36:00PM -0700, Deepa Dinamani wrote:
> >>> defconfig, allmodconfig and nomodconfig.
> >>> And hence does not inlude definitions for compat data types.
> >>>
> >>> Now that time syscalls are being reused in non CONFIG_COMPAT
> >>> modes, include asm-generic definitions for riscv.
> >>>
> >>> Alternative would be to make compat_time.h to be conditional on
> >>> CONFIG_COMPAT_32BIT_TIME. But, since riscv is already has an
> >>> asm/compat.h include the generic version instead.
> >>
> >> Two comments here:
> >>
> >> First I think the current riscv compat.h is completely bogus.
> >> As you mentioned riscv does not actually have a compat mode, so
> >> having a compat.h makes no sensse at all, and the COMPAT_UTS_MACHINE
> >> override which is the only thing implemented is included in that
> >> statement.
> >
> > I was leaving the decision on how to clean up compat mode to the
> > architecture maintainers.
> > I wasn't sure if they were still in the middle of implementing it.
>
> If we only need it for 32 bit time_t, we can probably just use the
> asm-generic/compat.h for now.
>
> >> Second I think abusing compat.h for old syscall compatibility of any
> >> form is a really bad idea.  I think you need to split that part out,
> >> and preferably not using compat in the name, but something like
> >> old-time.h or time32.h for the name.
> >
> > Are you talking about just the header file or the way we are reusing
> > compat syscalls?
> > Either way, we have merged quite a few patches this way already.
> > I agree that having something like time32.h might be less confusing.
> > But, if you are worried about the former, then maybe we should propose
> > a cleanup after we finish what we are doing or back out the merged
> > patches.
> > For instance, posix_clock apis have already been changed this way.
>
> It would be easy to rename compat_time_t, compat_timespec and
> compat_timeval to something else if we could come up with a good
> name for them (we already have too many variants of each of
> them though, otherwise we end up being more confusing rather
> than less).

legacy_time_t etc.?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
