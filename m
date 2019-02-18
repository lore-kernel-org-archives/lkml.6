Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369BEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F7121736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bcffL92+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391772AbfBRR7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:59:08 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46131 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391701AbfBRR7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:59:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id v16so15097200ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 09:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZSrGBeMt8miQsxUb0HHnQwJnv/0AoLI/ruohepXj4A=;
        b=bcffL92+OgnG/ODd3BcH05qeWSmqCDg8HJ0Loh3CX++i3nu7xeU902kZgS1f3plb7h
         gAxdyhj1v7IVbGmZa053r4tFZ2PAT+ovnhQX9K/4fEjR9tjoQXjacTRB0ZiaWIWzEqIW
         3noKgeKms5w7N+sW/+mAx1nHhPtn2Tz4HZraY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZSrGBeMt8miQsxUb0HHnQwJnv/0AoLI/ruohepXj4A=;
        b=P4gxwJ9xBuIM4+0h6pYfPmqONe9ys18e0rELeh5fJgv49drlhr4eAMxDSbpafYa9kL
         wK/Q7dYI+ExMxRqBVXA7UQnak6xOwxLsEuSJxG5j7bOWm7XBfhFHROO9Dg9RHgX+IfN2
         /7f5gKy49Kp9jX6+1/D8ub1o0Cr9M47GXSkbuOl4HsmkFBQOsaEU1Zpf9I/dS3TBeaBu
         2IHQw8GqWKZdPh7I9TsCvAS52AuH1pYreS9sbioEeG96GUaJFEowHb7qcmj/pL/Jb7/E
         thEHS3uJEIe+BKv3O5oZimqe5wLca/WYocny68Zm5/2u4Es8H3W6x0bYFtYGQV5fU3ve
         MFIQ==
X-Gm-Message-State: AHQUAuah+vQYJ1RWhC96r8cw063EfyQPLafDamujce7uioEtR1auSNr3
        6bYiKLHDudje+NEw1iF1HEf97F+Mzko=
X-Google-Smtp-Source: AHgI3IbcHcfz7na0ukbGU0au3+s4pDjorQhbbPSWvgxi8XLlX3kZYrXu5PrFClYjjNQbT5rgYNqD6Q==
X-Received: by 2002:a2e:85cf:: with SMTP id h15mr14662494ljj.73.1550512741833;
        Mon, 18 Feb 2019 09:59:01 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id j14sm3610180lji.32.2019.02.18.09.59.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 09:59:01 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id g12so3332739lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 09:59:00 -0800 (PST)
X-Received: by 2002:ac2:4433:: with SMTP id w19mr14380382lfl.67.1550512740346;
 Mon, 18 Feb 2019 09:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20190215174712.372898450@goodmis.org> <20190215174945.557218316@goodmis.org>
 <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com>
 <20190215171539.4682f0b4@gandalf.local.home> <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net>
 <20190215191949.04604191@gandalf.local.home>
In-Reply-To: <20190215191949.04604191@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Feb 2019 09:58:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
Message-ID: <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Sorry for not looking at this earlier, I have family in town so I
was mostly busy over the weekend... ]

On Fri, Feb 15, 2019 at 4:19 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Would changing all the mention of "kernel address" to "non user space"
> be accurate?

That would have worked, but in the meantime I just decided to pull the
existing tag, because it's not _horribly_ misleading any more and now
we're just talking details of what is a "kernel address" etc. And the
patch itself is better than what we used to have.

That said, I do agree with Andy that both the old
_copy_from_user_inatomic() thing and the new probe_mem_read() are just
fundamentally broken, nasty and slow. It just so happens that
probe_mem_read() works _reasonably_ well in practice on x86.

Basically, probe_mem_read() -> probe_kernel_read() really only works
on true kernel addresses. And some of that is very fundamental: some
architectures can have two entirely different address spaces for user
and kernel memory, so if you give _any_ function an "try to read this
address", it fundamentally has to be one or the other.

The fact that on x86, there is a unified address space for
kernel/user, and it can work for one or the other, is just
happenstance (and admittedly the common case).

So I've pulled the existing pull request, because it papers over one
particular issue, but the real fix would require:

 - knowing whether it's kernel or user space you access

 - actually using that knowledge to then limit the addresses we are
willing to probe, and _how_ we probe them.

The user-space case is fairly easy: just check the address with
"access_ok()", and then use _copy_user_atomic() without any set_fs()
games. That should "JustWork(tm)".

And if it's truly supposed to be a kernel address, then we probably
need to add a "is this possibly a valid kernel data pointer"
interface. Before we then do what "probe_kernel_read()" currently
does.

               Linus
