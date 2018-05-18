Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbeERODY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:03:24 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:38950 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751577AbeERODW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:03:22 -0400
Date: Fri, 18 May 2018 16:03:13 +0200
From: Christian Brauner <christian@brauner.io>
To: Tycho Andersen <tycho@tycho.ws>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        "Tobin C . Harding" <me@tobin.cc>, Kees Cook <keescook@chromium.org>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH v2 0/4] seccomp trap to userspace
Message-ID: <20180518140313.GA26297@mailbox.org>
References: <20180517151218.12850-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180517151218.12850-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 09:12:14AM -0600, Tycho Andersen wrote:
> Hi,
> 
> After a while focusing on other things, I finally managed ot get a v2 of
> this series prepared. I believe I've addressed all the feedback from v1,
> except for one major point: switching the communication protocol over
> the fd to nlattr. I looked into doing this, but the kernel stuff for
> dealing with nlattr seems to require an skb (via nlmsg_{new,put} and
> netlink_unicast), which means we need to deal with the netlink sequence
> numbers, portids, and create a socket protocol. I can do this if we
> still think nlattr is necessary, but based on looking at it, it seems
> like a lot of extra code for no real benefit.

Yes, we've had that discussion before and I agree. I fail to see the
benefit here too.

Christian

> 
> I've also added support for passing fds. The code itself is simple, but
> the API could/should probably be different, see patch 4 for discussion.
> 
> Tycho
> 
> Tycho Andersen (4):
>   seccomp: add a return code to trap to userspace
>   seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
>   seccomp: add a way to get a listener fd from ptrace
>   seccomp: add support for passing fds via USER_NOTIF
> 
>  arch/Kconfig                                  |   7 +
>  include/linux/seccomp.h                       |  14 +-
>  include/uapi/linux/ptrace.h                   |   2 +
>  include/uapi/linux/seccomp.h                  |  20 +-
>  kernel/ptrace.c                               |   4 +
>  kernel/seccomp.c                              | 480 +++++++++++++++++-
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 359 ++++++++++++-
>  7 files changed, 878 insertions(+), 8 deletions(-)
> 
> -- 
> 2.17.0
> 
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/containers
