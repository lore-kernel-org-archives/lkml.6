Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262B7C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71F520836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="VTuQ8pw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71F520836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbeFTOl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:41:29 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44542 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752827AbeFTOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:41:28 -0400
Received: by mail-io0-f194.google.com with SMTP id g7-v6so3661010ioh.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 07:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NrINNhEX7lfgDIo4r43XDgM9aBOI2783vBVqvCZn0wM=;
        b=VTuQ8pw5uawLoftDAp89uVTCmfPMokVCGt2woxS4P3i4engzVd4AimTvYyV3EwBZng
         rny/VjyH2Kr+l7iS5UnrtTxsOdV1h4EhlsHGmYtAN3aU/SZJ1e48+Pwhn7v8bGjEfbbM
         mesaFMI9DUvWLdSfWqLADz3vfrvN+84cw+npowbn+NUyhSFTMbOAJ5mK3pM58EK2pL9U
         loBJy+Vhzui9Q7zPXpzNUc3fWsmY7k4CfWa86wiabaxfVX85z6ArchKYNXvUZf8BDlAw
         pdx/jzVrJcg5ObolTxNU7Dtu0wMutEA3GIB0Y4iRFBzy+rFUQryiFgZ1ZasDgGAdOnU5
         us2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NrINNhEX7lfgDIo4r43XDgM9aBOI2783vBVqvCZn0wM=;
        b=nes05JrlJYkftxV0c+f/iK545aavxPh5gDJhwgU3t2u3eG1De+v9IgkgCtHHWseaJJ
         xPg/7bqtyNfeVfo7/0vsxCxNw7J+A1zvW/kQghw+M+dt0Z+/mDadE7PCQ5P9+6IHeo59
         16h7gG4pSRb5tYH/G9e2lMxqc9enmwi4iMqkWiA62nWf7tovC8v/4XYXS7BxVvAUTp2A
         mkxO7lvOgJ5AZJzL0IotikZ6dSUMKW+YiOLD2LFNLsEUKpiFm1RTTQBBrq1pmPrPIAXn
         ysZtzQ+DUpik46jA2sYRya4JAHfnurtloeRCJnJrJFpLCzlpj0biVb/MkgQ+9lGst5OT
         Xh4w==
X-Gm-Message-State: APt69E1hdG4ANbArbH2tV6Wg26CDlZ1SPYD0tA6GJfoL8fg1P9ZU4QQv
        RtM/Z28IlJUmliYpWaZgWXny8g==
X-Google-Smtp-Source: ADUXVKJOsmtrcyh6MQu1c1XTE16EzS16+Nv1c0nkrVignQIAz07qUGR59+UTmCqnkLgd6s0EGwcmGQ==
X-Received: by 2002:a6b:bec3:: with SMTP id o186-v6mr18596693iof.147.1529505687474;
        Wed, 20 Jun 2018 07:41:27 -0700 (PDT)
Received: from smitten ([8.24.24.129])
        by smtp.gmail.com with ESMTPSA id q2-v6sm946628ioh.40.2018.06.20.07.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 07:41:26 -0700 (PDT)
Date:   Wed, 20 Jun 2018 08:41:25 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Matthew Helsley <matt.helsley@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Oleg Nesterov <oleg@redhat.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Tyler Hicks <tyhicks@canonical.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH v3 1/4] seccomp: add a return code to trap to userspace
Message-ID: <20180620144125.GH14770@smitten>
References: <20180531144949.24995-1-tycho@tycho.ws>
 <20180531144949.24995-2-tycho@tycho.ws>
 <CA+RrjuW98m2coL+TOKq5cL0QhAb=HYxo2DpNoqMzdiwjqhc2BA@mail.gmail.com>
 <20180612231610.GA3837@cisco>
 <CA+RrjuUtYoXfbH3cTbSY=QzXcxJsJOa0BL628ADy9N3bTO4=Mw@mail.gmail.com>
 <20180614210325.GA5673@cisco>
 <87in6lt4pc.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87in6lt4pc.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Thu, Jun 14, 2018 at 04:53:51PM -0500, Eric W. Biederman wrote:
> >> static void seccomp_do_user_notification(...)
> >> {
> >>     ...
> >>     n.pid = get_task_pid(current, PIDTYPE_PID);
> >>     ...
> >> remove_list:
> >>     list_del(&n.list);
> >>     put_pid(n.pid);
> >>     ...
> >> }
> >> ...
> >> static ssize_t seccomp_notify_read(...)
> >> {
> >>     ...
> >>     unotif.pid = pid_vnr(knotif->pid);
> >>     ...
> >> }
> >> 
> >> I like holding the pid reference because it's what we do elsewhere when pid
> >> namespaces
> >> are a concern and it more precisely specifies what the knotif content needs
> >> to convey.
> >> Otherwise I don't think it makes a difference.
> >
> > Great, thanks, I'll do this. I guess we need a put_pid() here too.
> 
> A)  We know that the task is stopped.  Unless there is something
>     like SIGKILL that can make the task move you don't need to
>     take a reference to anything.

Yes, agreed. (I think the task can't die, because even if it gets an
interrupt, we hold the ->notify_lock here, so it'll block waiting for
that to remove itself from the notification queue.)

> B)  pid_vnr is the wrong answer.  When you create the struct file
>     and intialize the filter you need to capture the calling processes
>     pid namespace.  The you can use "pid_nr_ns(knotif->pid, filter->pid_ns);".
>     That will work consistently even if the file descriptor is passed
>     between processes.

We want the pid of the tracee in the tracer's namespace, so I'm not so
sure. Doesn't your code above give us the pid in the namespace of the
task that happened to create the struct file (which may be unrelated
to the namespace of the tracer)?

Tycho
