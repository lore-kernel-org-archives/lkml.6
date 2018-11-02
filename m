Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC911C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F0B204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="Dg2gw/SC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F0B204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeKBW52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:57:28 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50359 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeKBW52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:57:28 -0400
Received: by mail-it1-f194.google.com with SMTP id k206-v6so3223114ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PnptN6cZ1jWu6MmjASLMC8vLTTjDJgkcp9FaLvSTpG8=;
        b=Dg2gw/SCM1zUT7xayesds6Wo8Ob3Y59P43lacx0ndHPD9vN9bDHYXG2ga5QraIFsq+
         dRtYz4lAfC4Ge4QPzaVf5HgMNGV1IMa4xite9zWcFVHHYv9nxNCQz5IcYX7kxGPoFWAA
         4Ne3QRkgKRBb73hDDQei5xqi7yl5QSwVYR+kvLGmgMwPLWAnzpWT73lQzCN7aT+nBpdu
         DOd9ysp+GZj+zkDpNj9cASAcXhlQ+xammgKlIXF2k9gqJWW8fMacwH0FQbtglzO8IVFl
         aJnbFbvrPMSTE4Cs20U3UkA++hAgB6U0fDZEJwhvgEZvPjxiJ+hSaBMQvion3ZWGCgyB
         7U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PnptN6cZ1jWu6MmjASLMC8vLTTjDJgkcp9FaLvSTpG8=;
        b=uOQuxLMP3zxBYp/jVC0H1vaRwpVP5pjknqCVDutROlAOLP6aAs6GuRTyjXyRGBW5QE
         M5njp13qFhKQaK40upeYXoRgZ41xtkN84nYab7kZrIUcXhUVnYGBaeoog3jdZZdQrAH0
         tcCxBbSM4fEkSx+bNhja19Dqz0mYdbBIjJ+gFrUus1bD0WexHYqwtdboi3TboLObAxhU
         IT/RVQ/mAldCUDWYsMsRpwTVd7jKglOickqrLGV3OTCSS+7eyB9bY4WLmR25RuNgJjin
         SUj7IydTeLN6lb5ArBHaZ5X5tLEbMbG1MK8/7/BGE9GKlYPNt7yeysNY3PYFH6JS8kjl
         HY8g==
X-Gm-Message-State: AGRZ1gJS4Z0e65p24ZLCC7ESbNNrB8g5Z80HF4Pc3CFh/g7/HX17gi9i
        0UsjwdFqcIe0f6diGA6YfZF6CBul5i0=
X-Google-Smtp-Source: AJdET5e5hVnVl9KEcVJj2XcZV4okhh+P5KDOx5O041gifWH/KMk4KUlPNwfAW9NLNZnoAhEviC+rtw==
X-Received: by 2002:a24:d983:: with SMTP id p125-v6mr28733itg.97.1541166614449;
        Fri, 02 Nov 2018 06:50:14 -0700 (PDT)
Received: from cisco (75-166-162-63.hlrn.qwest.net. [75.166.162.63])
        by smtp.gmail.com with ESMTPSA id 142-v6sm3530107itw.40.2018.11.02.06.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 06:50:13 -0700 (PDT)
Date:   Fri, 2 Nov 2018 07:50:11 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
Message-ID: <20181102135011.GK2180@cisco>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
 <20181030143235.GA3385@redhat.com>
 <20181030153231.GB7343@cisco>
 <20181101144804.GD23232@redhat.com>
 <20181101203328.GI2180@cisco>
 <20181102112903.GB12360@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102112903.GB12360@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 12:29:03PM +0100, Oleg Nesterov wrote:
> On 11/01, Tycho Andersen wrote:
> >
> > On Thu, Nov 01, 2018 at 03:48:05PM +0100, Oleg Nesterov wrote:
> > >
> > > > > But my main concern is that either way wait_for_completion_killable() allows
> > > > > to trivially create a process which doesn't react to SIGSTOP, not good...
> > > > >
> > > > > Note also that this can happen if, say, both the tracer and tracee run in the
> > > > > same process group and SIGSTOP is sent to their pgid, if the tracer gets the
> > > > > signal first the tracee won't stop.
> > > > >
> > > > > Of freezer. try_to_freeze_tasks() can fail if it freezes the tracer before
> > > > > it does SECCOMP_IOCTL_NOTIF_SEND.
> > > >
> > > > I think in general the way this is intended to be used these things
> > > > wouldn't happen.
> > >
> > > Why?
> >
> > The intent is to run the tracer on the host and have it trace
> > containers, which would live in a different freezer cgroup, process
> > group, etc.
> 
> I didn't mean the freezer cgroup, suspend can fail, it does the "global" freeze.
> Nevermind.
> 
> > > Yes I think it would be nice to avoid wait_for_completion_killable().
> > >
> > > So please help me to understand the problem. Once again, why can not
> > > seccomp_do_user_notification() use wait_for_completion_interruptible() only?
> > >
> > > This is called before the task actually starts the syscall, so
> > > -ERESTARTNOINTR if signal_pending() can't hurt.
> >
> > The idea was that when the tracee gets a signal, it notifies the
> > tracer exactly once, and then waits for the tracer to decide what to
> > do. So if we use another wait_for_completion_interruptible(), doesn't
> > it just get re-woken immediately because the signal is still pending?
> 
> Hmm. I meant that we should use a single wait_for_completion_interruptible().

Yes, but if we can use a second _interruptible(), then we can avoid
the SIGSTOP issue and still perhaps preserve the SIGNALED bit if we
decide it's worth it at the conclusion of this thread.

> > > Now lets suppose seccomp_do_user_notification() simply does
> > >
> > > 	err = wait_for_completion_interruptible(&n.ready);
> > >
> > > 	if (err < 0 && state != SECCOMP_NOTIFY_REPLIED) {
> > > 		syscall_set_return_value(ERESTARTNOINTR);
> > > 		list_del(&n.list);
> > > 		return -1;
> > > 	}
> > >
> > > (I am ignoring the locking/etc). Now the obvious problem is that the listener
> > > doing SECCOMP_IOCTL_NOTIF_SEND can't distinguish -ENOENT from the case when the
> > > tracee was killed, yes?
> > >
> > > Is it that important?
> >
> > The answer to this question depends on how we want the listener to be
> > able to react. For example, if the listener is in the middle of doing
> > a mount() on behalf of the task and it gets a signal and we return
> > immediately, the listener will complete the mount(), try to respond
> > with success and get -ENOENT.
> 
> Yes. Should we undo the mount if the tracee is killed?
> 
> > If the task handles the signal and
> > restarts the mount(), it'll happen twice unless the listener undoes
> > it when it sees the -ENOENT.
> 
> Yes. But note that we know that if the same tracee sends another notification
> it must be the same syscall.
> 
> So. If the listener needs to undo mount when the tracee is killed, it should
> undo it if it was interrupted too.
> 
> If no, the listener can simply "ignore" the next notification and do
> SECCOMP_IOCTL_NOTIF_SEND(val = 0, error = 0).
> 
> I see no real difference...

Well, doesn't it seem like a hack? What if the tracee really makes the
same syscall twice? How do we tell the difference between one that was
restarted and a real second call?

> > If we send another notification with the
> > SIGNALED flag, the listener has a better picture of what's going on,
> > which might be nice.
> 
> Yes, but this returns us to my my question: Is it that important?
> 
> What exactly the listener can do if it gets SECCOMP_NOTIF_FLAG_SIGNALED?
> 
> Undo the mount? No. This doesn't differ from the case when the tracee gets
> the non-fatal signal right after SECCOMP_NOTIFY_REPLIED.

I guess that in do_user_notification(), even if we get -EINTER from
the wait, we should check to see that the state is REPLIED. If it is,
we can use the err and val from it, and complete the syscall as
normal, since it did.

Tycho
