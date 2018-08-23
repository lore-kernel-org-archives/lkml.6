Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5F0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F95820A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="yqbUxqIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F95820A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbeHWDzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 23:55:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45129 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeHWDzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 23:55:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id 20-v6so3028739wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 17:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6L+ncNStlKcOxmgbMiAHgbGIXqLn7eK23P7cqWQBDR4=;
        b=yqbUxqIjVAnQ2ymuUlJuQh+ZEcLRNaBisFQfQ2hlOkStQCHwuAosMGTqcoQMI2d1CO
         OrqD9ZqOcWOn1/f9A9F6iCyx8tlcN4KiPuk54lP8f10rs+rvkeEwWk2NE1uUQIBbj0CF
         1k6+66LkGHEBO2SWDaLeg+iH+6hj3wdvYBHpp/kswDWBA1A9GYnewKnWl/1PNKmeJaGs
         q6hjSXo/GuDiMbPivoq7urk4/7wFqP74w1P10HYQyxlrEWxsU6nMEGAqxGyDqhd41g5I
         ZGYzqaSaEhrOb23e1Q//xk9TqwJuNJHVPgob33+kuUd8bJf4YUL6ROqnau0OjTD0lfTP
         Gkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6L+ncNStlKcOxmgbMiAHgbGIXqLn7eK23P7cqWQBDR4=;
        b=RdHaYzmEugt4ZAADpiRs1goEG6qgmoKYYB+mJXNqlc9DpFUE7I2NQPT+I4NKWQuNC2
         dzHTyFTuZn7sdfHXmF7wDE9/WIjJ7iTM5EwaFF/D4fO00MHmbcaKM0WZbYtnzM28/G/Q
         zBlX0AcazZniCWexE/xhrxAHYp+ko8wgbyQTOjrCa14nfDxXDO1XEMDN5smTz72QBmVv
         eF+9zm3u7b0Jse9khRQMvMbtK/q7GX6WAWc4VIFuwTqKaO3F2wIJuIoLXdHInQfPLVI9
         0ubrYlRpQqQG+qpTHqPNb3IwmTjAeuL0SEHGtWuNiSSRK0kxVfadkjK2Qt72F+3yb5ZF
         UtTg==
X-Gm-Message-State: AOUpUlFl3rqvy8k+v3goPbyEsa4CUvWnAydk1tJ0PXdSzaOvGfCsO3ap
        nkY6lrDOdwqdtD1aDRfqDz3yc/ilwVOljUOw+H3sAw==
X-Google-Smtp-Source: AA+uWPzXBhIkTrUJOArWO2mXGRJjREyqLh0SWMIcV0HJwIsg2ABTABUjJq8ROtXU1oL6Gbl8ZyldZ+4QQih6FEoSyUs=
X-Received: by 2002:adf:c554:: with SMTP id s20-v6mr35686781wrf.46.1534984124465;
 Wed, 22 Aug 2018 17:28:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 17:28:24 -0700 (PDT)
In-Reply-To: <CAG48ez0c0L+WyfjDcfx=3wDwOQDOSJM-2JSVUBoWJCaKDVEfbw@mail.gmail.com>
References: <20180807012257.20157-1-jannh@google.com> <C6369CAA-CBB8-420F-97DB-7A242D9650A8@amacapital.net>
 <CAG48ez0c0L+WyfjDcfx=3wDwOQDOSJM-2JSVUBoWJCaKDVEfbw@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 22 Aug 2018 17:28:24 -0700
Message-ID: <CALCETrU6gUBiTkpAUKh97y2R1cSftbMcfSTnSYxhZFRKf7vGWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] x86: WARN() when uaccess helpers fault on kernel addresses
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 4:53 PM, Jann Horn <jannh@google.com> wrote:
> On Tue, Aug 7, 2018 at 4:55 AM Andy Lutomirski <luto@amacapital.net> wrote:
>> > On Aug 6, 2018, at 6:22 PM, Jann Horn <jannh@google.com> wrote:
>> > There have been multiple kernel vulnerabilities that permitted userspace to
>> > pass completely unchecked pointers through to userspace accessors:
>> >
>> > - the waitid() bug - commit 96ca579a1ecc ("waitid(): Add missing
>> >  access_ok() checks")
>> > - the sg/bsg read/write APIs
>> > - the infiniband read/write APIs
>> >
>> > These don't happen all that often, but when they do happen, it is hard to
>> > test for them properly; and it is probably also hard to discover them with
>> > fuzzing. Even when an unmapped kernel address is supplied to such buggy
>> > code, it just returns -EFAULT instead of doing a proper BUG() or at least
>> > WARN().
>> >
>> > This patch attempts to make such misbehaving code a bit more visible by
>> > WARN()ing in the pagefault handler code when a userspace accessor causes
>> > #PF on a kernel address and the current context isn't whitelisted.
>>
>> I like this a lot, and, in fact, I once wrote a patch to do something similar. It was before the fancy extable code, though, so it was a mess.  Here are some thoughts:
>>
>> - It should be three patches. One patch to add the _UA annotations, one to improve the info passes to the handlers, and one to change behavior.
>>
>> - You should pass the vector, the error code, and the address to the handler.
>
> I'm polishing the patch a bit, and I've noticed that to plumb the
> error code and address through properly, I might need significantly
> more code churn because of kprobes - I want to make sure I'm not going
> down the completely wrong path here.
>
> I'm extending fixup_exception() to take two extra args "unsigned long
> error_code, unsigned long fault_addr". Most callers of
> fixup_exception() are fairly straightforward, but
> kprobe_fault_handler() has a dozen callchains from different exception
> handlers, and most of them are coming via notify_die().

KILL IT WITH FIRE!!!!!!!!

More seriously, kill kprobe_exceptions_notify() and just fold the
contents into do_general_protection().  This notifier chain crap is
incomprehensible.  I would love to see notify_die() removed entirely,
and crap like this is just more reason to want it gone.

> I think there's also some inconsistency between #PF and #GP in the
> ordering of error handling:

It's probably a bug.  It's also probably irrelevant, but maybe not.
