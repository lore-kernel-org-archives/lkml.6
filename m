Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61F1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DDE20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DDE20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeLAK0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:26:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43801 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeLAK0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:26:21 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so7776579qtj.10;
        Fri, 30 Nov 2018 15:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkSNgAo+H7Jozc4gFZfunSW1trvE5ym2eJgraeDyBvw=;
        b=H+ll32GZ9E6OkU5xfYnOipT39i+QvfW4WWwuosVMzi2uJqvHuHmr2wVNcQWIfa46rq
         /0FdQFdUWjJ75a21mKXTsvmn9VLJkJBso4k6DH9+pr1a97lIFyGUcLAO64tI0NvWYFAb
         B0TdMkk/Dr7gWChHK2k59cY5uE/I9/yum8NzTWXW8ckoWYu4Z4L8oRU9d8xrPkXCHkpC
         6jIVVHPrV0Oy8nmq4gPRavoqgL6WLzFIgNfk9/k7Emg2J0C6jLWW5OXnlyp0IOjtobxV
         oqcD7+rjVBkJr89K3+zHMt07vn70xpjFQIm3qZjrWTXbfZTEa6hOnXtKH9W6Tm745JlO
         qJWw==
X-Gm-Message-State: AA+aEWYdEEbn355XRvQUbt1NLoeUrrOohSB3HMqdKn1tx+2Jfidz53Mo
        7X5dQq3y9O+wxB2R5WDcTP7xGFyR204Z7Ur+Vog=
X-Google-Smtp-Source: AFSGD/WRuIsgynrOx9n2/uJAj0k7uAi53PXSqdNi+5cfLu2qDF6BCXWklGzzANzKwqBptMHMfWDxydAzT/9NlUYDcSc=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr7624613qvj.161.1543619726628;
 Fri, 30 Nov 2018 15:15:26 -0800 (PST)
MIME-Version: 1.0
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com>
 <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io>
 <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com>
 <20181129195551.woe2bl3z3yaysqb6@brauner.io> <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net>
 <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com>
 <87y39b2lm2.fsf@xmission.com> <20181130065606.kmilbbq46oeycjp5@brauner.io>
 <CAK8P3a0kqPii5TwFAo_JHLX=o_FDMFVKXxgzzbDjLFZ7OQ5QCQ@mail.gmail.com>
 <CALCETrW2aphWwEY4=hUwo_JBCvkQyMjxzxGd9FCW017kMLaMOQ@mail.gmail.com>
 <CAK8P3a1isSRCd-OLJK15C+gSJdpeR=zEXghc8+AMM5QYYw3Tyg@mail.gmail.com>
 <EC87B1BE-BDD0-414F-85F8-806C3CC4DD07@brauner.io> <CAKOZuesEPFnkd7YGbu82TRQwhR=KPwNW8GpYTw=719_xmJx9FA@mail.gmail.com>
 <CAK8P3a2x3nQKKvLBSH8G9R6w+sv=09y3h7gWdFYUMNAsB8aj6g@mail.gmail.com>
In-Reply-To: <CAK8P3a2x3nQKKvLBSH8G9R6w+sv=09y3h7gWdFYUMNAsB8aj6g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 1 Dec 2018 00:15:08 +0100
Message-ID: <CAK8P3a3XRLUsoG0GJ8mkp6LGHRHtVg0eV0RZfrMoPcEgyHcCZA@mail.gmail.com>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Daniel Colascione <dancol@google.com>
Cc:     christian@brauner.io, Andy Lutomirski <luto@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, cyphar@cyphar.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 1, 2018 at 12:12 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Dec 1, 2018 at 12:05 AM Daniel Colascione <dancol@google.com> wrote:
> > On Fri, Nov 30, 2018 at 2:26 PM Christian Brauner <christian@brauner.io> wrote:
> > > On December 1, 2018 11:09:58 AM GMT+13:00, Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > One humble point I would like to make is that what I care about most is a sensible way forward without having to redo essential parts of how syscalls work.
> > > I don't want to introduce a sane, small syscall that ends up breaking all over the place because we decided to fix past mistakes that technically have nothing to do with the patch itself.
> > > However, I do sympathize and understand these concerns.
> >
> > IMHO, it's fine to just replicate all the splits we have for the
> > existing signal system calls. It's ugly, but once it's done, it'll be
> > done for a long time. I can't see a need to add even more signal
> > system calls after this one.
>
> We definitely need waitid_time64() and rt_sigtimedwait_time64()
> in the very near future.

To clarify: we probably don't need rt_sigtimedwait_time64() for
x32, as it already has a 64-bit time_t. We might need waitid_time64()
or something similar though, since the plan now is to change the
time resolution for rusage to nanoseconds (__kernel_timespec)
now. The exact behavior and name of waitid_time64() is still
a matter of discussion.

       Arnd
