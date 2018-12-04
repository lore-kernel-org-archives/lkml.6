Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05FDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4FE2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ZKALe0PQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4FE2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbeLDN0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:26:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39004 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbeLDN0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:26:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id c72so8213249pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 05:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lUBWBMjwQZh4BgUZEUxqp89yk9ZvrcKIj+bZ2O6Ba/Y=;
        b=ZKALe0PQvtHSGg/TFfVRQEh8CFJN1/pKILkYhksseQxqcMak9vfVZ2CIkD4viok2jp
         RFbR4ys6dd4EBXxAyuhhTMQ+HwL8P1ebIvH+sjjHPYSh8wmvZvO9Xpcjxe3+04GRSV3w
         YrBo40ehWR4H1Ejw6AGToo46Q6f/AhMFBxK3nqlOHdWDVzStYAvGH6G13agJHO5m65zJ
         qUajQgnDTgNGVnv5wyQ+CnTXGGq/e3JcPP9RIxPdW3H58LETa8qZz64JkCOXvp7sJffT
         8ITCtrFVIVEEYOxCiUPPBlFGpuzwXBKaQeox17xJBXvK3R/nq5P53m0ZUppNg5K/Kf/4
         D08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lUBWBMjwQZh4BgUZEUxqp89yk9ZvrcKIj+bZ2O6Ba/Y=;
        b=MdCHYImBjhFeJELfZig8N+x3cNk3+0RONOj1LowPpcF7K3i8GAbXcOe4HZw9jpErF4
         hDAHRFHIl3s86BncWbykv5ThdPbleOLgruVKhgvLxvuZjIST2L7fKneCar5cu8Il/TBJ
         M8Kf7eC3W3KiJEpfhSHl0mA/GSaiLWeR0I7CimLtvshurFw7dF1o7PMNmvo4gFVWzPMN
         CRdpSwEAq8zr4TIJw0salRscADTltjHuoQbFxUlfL1gECoQNvY69MhTwLGKTfWSzDY8d
         sC98BzzRGSEyRqDfkkoH6VLx5B7BU3zgNuoh15W4SxlU1sw/D0rWFqCg1BxAhThiE8O4
         ooVw==
X-Gm-Message-State: AA+aEWY6kJltv0q3+f4RrGVSN5EzI0WS4OhFIl8NHtq5QMekIfu7bgJ4
        0maZu/7a0/q+zMHDrUlKfE7krw==
X-Google-Smtp-Source: AFSGD/UMMQ+4X7LRJlfx1JJmrWBaFOnUteR+FjXX1vdXEFDRkY45wCSUpTnoNcHTa3gAz3V1Olonuw==
X-Received: by 2002:a63:ea15:: with SMTP id c21mr15889850pgi.361.1543929975524;
        Tue, 04 Dec 2018 05:26:15 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:b824:a031:b50e:f401])
        by smtp.gmail.com with ESMTPSA id d18sm22759112pfj.47.2018.12.04.05.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 05:26:14 -0800 (PST)
Date:   Tue, 4 Dec 2018 14:26:06 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
Message-ID: <20181204132604.aspfupwjgjx6fhva@brauner.io>
References: <20181120105124.14733-1-christian@brauner.io>
 <87in0g5aqo.fsf@oldenburg.str.redhat.com>
 <746B7C49-CC7B-4040-A7EF-82491796D360@brauner.io>
 <20181202100304.labt63mzrlr5utdl@brauner.io>
 <8736rebl9s.fsf@oldenburg.str.redhat.com>
 <20181203180224.fkvw4kajtbvru2ku@brauner.io>
 <874lbtjvtd.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874lbtjvtd.fsf@oldenburg2.str.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 01:55:10PM +0100, Florian Weimer wrote:
> * Christian Brauner:
> 
> > On Mon, Dec 03, 2018 at 05:57:51PM +0100, Florian Weimer wrote:
> >> * Christian Brauner:
> >> 
> >> > Ok, I finally have access to source code again. Scratch what I said above!
> >> > I looked at the code and tested it. If the process has exited but not
> >> > yet waited upon aka is a zombie procfd_send_signal() will return 0. This
> >> > is identical to kill(2) behavior. It should've been sort-of obvious
> >> > since when a process is in zombie state /proc/<pid> will still be around
> >> > which means that struct pid must still be around.
> >> 
> >> Should we make this state more accessible, by providing a different
> >> error code?
> >
> > No, I don't think we want that. Imho, It's not really helpful. Signals
> > are still delivered to zombies. If zombie state were to always mean that
> > no-one is going to wait on this thread anymore then it would make sense
> > to me. But given that zombie can also mean that someone put a
> > sleep(1000) right before their wait() call in the parent it seems odd to
> > report back that it is a zombie.
> 
> It allows for error checking that the recipient of a signal is still
> running.  It's obviously not reliable, but I think it could be helpful
> in the context of closely cooperating processes.
> 
> >> Will the system call ever return ESRCH, given that you have a handle for
> >> the process?
> >
> > Yes, whenever you signal a process that has already been waited upon:
> > - get procfd handle referring to <proc>
> > - <proc> exits and is waited upon
> > - procfd_send_signal(procfd, ...) returns -1 with errno == ESRCH
> 
> I see, thanks.
> 
> >> Do you want to land all this in one kernel release?  I wonder how
> >> applications are supposed to discover kernel support if functionality is
> >> split across several kernel releases.  If you get EINVAL or EBADF, it
> >> may not be obvious what is going on.
> >
> > Sigh, I get that but I really don't want to have to land this in one big
> > chunk. I want this syscall to go in in a as soon as we can to fulfill
> > the most basic need: having a way that guarantees us that we signal the
> > process that we intended to signal.
> >
> > The thread case is easy to implement on top of it. But I suspect we will
> > quibble about the exact semantics for a long time. Even now we have been
> > on multiple - justified - detrous. That's all pefectly fine and
> > expected. But if we have the basic functionality in we have time to do
> > all of that. We might even land it in the same kernel release still. I
> > really don't want to come of as tea-party-kernel-conservative here but I
> > have time-and-time again seen that making something fancy and cover ever
> > interesting feature in one patchset takes a very very long time.
> >
> > If you care about userspace being able to detect that case I can return
> > EOPNOTSUPP when a tid descriptor is passed.
> 
> I suppose that's fine.  Or alternatively, when thread group support is
> added, introduce a flag that applications have to use to enable it, so
> that they can probe for support by checking support for the flag.
> 
> I wouldn't be opposed to a new system call like this either:
> 
>   int procfd_open (pid_t thread_group, pid_t thread_id, unsigned flags);
> 
> But I think this is frowned upon on the kernel side.

If this is purely about getting a procfd then I think this isn't really
necessary since you can get it from /proc/<pid> and
/proc/<pid>/task/<tid> so a syscall just for that is likely overkill.
However, I started to pick up the CLONE_FD patchset but ideally I would
like it to be way simpler to what was proposed back in the day (which is
not a critique, I just don't feel comfortable with bringing massive
patches to the table that I can barely judge wrt to their correctness.
:)). I have toyed around with this a little and I'm tempted to simply
have the syscall always return an fd for the process and not require a
separate flag for this. But I need to work through the details and this
is really far out into the (kernel) future.

> 
> >> What happens if you use the new interface with an O_PATH descriptor?
> >
> > You get EINVAL. When an O_PATH file descriptor is created the kernel
> > will set file->f_op = &empty_fops at which point the check I added 
> >         if (!proc_is_tgid_procfd(f.file))
> >                 goto err;
> > will fail. Imho this is correct behavior since technically signaling a
> > struct pid is the equivalent of writing to a file and hence doesn't
> > purely operate on the file descriptor level.
> 
> Yes, that's quite reasonable.  Thanks.
> 
> Florian
