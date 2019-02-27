Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FF9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC13217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knrIfGMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfB0Pkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:40:41 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34668 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfB0Pkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 10:40:41 -0500
Received: by mail-io1-f66.google.com with SMTP id e1so13891516iok.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 07:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FTlGzrdjHMspvPIovy1tEc6cpfkFlq6LIdNnJjIV4s=;
        b=knrIfGMpqIIDo3JVnjW0sniiT/hRvj9nuMqTzyhnTQAGG2dOuve4GL2Z73nLlxgb1L
         djA/ci0Vmi2xjHnWcgGlXzAChuvvGS2J8uSpOKUNv6PJqB4S+RXLTLQv6fXQgsFooeaf
         7HL0QIdnZkZw3qfgHFT4iqa/zOn32Lr5Nlaa94ZBNVX5MX5UrF8MYgnPNcTswgIKBYIo
         9rcVB/VLERykqhVkeJT6o2sgQP9QK1ssOTPpRObMkk9UY8BtjE6PaqYeyj4UdpTcePvH
         q3ZILJh7LndlhrMFVpLdjpxs9BeyhTSgsPWZ2NQzZnKR8D5lpYtSLnhMoclVbFTqftH8
         aBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FTlGzrdjHMspvPIovy1tEc6cpfkFlq6LIdNnJjIV4s=;
        b=lBHXsE0rXIVFvVVrBJ1iakT4JzKhINHUOxOgxm26vv9LcxKDBdYQDxFVHv0TkA4mDQ
         xhJQIk8qndLWH3cYFu0neF/kBRx53HY16GKhWbnmhs/OILghrlxegAAdOaWi1YuazNWt
         WWam1MJH9RfQS8lB9bltKyNtqPWreXOr4Bs0OMON0VZ9i5jKZ42e5B8gy5Yp6P+cbcY9
         BEKqT1nwCF4F/Xg97KQ6hGyJzHE5YF3kGFLYnapVSMxFQAGquea0bQ3tWmpW77gZn8a8
         oT6BH1p6n0rVp+auYcQnJXUHDQNGNmSiWU6YZLd9fnjPM8LU3p2svfc7+wzHKHrHLUR6
         XW6g==
X-Gm-Message-State: APjAAAUpwQbHCPzh6FAuPPg6U2BBzt7jF1LgkcwhY6t2EEu4AAk6+Q6h
        TjRIQ+qVVQMsDrBz8lxX5Q29UAILfSWmaJP1vkJJ2A==
X-Google-Smtp-Source: APXvYqzXmXnklrKv6IfpmJ5vf4nQYE/MfubazZH3gQED2Xx1Yz5VnfoQtZAZdRN5Cj7vtq18qZ9LlbXpd/t1j7nkYrI=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr1995974ioc.282.1551282039567;
 Wed, 27 Feb 2019 07:40:39 -0800 (PST)
MIME-Version: 1.0
References: <20190225124330.613028745@infradead.org> <20190225125232.191698923@infradead.org>
 <20190227140830.GP32494@hirez.programming.kicks-ass.net> <19b35cb1-9527-2e15-6deb-9ce7c1ef1d66@virtuozzo.com>
 <20190227142623.GR32494@hirez.programming.kicks-ass.net> <20190227143313.GK32534@hirez.programming.kicks-ass.net>
In-Reply-To: <20190227143313.GK32534@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 27 Feb 2019 16:40:28 +0100
Message-ID: <CACT4Y+a9yJvwzwVcjhyOkJUdMp05mxW1++EduLLa2M_buQ7OhA@mail.gmail.com>
Subject: Re: [PATCH 5/6] objtool: Add UACCESS validation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 3:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 27, 2019 at 03:26:23PM +0100, Peter Zijlstra wrote:
> > On Wed, Feb 27, 2019 at 05:17:58PM +0300, Andrey Ryabinin wrote:
> > >
> > >
> > > On 2/27/19 5:08 PM, Peter Zijlstra wrote:
> >
> > > > I can't actually find any definitions of those functions, so I can't
> > > > very well mark the safe, even if we wanted to.
> > > >
> > >
> > > They are macro-generated. Use 'git grep DEFINE_ASAN'
> >
> > Ah, indeed! I'll go have a look.
>
> Urgh, kasan_report() is definitely unsafe. Now, admitedly we should
> 'never' hit that, but it does leave us up a creek without a paddle.
>
> Not sure what to do here; best I can come up with atm. is kill SMAP on
> KASAN builds.

If SMAP detects additional bugs, then it would be pity to disable it
with KASAN (detect bugs in production but not during testing).

You mentioned that exception save/restore the UACCESS state. Is it
possible to do the same in kasan_report? At the very least we need to
survive report printing, what happens after that does not matter much
(we've corrupted memory by now anyway).
