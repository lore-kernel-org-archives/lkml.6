Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeEOWbu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:31:50 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37603 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeEOWbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:31:49 -0400
X-Google-Smtp-Source: AB8JxZokXCswenWVN5uKF7Nfs4IdWqmlhUce6bXgf4/C2Y2AMfAIdZEyuL4LK78KBBL4L/Zodu/SAF5QrHSrxS3YXfk=
MIME-Version: 1.0
References: <20180515100558.21df515e@gandalf.local.home> <CA+55aFyBHRmXLo07f_7qt7szaDvppMStfX5Sq9Df6mZSy+qYvA@mail.gmail.com>
 <20180515145744.3bdcbbe9@gandalf.local.home> <CA+55aFwOoMHJaK5LmgmKKPvPUpTUBKSXS67cwaXwm2p-eG6ycQ@mail.gmail.com>
 <20180515161027.468e8975@gandalf.local.home>
In-Reply-To: <20180515161027.468e8975@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 May 2018 15:31:37 -0700
Message-ID: <CA+55aFztxY-w=0tPZ8KAenENA7NCYSWUcCPV4Nzs0ffwrh3G4Q@mail.gmail.com>
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

On Tue, May 15, 2018 at 1:10 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> The work queue looks to run immediately.

2ms is definitely not "immediately". It's just "soon".

The whole - and _only_ reason we're doing all these changes is that people
wanted reliable object hashes from very early bootup tracing, so I think it
matters.

> we could always do this:

Ugh. I think I prefer the barriers.

                Linus
