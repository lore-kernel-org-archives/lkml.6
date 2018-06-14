Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3E1C8C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D070B208BA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="Cl1tX3yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D070B208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755544AbeFNVDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 17:03:30 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42006 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755348AbeFNVD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 17:03:29 -0400
Received: by mail-pg0-f66.google.com with SMTP id c10-v6so3456996pgu.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ktcG6uywBV8NjzK6lMH2IQIK3LXHKP+jlSGigMv91j4=;
        b=Cl1tX3yxE6m4KyfQScZQZiqrsxuRw4t7XFtMOI+y3mFTK7qo+7BI6tkabsHQhud4YU
         yy2MuRyeKFnpJ7pW+8MQnOzKyxIb/xJd3mD7Q7O5C0LUrjnK06poHfnPsdqN0MuHZuOF
         Niuv3ErDnCSfBn1mWphEOVMRGy0/Da0ZuA5yCVpRvY8fg7daot4m9j3QgYX1RGFZ7iAd
         Z3k0NPqzxliM/7A3l2O+5Ow93TU1vAhg/VNdS9mNgUQaP5Z4xTXts8FnP5CWVvvcoLvm
         G28XZhVWpmUgKWT93s6dp7HyvtqE1HgR2p2OgzDGBxDFl+nmiqePcWo/omHzTITqiti7
         cNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ktcG6uywBV8NjzK6lMH2IQIK3LXHKP+jlSGigMv91j4=;
        b=Y4iDaphyL7oEsk4KagQskZA2G2nLsxGRuUtdzJYRcfyINaMS5qL1YBH2JzLB0fPxGt
         telMCR3cpm1cl4AFdzo+XzI2RhTOFr1FVcd1h9YLS5Pk+Bj0jnaLXDY6c3PoiV0VNPCq
         LOQ3UMe/8PhUb6omvkpuPD1Q9CkwrsxKcPh6XHBt1vvubdnD9GdRKrK3ESvDBL1Iozcp
         Ht9Ib1UOkG0To5wX9dLE7yGzvyGvkXuAdZkZ741GudwK0lLwXNkwNkTZScU9pUISANnV
         5GXmaE2rDNQNJT4PrrPm/IQyDitNI+WG+HU8DQV7Hf44v9VKFPxkqWLwnr6Qi8AzaK/g
         d8dQ==
X-Gm-Message-State: APt69E3itcvajRQNFOVIp0fbnsh74H/Bp1jKsx/1+Z/cdEjYCdCN33gS
        hpUWoSn0Apywpqrzf87RPI5wMw==
X-Google-Smtp-Source: ADUXVKLpHQND1EGG8Ghop4aB02kK4L0OL4hwthqRwJY4iug2rWBK2AxUbMr8xrq3rmjnsi66QE84+A==
X-Received: by 2002:a65:6148:: with SMTP id o8-v6mr3600505pgv.93.1529010208516;
        Thu, 14 Jun 2018 14:03:28 -0700 (PDT)
Received: from cisco ([2001:420:28d:1250:4fa:4ea4:93fe:a612])
        by smtp.gmail.com with ESMTPSA id j19-v6sm8755349pfi.84.2018.06.14.14.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 14:03:27 -0700 (PDT)
Date:   Thu, 14 Jun 2018 14:03:25 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Matthew Helsley <matt.helsley@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        "Tobin C . Harding" <me@tobin.cc>,
        Kees Cook <keescook@chromium.org>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH v3 1/4] seccomp: add a return code to trap to userspace
Message-ID: <20180614210325.GA5673@cisco>
References: <20180531144949.24995-1-tycho@tycho.ws>
 <20180531144949.24995-2-tycho@tycho.ws>
 <CA+RrjuW98m2coL+TOKq5cL0QhAb=HYxo2DpNoqMzdiwjqhc2BA@mail.gmail.com>
 <20180612231610.GA3837@cisco>
 <CA+RrjuUtYoXfbH3cTbSY=QzXcxJsJOa0BL628ADy9N3bTO4=Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+RrjuUtYoXfbH3cTbSY=QzXcxJsJOa0BL628ADy9N3bTO4=Mw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 12:44:21PM -0700, Matthew Helsley wrote:
> On Tue, Jun 12, 2018 at 4:16 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> 
> > Hi Matthew,
> >
> > On Tue, Jun 12, 2018 at 02:39:03PM -0700, Matthew Helsley wrote:
> > > On Thu, May 31, 2018 at 7:49 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> > >
> > > <snip>
> > >
> > >
> > > > +struct seccomp_notif {
> > > > +       __u64 id;
> > > > +       pid_t pid;
> > > > +       struct seccomp_data data;
> > > > +};
> > > >
> > >
> > > Since it's part of the UAPI I think it would be good to add documentation
> > > to this patch series. Part of that documentation should talk about which
> > > pid namespaces this pid value is relevant in. This is especially
> > important
> > > since the feature is designed for use by things like container/sandbox
> > > managers.
> >
> > Yes, at least Documentation/userspace-api/seccomp_filter.txt should be
> > updated. I'll add that for the next series.
> >
> 
> Are there some relevant man pages too that should be updated too?

Yes, but since those are in a separate tree, I usually send the sets
separately.

> > > > +static void seccomp_do_user_notification(int this_syscall,
> > > > +                                        struct seccomp_filter *match,
> > > > +                                        const struct seccomp_data *sd)
> > > > +{
> > > > +       int err;
> > > > +       long ret = 0;
> > > > +       struct seccomp_knotif n = {};
> > > > +
> > > > +       mutex_lock(&match->notify_lock);
> > > > +       err = -ENOSYS;
> > > > +       if (!match->has_listener)
> > > > +               goto out;
> > > > +
> > > > +       n.pid = current->pid;
> > > >
> > >
> > > How have you tested this code for correctness? I don't see many
> > > combinations being tested below nor here:
> > > https://github.com/tych0/kernel-utils/blob/master/
> > seccomp/notify_stress.c
> > >
> > > What about processes in different pid namespaces? Make tests that vary
> > key
> > > parameters like these between the task generating the notifications and
> > the
> > > task interested in processing the notifications. Make tests that try to
> > > kill them at interesting times too. etc. Make tests that pass the
> > > notification fd around and see how they work (or not).
> > >
> > > I ask about testing because you're effectively returning a pid value to
> > > userspace here but not using the proper macros to access the task's
> > struct
> > > pid for that purpose. That will work so long as both processes are in the
> > > same pid namespace but breaks otherwise.
> > >
> > > Furthermore, a pid value is not the best solution for the queueing of
> > these
> > > notifications because a single pid value is not meaningful/correct
> > outside
> > > current's pid namespace and the seccomp notification file descriptor
> > could
> > > be passed on to processes in another pid namespaces; this pid value will
> > > almost always not be relevant or correct there hence taking a reference
> > to
> >
> > Well, it *has* to be relevant in some cases: if you want to access
> > some of the task's memory to e.g. read the args to the syscall, you
> > need to ptrace or map_files to access the memory. So we do need to
> > pass it, but,
> >
> > > the struct pid is useful. Then, during read(), the code would use the
> > > proper macro to turn the struct pid reference into a pid value relevant
> > in
> > > the *reader's* pid namespace *or* return something obviously bogus if the
> > > reader is in a pid namespace that can't see that pid. This could prevent
> > > management processes from being tricked into clobbering the wrong
> > process,
> > > feeding the wrong process sensitive information via syscall results, etc.
> >
> > Yes, this makes sense. Seems like we need to do some magic about
> > passing the tracee's task struct to the listener, so it can do
> > task_pid_vnr(). We could perhaps require the listener to be in the
> > init_pid_ns case, but I think things like socket() might still be
> > useful even if you can't read the tracee's memory.
> 
> 
> You could take a reference to the pid rather than the task
> then use pid_vnr(). In that case the changes should result in something
> like:
> 
> 
> struct seccomp_knotif {
>        /* The pid whose filter triggered the notification */
>        struct pid *pid;
> ...
> 
> static void seccomp_do_user_notification(...)
> {
>     ...
>     n.pid = get_task_pid(current, PIDTYPE_PID);
>     ...
> remove_list:
>     list_del(&n.list);
>     put_pid(n.pid);
>     ...
> }
> ...
> static ssize_t seccomp_notify_read(...)
> {
>     ...
>     unotif.pid = pid_vnr(knotif->pid);
>     ...
> }
> 
> I like holding the pid reference because it's what we do elsewhere when pid
> namespaces
> are a concern and it more precisely specifies what the knotif content needs
> to convey.
> Otherwise I don't think it makes a difference.

Great, thanks, I'll do this. I guess we need a put_pid() here too.

Cheers,

Tycho
