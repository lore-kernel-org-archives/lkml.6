Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965889AbeBMVc3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 16:32:29 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46759 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965749AbeBMVc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 16:32:27 -0500
X-Google-Smtp-Source: AH8x226Vn0/Gr4Dp5M7B3j/3+f3153mFYRhx6DS+6gIUhlsRWXonqlrviWNh+MdBG5ITM5p2xmLLZA5htYaRiFyzoxw=
MIME-Version: 1.0
In-Reply-To: <20180204104946.25559-4-tycho@tycho.ws>
References: <20180204104946.25559-1-tycho@tycho.ws> <20180204104946.25559-4-tycho@tycho.ws>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 13 Feb 2018 13:32:26 -0800
X-Google-Sender-Auth: uI6ZsRTzXZHuWrZaobzRo0vcjto
Message-ID: <CAGXu5jLS2dzCjZOKa-W4kUdOPoJkRAq5Rsw1t5jX99v34yaoQw@mail.gmail.com>
Subject: Re: [RFC 3/3] seccomp: add a way to get a listener fd from ptrace
To: Tycho Andersen <tycho@tycho.ws>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 4, 2018 at 2:49 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> version which can acquire filters is useful. There are at least two reasons
> this is preferable, even though it uses ptrace:
>
> 1. You can control tasks that aren't cooperating with you
> 2. You can control tasks whose filters block sendmsg() and socket(); if the
>    task installs a filter which blocks these calls, there's no way with
>    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.

I got worried for a second that this would get us into a many-to-many
state, but I see init_listener enforces a single listener per filter.
Whew. Seems legit. :)

-Kees

-- 
Kees Cook
Pixel Security
