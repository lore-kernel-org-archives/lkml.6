Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8E0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBADC20818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AmqfPt6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBADC20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeKJDgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:36:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44451 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbeKJDgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:36:13 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so1935728lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 09:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O0DurmDImqGdt8ZuCUaJG4NdvqVvsfmNXDN2OxcV1Gk=;
        b=AmqfPt6JW75VA74GPrMVyKwc1Il/HMB+h/qJAAnyb+tIhhjyoWtuemJdd412+G/Mgn
         Ec8V0SCljCSFbAEbqFvMvulOfsTl01jJ2p3PEuDWPMr9CdJN3otQpn6IhiXAWGAcW3MZ
         /NjxUNJJjyozhaaLdLkwQtsEeSWY9oxKvAybrnCMwR216yggsZ7F/RoZrRTCyT/KcL1B
         9jJaUARygMPca7L1IzMNBw2z1D72Y9HkUFYEDbT8b8agq/TgjzzRllzaGw2WftR5Ha0M
         9tnhqpDd/nVXo2ss7RHdHNLHI1h2CxemaDh6tkb2EwPR3Dk+o+VUMk4r4Hf8swlbLXpl
         WnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O0DurmDImqGdt8ZuCUaJG4NdvqVvsfmNXDN2OxcV1Gk=;
        b=R7sPzxCmtCPvxXCl1b7kB/LNSnQWEmynkz0sspgU4We0/XLXNttD98DVJsA5I9drLX
         5Lu4zR8ODc9US06rzA6zDS34Z/TKnWnTJTbY/KAkhF7PXWAQrF+TM31Uqqs19fHDFt4x
         bh8gUKb4lXOMfblMm/1PIHNBAwbB+sjEGrK6SB7GR6v++DKh5ic0jlxUYuEH6EAv6Uzh
         OFA+hmFckSJeT3gdXuhvsmTAUhHo+Oq/OnPP97QCgSsraAHq9AI8DbQ2xIlC6QXf7Y1b
         UZc3oEe6+1bETMSSGSmcdCnIlVuTbUEqnxVHp2yOCIaWjui2UwbB4vOmEEscooNxY47l
         KTqA==
X-Gm-Message-State: AGRZ1gLqqJjtcL31PkRAVY9JdNVWQBbWrLdtAw4xqXjROAdgk+dqheNc
        qjnD1KQe/Pz2wT4tsIg7JgLhNrGeMYtHmVM1bYw5dg==
X-Google-Smtp-Source: AJdET5cjDTMqCUFCxhgMnC09ivmhLkU9AN9CFnlmgi0zKslsZ4k1gkKp2WBDfWU6TCeNrJ/G3X41ZkhCIoSy2HA5QkI=
X-Received: by 2002:a19:7306:: with SMTP id o6mr5651403lfc.136.1541786071133;
 Fri, 09 Nov 2018 09:54:31 -0800 (PST)
MIME-Version: 1.0
References: <5FBCBE569E134E4CA167B91C0A77FD610198F851AC@EXMBX-SZMAIL022.tencent.com>
In-Reply-To: <5FBCBE569E134E4CA167B91C0A77FD610198F851AC@EXMBX-SZMAIL022.tencent.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 9 Nov 2018 09:54:19 -0800
Message-ID: <CAHRSSExukqyS5V=fgdBP1Jn_KXZEMsWR+wMLNtxBq8+G3wkgSQ@mail.gmail.com>
Subject: Re: [PATCH V3] binder: ipc namespace support for android binder
To:     chouryzhou@tencent.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, akpm@linux-foundation.org,
        dave@stgolabs.net,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 5:02 AM chouryzhou(=E5=91=A8=E5=A8=81) <chouryzhou@t=
encent.com> wrote:
>
>   We are working for running android in container, but we found that bind=
er is
> not isolated by ipc namespace. Since binder is a form of IPC and therefor=
e should
> be tied to ipc namespace. With this patch, we can run more than one andro=
id
> container on one host.
>   This patch move "binder_procs" and "binder_context" into ipc_namespace,
> driver will find the context from it when opening. Although statistics in=
 debugfs
> remain global.
>
> Signed-off-by: chouryzhou <chouryzhou@tencent.com>
> ---
>  drivers/android/binder.c      | 128 +++++++++++++++++++++++++++++++-----=
------
>  include/linux/ipc_namespace.h |  15 +++++
>  ipc/namespace.c               |  10 +++-
>  3 files changed, 117 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index cb30a524d16d..22e45bb937e6 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -68,6 +68,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/uaccess.h>
>  #include <linux/pid_namespace.h>
> +#include <linux/ipc_namespace.h>
>  #include <linux/security.h>
>  #include <linux/spinlock.h>
>  #include <linux/ratelimit.h>
> @@ -80,13 +81,18 @@
>  #include "binder_alloc.h"
>  #include "binder_trace.h"
>
> +
> +#if !defined(CONFIG_SYSVIPC) &&  !defined(CONFIG_POSIX_MQUEUE)

I still don't understand the dependencies on SYSVIPC or POSIX_MQUEUE.
It seems like this mechanism would work even if both are disabled --
as long as IPC_NS is enabled. Seems cleaner to change init/Kconfig and
allow IPC_NS if CONFIG_ANDROID_BINDER_IPC and change this line to
"#ifndef CONFIG_IPC_NS"

> +struct ipc_namespace init_ipc_ns;
> +#define ipcns  (&init_ipc_ns)
> +#else
> +#define ipcns  (current->nsproxy->ipc_ns)
> +#endif
> +
>  static HLIST_HEAD(binder_deferred_list);
>  static DEFINE_MUTEX(binder_deferred_lock);
>
>  static HLIST_HEAD(binder_devices);
> -static HLIST_HEAD(binder_procs);
> -static DEFINE_MUTEX(binder_procs_lock);
> -
>  static HLIST_HEAD(binder_dead_nodes);
>  static DEFINE_SPINLOCK(binder_dead_nodes_lock);
>
> @@ -232,7 +238,7 @@ struct binder_transaction_log_entry {
>         int return_error_line;
>         uint32_t return_error;
>         uint32_t return_error_param;
> -       const char *context_name;
> +       int context_device;
>  };
>  struct binder_transaction_log {
>         atomic_t cur;
> @@ -263,19 +269,64 @@ static struct binder_transaction_log_entry *binder_=
transaction_log_add(
>  }
>
>  struct binder_context {
> +       struct hlist_node hlist;
>         struct binder_node *binder_context_mgr_node;
>         struct mutex context_mgr_node_lock;
>
>         kuid_t binder_context_mgr_uid;
> -       const char *name;
> +       int    device;
>  };
>
>  struct binder_device {
>         struct hlist_node hlist;
>         struct miscdevice miscdev;
> -       struct binder_context context;
>  };
>
> +void binder_exit_ns(struct ipc_namespace *ns)
> +{
> +       struct binder_context *context;
> +       struct hlist_node *tmp;
> +
> +       mutex_destroy(&ns->binder_procs_lock);
> +       hlist_for_each_entry_safe(context, tmp, &ns->binder_contexts, hli=
st) {
> +               mutex_destroy(&context->context_mgr_node_lock);
> +               hlist_del(&context->hlist);
> +               kfree(context);
> +       }
> +}
> +
> +int binder_init_ns(struct ipc_namespace *ns)
> +{
> +       int ret;
> +       struct binder_device *device;
> +
> +       mutex_init(&ns->binder_procs_lock);
> +       INIT_HLIST_HEAD(&ns->binder_procs);
> +       INIT_HLIST_HEAD(&ns->binder_contexts);
> +
> +       hlist_for_each_entry(device, &binder_devices, hlist) {
> +               struct binder_context *context;
> +
> +               context =3D kzalloc(sizeof(*context), GFP_KERNEL);
> +               if (!context) {
> +                       ret =3D -ENOMEM;
> +                       goto err;
> +               }
> +
> +               context->device =3D device->miscdev.minor;
> +               context->binder_context_mgr_uid =3D INVALID_UID;
> +               mutex_init(&context->context_mgr_node_lock);
> +
> +               hlist_add_head(&context->hlist, &ns->binder_contexts);
> +       }
> +
> +       return 0;
> +err:
> +       binder_exit_ns(ns);
> +       return ret;
> +}
> +
> +
>  /**
>   * struct binder_work - work enqueued on a worklist
>   * @entry:             node enqueued on list
> @@ -2727,7 +2778,7 @@ static void binder_transaction(struct binder_proc *=
proc,
>         e->target_handle =3D tr->target.handle;
>         e->data_size =3D tr->data_size;
>         e->offsets_size =3D tr->offsets_size;
> -       e->context_name =3D proc->context->name;
> +       e->context_device =3D proc->context->device;

why eliminate name? The string name is very useful for differentiating
normal "framework" binder transactions vs "hal" or "vendor"
transactions. If we just have a device number it will be hard to tell
in the logs even which namespace it belongs to. We need to keep both
the "name" (for which there might be multiple in each ns) and some
indication of which namespace this is. Maybe we assign some sort of
namespace ID during binder_init_ns().

>
>         if (reply) {
>                 binder_inner_proc_lock(proc);
> @@ -4922,6 +4973,7 @@ static int binder_open(struct inode *nodp, struct f=
ile *filp)
>  {
>         struct binder_proc *proc;
>         struct binder_device *binder_dev;
> +       struct binder_context *context;
>
>         binder_debug(BINDER_DEBUG_OPEN_CLOSE, "%s: %d:%d\n", __func__,
>                      current->group_leader->pid, current->pid);
> @@ -4937,7 +4989,15 @@ static int binder_open(struct inode *nodp, struct =
file *filp)
>         proc->default_priority =3D task_nice(current);
>         binder_dev =3D container_of(filp->private_data, struct binder_dev=
ice,
>                                   miscdev);
> -       proc->context =3D &binder_dev->context;
> +       hlist_for_each_entry(context, &ipcns->binder_contexts, hlist) {
> +               if (context->device =3D=3D binder_dev->miscdev.minor) {
> +                       proc->context =3D context;
> +                       break;
> +               }
> +       }
> +       if (!proc->context)
> +               return -ENOENT;
> +
>         binder_alloc_init(&proc->alloc);
>
>         binder_stats_created(BINDER_STAT_PROC);
> @@ -4946,9 +5006,9 @@ static int binder_open(struct inode *nodp, struct f=
ile *filp)
>         INIT_LIST_HEAD(&proc->waiting_threads);
>         filp->private_data =3D proc;
>
> -       mutex_lock(&binder_procs_lock);
> -       hlist_add_head(&proc->proc_node, &binder_procs);
> -       mutex_unlock(&binder_procs_lock);
> +       mutex_lock(&ipcns->binder_procs_lock);
> +       hlist_add_head(&proc->proc_node, &ipcns->binder_procs);
> +       mutex_unlock(&ipcns->binder_procs_lock);
>
>         if (binder_debugfs_dir_entry_proc) {
>                 char strbuf[11];
> @@ -5082,9 +5142,9 @@ static void binder_deferred_release(struct binder_p=
roc *proc)
>         struct rb_node *n;
>         int threads, nodes, incoming_refs, outgoing_refs, active_transact=
ions;
>
> -       mutex_lock(&binder_procs_lock);
> +       mutex_lock(&ipcns->binder_procs_lock);
>         hlist_del(&proc->proc_node);
> -       mutex_unlock(&binder_procs_lock);
> +       mutex_unlock(&ipcns->binder_procs_lock);
>
>         mutex_lock(&context->context_mgr_node_lock);
>         if (context->binder_context_mgr_node &&
> @@ -5377,7 +5437,7 @@ static void print_binder_proc(struct seq_file *m,
>         struct binder_node *last_node =3D NULL;
>
>         seq_printf(m, "proc %d\n", proc->pid);
> -       seq_printf(m, "context %s\n", proc->context->name);
> +       seq_printf(m, "context %d\n", proc->context->device);

As mentioned above, we need to retain name and probably also want a ns
id of some sort. So context now has 3 components if IPC_NS, so maybe a
helper function to print context like:

static void binder_seq_print_context(struct seq_file *m, struct
binder_context *context)
{
#ifdef CONFIG_IPC_NS
          seq_printf(m, "%d-%d-%s", context->ns_id, context->device,
context->name);
#else
          seq_printf(m, "%d", context->name);
#endif
}

(same comment below everywhere context is printed)

Should these debugfs nodes should be ns aware and only print debugging
info for the context of the thread accessing the node? If so, we would
also want to be namespace-aware when printing pids.

>         header_pos =3D m->count;
>
>         binder_inner_proc_lock(proc);
> @@ -5538,7 +5598,7 @@ static void print_binder_proc_stats(struct seq_file=
 *m,
>                 binder_alloc_get_free_async_space(&proc->alloc);
>
>         seq_printf(m, "proc %d\n", proc->pid);
> -       seq_printf(m, "context %s\n", proc->context->name);
> +       seq_printf(m, "context %d\n", proc->context->device);
>         count =3D 0;
>         ready_threads =3D 0;
>         binder_inner_proc_lock(proc);
> @@ -5623,10 +5683,10 @@ static int binder_state_show(struct seq_file *m, =
void *unused)
>         if (last_node)
>                 binder_put_node(last_node);
>
> -       mutex_lock(&binder_procs_lock);
> -       hlist_for_each_entry(proc, &binder_procs, proc_node)
> +       mutex_lock(&ipcns->binder_procs_lock);
> +       hlist_for_each_entry(proc, &ipcns->binder_procs, proc_node)
>                 print_binder_proc(m, proc, 1);
> -       mutex_unlock(&binder_procs_lock);
> +       mutex_unlock(&ipcns->binder_procs_lock);
>
>         return 0;
>  }
> @@ -5639,10 +5699,10 @@ static int binder_stats_show(struct seq_file *m, =
void *unused)
>
>         print_binder_stats(m, "", &binder_stats);
>
> -       mutex_lock(&binder_procs_lock);
> -       hlist_for_each_entry(proc, &binder_procs, proc_node)
> +       mutex_lock(&ipcns->binder_procs_lock);
> +       hlist_for_each_entry(proc, &ipcns->binder_procs, proc_node)
>                 print_binder_proc_stats(m, proc);
> -       mutex_unlock(&binder_procs_lock);
> +       mutex_unlock(&ipcns->binder_procs_lock);
>
>         return 0;
>  }
> @@ -5652,10 +5712,10 @@ static int binder_transactions_show(struct seq_fi=
le *m, void *unused)
>         struct binder_proc *proc;
>
>         seq_puts(m, "binder transactions:\n");
> -       mutex_lock(&binder_procs_lock);
> -       hlist_for_each_entry(proc, &binder_procs, proc_node)
> +       mutex_lock(&ipcns->binder_procs_lock);
> +       hlist_for_each_entry(proc, &ipcns->binder_procs, proc_node)
>                 print_binder_proc(m, proc, 0);
> -       mutex_unlock(&binder_procs_lock);
> +       mutex_unlock(&ipcns->binder_procs_lock);
>
>         return 0;
>  }
> @@ -5665,14 +5725,14 @@ static int binder_proc_show(struct seq_file *m, v=
oid *unused)
>         struct binder_proc *itr;
>         int pid =3D (unsigned long)m->private;
>
> -       mutex_lock(&binder_procs_lock);
> -       hlist_for_each_entry(itr, &binder_procs, proc_node) {
> +       mutex_lock(&ipcns->binder_procs_lock);
> +       hlist_for_each_entry(itr, &ipcns->binder_procs, proc_node) {
>                 if (itr->pid =3D=3D pid) {
>                         seq_puts(m, "binder proc state:\n");
>                         print_binder_proc(m, itr, 1);
>                 }
>         }
> -       mutex_unlock(&binder_procs_lock);
> +       mutex_unlock(&ipcns->binder_procs_lock);
>
>         return 0;
>  }
> @@ -5687,10 +5747,10 @@ static void print_binder_transaction_log_entry(st=
ruct seq_file *m,
>          */
>         smp_rmb();
>         seq_printf(m,
> -                  "%d: %s from %d:%d to %d:%d context %s node %d handle =
%d size %d:%d ret %d/%d l=3D%d",
> +                  "%d: %s from %d:%d to %d:%d context %d node %d handle =
%d size %d:%d ret %d/%d l=3D%d",
>                    e->debug_id, (e->call_type =3D=3D 2) ? "reply" :
>                    ((e->call_type =3D=3D 1) ? "async" : "call "), e->from=
_proc,
> -                  e->from_thread, e->to_proc, e->to_thread, e->context_n=
ame,
> +                  e->from_thread, e->to_proc, e->to_thread, e->context_d=
evice,
>                    e->to_node, e->target_handle, e->data_size, e->offsets=
_size,
>                    e->return_error, e->return_error_param,
>                    e->return_error_line);
> @@ -5753,10 +5813,6 @@ static int __init init_binder_device(const char *n=
ame)
>         binder_device->miscdev.minor =3D MISC_DYNAMIC_MINOR;
>         binder_device->miscdev.name =3D name;
>
> -       binder_device->context.binder_context_mgr_uid =3D INVALID_UID;
> -       binder_device->context.name =3D name;
> -       mutex_init(&binder_device->context.context_mgr_node_lock);
> -
>         ret =3D misc_register(&binder_device->miscdev);
>         if (ret < 0) {
>                 kfree(binder_device);
> @@ -5832,8 +5888,12 @@ static int __init binder_init(void)
>                         goto err_init_binder_device_failed;
>         }
>
> -       return ret;
> +       ret =3D binder_init_ns(&init_ipc_ns);
> +       if (ret)
> +               goto err_init_namespace_failed;
>
> +       return ret;
> +err_init_namespace_failed:
>  err_init_binder_device_failed:
>         hlist_for_each_entry_safe(device, tmp, &binder_devices, hlist) {
>                 misc_deregister(&device->miscdev);
> diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.=
h
> index 6ab8c1bada3f..d7f850a2ded8 100644
> --- a/include/linux/ipc_namespace.h
> +++ b/include/linux/ipc_namespace.h
> @@ -63,6 +63,13 @@ struct ipc_namespace {
>         unsigned int    mq_msg_default;
>         unsigned int    mq_msgsize_default;
>
> +#ifdef CONFIG_ANDROID_BINDER_IPC
> +       /* next fields are for binder */
> +       struct mutex      binder_procs_lock;
> +       struct hlist_head binder_procs;
> +       struct hlist_head binder_contexts;
> +#endif
> +
>         /* user_ns which owns the ipc ns */
>         struct user_namespace *user_ns;
>         struct ucounts *ucounts;
> @@ -118,6 +125,14 @@ extern int mq_init_ns(struct ipc_namespace *ns);
>  static inline int mq_init_ns(struct ipc_namespace *ns) { return 0; }
>  #endif
>
> +#ifdef CONFIG_ANDROID_BINDER_IPC
> +extern int binder_init_ns(struct ipc_namespace *ns);
> +extern void binder_exit_ns(struct ipc_namespace *ns);
> +#else
> +static inline int binder_init_ns(struct ipc_namespace *ns) { return 0; }
> +static inline void binder_exit_ns(struct ipc_namespace *ns) { }
> +#endif

I'm fine with this if the namespace.[hc] maintainers are, but would it
be better to add some sort of registration function so we don't need
binder-specific stuff here?

A version of this was proposed by Oren Laadan in:

https://lists.linuxfoundation.org/pipermail/containers/2013-December/033834=
.html

and then updated for 4.9 in a proposal in AOSP:

https://android-review.googlesource.com/c/kernel/common/+/471961

There will be some discussions on containerized binder support at LPC,
so we'll want to wait until after LPC before moving ahead with this.

-Todd


> +
>  #if defined(CONFIG_IPC_NS)
>  extern struct ipc_namespace *copy_ipcs(unsigned long flags,
>         struct user_namespace *user_ns, struct ipc_namespace *ns);
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index 21607791d62c..68c6e983b002 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -57,7 +57,10 @@ static struct ipc_namespace *create_ipc_ns(struct user=
_namespace *user_ns,
>
>         err =3D mq_init_ns(ns);
>         if (err)
> -               goto fail_put;
> +               goto fail_init_mq;
> +       err =3D binder_init_ns(ns);
> +       if (err)
> +               goto fail_init_binder;
>
>         sem_init_ns(ns);
>         msg_init_ns(ns);
> @@ -65,7 +68,9 @@ static struct ipc_namespace *create_ipc_ns(struct user_=
namespace *user_ns,
>
>         return ns;
>
> -fail_put:
> +fail_init_binder:
> +       mq_put_mnt(ns);
> +fail_init_mq:
>         put_user_ns(ns->user_ns);
>         ns_free_inum(&ns->ns);
>  fail_free:
> @@ -120,6 +125,7 @@ static void free_ipc_ns(struct ipc_namespace *ns)
>         sem_exit_ns(ns);
>         msg_exit_ns(ns);
>         shm_exit_ns(ns);
> +       binder_exit_ns(ns);
>
>         dec_ipc_namespaces(ns->ucounts);
>         put_user_ns(ns->user_ns);
> --
> 2.11.0
