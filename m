Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53FEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3EC2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fkCgTRCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfBYRBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:01:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37313 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbfBYRBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:01:19 -0500
Received: by mail-lj1-f196.google.com with SMTP id a17so8058243ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 09:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fw37tU+LNZHOvKdIAztuIbfp+4xwi2klt2Zgxp9NXUw=;
        b=fkCgTRCIhak0c2EnwXj1zVVxvk9Jx5hwBS3CNf8U0KYdZgADoO6WmdKZkk459DdgNG
         b6DB4RbZtYQSh3IXUHTxHAB8iKDYHdJI4wrZ3KO2mCP7Mpoaf/S0isE1bUIhN9xbXpVE
         M38JO1CMwBJR81raAcfRbGeHjDHGSwuKIjWVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fw37tU+LNZHOvKdIAztuIbfp+4xwi2klt2Zgxp9NXUw=;
        b=kjYjm0ga4ASuS8/BxpG1FiahXHHA8oVFf9GwCbvAOOhttMnFbt5Og3o317FkRtLa8T
         RxxxFETwbz/BSKK8DykC6YtaSBkwN0CbK10fYNI+3D2PSddXjRtQFbB/tAPNS0yR6Mi6
         zbY3Q9U03votKTtfpUCrVBstL2mL6k9tCux7czSwvBUkd6wMFKSwkqCsnwILsTZa12hQ
         toW8+PaLE7wc4I0ewJNJqqR14Idnqz9RaJlHrWcyoJ8wo8gsMyA4yfak488C+SuAcB+b
         V6XAGpKb4oa8wcrNKHYZRlWexQIiKLFGaVs483SWBXwRjNp/8q2O1ldarZvN3V7q/tPf
         4OAQ==
X-Gm-Message-State: AHQUAuahaovYk2LZOx6R6jTAWnYHDKo6BqoamZ4VM5q4lXO1U56rMqYo
        pKa/RwU8X8r/gwQLn3fZ3jhTEjGIyyc=
X-Google-Smtp-Source: AHgI3IaCqXIP725nYywP3P9+iQCiNErB0Vu4V0bH+hxUff9i1EyPQBPXXhrml5W201XNj9yfV2LEiA==
X-Received: by 2002:a2e:4715:: with SMTP id u21mr10261414lja.156.1551114076146;
        Mon, 25 Feb 2019 09:01:16 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 13sm2631442lju.27.2019.02.25.09.01.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 09:01:14 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id l5so8072475lje.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 09:01:14 -0800 (PST)
X-Received: by 2002:a2e:208a:: with SMTP id g10mr10539201lji.135.1551114073725;
 Mon, 25 Feb 2019 09:01:13 -0800 (PST)
MIME-Version: 1.0
References: <155110348217.21156.3874419272673328527.stgit@devbox>
 <155110354092.21156.13871336589042178985.stgit@devbox> <20190225150603.GE32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190225150603.GE32494@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Feb 2019 09:00:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNctC6PoCH9HE3hWFGq+5qBt0nsh+STDguD=jV9ovcag@mail.gmail.com>
Message-ID: <CAHk-=wgNctC6PoCH9HE3hWFGq+5qBt0nsh+STDguD=jV9ovcag@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] uaccess: Add non-pagefault user-space read functions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 7:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Would something like so work for people?

Looks reasonable to me.

> Why not keep it simple:
>
>         mm_segment_t old_fs = get_fs();
>
>         set_fs(USER_DS);
>         ret = __strncpy...();
>         set_fs(old_fd);
>
>         return ret;

So none of this code looks sane. First odd, there's no real reason to
use __get_user(). The thing should never be used. It does the whole
stac/clac for every byte.

In the copy_from_user() case, I suggested re-doing it as one common
routine without the set_fs() dance for the "already there" case to
simplify error handling. Here it doesn't do that.

But honestly, I think for the strncpy case, we could just do

  long strncpy_from_unsafe_user(char *dst, const void __user *src, long count)
  {
      long ret;
      mm_segment_t old_fs = get_fs();

      set_fs(USER_DS);
      pagefault_disable();
      ret = strncpy_from_user(dst, src, count);
      pagefault_enable();
      set_fs(old_fs);
      return ret;
  }

and be done with it. Efficient and simple.

Note: the above will *only* work for actual user addresses, because
strncpy_from_user() does that proper range check.

                  Linus
