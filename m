Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC27C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5739420872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="UEUiho+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5739420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754122AbeFTOzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:55:06 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36482 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753541AbeFTOzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:55:03 -0400
Received: by mail-it0-f67.google.com with SMTP id j135-v6so48811itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 07:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A0Eqq1YFw6BedwVmUoYxvrLqWTEDQE4sVTT1uG1Jn7E=;
        b=UEUiho+5Ewd28Y05Uv/c5O3LWuZ6wnl1PL5jgq8bG1GfDtENG48lbPCi0Mg4hk9HbD
         tVh1/xzW5LtIiyeO1N+zG9b5qeRjjeFTNJZsp6msAhEeaSpGT0yXPRWfmerKvPzdPQiO
         4gkl8fu2soO67jkfR5fB4S5XzTGKRlkYPAP9uTRHkVlya2cY8gXmU7xbvo9LJhD9769H
         uxD7sKOD3UHpXyNW/EcVz7pgTazCUmMc+yhQKE16VVU37oOQkfn0CvguF1bKeKL1Qsgf
         NAkFqrMyNpiaClLMgphpHbqMHmrloPd0Uxx+1p8gl5jqsGBM+/DNIRgZhK1skoGJNCpk
         ARgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A0Eqq1YFw6BedwVmUoYxvrLqWTEDQE4sVTT1uG1Jn7E=;
        b=stOV/bE2O3vpPI1Hplfli0NLaoG8bgDTIzn8JbVG+lU2R6J1eSA+/XUUn/Gz5sOtTL
         AylogRymKl7VLc+WjRcfbM4Hiot2TRz9fcDJpqEtwr+xxzlXvEs18p6G2E3JR/jtG0q5
         zIOqcUEY5YnF/7Hd6pWAqxW8ZjuHkdl7NwetkqM4WLxX/4oSt72MYRNRy1L+jO1X0qhb
         uVDRNzHmIpho7ZX9jlfNtkUkYdQUdw+NgB5ueXLTPncqCTo9xcsIZ1eR+uoSJMK5qxXM
         tU/sliW0Ze8gITfdwymJ8cv6eU6HJOG1KiOG8T/pW6Mm5bd1U4yeep8xbMqcTsG4I1ur
         zQeg==
X-Gm-Message-State: APt69E2YhO/IPRh9QOxT5NY+XpS2xPRBcOqMNCN/TUtRkhAhFxPJiQAf
        7rYZqcQMidpOBpmBel6qud32Zw==
X-Google-Smtp-Source: ADUXVKKsIgh7StNpW8hj5xU4wufU4gvR32Ow5vbO3hq4jObC5xh8Sdl+fdVmwQUdnnE2IcCkLsHAWg==
X-Received: by 2002:a24:d6cf:: with SMTP id o198-v6mr1813011itg.3.1529506502157;
        Wed, 20 Jun 2018 07:55:02 -0700 (PDT)
Received: from smitten ([8.24.24.129])
        by smtp.gmail.com with ESMTPSA id d136-v6sm1294639itd.22.2018.06.20.07.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 07:55:01 -0700 (PDT)
Date:   Wed, 20 Jun 2018 08:55:00 -0600
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
Message-ID: <20180620145500.GI14770@smitten>
References: <20180531144949.24995-1-tycho@tycho.ws>
 <20180531144949.24995-2-tycho@tycho.ws>
 <CA+RrjuUhFW+XU7RkZOM+f8cyDGOBjJrQHK3GruZmmCETb8ugfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+RrjuUhFW+XU7RkZOM+f8cyDGOBjJrQHK3GruZmmCETb8ugfA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 02:55:03PM -0700, Matthew Helsley wrote:
> > +       /*
> > +        * Notification states. When SECCOMP_RET_USER_NOTIF is returned, a
> > +        * struct seccomp_knotif is created and starts out in INIT. Once
> > the
> > +        * handler reads the notification off of an FD, it transitions to
> > READ.
> >
> 
> Comment above needs to be updated: READ state no longer exists.

Thanks, fixed for v4.

> 
> > +        * If a signal is received the state transitions back to INIT and
> > +        * another message is sent. When the userspace handler replies,
> > state
> > +        * transitions to REPLIED.
> > +        */
> > +       enum notify_state state;
> > +
> > +       /* The return values, only valid when in SECCOMP_NOTIFY_REPLIED */
> > +       int error;
> > +       long val;
> > +
> > +       /* Signals when this has entered SECCOMP_NOTIFY_REPLIED */
> > +       struct completion ready;
> > +
> > +       struct list_head list;
> > +};
> > +#endif
> > +
> >  /**
> >   * struct seccomp_filter - container for seccomp BPF programs
> >   *
> > @@ -64,6 +111,27 @@ struct seccomp_filter {
> >         bool log;
> >         struct seccomp_filter *prev;
> >         struct bpf_prog *prog;
> > +
> > +#ifdef CONFIG_SECCOMP_USER_NOTIFICATION
> > +       /*
> > +        * A semaphore that users of this notification can wait on for
> > +        * changes. Actual reads and writes are still controlled with
> > +        * filter->notify_lock.
> > +        */
> > +       struct semaphore request;
> > +
> > +       /* A lock for all notification-related accesses. */
> > +       struct mutex notify_lock;
> > +
> > +       /* Is there currently an attached listener? */
> > +       bool has_listener;
> >
> 
> Assumes only one listener.
>
> Is there any chance userspace could try to attach multiple listeners and
> get confused? Perhaps by sharing the fd with multiple processes (via exec,
> SCM_RIGHTS..)?

Yes, only one listener fd is allowed, we return -EBUSY if you try to
attach multiple times. Once the fd is created, listening to it with
multiple tasks is fine, we synchronize that (indeed, that's what the
stress test tests).

> > +       /*
> > +        * Here it's possible we got a signal and then had to wait on the
> > mutex
> > +        * while the reply was sent, so let's be sure there wasn't a
> > response
> > +        * in the meantime.
> > +        */
> > +       if (err < 0 && n.state != SECCOMP_NOTIFY_REPLIED) {
> > +               /*
> > +                * We got a signal. Let's tell userspace about it
> > (potentially
> > +                * again, if we had already notified them about the first
> > one).
> > +                */
> > +               if (n.state == SECCOMP_NOTIFY_SENT) {
> > +                       n.state = SECCOMP_NOTIFY_INIT;
> > +                       up(&match->request);
> > +               }
> > +               mutex_unlock(&match->notify_lock);
> > +               err = wait_for_completion_killable(&n.ready);
> > +               mutex_lock(&match->notify_lock);
> > +               if (err < 0)
> > +                       goto remove_list;
> > +       }
> >
> 
> This section looks a little odd.
> 
> I notice you don't loop here yet you reset n.state back to INIT and don't
> wait for
> it to return to the SENT (much less REPLIED) state. This effectively looks
> like a subtle
> hard-coded number of "send" retries.

Yes, it is.

> I'm low on time so I couldn't figure out answers to some important
> questions:
> 
> Is one "retry" always enough? Is it possible the notification might get
> lost due to the lack
> of a loop here? Is it possible the syscall might return without a "reply"?
> That's not
> consistent with your comments about the states. Is there any possibility of
> missing a
> completion because of the interaction between this and other parts that
> signal completion
> conditionally based on this state?

This is in response to this subthread on the first version:
https://lkml.org/lkml/2018/3/15/1122

Basically, we want exactly one notification if the thing gets a
signal, and then we wait_killable instead of wait_interruptible
instead. It should not be possible for a syscall to return without a
reply (indeed, for a syscall to return, it needs a wake on the
completion, so it would just hang forever if there's some bug here).

> +
> > +       ret = n.val;
> > +       err = n.error;
> > +
> > +remove_list:
> > +       list_del(&n.list);
> > +out:
> > +       mutex_unlock(&match->notify_lock);
> > +       syscall_set_return_value(current, task_pt_regs(current),
> > +                                err, ret);
> > +}
> > +#else
> > +static void seccomp_do_user_notification(int this_syscall,
> > +                                        struct seccomp_filter *match,
> > +                                        const struct seccomp_data *sd)
> > +{
> > +       seccomp_log(this_syscall, SIGSYS, SECCOMP_RET_USER_NOTIF, true);
> > +       do_exit(SIGSYS);
> > +}
> > +#endif
> > +
> >  #ifdef CONFIG_SECCOMP_FILTER
> >  static int __seccomp_filter(int this_syscall, const struct seccomp_data
> > *sd,
> >                             const bool recheck_after_trace)
> > @@ -722,6 +877,9 @@ static int __seccomp_filter(int this_syscall, const
> > struct seccomp_data *sd,
> >
> >                 return 0;
> >
> > +       case SECCOMP_RET_USER_NOTIF:
> > +               seccomp_do_user_notification(this_syscall, match, sd);
> > +               goto skip;
> >         case SECCOMP_RET_LOG:
> >                 seccomp_log(this_syscall, 0, action, true);
> >                 return 0;
> > @@ -828,6 +986,9 @@ static long seccomp_set_mode_strict(void)
> >  }
> >
> >  #ifdef CONFIG_SECCOMP_FILTER
> > +static struct file *init_listener(struct task_struct *,
> > +                                 struct seccomp_filter *);
> > +
> >  /**
> >   * seccomp_set_mode_filter: internal function for setting seccomp filter
> >   * @flags:  flags to change filter behavior
> > @@ -847,6 +1008,8 @@ static long seccomp_set_mode_filter(unsigned int
> > flags,
> >         const unsigned long seccomp_mode = SECCOMP_MODE_FILTER;
> >         struct seccomp_filter *prepared = NULL;
> >         long ret = -EINVAL;
> > +       int listener = 0;
> > +       struct file *listener_f = NULL;
> >
> >         /* Validate flags. */
> >         if (flags & ~SECCOMP_FILTER_FLAG_MASK)
> > @@ -857,13 +1020,28 @@ static long seccomp_set_mode_filter(unsigned int
> > flags,
> >         if (IS_ERR(prepared))
> >                 return PTR_ERR(prepared);
> >
> > +       if (flags & SECCOMP_FILTER_FLAG_GET_LISTENER) {
> 
> +               listener = get_unused_fd_flags(O_RDWR);
> >
> 
> So I checked and a man page does need to be update. Among other updates
> this needs a mention in the RETURN section of
> man 2 seccomp along the lines of:
> 
> "If SECCOMP_FILTER_FLAG_GET_LISTENER is specified then the return value is
> a file descriptor upon success or -1 otherwise."
> 
> "If seccomp() is called multiple times
> with SECCOMP_FILTER_FLAG_GET_LISTENER then, after the first successful
> call, it will not
> create any new file descriptors and may return with either the existing
> file descriptor or -1 and errno set to EBUSY" (I smell a testcase!)

Yes, I'll update the man pages when these get merged. And there
already is a test for this.

> Now, that said, this interface is somewhat awkward. The principle of least
> surprise suggests that subsequent calls with GET_LISTENER
> should return any file descriptor created previously rather than -1 and
> errno==EBUSY. Perhaps rather than GET_LISTENER you could rename it
> NEW_LISTENER_EXCL. Or you could add the ability to return any pre-existing
> fd.

How about NEW_LISTENER? We can add a GET_LISTENER command later if
people find it useful, but frankly I think the ptrace interface is
what most people will use, and we could possibly drop this all
together.

> > +static ssize_t seccomp_notify_read(struct file *f, char __user *buf,
> > +                                  size_t size, loff_t *ppos)
> > +{
> > +       struct seccomp_filter *filter = f->private_data;
> > +       struct seccomp_knotif *knotif = NULL, *cur;
> > +       struct seccomp_notif unotif;
> > +       ssize_t ret;
> > +
> > +       /* No offset reads. */
> > +       if (*ppos != 0)
> > +               return -EINVAL;
> > +
> >
> 
> I think you should use memset to clear unotif -- that prevents any
> accidental information disclosure
> via the kernel stack if this structure ever has padding.

Good catch, thanks.

> Will the size of unotif ever *possibly* need to change (i.e. grow) in the
> future? You might consider
> how that could be enabled while maintaining backwards compatibility.
> 
> I'm thinking you should check size here:
> 
> if (size < sizeof(unotif))
>         return -EFAULT;

Well, if it ever needs to grow, we can't do that :). And yes, the
intent is for it to grow -- it does later in this series, for example.

> Yes, copy_to_user() will stop you from walking past a page boundary but it
> won't
> stop you from quietly clobbering legitimate userspace memory. Seeing:
> 
> size != sizeof(unotif)
> 
> is also an indicator that there may be an ABI mismatch -- so again,
> consider the
> current/possible-future behavior carefully.
> 
> +       ret = down_interruptible(&filter->request);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       mutex_lock(&filter->notify_lock);
> > +       list_for_each_entry(cur, &filter->notifications, list) {
> > +               if (cur->state == SECCOMP_NOTIFY_INIT) {
> > +                       knotif = cur;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       /*
> > +        * If we didn't find a notification, it could be that the task was
> > +        * interrupted between the time we were woken and when we were
> > able to
> > +        * acquire the rw lock. Should we retry here or just -ENOENT?
> > -ENOENT
> > +        * for now.
> > +        */
> > +       if (!knotif) {
> > +               ret = -ENOENT;
> > +               goto out;
> > +       }
> > +
> > +       unotif.id = knotif->id;
> > +       unotif.pid = knotif->pid;
> > +       unotif.data = *(knotif->data);
> > +
> > +       size = min_t(size_t, size, sizeof(struct seccomp_notif));
> 
> 
> nit: sizeof(unotif) here since that's shorter, ultimately what we're
> copying to userspace,
> changes if the type ever changes, and you're also using that to set ret
> later.

Fixed, thanks.

> 
> >
> 
> +       if (copy_to_user(buf, &unotif, size)) {
> > +               ret = -EFAULT;
> > +               goto out;
> > +       }
> > +
> > +       ret = sizeof(unotif);
> > +       knotif->state = SECCOMP_NOTIFY_SENT;
> > +
> > +out:
> > +       mutex_unlock(&filter->notify_lock);
> > +       return ret;
> > +}
> > +
> > +static ssize_t seccomp_notify_write(struct file *file, const char __user
> > *buf,
> > +                                   size_t size, loff_t *ppos)
> > +{
> > +       struct seccomp_filter *filter = file->private_data;
> > +       struct seccomp_notif_resp resp = {};
> > +       struct seccomp_knotif *knotif = NULL;
> > +       ssize_t ret = -EINVAL;
> > +
> > +       /* No partial writes. */
> > +       if (*ppos != 0)
> > +               return -EINVAL;
> >
> 
> What happens if size < sizeof(resp) ? Is there a chance we could give some
> kernel bits to
> the process we're filtering with seccomp()?
> 
> Again: Using memset() to clear resp seems like a good step since it
> contains field(s) that
> could appear in the filtered program. That or simply:
> 
> if (size < sizeof(resp))
>         return -EINVAL;

We're initializing with = {}, so I think it's not necessary here.

> 
> > +
> > +       size = min_t(size_t, size, sizeof(resp));
> > +       if (copy_from_user(&resp, buf, size))
> > +               return -EFAULT;
> > +
> > +       ret = mutex_lock_interruptible(&filter->notify_lock);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       list_for_each_entry(knotif, &filter->notifications, list) {
> > +               if (knotif->id == resp.id)
> > +                       break;
> > +       }
> > +
> > +       if (!knotif || knotif->id != resp.id) {
> > +               ret = -EINVAL;
> > +               goto out;
> > +       }
> > +
> > +       /* Allow exactly one reply. */
> > +       if (knotif->state != SECCOMP_NOTIFY_SENT) {
> > +               ret = -EINVAL;
> >
> 
> nit: is there a better errno than EINVAL for this which would distinguish
> this error from simple invalid parameters?
> 
> EALREADY (connection already in progress)?      <-- not mentioned in man 2
> write ("unused" below)
> EINPROGRESS (operation already in progress)? <-- unused (see man 2 connect)

Sure, I'll switch to one of these.

> ENOTSUP ?                                                           <--
> unused
> ENOTUNIQ (name not unique on network)?          <-- unused
> ENOSPC (device containing file has no room for the data)?  <-- definitely
> used
> EIO (low level IO error) ?
>        <-- definitely used
> 
> 
> > +               goto out;
> > +       }
> > +
> > +       ret = size;
> > +       knotif->state = SECCOMP_NOTIFY_REPLIED;
> > +       knotif->error = resp.error;
> > +       knotif->val = resp.val;
> > +       complete(&knotif->ready);
> > +out:
> > +       mutex_unlock(&filter->notify_lock);
> > +       return ret;
> > +}
> > +
> > +static __poll_t seccomp_notify_poll(struct file *file,
> > +                                   struct poll_table_struct *poll_tab)
> > +{
> > +       struct seccomp_filter *filter = file->private_data;
> > +       __poll_t ret = 0;
> > +       struct seccomp_knotif *cur;
> > +
> > +       ret = mutex_lock_interruptible(&filter->notify_lock);
> > +       if (ret < 0)
> > +               return ret;
> 
> +
> > +       list_for_each_entry(cur, &filter->notifications, list) {
> > +               if (cur->state == SECCOMP_NOTIFY_INIT)
> > +                       ret |= EPOLLIN | EPOLLRDNORM;
> > +               if (cur->state == SECCOMP_NOTIFY_SENT)
> > +                       ret |= EPOLLOUT | EPOLLWRNORM;
> >
> 
> Hmm, it's been a while since I read poll file ops but if you do wind up
> walking this list then you may not have to walk the entire list here:
> 
> if (ret == EPOLLIN | EPOLLRDNORM | EPOLLOUT | EPOLLWRNORM)
>         break;
> 
> Then poll() is not always O(N) (where N is the number of queued
> notifications...)

Yep, poll is totally reworked for v4 based on other comments.

Tycho
