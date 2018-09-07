Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CFEC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F762077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="vg1UoONv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F762077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbeIGU1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:27:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34479 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbeIGU1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:27:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id d19-v6so7210601pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uA6JfU62Dm4/ogPvaiLCmNtIK3dsp5a991sMARKcDaY=;
        b=vg1UoONvoe2HMuwMmF1UUkoribatQoPiVs2y8i9z5C4aznrenwUQH0AsyxulRrLVSi
         4jBnW8vhO3C2sVU3I0IW00+ICno+YvhTd8eIv/LJkZnzq4Qb83rEnmyVU5k+peGgnJ3V
         sEy3L1f0frpxFO/qH5YJRbx02HIbMsSPIY5RuKUx+3z3rW3ExQCimIeC462IdUVQhrJm
         mMTmWFi6ec9aXx8XvVa52TgQYi/VmHVSGInX8xxJbn8QVhdsUFxsX7BZuRt11PzwjAkO
         IEbPIlDCuyk+TsY5EKOIdd/vgn8+5+jSNgWqXGPM6kObwah1DiQsEZjCLRivdpS74Grw
         nViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uA6JfU62Dm4/ogPvaiLCmNtIK3dsp5a991sMARKcDaY=;
        b=LNNnJ7mEVO80CcRQ/0ZSJyYqCHmtNz2NPkV+HnapqsfsU/zzJyB5LIOllfcOHxdt6a
         hP5rbrGPUHoAhuaxkw7IJzHfrACIBTue9Wm2jrC/8VBDl6d0p35rvAC8WXATzT+OuBEd
         mcVnUMU/FnzrpUzYpom8yF3cDslXEt23RCAukECa9OyevwKXiJ396qxC869gA+sRy5T0
         t7bpiT37fwboo6KYDJGBmTrpgLA9SoloMiTeh//HMjLX6+gOP/Q+ooCArAY0LghWnqZg
         hUcsQhW08YfoHJBtPdCguxyE5rOET8b+SkRn1NcqbfWr/0Y+0fKHQ55ZbGiBwTNpeXCT
         5vsA==
X-Gm-Message-State: APzg51CWBHEkDH1Y7zpj+APy0f+ImQzjMcd/ozgH13V6Q4vJ7CLkJJxd
        TSxghQ1p1xvDFpFv7RQ+ol4Q9g==
X-Google-Smtp-Source: ANB0VdYJYoqEp+aSqQ5hMu3DUw8poIr1OcCLSM6SlrwYd8IXBGtD2SM03q6d2f6+o4akHbB5Ebk0Mw==
X-Received: by 2002:a63:c046:: with SMTP id z6-v6mr8963993pgi.114.1536335150890;
        Fri, 07 Sep 2018 08:45:50 -0700 (PDT)
Received: from cisco.cisco.com ([128.107.241.179])
        by smtp.gmail.com with ESMTPSA id x9-v6sm15861743pfd.31.2018.09.07.08.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 08:45:46 -0700 (PDT)
Date:   Fri, 7 Sep 2018 09:45:44 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Tyler Hicks <tyhicks@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v6 1/5] seccomp: add a return code to trap to userspace
Message-ID: <20180907154544.GD3444@cisco.cisco.com>
References: <20180906152859.7810-1-tycho@tycho.ws>
 <20180906152859.7810-2-tycho@tycho.ws>
 <20180906221412.GA26209@sec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906221412.GA26209@sec>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Tyler,

On Thu, Sep 06, 2018 at 10:15:12PM +0000, Tyler Hicks wrote:
> > +Users can read via ``ioctl(SECCOMP_NOTIF_RECV)``  (or ``poll()``) on a seccomp
> > +notification fd to receive a ``struct seccomp_notif``, which contains five
> > +members: the input length of the structure, a globally unique ``id``, the
> 
> This documentation says that id is "globally unique" but an in-code
> comment below says "this is unique for this filter". IIUC, the id is
> only guaranteed to be unique for the filter so this documentation should
> be updated slightly to make it clear that the id is only global in those
> terms.

Yup, thanks.

> > +``pid`` of the task which triggered this request (which may be 0 if the task is
> > +in a pid ns not visible from the listener's pid namespace), a flag representing
> > +whether or not the notification is a result of a non-fatal signal, and the
> > +``data`` passed to seccomp. Userspace can then make a decision based on this
> > +information about what to do, and ``ioctl(SECCOMP_NOTIF_SEND)`` a response,
> > +indicating what should be returned to userspace. The ``id`` member of ``struct
> > +seccomp_notif_resp`` should be the same ``id`` as in ``struct seccomp_notif``.
> > +
> > +It is worth noting that ``struct seccomp_data`` contains the values of register
> > +arguments to the syscall, but does not contain pointers to memory. The task's
> > +memory is accessible to suitably privileged traces via ``ptrace()`` or
> > +``/proc/pid/map_files/``. However, care should be taken to avoid the TOCTOU
> > +mentioned above in this document: all arguments being read from the tracee's
> > +memory should be read into the tracer's memory before any policy decisions are
> > +made. This allows for an atomic decision on syscall arguments.
> > +
> >  Sysctls
> >  =======
> >  
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 6801123932a5..42f3585d925d 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -419,6 +419,15 @@ config SECCOMP_FILTER
> >  
> >  	  See Documentation/userspace-api/seccomp_filter.rst for details.
> >  
> > +config SECCOMP_USER_NOTIFICATION
> 
> Did someone request a Kconfig option for this new feature? If not, I
> think that nuking the Kconfig option would reduce the test matrix. No
> other filter flags have their own build time option but maybe it makes
> sense in this case if this filter flag exposes the kernel to significant
> new attack surface since there's more to this than just a new filter
> flag.
> 
> If someone has a requirement to disable this feature, maybe it'd be
> better to leave the decision up to the distro *and* the admin via a
> sysctl instead of taking the admin out of the decision with a build
> time option.

No, there was no explicit request by anyone, I just did it so I
wouldn't offend anyone with this code. I'll drop it for the next
version.

> >  /**
> >   * struct seccomp_filter - container for seccomp BPF programs
> >   *
> > @@ -66,6 +114,30 @@ struct seccomp_filter {
> >  	bool log;
> >  	struct seccomp_filter *prev;
> >  	struct bpf_prog *prog;
> > +
> > +#ifdef CONFIG_SECCOMP_USER_NOTIFICATION
> > +	/*
> > +	 * A semaphore that users of this notification can wait on for
> > +	 * changes. Actual reads and writes are still controlled with
> > +	 * filter->notify_lock.
> > +	 */
> > +	struct semaphore request;
> > +
> > +	/* A lock for all notification-related accesses. */
> > +	struct mutex notify_lock;
> > +
> > +	/* Is there currently an attached listener? */
> > +	bool has_listener;
> > +
> > +	/* The id of the next request. */
> > +	u64 next_id;
> > +
> > +	/* A list of struct seccomp_knotif elements. */
> > +	struct list_head notifications;
> > +
> > +	/* A wait queue for poll. */
> > +	wait_queue_head_t wqh;
> > +#endif
> 
> I suspect that these additions would benefit from better struct packing
> since there could be a lot of seccomp_filter structs floating around in
> memory on a system with a large number of running containers or
> otherwise sandboxed processes.
> 
> IIRC, there's a 3 byte hole following the log member that could be used
> by has_listener, at least, and I'm not sure how the rest of the new
> members affect things.

Ok, I'll take a look.

> > +static void seccomp_do_user_notification(int this_syscall,
> > +					 struct seccomp_filter *match,
> > +					 const struct seccomp_data *sd)
> > +{
> > +	int err;
> > +	long ret = 0;
> > +	struct seccomp_knotif n = {};
> > +
> > +	mutex_lock(&match->notify_lock);
> > +	err = -ENOSYS;
> > +	if (!match->has_listener)
> > +		goto out;
> > +
> > +	n.pid = task_pid(current);
> > +	n.state = SECCOMP_NOTIFY_INIT;
> > +	n.data = sd;
> > +	n.id = seccomp_next_notify_id(match);
> > +	init_completion(&n.ready);
> > +
> > +	list_add(&n.list, &match->notifications);
> > +	wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
> > +
> > +	mutex_unlock(&match->notify_lock);
> > +	up(&match->request);
> > +
> > +	err = wait_for_completion_interruptible(&n.ready);
> > +	mutex_lock(&match->notify_lock);
> > +
> > +	/*
> > +	 * Here it's possible we got a signal and then had to wait on the mutex
> > +	 * while the reply was sent, so let's be sure there wasn't a response
> > +	 * in the meantime.
> > +	 */
> > +	if (err < 0 && n.state != SECCOMP_NOTIFY_REPLIED) {
> > +		/*
> > +		 * We got a signal. Let's tell userspace about it (potentially
> > +		 * again, if we had already notified them about the first one).
> > +		 */
> > +		n.signalled = true;
> > +		if (n.state == SECCOMP_NOTIFY_SENT) {
> > +			n.state = SECCOMP_NOTIFY_INIT;
> > +			up(&match->request);
> > +		}
> > +		mutex_unlock(&match->notify_lock);
> 
> Is it intentional that you call mutex_unlocked() followed by up() when
> initially waiting but then switch up the order before re-waiting here? I
> don't yet fully understand the locking but this looked odd to me.

No, not intentional. Assuming everything is correct, the order doesn't
matter here. It might be slightly better to do the up() after, since
then the woken task won't immediately sleep waiting on the mutex, but
who knows :)

> > +out_put_fd:
> > +	if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
> > +		if (ret < 0) {
> > +			fput(listener_f);
> > +			put_unused_fd(listener);
> > +		} else {
> > +			fd_install(listener, listener_f);
> > +			ret = listener;
> > +		}
> > +	}
> >  out_free:
> >  	seccomp_filter_free(prepared);
> >  	return ret;
> > @@ -915,6 +1117,9 @@ static long seccomp_get_action_avail(const char __user *uaction)
> >  	case SECCOMP_RET_LOG:
> >  	case SECCOMP_RET_ALLOW:
> >  		break;
> > +	case SECCOMP_RET_USER_NOTIF:
> > +		if (IS_ENABLED(CONFIG_SECCOMP_USER_NOTIFICATION))
> > +			break;
> 
> Lets add a "/* fall through */" comment here to support the ongoing
> effort of marking these sorts of cases in prep for
> -Wimplicit-fallthrough.

Will do.

> >  	default:
> >  		return -EOPNOTSUPP;
> >  	}
> > @@ -1111,6 +1316,7 @@ long seccomp_get_metadata(struct task_struct *task,
> >  #define SECCOMP_RET_KILL_THREAD_NAME	"kill_thread"
> >  #define SECCOMP_RET_TRAP_NAME		"trap"
> >  #define SECCOMP_RET_ERRNO_NAME		"errno"
> > +#define SECCOMP_RET_USER_NOTIF_NAME	"user_notif"
> >  #define SECCOMP_RET_TRACE_NAME		"trace"
> >  #define SECCOMP_RET_LOG_NAME		"log"
> >  #define SECCOMP_RET_ALLOW_NAME		"allow"
> > @@ -1120,6 +1326,7 @@ static const char seccomp_actions_avail[] =
> >  				SECCOMP_RET_KILL_THREAD_NAME	" "
> >  				SECCOMP_RET_TRAP_NAME		" "
> >  				SECCOMP_RET_ERRNO_NAME		" "
> > +				SECCOMP_RET_USER_NOTIF_NAME     " "
> >  				SECCOMP_RET_TRACE_NAME		" "
> >  				SECCOMP_RET_LOG_NAME		" "
> >  				SECCOMP_RET_ALLOW_NAME;
> > @@ -1137,6 +1344,7 @@ static const struct seccomp_log_name seccomp_log_names[] = {
> >  	{ SECCOMP_LOG_TRACE, SECCOMP_RET_TRACE_NAME },
> >  	{ SECCOMP_LOG_LOG, SECCOMP_RET_LOG_NAME },
> >  	{ SECCOMP_LOG_ALLOW, SECCOMP_RET_ALLOW_NAME },
> > +	{ SECCOMP_LOG_USER_NOTIF, SECCOMP_RET_USER_NOTIF_NAME },
> 
> Probably best to keep this list in order. Can you stick it in front of
> the element for TRACE?

Yep!

> > +	/*
> > +	 * If this file is being closed because e.g. the task who owned it
> > +	 * died, let's wake everyone up who was waiting on us.
> > +	 */
> > +	list_for_each_entry(knotif, &filter->notifications, list) {
> > +		if (knotif->state == SECCOMP_NOTIFY_REPLIED)
> > +			continue;
> > +
> > +		knotif->state = SECCOMP_NOTIFY_REPLIED;
> > +		knotif->error = -ENOSYS;
> 
> ENOSYS seems odd to me since the functionality is implemented. Is EIO
> more appropriate? It feels like it better matches an EIO from read(2),
> for example.

I copied the ENOSYS usage from SECCOMP_RET_TRACE: when there is no
tracer attached, it responds to any SECCOMP_RET_TRACE with ENOSYS.
Seems like keeping the same behavior here is useful.

> > +	unotif.len = size;
> > +	unotif.id = knotif->id;
> > +	unotif.pid = pid_vnr(knotif->pid);
> > +	unotif.signalled = knotif->signalled;
> > +	unotif.data = *(knotif->data);
> > +
> > +	if (copy_to_user(buf, &unotif, size)) {
> > +		ret = -EFAULT;
> > +		goto out;
> > +	}
> > +
> > +	ret = sizeof(unotif);
> 
> I would have thought that ret = size since only size bytes are copied.

Yes, right you are.

> > +	knotif->state = SECCOMP_NOTIFY_SENT;
> > +	wake_up_poll(&filter->wqh, EPOLLOUT | EPOLLWRNORM);
> > +
> > +out:
> > +	mutex_unlock(&filter->notify_lock);
> > +	return ret;
> > +}
> > +
> > +static long seccomp_notify_send(struct seccomp_filter *filter,
> > +				unsigned long arg)
> > +{
> > +	struct seccomp_notif_resp resp = {};
> > +	struct seccomp_knotif *knotif = NULL;
> > +	long ret;
> > +	u16 size;
> > +	void __user *buf = (void __user *)arg;
> > +
> > +	if (copy_from_user(&size, buf, sizeof(size)))
> > +		return -EFAULT;
> > +	size = min_t(size_t, size, sizeof(resp));
> > +	if (copy_from_user(&resp, buf, size))
> > +		return -EFAULT;
> > +
> > +	ret = mutex_lock_interruptible(&filter->notify_lock);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	list_for_each_entry(knotif, &filter->notifications, list) {
> > +		if (knotif->id == resp.id)
> > +			break;
> > +	}
> > +
> > +	if (!knotif || knotif->id != resp.id) {
> > +		ret = -EINVAL;
> 
> ENOENT here instead? It clearly conveys that there is no notification
> matching the requested ID. We'll probably have a more ambiguous error
> path that we can use to abuse EINVAL. :)

Yes, will do :)

> > +		goto out;
> > +	}
> > +
> > +	/* Allow exactly one reply. */
> > +	if (knotif->state != SECCOMP_NOTIFY_SENT) {
> > +		ret = -EINPROGRESS;
> > +		goto out;
> > +	}
> > +
> > +	ret = size;
> > +	knotif->state = SECCOMP_NOTIFY_REPLIED;
> > +	knotif->error = resp.error;
> > +	knotif->val = resp.val;
> > +	complete(&knotif->ready);
> > +out:
> > +	mutex_unlock(&filter->notify_lock);
> > +	return ret;
> > +}
> > +
> > +static long seccomp_notify_is_id_valid(struct seccomp_filter *filter,
> > +				       unsigned long arg)
> > +{
> > +	struct seccomp_knotif *knotif = NULL;
> > +	void __user *buf = (void __user *)arg;
> > +	u64 id;
> > +
> > +	if (copy_from_user(&id, buf, sizeof(id)))
> > +		return -EFAULT;
> > +
> > +	list_for_each_entry(knotif, &filter->notifications, list) {
> > +		if (knotif->id == id)
> > +			return 1;
> > +	}
> > +
> > +	return 0;
> 
> I understand the desire to return 1 from
> ioctl(fd, SECCOMP_NOTIF_IS_ID_VALID, id) when id is valid but it goes
> against the common case where a syscall returns 0 on success. Also, the
> ioctl_list(2) man page states:
> 
>  Decent ioctls return 0 on success and -1 on error, ...
> 
> The only suggestion that I have here is to change the ioctl name to
> SECCOMP_NOTIF_VALID_ID (or similiar) and return 0 if the id is valid and
> -EINVAL if the id is invalid. I don't feel strongly about it so take it
> or leave it.

Sure, will do.

> > +}
> > +
> > +static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
> > +				 unsigned long arg)
> > +{
> > +	struct seccomp_filter *filter = file->private_data;
> > +
> > +	switch (cmd) {
> > +	case SECCOMP_NOTIF_RECV:
> > +		return seccomp_notify_recv(filter, arg);
> > +	case SECCOMP_NOTIF_SEND:
> > +		return seccomp_notify_send(filter, arg);
> > +	case SECCOMP_NOTIF_IS_ID_VALID:
> > +		return seccomp_notify_is_id_valid(filter, arg);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static __poll_t seccomp_notify_poll(struct file *file,
> > +				    struct poll_table_struct *poll_tab)
> > +{
> > +	struct seccomp_filter *filter = file->private_data;
> > +	__poll_t ret = 0;
> > +	struct seccomp_knotif *cur;
> > +
> > +	poll_wait(file, &filter->wqh, poll_tab);
> > +
> > +	ret = mutex_lock_interruptible(&filter->notify_lock);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	list_for_each_entry(cur, &filter->notifications, list) {
> > +		if (cur->state == SECCOMP_NOTIFY_INIT)
> > +			ret |= EPOLLIN | EPOLLRDNORM;
> > +		if (cur->state == SECCOMP_NOTIFY_SENT)
> > +			ret |= EPOLLOUT | EPOLLWRNORM;
> > +		if (ret & EPOLLIN && ret & EPOLLOUT)
> > +			break;
> > +	}
> > +
> > +	mutex_unlock(&filter->notify_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct file_operations seccomp_notify_ops = {
> > +	.poll = seccomp_notify_poll,
> > +	.release = seccomp_notify_release,
> > +	.unlocked_ioctl = seccomp_notify_ioctl,
> > +};
> > +
> > +static struct file *init_listener(struct task_struct *task,
> > +				  struct seccomp_filter *filter)
> > +{
> > +	struct file *ret = ERR_PTR(-EBUSY);
> > +	struct seccomp_filter *cur, *last_locked = NULL;
> > +	int filter_nesting = 0;
> > +
> > +	for (cur = task->seccomp.filter; cur; cur = cur->prev) {
> > +		mutex_lock_nested(&cur->notify_lock, filter_nesting);
> > +		filter_nesting++;
> > +		last_locked = cur;
> > +		if (cur->has_listener)
> > +			goto out;
> > +	}
> > +
> > +	ret = anon_inode_getfile("seccomp notify", &seccomp_notify_ops,
> > +				 filter, O_RDWR);
> > +	if (IS_ERR(ret))
> > +		goto out;
> > +
> > +
> > +	/* The file has a reference to it now */
> > +	__get_seccomp_filter(filter);
> > +	filter->has_listener = true;
> > +
> > +out:
> > +	for (cur = task->seccomp.filter; cur; cur = cur->prev) {
> > +		mutex_unlock(&cur->notify_lock);
> > +		if (cur == last_locked)
> > +			break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +#else
> > +static struct file *init_listener(struct task_struct *task,
> > +				  struct seccomp_filter *filter)
> > +{
> > +	return ERR_PTR(-EINVAL);
> > +}
> > +#endif
> > diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > index e1473234968d..89f2c788a06b 100644
> > --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> > +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > @@ -5,6 +5,7 @@
> >   * Test code for seccomp bpf.
> >   */
> 
> [...]
> 
> I only gave the tests a quick review so far but nothing stood out.
> 
> I'm anxious to give this patch set some testing. I'll get to the other
> patches soon.

Thanks!

Tycho
