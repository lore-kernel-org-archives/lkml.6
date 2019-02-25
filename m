Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A231C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075682087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="RbSdFh8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfBYPmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:42:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34991 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfBYPmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:42:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id y15so8544853wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 07:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/PhMVer6cJ+0OmNDHeuEY29H9bgR5jD9IGeXAW6c908=;
        b=RbSdFh8+9GMLKl/GTWpQxhxZy0plUn5SiiQZIk8HV05DN+U/cr4knPT5IjkbsfKgZn
         bJNrcxB7pKFU1VYOvlSy5pZiPwFN+0N+xZta4hehf/A8qB6UYRqnwGzAxt4QqchzpyB+
         kzoMKUQ3bJcLnx09XCXD06K10phtMKBjHZy1QjJECWAmqnGCBwRYrkF2msluV6tU5WNZ
         4XQsmVVX53jJ3IoaFfBbE0+LY69hMClW5EYtiNqi0PcFayPmnIaPnXYjfeIszEVebKew
         R71gO1xEEBkYRTR5jDd91hzJ+P0Ovut+9K2uwoO09aYPnH98yYpSI8xo924bSzSPC1z8
         Zu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/PhMVer6cJ+0OmNDHeuEY29H9bgR5jD9IGeXAW6c908=;
        b=pqBVlPRe15JlUXjoLxwgb0OZcva5hkFvmFkNTNIbCkWIsEy5qIQhihotd9c5FloCQy
         PMUp7Kb2nDUd6976V3x0ac0HiredbyQEDIY+YS5Y+fYZUelT+k1aOd0YmErFxd9kyirK
         1j9EcuRJFFhu8pfSQKC5R5PiYxSTHL13qeOMgnxziN0PfLqPtOaAVBhI66dqq0cYtdTc
         R03vC4e3PiJLdaBCTQNXMlsneFUblH69e8azZUnXGuOUZkP6phgp/0aTO6o3k9ZAxgYT
         mdxkkgQjgA8YIk/VaevcV0nxZHCjDUgYxbGHtmlfq4q7ViIMiaNxExRUTTFMwgUI6IoF
         Noxg==
X-Gm-Message-State: AHQUAuajMTI/aCV81eOw+/gHGkWDOmlnGXiujq62P9NhQxybWlM+f3c9
        DhiabwJqH40jAhKmOU3UfsEjiYkL35v4WFe/MAm7sA==
X-Google-Smtp-Source: AHgI3IYAn81bMpLrqZGTZ98Hkj79YTsZYogW/6mDjLpxRvqyc8eE7wF7Bb9k0y4Js4R0w0HCv7ZDL7CL1WBE0AF6QZ4=
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr10827034wml.108.1551109322740;
 Mon, 25 Feb 2019 07:42:02 -0800 (PST)
MIME-Version: 1.0
References: <20190225124330.613028745@infradead.org> <20190225125231.936952143@infradead.org>
In-Reply-To: <20190225125231.936952143@infradead.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 25 Feb 2019 07:41:50 -0800
Message-ID: <CALCETrW-p4iF-RMecyNt1JDwKh74c_tw67FCW7Yr_Fd3adtGUw@mail.gmail.com>
Subject: Re: [PATCH 2/6] x86/ia32: Fix ia32_restore_sigcontext AC leak
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 4:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Don't call load_gs_index() with AC set; delay the segment setting
> until after the AC section.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/ia32/ia32_signal.c |   29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> --- a/arch/x86/ia32/ia32_signal.c
> +++ b/arch/x86/ia32/ia32_signal.c
> @@ -60,17 +60,21 @@
>         regs->seg = GET_SEG(seg) | 3;                   \
>  } while (0)
>
> -#define RELOAD_SEG(seg)                {               \
> -       unsigned int pre = GET_SEG(seg);        \
> -       unsigned int cur = get_user_seg(seg);   \
> -       pre |= 3;                               \
> -       if (pre != cur)                         \
> -               set_user_seg(seg, pre);         \
> +#define LOAD_SEG(seg)          {                       \
> +       pre_##seg = 3 | GET_SEG(seg);                   \
> +       cur_##seg = get_user_seg(seg);                  \
> +}
> +
> +#define RELOAD_SEG(seg)                {                       \
> +       if (pre_##seg != cur_##seg)                     \
> +               set_user_seg(seg, pre_##seg);           \
>  }

This is so tangled.

How about changing RELOAD_SEG to replace unsigned int pre =
GET_SEG(seg); with unsigned int pre = (seg); to make it less magic.
Then do:

unsigned int gs = GET_SEG(gs);

...

RELOAD_SEG(gs);

And now the code actually does what it looks like it does.
