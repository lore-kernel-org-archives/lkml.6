Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031476AbeBNPeD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:34:03 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:37846 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031333AbeBNPeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:34:01 -0500
X-Google-Smtp-Source: AH8x226urQYFvBhw3KFMfMDAaZzdHX3Kz5kFF+RxskxhQYU5MZVgIA85sTbQVFwsPsG3fdukdE4q1Q==
Date: Wed, 14 Feb 2018 08:33:59 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
Subject: Re: [RFC 3/3] seccomp: add a way to get a listener fd from ptrace
Message-ID: <20180214153359.6wj6wclsqvgj4jlt@smitten>
References: <20180204104946.25559-1-tycho@tycho.ws>
 <20180204104946.25559-4-tycho@tycho.ws>
 <CAGXu5jLS2dzCjZOKa-W4kUdOPoJkRAq5Rsw1t5jX99v34yaoQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLS2dzCjZOKa-W4kUdOPoJkRAq5Rsw1t5jX99v34yaoQw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 01:32:26PM -0800, Kees Cook wrote:
> On Sun, Feb 4, 2018 at 2:49 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> > As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> > version which can acquire filters is useful. There are at least two reasons
> > this is preferable, even though it uses ptrace:
> >
> > 1. You can control tasks that aren't cooperating with you
> > 2. You can control tasks whose filters block sendmsg() and socket(); if the
> >    task installs a filter which blocks these calls, there's no way with
> >    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.
> 
> I got worried for a second that this would get us into a many-to-many
> state, but I see init_listener enforces a single listener per filter.
> Whew. Seems legit. :)

Yes, although if you sendmsg() the listener fd, you could still get
into that state, so it's still maybe a concern?

Tycho
