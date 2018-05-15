Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752354AbeEOTDq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 15:03:46 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37873 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbeEOTDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 15:03:44 -0400
X-Google-Smtp-Source: AB8JxZq9GmdbUkjc2ApCdhg84v9YHnFh5+pOJ4p4DDgFrXsoD0gg6N/x23mOFY/NRTsNyTDiKUSD85SAmsfuZ00tQKU=
MIME-Version: 1.0
References: <20180515100558.21df515e@gandalf.local.home> <CA+55aFyBHRmXLo07f_7qt7szaDvppMStfX5Sq9Df6mZSy+qYvA@mail.gmail.com>
 <20180515145744.3bdcbbe9@gandalf.local.home>
In-Reply-To: <20180515145744.3bdcbbe9@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 May 2018 12:03:32 -0700
Message-ID: <CA+55aFwOoMHJaK5LmgmKKPvPUpTUBKSXS67cwaXwm2p-eG6ycQ@mail.gmail.com>
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

On Tue, May 15, 2018 at 11:57 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> +       queue_work(system_unbound_wq, &enable_ptr_key_work);

I think this part just makes the whole thing entirely pointless.

Now the 'not_filled_random_ptr_key' thing won't actually take effect until
possibly much later, so all the work with making this work very early
during boot (when those works are *not* done) is all for naught.

Did I miss something?

              Linus
