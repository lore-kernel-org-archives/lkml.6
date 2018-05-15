Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeEOXLG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:11:06 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51419 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeEOXLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:11:05 -0400
X-Google-Smtp-Source: AB8JxZp1jgDGEx59IjJVHtWuGu9fB1+1X0GUn7QaisbFsKdMXzf7vjclmAN++6KI+TVFlCDLb6luRzm4U+Y4Bk1f1vc=
MIME-Version: 1.0
References: <20180515100558.21df515e@gandalf.local.home> <CA+55aFyBHRmXLo07f_7qt7szaDvppMStfX5Sq9Df6mZSy+qYvA@mail.gmail.com>
 <20180515145744.3bdcbbe9@gandalf.local.home> <CA+55aFwOoMHJaK5LmgmKKPvPUpTUBKSXS67cwaXwm2p-eG6ycQ@mail.gmail.com>
 <20180515161027.468e8975@gandalf.local.home> <CA+55aFztxY-w=0tPZ8KAenENA7NCYSWUcCPV4Nzs0ffwrh3G4Q@mail.gmail.com>
 <20180515184117.5fb0b7fa@gandalf.local.home> <20180515190022.3b5f96b4@gandalf.local.home>
In-Reply-To: <20180515190022.3b5f96b4@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 May 2018 16:10:53 -0700
Message-ID: <CA+55aFwwyxG_7+vJ_7xAxTA_MpYQYPaZk7SYu+s8a9kafQaVmA@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: Fix memory barriers of ptr_key to have_filed_random_ptr_key
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, tcharding <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 4:00 PM Steven Rostedt <rostedt@goodmis.org> wrote:

> If it is that if statement you don't like. We can get rid of it. On
> early boot, the code is called from preemptable context, it's only
> later that it is not. So we know when we can call it directly and when
> we need to have a work queue.

Oh, that looks much better to me, yes. Just doing it this way instead
removes my "ugh, that's nasty" objections.

So ack on this last version of the patch, because it doesn't scare me (or
you've worn me down ;)

               Linus
