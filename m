Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F63C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD962081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bbVhzyWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD962081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbeLDSH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:07:29 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37739 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeLDSH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:07:29 -0500
Received: by mail-yw1-f66.google.com with SMTP id h193so7354557ywc.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 10:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P7Q+6Q7EQjFQY2Xk7dt5+mUPd/Z6udMs7VDUul38GiA=;
        b=bbVhzyWIY8kUQeSTevtql7ECZm5YFj1+oHdNuuaWPu2Lt4+YuwyCtXs+Y2yrkhCMtP
         g+Odg3xrPj27rE+JCE4oRyCyWMLQTxHckyX8Qvcjl+fqnlxi368OXyzD7PXymIqqc/CC
         Wu2m8CBfn9e5XP4Gt6lttWEpS3qBII1ntA8g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P7Q+6Q7EQjFQY2Xk7dt5+mUPd/Z6udMs7VDUul38GiA=;
        b=rz47kIzcGQ2doh5wBzO7MkrexZEIb3lfVnc+uZk7T7PZ8DViKYstVn2OLWz6Tg6xxU
         xb6DUWqShondfcnHYMjtezHd48NcoHcTdnknvDf32iU+J+OJSLzi9iJD5Y3bEnpuHEA4
         RsSktzMs3hZFDCvkXQxiIxY7tCVSBxef9Uj0jCE9EA6oPZquIy26IDpDJvEjk+kX2uPI
         7SoSvNQ/fFeHp+soDjv7e/hMHH3iZsEaxfLSzclueOfQr+BxF8lRHNODBSfYgs2nYdnk
         lfCNAX+HrVBeEWKYQ7ADqA5dyXwnadzqi/68YNcbJXJNbZY6cci1CcLZjwfU6Bh+6VJn
         +mRA==
X-Gm-Message-State: AA+aEWamz/R2UFQ0EWCAN8R+DXujZril9YXGZ9EWEe+bqLrLJ3Xk3h4z
        e/aIGFozuHXMD/Ml/ustdclXyQzP0phzlteyrx4bGA==
X-Google-Smtp-Source: AFSGD/X3ZJmtgoo/0zrkgdqIjthFj0b3FkfEkhHvcMS7KUaNUvJU82dTfaBIEhj0Pu1xoMDbfzIt433J+IntVoMk+SM=
X-Received: by 2002:a81:9b8e:: with SMTP id s136mr20423301ywg.85.1543946848163;
 Tue, 04 Dec 2018 10:07:28 -0800 (PST)
MIME-Version: 1.0
References: <20181130150956.27620-1-anders.roxell@linaro.org>
 <20181203192228.GC29028@arm.com> <CAK8P3a2gekEqUuvsC-_+ijhiqqff2bK-s2wQfkjn7z-HtNnMDQ@mail.gmail.com>
 <20181204005012.11f73df9@vmware.local.home> <20181204111242.GA32596@arm.com> <20181204122627.225befaa@vmware.local.home>
In-Reply-To: <20181204122627.225befaa@vmware.local.home>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 4 Dec 2018 19:07:16 +0100
Message-ID: <CADYN=9K+On_Qbd_4a+C=59tffWiLF9YwACF4kXyTtDU1mazxjA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: ftrace: add cond_resched() to func ftrace_make_(call|nop)
To:     rostedt@goodmis.org
Cc:     Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        mingo@redhat.com, Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 at 18:26, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 4 Dec 2018 11:12:43 +0000
> Will Deacon <will.deacon@arm.com> wrote:
>
> > > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > > index 8ef9fc226037..42e89397778b 100644
> > > --- a/kernel/trace/ftrace.c
> > > +++ b/kernel/trace/ftrace.c
> > > @@ -2393,11 +2393,14 @@ void __weak ftrace_replace_code(int enable)
> > >  {
> > >     struct dyn_ftrace *rec;
> > >     struct ftrace_page *pg;
> > > +   bool schedulable;
> > >     int failed;
> > >
> > >     if (unlikely(ftrace_disabled))
> > >             return;
> > >
> > > +   schedulable = !irqs_disabled() & !preempt_count();
> >
> > Looks suspiciously like a bitwise preemptible() to me!
>
> Ah, thanks. Yeah, that should have been &&. But what did you expect.
> I didn't even compile this ;-)
>
> >
> > > +
> > >     do_for_each_ftrace_rec(pg, rec) {
> > >
> > >             if (rec->flags & FTRACE_FL_DISABLED)
> > > @@ -2409,6 +2412,8 @@ void __weak ftrace_replace_code(int enable)
> > >                     /* Stop processing */
> > >                     return;
> > >             }
> > > +           if (schedulable)
> > > +                   cond_resched();
> > >     } while_for_each_ftrace_rec();
> > >  }
> >
> > If this solves the problem in core code, them I'm all for it. Otherwise, I
> > was thinking of rolling our own ftrace_replace_code() for arm64, but that's
> > going to involve a fair amount of duplication.
> >
>
> If it does, then I'll add it. Or take a patch for it ;-)

I tested your patch. it worked.

I'll send a patch shortly.

Cheers,
Anders
