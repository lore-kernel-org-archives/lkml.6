Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E26EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7AC20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g2AGV0vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7AC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeLMXPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 18:15:54 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38310 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbeLMXPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 18:15:54 -0500
Received: by mail-lf1-f65.google.com with SMTP id p86so2889987lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 15:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cOgtwtXW2hwS4Z5secLwWSgf9qVAsZc00uIwXSzbqcA=;
        b=g2AGV0vvtxqZ4m+7N5P08alz2vCM+Wa+gifJVW71fCojW+eVa70Lsr8S5sGehpXcAr
         Wl+g9HLZvE/yOBNgepugty6gsmtYvs81Qxkx6TqVmAA4LhauSRmfQXblS0DPi5c8QP0S
         3NhDHJ6En9nHyApuRGBjDfxeAs9eE8jmKM9Q1E6AbXmbKRnn35vGyyCfQ+fsv0UsMDKt
         d3zLv+o4eX6Jdt5d+ToSDdjzgP7TvkjJih0onN77ejJB4i/Vp2Aw4HoU35QiJa9na/+u
         1+SX2ueVdQr2pRmPf1ClUIEoBIeLmPN2uuFU5xcoSAwsMrEOGutpwsIPZasvacOanjZj
         UcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOgtwtXW2hwS4Z5secLwWSgf9qVAsZc00uIwXSzbqcA=;
        b=BIuPcJEAX1ozOmTeJgu5tPRoBLsJm7tmNb5S1kxknReCBAdmeGK9RaQ9VSSLmExOPq
         5n/HbjtVcAMRaPb5QBagTf2yrcEjLMy0f9Dx4qw8FswuSMZUrjoXI7Td+yZ/04OC2aze
         nzeCMS1DOrQ7uKwXuDC/5KHnm2/b+Z3p3yGkd3vOCUjHcmKwhjjZu2L/EisXFJRRfj+H
         W982tTgxH0hdVbVEonfaNigM2IMTGuwwXOpXp65fnYZxE8tDTjloawCk4aOszgGCZ2kd
         1wGEHiKTgBSJdP/MGbY2yEqIKCfk636yIyAxvT2d78HTwpXNkBbAC1xvwdtctQiXjd0a
         6bGw==
X-Gm-Message-State: AA+aEWYwjr17TuYFb5aYnvi/xutWLY8h9UNAHodQmYjNn4sSqpJ8Rcb6
        EfySJCPjIzeaJlya/X3USOUOZieVPW//7ZJCfXUbJQ==
X-Google-Smtp-Source: AFSGD/W+tykRWyPTbmbWJ9e1McGKp6OUzptzxZ3r8BAqpmGpkWVikIqPCXWYh/kZxvLCv7L1JWEK2UnSRdg+rCMWk7w=
X-Received: by 2002:ac2:4215:: with SMTP id y21mr391524lfh.6.1544742949935;
 Thu, 13 Dec 2018 15:15:49 -0800 (PST)
MIME-Version: 1.0
References: <20181213210401.83041-1-tkjos@google.com>
In-Reply-To: <20181213210401.83041-1-tkjos@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 13 Dec 2018 15:15:38 -0800
Message-ID: <CAHRSSExfd9==SUGqh-iqdFkypVVG_scVD5S+net+2ukCo4U75A@mail.gmail.com>
Subject: Re: [PATCH] binder: fix use-after-free due to ksys_close() during fdget()
To:     Todd Kjos <tkjos@android.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, joel@joelfernandes.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I need to make a change to this patch, so please ignore this version.
I'll send a v2 soon.
On Thu, Dec 13, 2018 at 1:04 PM Todd Kjos <tkjos@android.com> wrote:
>
> 44d8047f1d8 ("binder: use standard functions to allocate fds")
> exposed a pre-existing issue in the binder driver.
>
> fdget() is used in ksys_ioctl() as a performance optimization.
> One of the rules associated with fdget() is that ksys_close() must
> not be called between the fdget() and the fdput(). There is a case
> where this requirement is not met in the binder driver which results
> in the reference count dropping to 0 when the device is still in
> use. This can result in use-after-free or other issues.
>
> If userpace has passed a file-descriptor for the binder driver using
> a BINDER_TYPE_FDA object, then kys_close() is called on it when
> handling a binder_ioctl(BC_FREE_BUFFER) command. This violates
> the assumptions for using fdget().
>
> The problem is fixed by deferring the fd close using task_work_add()
> so ksys_close() is called after returning from binder_ioctl().
>
> Fixes: 44d8047f1d87a ("binder: use standard functions to allocate fds")
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---
>  drivers/android/binder.c | 91 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 81 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index c525b164d39d2..8f77d6af31209 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -72,6 +72,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/ratelimit.h>
>  #include <linux/syscalls.h>
> +#include <linux/task_work.h>
>
>  #include <uapi/linux/android/binder.h>
>
> @@ -560,6 +561,9 @@ enum {
>   *                        (protected by @proc->inner_lock)
>   * @waiting_thread_node:  element for @proc->waiting_threads list
>   *                        (protected by @proc->inner_lock)
> + * @deferred_close_fd_cb: callback_head for task work
> + * @deferred_close_fds:   list of fds to be closed
> + *                        (only accessed by this thread)
>   * @pid:                  PID for this thread
>   *                        (invariant after initialization)
>   * @looper:               bitmap of looping state
> @@ -592,6 +596,8 @@ struct binder_thread {
>         struct binder_proc *proc;
>         struct rb_node rb_node;
>         struct list_head waiting_thread_node;
> +       struct callback_head deferred_close_fd_cb;
> +       struct hlist_head deferred_close_fds;
>         int pid;
>         int looper;              /* only modified by this thread */
>         bool looper_need_return; /* can be written by other thread */
> @@ -2184,7 +2190,64 @@ static bool binder_validate_fixup(struct binder_buffer *b,
>         return (fixup_offset >= last_min_offset);
>  }
>
> +struct binder_task_work {
> +       struct hlist_node entry;
> +       int fd;
> +};
> +
> +/**
> + * binder_do_fd_close() - close list of file descriptors
> + * @twork:     callback head for task work
> + *
> + * It is not safe to call ksys_close() during the binder_ioctl()
> + * function if there is a chance that binder's own file descriptor
> + * might be closed. This is to meet the requirements for using
> + * fdget() (see comments for __fget_light()). Therefore use
> + * task_add_work() to schedule the close operation once we have
> + * returned from binder_ioctl(). This function is a callback
> + * for that mechanism and does the actual ksys_close() on the list
> + * of file descriptors.
> + */
> +static void binder_do_fd_close(struct callback_head *twork)
> +{
> +       struct binder_thread *thread = container_of(twork,
> +                       struct binder_thread, deferred_close_fd_cb);
> +       struct hlist_node *entry, *tmp;
> +
> +       hlist_for_each_safe(entry, tmp, &thread->deferred_close_fds) {
> +               struct binder_task_work *work = container_of(entry,
> +                               struct binder_task_work, entry);
> +
> +               ksys_close(work->fd);
> +               hlist_del(&work->entry);
> +               kfree(work);
> +       }
> +}
> +
> +/**
> + * binder_deferred_fd_close() - schedule a close for the given file-descriptor
> + * @thread:    struct binder_thread for this task
> + * @fd:                file-descriptor to close
> + *
> + * See comments in binder_do_fd_close(). This function is used to schedule
> + * a file-descriptor to be closed after returning from binder_ioctl().
> + */
> +static void binder_deferred_fd_close(struct binder_thread *thread, int fd)
> +{
> +       struct binder_task_work *work;
> +
> +       work = kzalloc(sizeof(*work), GFP_KERNEL);
> +       if (!work)
> +               return;
> +       work->fd = fd;
> +
> +       if (hlist_empty(&thread->deferred_close_fds))
> +               task_work_add(current, &thread->deferred_close_fd_cb, true);
> +       hlist_add_head(&work->entry, &thread->deferred_close_fds);
> +}
> +
>  static void binder_transaction_buffer_release(struct binder_proc *proc,
> +                                             struct binder_thread *thread,
>                                               struct binder_buffer *buffer,
>                                               binder_size_t *failed_at)
>  {
> @@ -2323,7 +2386,8 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
>                         }
>                         fd_array = (u32 *)(parent_buffer + (uintptr_t)fda->parent_offset);
>                         for (fd_index = 0; fd_index < fda->num_fds; fd_index++)
> -                               ksys_close(fd_array[fd_index]);
> +                               binder_deferred_fd_close(thread,
> +                                                        fd_array[fd_index]);
>                 } break;
>                 default:
>                         pr_err("transaction release %d bad object type %x\n",
> @@ -3266,7 +3330,7 @@ static void binder_transaction(struct binder_proc *proc,
>  err_copy_data_failed:
>         binder_free_txn_fixups(t);
>         trace_binder_transaction_failed_buffer_release(t->buffer);
> -       binder_transaction_buffer_release(target_proc, t->buffer, offp);
> +       binder_transaction_buffer_release(target_proc, thread, t->buffer, offp);
>         if (target_node)
>                 binder_dec_node_tmpref(target_node);
>         target_node = NULL;
> @@ -3330,6 +3394,7 @@ static void binder_transaction(struct binder_proc *proc,
>  /**
>   * binder_free_buf() - free the specified buffer
>   * @proc:      binder proc that owns buffer
> + * @thread:    current binder thread
>   * @buffer:    buffer to be freed
>   *
>   * If buffer for an async transaction, enqueue the next async
> @@ -3338,7 +3403,8 @@ static void binder_transaction(struct binder_proc *proc,
>   * Cleanup buffer and free it.
>   */
>  static void
> -binder_free_buf(struct binder_proc *proc, struct binder_buffer *buffer)
> +binder_free_buf(struct binder_proc *proc, struct binder_thread *thread,
> +               struct binder_buffer *buffer)
>  {
>         if (buffer->transaction) {
>                 buffer->transaction->buffer = NULL;
> @@ -3364,7 +3430,7 @@ binder_free_buf(struct binder_proc *proc, struct binder_buffer *buffer)
>                 binder_node_inner_unlock(buf_node);
>         }
>         trace_binder_transaction_buffer_release(buffer);
> -       binder_transaction_buffer_release(proc, buffer, NULL);
> +       binder_transaction_buffer_release(proc, thread, buffer, NULL);
>         binder_alloc_free_buf(&proc->alloc, buffer);
>  }
>
> @@ -3558,7 +3624,7 @@ static int binder_thread_write(struct binder_proc *proc,
>                                      proc->pid, thread->pid, (u64)data_ptr,
>                                      buffer->debug_id,
>                                      buffer->transaction ? "active" : "finished");
> -                       binder_free_buf(proc, buffer);
> +                       binder_free_buf(proc, thread, buffer);
>                         break;
>                 }
>
> @@ -3883,7 +3949,8 @@ static int binder_wait_for_work(struct binder_thread *thread,
>
>  /**
>   * binder_apply_fd_fixups() - finish fd translation
> - * @t: binder transaction with list of fd fixups
> + * @thread:    current binder thread
> + * @t:         binder transaction with list of fd fixups
>   *
>   * Now that we are in the context of the transaction target
>   * process, we can allocate and install fds. Process the
> @@ -3894,7 +3961,8 @@ static int binder_wait_for_work(struct binder_thread *thread,
>   * fput'ing files that have not been processed and ksys_close'ing
>   * any fds that have already been allocated.
>   */
> -static int binder_apply_fd_fixups(struct binder_transaction *t)
> +static int binder_apply_fd_fixups(struct binder_thread *thread,
> +                                 struct binder_transaction *t)
>  {
>         struct binder_txn_fd_fixup *fixup, *tmp;
>         int ret = 0;
> @@ -3942,7 +4010,7 @@ static int binder_apply_fd_fixups(struct binder_transaction *t)
>                 } else if (ret) {
>                         u32 *fdp = (u32 *)(t->buffer->data + fixup->offset);
>
> -                       ksys_close(*fdp);
> +                       binder_deferred_fd_close(thread, *fdp);
>                 }
>                 list_del(&fixup->fixup_entry);
>                 kfree(fixup);
> @@ -4237,7 +4305,7 @@ static int binder_thread_read(struct binder_proc *proc,
>                         tr.sender_pid = 0;
>                 }
>
> -               ret = binder_apply_fd_fixups(t);
> +               ret = binder_apply_fd_fixups(thread, t);
>                 if (ret) {
>                         struct binder_buffer *buffer = t->buffer;
>                         bool oneway = !!(t->flags & TF_ONE_WAY);
> @@ -4248,7 +4316,7 @@ static int binder_thread_read(struct binder_proc *proc,
>                         buffer->transaction = NULL;
>                         binder_cleanup_transaction(t, "fd fixups failed",
>                                                    BR_FAILED_REPLY);
> -                       binder_free_buf(proc, buffer);
> +                       binder_free_buf(proc, thread, buffer);
>                         binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
>                                      "%d:%d %stransaction %d fd fixups failed %d/%d, line %d\n",
>                                      proc->pid, thread->pid,
> @@ -4433,6 +4501,8 @@ static struct binder_thread *binder_get_thread_ilocked(
>         thread->reply_error.work.type = BINDER_WORK_RETURN_ERROR;
>         thread->reply_error.cmd = BR_OK;
>         INIT_LIST_HEAD(&new_thread->waiting_thread_node);
> +       INIT_HLIST_HEAD(&new_thread->deferred_close_fds);
> +       init_task_work(&new_thread->deferred_close_fd_cb, binder_do_fd_close);
>         return thread;
>  }
>
> @@ -4470,6 +4540,7 @@ static void binder_free_proc(struct binder_proc *proc)
>  static void binder_free_thread(struct binder_thread *thread)
>  {
>         BUG_ON(!list_empty(&thread->todo));
> +       BUG_ON(!hlist_empty(&thread->deferred_close_fds));
>         binder_stats_deleted(BINDER_STAT_THREAD);
>         binder_proc_dec_tmpref(thread->proc);
>         kfree(thread);
> --
> 2.20.0.rc2.403.gdbc3b29805-goog
>
