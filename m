Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79986C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1016D2170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="A4u2t4X/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1016D2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeI1F2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:28:52 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40994 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeI1F2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:28:51 -0400
Received: by mail-oi1-f196.google.com with SMTP id l197-v6so3694960oib.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 16:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3uw7GBCuxgebYD0IFZlGwwCCWhXdqK2polDPMZ7bCpQ=;
        b=A4u2t4X/19BkdQNzHOT6jyziVX+UEAiCjXzdj8Lju6t72Qe2Wr8lkdQm+mivyKPDgr
         9kFvwX3hvXOMltMD2/mTfzItDM0Blwe9xtzGO/iSW04IAAtRwkFwkKXe7bCRJGk1GChi
         qk/j4NeJa4C3yBENl7to8Dkhtl82+th6dIW3oHjlX7uPby0yDhbsXQt/1gWKqUz+8y+D
         Av0m8cloacTR4YKIM5mSZ5zr4Z3cK6yq1ouqYaUy65AA575JzZ9iVEixhr3OFWgPjKH8
         8ZnvEjkVaHLGXNCyYhBBlQJFd6mK3KXgRdZJvuXN1A0CkCGpDlhFl4VGVANDLOzJNb4i
         KAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3uw7GBCuxgebYD0IFZlGwwCCWhXdqK2polDPMZ7bCpQ=;
        b=MI0shiNGiKY/TztfMKTr9O7V60pxOyqOh4u+cf/dwKfgTur824cFimwLxwuakKn1p6
         2MYcr3tAkMU3MEKSs5ohVrcnfl5oEzOmw9rQ/GBKSkpZfE3u6iYnDOL3g77Ak5rDsFMJ
         PtpkNe2lD+G+8Pko0TqpVkNTVYZpkOwZpYvKxtaBQiN+DBQ2s48qEcGrfSnWe8BoSjWS
         Bqn0Bn5lSd09XZ8Z9fL8DYMidbF/8rDdvYRvdhHxIs1PD6yzuhY2Vy04RTr1O8ekZyzf
         tXyMq+WlM97Jy572xrpeelKha7Y/IGfRcftULiUK1gqKhB6NH2K7GXxEktRWHzmQzAI2
         /UyQ==
X-Gm-Message-State: ABuFfohcwOySoXre6uaQk8AdXxkgz+VEBQde2atpIok9b7ScYwdO6H/5
        nXU5FbvACtLjBZMjke+KaHc7fg==
X-Google-Smtp-Source: ACcGV61PInxnamz6CAV6X6yVztK2ClqgZXFJtZgcKRM0Po5M9hWnJb+M2ojaeZvVSY8T/ACOco8Qpw==
X-Received: by 2002:aca:bbc3:: with SMTP id l186-v6mr4379560oif.315.1538089689962;
        Thu, 27 Sep 2018 16:08:09 -0700 (PDT)
Received: from cisco.cisco.com ([128.107.241.175])
        by smtp.gmail.com with ESMTPSA id x65-v6sm700637oix.3.2018.09.27.16.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 16:08:09 -0700 (PDT)
Date:   Thu, 27 Sep 2018 17:08:06 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
Subject: Re: [PATCH v7 1/6] seccomp: add a return code to trap to userspace
Message-ID: <20180927230806.GI15491@cisco.cisco.com>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-2-tycho@tycho.ws>
 <CAG48ez05LyQOb4pw5H74VhHdQFDEOPLoLuhDPMEqFG7W1hwA_Q@mail.gmail.com>
 <CAGXu5j+uqgCkxaEPoOa_+XSTJBe==bNATCewsqqzwiyKhbLGVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+uqgCkxaEPoOa_+XSTJBe==bNATCewsqqzwiyKhbLGVQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 03:45:11PM -0700, Kees Cook wrote:
> On Thu, Sep 27, 2018 at 2:51 PM, Jann Horn <jannh@google.com> wrote:
> > On Thu, Sep 27, 2018 at 5:11 PM Tycho Andersen <tycho@tycho.ws> wrote:
> >> However, care should be taken to avoid the TOCTOU
> >> +mentioned above in this document: all arguments being read from the tracee's
> >> +memory should be read into the tracer's memory before any policy decisions are
> >> +made. This allows for an atomic decision on syscall arguments.
> >
> > Again, I don't really see how you could get this wrong.
> 
> Doesn't hurt to mention it, IMO.
> 
> >> +static long seccomp_notify_send(struct seccomp_filter *filter,
> >> +                               unsigned long arg)
> >> +{
> >> +       struct seccomp_notif_resp resp = {};
> >> +       struct seccomp_knotif *knotif = NULL;
> >> +       long ret;
> >> +       u16 size;
> >> +       void __user *buf = (void __user *)arg;
> >> +
> >> +       if (copy_from_user(&size, buf, sizeof(size)))
> >> +               return -EFAULT;
> >> +       size = min_t(size_t, size, sizeof(resp));
> >> +       if (copy_from_user(&resp, buf, size))
> >> +               return -EFAULT;
> >> +
> >> +       ret = mutex_lock_interruptible(&filter->notify_lock);
> >> +       if (ret < 0)
> >> +               return ret;
> >> +
> >> +       list_for_each_entry(knotif, &filter->notif->notifications, list) {
> >> +               if (knotif->id == resp.id)
> >> +                       break;
> >> +       }
> >> +
> >> +       if (!knotif || knotif->id != resp.id) {
> >
> > Uuuh, this looks unsafe and wrong. I don't think `knotif` can ever be
> > NULL here. If `filter->notif->notifications` is empty, I think
> > `knotif` will be `container_of(&filter->notif->notifications, struct
> > seccom_knotif, list)` - in other words, you'll have a type confusion,
> > and `knotif` probably points into some random memory in front of
> > `filter->notif`.
> >
> > Am I missing something?
> 
> Oh, good catch. This just needs to be fixed like it's done in
> seccomp_notif_recv (separate cur and knotif).
> 
> >> +static struct file *init_listener(struct task_struct *task,
> >> +                                 struct seccomp_filter *filter)
> >> +{
> >
> > Why does this function take a `task` pointer instead of always
> > accessing `current`? If `task` actually wasn't `current`, I would have
> > concurrency concerns. A comment in seccomp.h even explains:
> >
> >  *          @filter must only be accessed from the context of current as there
> >  *          is no read locking.
> >
> > Unless there's a good reason for it, I would prefer it if this
> > function didn't take a `task` pointer.
> 
> This is to support PTRACE_SECCOMP_NEW_LISTENER.
> 
> But you make an excellent point. Even TSYNC expects to operate only on
> the current thread group. Hmm.
> 
> While the process is stopped by ptrace, we could, in theory, update
> task->seccomp.filter via something like TSYNC.
> 
> So perhaps use:
> 
> mutex_lock_killable(&task->signal->cred_guard_mutex);
> 
> before walking the notify_locks?

This means that all the seccomp/ptrace code probably needs to be
updated for this? I'll try to send patches for this as well as the
return code thing Jann pointed out.

> >
> >> +       struct file *ret = ERR_PTR(-EBUSY);
> >> +       struct seccomp_filter *cur, *last_locked = NULL;
> >> +       int filter_nesting = 0;
> >> +
> >> +       for (cur = task->seccomp.filter; cur; cur = cur->prev) {
> >> +               mutex_lock_nested(&cur->notify_lock, filter_nesting);
> >> +               filter_nesting++;
> >> +               last_locked = cur;
> >> +               if (cur->notif)
> >> +                       goto out;
> >> +       }
> >> +
> >> +       ret = ERR_PTR(-ENOMEM);
> >> +       filter->notif = kzalloc(sizeof(*(filter->notif)), GFP_KERNEL);
> >
> > sizeof(struct notification) instead, to make the code clearer?
> 
> I prefer what Tycho has: I want to allocate an instances of whatever
> filter->notif is.
> 
> Though, let's do the kzalloc outside of the locking, instead?

Yep, sounds good.

> >> +       ret = anon_inode_getfile("seccomp notify", &seccomp_notify_ops,
> >> +                                filter, O_RDWR);
> >> +       if (IS_ERR(ret))
> >> +               goto out;
> >> +
> >> +
> >> +       /* The file has a reference to it now */
> >> +       __get_seccomp_filter(filter);
> >
> > __get_seccomp_filter() has a comment in it that claims "/* Reference
> > count is bounded by the number of total processes. */". I think this
> > change invalidates that comment. I think it should be fine to just
> > remove the comment.
> 
> Update it to "bounded by total processes and notification listeners"?

Will do.

> >> +out:
> >> +       for (cur = task->seccomp.filter; cur; cur = cur->prev) {
> >
> > s/; cur;/; 1;/, or use a while loop instead? If the NULL check fires
> > here, something went very wrong.
> 
> Hm? This is correct. This is how seccomp_run_filters() walks the list too:
> 
>         struct seccomp_filter *f =
>                         READ_ONCE(current->seccomp.filter);
>         ...
>         for (; f; f = f->prev) {
> 
> Especially if we'll be holding the cred_guard_mutex.

There is a last_locked local here though, I think that's what Jann is
pointing out.

Cheers,

Tycho
