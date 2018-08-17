Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F39FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3572121A05
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcRxQJGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3572121A05
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeHQUis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:38:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33854 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbeHQUir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:38:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so3802889pfi.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8Eu/rHdhn1VLK9gQAZ9GGPMcESnYTWOik7RiPeiosto=;
        b=fcRxQJGAc/Go49bISMCJT9fHGpBQVLwvNIh/gYSrxSxs2CvA82RZNRynNHk3+25Giy
         ljDsPzGR2j42GIds+HMJmDyquqtNV1/y8nJmsJJaguUF3+rYqSP4YwHq9Flk4Vt0ICXA
         lQ7HiSwjhm29po+vS9bZzkiyYXw4jQx8A8XAP+VzO9NEqiQQinBayXrXocof3GB0XKB9
         F+wtRVqDMvmV4ZDUGaTq7XwjOSYgzFeN0cY7PwFdeJw6QjrH6sLRcZnmR4/OnfA7URcB
         vwwhY1IqtsI2tDpJQYfc7Snk6tnsAY90MpZVJOagFxY6SmSHJK+ZCPbrTK8k3hM6UXtd
         +e9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8Eu/rHdhn1VLK9gQAZ9GGPMcESnYTWOik7RiPeiosto=;
        b=iYKSP+IL+55js3f6u2S3TEIWxKHN8B94SIp0QW/rzxl3EX4lUZJ1+E4BzDFBd2cOvy
         azavW1Y3eXRFsbWVICosWbskugiAfaPCBSixWfMvOhKOWwbuEJO/NoVMI+ujXuCKaYha
         /gErygb+BpxDvLlYIVmrFL2PJLgwslZ6MKS8vrCDNNhDoj+v3SUqLpmdmTu1fvSJn5mA
         imzaqM6EqecujdOi68dXfr9+6m5amk15e5dik2CdTkb2g35EY9rsRof1qquSwmvGndgf
         QSVLKczf8vErMs15O7xvcujgYjBVbM4HvIOLEm8Qjxnsqevdwb8mt2gsJYrK9nvddXSn
         +DWg==
X-Gm-Message-State: AOUpUlFRtQo9Zk9aW0I6jqwOofa8KlxRQ2KTQGH+Jf0knSqQrP6aH3y5
        DFYFPCXFEBOGPdFXn8Yqfi6m+3ddW+Wm4yXwT14qyw==
X-Google-Smtp-Source: AA+uWPz8hUr+Sn1/C7A7aTLi/IPwVx+jbTpOHW4ptMnuUaeD+UkUtLOaY5I4uSfbuywFkkqEkb1wlHEvIlnfjaaNcbk=
X-Received: by 2002:a63:5106:: with SMTP id f6-v6mr32941634pgb.95.1534527272591;
 Fri, 17 Aug 2018 10:34:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Fri, 17 Aug 2018 10:34:12
 -0700 (PDT)
In-Reply-To: <87k1orgdoo.fsf_-_@xmission.com>
References: <87efft5ncd.fsf_-_@xmission.com> <20180724032419.20231-7-ebiederm@xmission.com>
 <87k1orgdoo.fsf_-_@xmission.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Aug 2018 10:34:12 -0700
Message-ID: <CACT4Y+bYFatW=CMgH4M6AjtjO297gbQ8xwnEV0_f7J64FLQ4QQ@mail.gmail.com>
Subject: Re: [PATCH] signal: Don't send signals to tasks that don't exist
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+1f371ca19b341a276761@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 9:04 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Recently syzbot reported crashes in send_sigio_to_task and
> send_sigurg_to_task in linux-next.  Despite finding a reproducer
> syzbot apparently did not bisected this or otherwise track down the
> offending commit in linux-next.
>
> I happened to see this report and examined the code because I had
> recently changed these functions as part of making PIDTYPE_TGID a real
> pid type so that fork would does not need to restart when receiving a
> signal.  By examination I see that I spotted a bug in the code
> that could explain the reported crashes.
>
> When I took Oleg's suggestion and optimized send_sigurg and send_sigio
> to only send to a single task when type is PIDTYPE_PID or PIDTYPE_TGID
> I failed to handle pids that no longer point to tasks.  The macro
> do_each_pid_task simply iterates for zero iterations.  With pid_task
> an explicit NULL test is needed.
>
> Update the code to include the missing NULL test.
>
> Fixes: 019191342fec ("signal: Use PIDTYPE_TGID to clearly store where file signals will be sent")
> Reported-by: syzkaller-bugs@googlegroups.com

Since the commit does not contain the syzbot-provided Reported-by tag,
we need to tell syzbot that this is fixed explicitly:

#syz fix: signal: Don't send signals to tasks that don't exist

> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/fcntl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index a04accf6847f..4137d96534a6 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -791,7 +791,8 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
>         if (type <= PIDTYPE_TGID) {
>                 rcu_read_lock();
>                 p = pid_task(pid, PIDTYPE_PID);
> -               send_sigio_to_task(p, fown, fd, band, type);
> +               if (p)
> +                       send_sigio_to_task(p, fown, fd, band, type);
>                 rcu_read_unlock();
>         } else {
>                 read_lock(&tasklist_lock);
> @@ -830,7 +831,8 @@ int send_sigurg(struct fown_struct *fown)
>         if (type <= PIDTYPE_TGID) {
>                 rcu_read_lock();
>                 p = pid_task(pid, PIDTYPE_PID);
> -               send_sigurg_to_task(p, fown, type);
> +               if (p)
> +                       send_sigurg_to_task(p, fown, type);
>                 rcu_read_unlock();
>         } else {
>                 read_lock(&tasklist_lock);
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/87k1orgdoo.fsf_-_%40xmission.com.
> For more options, visit https://groups.google.com/d/optout.
