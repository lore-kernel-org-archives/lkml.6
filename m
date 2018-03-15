Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932277AbeCOQJf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:09:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51919 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbeCOQJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:09:33 -0400
X-Google-Smtp-Source: AG47ELuxtk9wqlAT8rZXUBQ/BA9dFJ9bkWRbmmK3CRGP4tBHZwRbBFxpuZKyIGOpYCB2BuLw6KJmmA==
Date: Thu, 15 Mar 2018 17:09:25 +0100
From: Christian Brauner <christian.brauner@canonical.com>
To: Tycho Andersen <tycho@tycho.ws>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
Subject: Re: [RFC 0/3] seccomp trap to userspace
Message-ID: <20180315160924.GA12744@gmail.com>
References: <20180204104946.25559-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180204104946.25559-1-tycho@tycho.ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 04, 2018 at 11:49:43AM +0100, Tycho Andersen wrote:
> Several months ago at Linux Plumber's, we had a discussion about adding a
> feature to seccomp which would allow seccomp to trigger a notification for some
> other process. Here's a draft of that feature.
> 
> Patch 1 contains the bulk of it, patches 2 & 3 offer an alternative way to
> acquire the fd that receives notifications via ptrace (the method in patch 1
> poses some problems). Other suggestions for how to acquire one of these fds
> would be welcome.
> 
> Take a close look at the synchronization. I think I've got it right, but I
> probably don't :)
> 
> Thanks!
> 
> Tycho Andersen (3):
>   seccomp: add a return code to trap to userspace
>   seccomp: hoist out filter resolving logic
>   seccomp: add a way to get a listener fd from ptrace
> 
>  arch/Kconfig                                  |   7 +
>  include/linux/seccomp.h                       |  14 +-
>  include/uapi/linux/ptrace.h                   |   1 +
>  include/uapi/linux/seccomp.h                  |  18 +-
>  kernel/ptrace.c                               |   4 +
>  kernel/seccomp.c                              | 467 ++++++++++++++++++++++++--
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 180 +++++++++-
>  7 files changed, 653 insertions(+), 38 deletions(-)

Hey,

So, I've been following the discussion silently in the background and I
see that it got sidetracked into seccomp + ebpf. While I can see that
there is value in adding epbf support to seccomp I'd really like to see
this decoupled from this patchset. Afaict, this patchset would just work
fine without the ebpf portion (but I might be just have missed the
point). So if possible I would like to see a second version of this with
the comments accounted for and - if possible - have this up for merging
independent of the ebpf patchset that's floating around.

Christian
