Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40942ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BAB20848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BThrqYPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BAB20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJ0B36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 21:29:58 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45471 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJ0B36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 21:29:58 -0400
Received: by mail-ot1-f68.google.com with SMTP id q25so1661513otn.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 09:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3Telf6dZAjoaIHalBNDPS8rEWRt50tGkP6Tw5xjXb6w=;
        b=BThrqYPr2NFhlx/gaExHJ26XL3T6fHWjeqHvPeXGJtr0k0TR/4aYctSicNRbwYAYck
         ihCx56ZzPVSt6RXn52R1+ueD3YViB67GCmrsbCONrKdLxe5toFMh483j/p2SGdoarwVq
         Pfieic5T6KoC35Hg2tw8RKHKhvrPAaljFjCJX9PFypr5CGrAWe+rd8bBUKERVlkmwLxB
         tLQQPAkBSrblH4BSqNV+DPTKRxkEB9j3wWxinV5ztV4HTPvQj26RxJG9jFv0wVdUUe5X
         tjP0OiAbPhD3LI4WdXL9ixHZiLp6rumIoseo/PwckgkOdzDXzRg7RHihUDiwxuXuEMn8
         uv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3Telf6dZAjoaIHalBNDPS8rEWRt50tGkP6Tw5xjXb6w=;
        b=TESuCBEc3sQzX+Pv6TT1L1uAaf8hWyKyYPWhm1CBYUYa+pLsNimTcycl6dOLEzgile
         ajJmArJHF+W+IuB7tRk/Gc9NVhLJoBoralDdOGNe9y5nfm8RIOdaZ0wa1NEoiD/NYY/K
         zoEs4eB9P8Vy6ywkcN6XJwwKZNVij9ao2SDWwhpxBMD1yfjORY0rVwnUfNtshllRcm5K
         OHYVya7PsFSdRd+5eGPqo0lBnhWGkyei64+6w8VGSPUiIv3jI45k0ICtHlr7PHhiwe39
         1VY7W7HwAXAEW3omsJSH2v8KLLLjpadxsUBvLabxamb/1ifVzw4W4ejHLGJJd6mswf1a
         2jmA==
X-Gm-Message-State: AGRZ1gI+lMC6n027LIwcwcsC+6l38O5n+pzyfAIzWYbce75X+Syzpizy
        T7F8+/hav07Cay1R9Txmjycipf2c8z3xjWmijDOlCA==
X-Google-Smtp-Source: AJdET5cG4BOh2k0wgTwDJPhAAIwdWmQgun2fw+kZiIfg9r2XAGqvtNEBUk9hbeYH12UlM5T41NXQT8XBj0Ot7plX7Ok=
X-Received: by 2002:a9d:2377:: with SMTP id k52mr2696149otd.238.1540572731266;
 Fri, 26 Oct 2018 09:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <5FBCBE569E134E4CA167B91C0A77FD610198F64D08@EXMBX-SZMAIL022.tencent.com>
In-Reply-To: <5FBCBE569E134E4CA167B91C0A77FD610198F64D08@EXMBX-SZMAIL022.tencent.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 26 Oct 2018 09:51:59 -0700
Message-ID: <CAHRSSEwKFOymEOcU3KnGy6nMuj2Paf1HXr5d0Y8UQ+boZAEH8Q@mail.gmail.com>
Subject: Re: [PATCH] binder: ipc namespace support for android binder
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

On Fri, Oct 26, 2018 at 2:20 AM chouryzhou(=E5=91=A8=E5=A8=81) <chouryzhou@=
tencent.com> wrote:
>
> Hi
>   We are working for running android in container, but we found that bind=
er is
> not isolated by ipc namespace. Since binder is a form of IPC and therefor=
e should
> be tied to ipc namespace. With this patch, we can run more than one andro=
id
> container on one host.
>   This patch move "binder_procs" and "binder_context" into ipc_namespace,
> driver will find the context from it when opening. Althought statistics i=
n debugfs
> remain global.
>
> Signed-off-by: choury zhou <chouryzhou@tencent.com>
> ---
>  drivers/android/Kconfig       |   2 +-
>  drivers/android/binder.c      | 126 +++++++++++++++++++++++++---------
>  include/linux/ipc_namespace.h |  14 ++++
>  ipc/namespace.c               |   4 ++
>  4 files changed, 111 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
> index 432e9ad77070..09883443b2da 100644
> --- a/drivers/android/Kconfig
> +++ b/drivers/android/Kconfig
> @@ -10,7 +10,7 @@ if ANDROID
>
>  config ANDROID_BINDER_IPC
>         bool "Android Binder IPC Driver"
> -       depends on MMU
> +       depends on MMU && SYSVIPC

NAK. We can't force SYSVIPC on for Android. The notion of running
binder in a container is reasonable, but needs to be done without
explicit requirement for SYSVIPC. binder-in-container is a topic in
the android microconf at Linux plumbers -- are you going to be at LPC?

It's not obvious from this patch where this dependency comes
from...why is SYSVIPC required? I'd like to not have to require IPC_NS
either for devices.

>         default n
>         ---help---
>           Binder is used in Android for both communication between proces=
ses,
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index d58763b6b009..e061dba9b8b3 100644
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
> @@ -79,13 +80,12 @@
>  #include "binder_alloc.h"
>  #include "binder_trace.h"
>
> +#define ipcns  (current->nsproxy->ipc_ns)
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
> @@ -231,7 +231,7 @@ struct binder_transaction_log_entry {
>         int return_error_line;
>         uint32_t return_error;
>         uint32_t return_error_param;
> -       const char *context_name;
> +       int context_device;
>  };
>  struct binder_transaction_log {
>         atomic_t cur;
> @@ -262,19 +262,66 @@ static struct binder_transaction_log_entry *binder_=
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
> +       mutex_destroy(&ns->binder_contexts_lock);
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
> +       mutex_init(&ns->binder_contexts_lock);
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
> @@ -2748,7 +2795,7 @@ static void binder_transaction(struct binder_proc *=
proc,
>         e->target_handle =3D tr->target.handle;
>         e->data_size =3D tr->data_size;
>         e->offsets_size =3D tr->offsets_size;
> -       e->context_name =3D proc->context->name;
> +       e->context_device =3D proc->context->device;
>
>         if (reply) {
>                 binder_inner_proc_lock(proc);
> @@ -4754,6 +4801,7 @@ static int binder_open(struct inode *nodp, struct f=
ile *filp)
>  {
>         struct binder_proc *proc;
>         struct binder_device *binder_dev;
> +       struct binder_context *context;
>
>         binder_debug(BINDER_DEBUG_OPEN_CLOSE, "%s: %d:%d\n", __func__,
>                      current->group_leader->pid, current->pid);
> @@ -4770,7 +4818,17 @@ static int binder_open(struct inode *nodp, struct =
file *filp)
>         proc->default_priority =3D task_nice(current);
>         binder_dev =3D container_of(filp->private_data, struct binder_dev=
ice,
>                                   miscdev);
> -       proc->context =3D &binder_dev->context;
> +       mutex_lock(&ipcns->binder_contexts_lock);
> +       hlist_for_each_entry(context, &ipcns->binder_contexts, hlist) {
> +               if (context->device =3D=3D binder_dev->miscdev.minor) {
> +                       proc->context =3D context;
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&ipcns->binder_contexts_lock);
> +       if (!proc->context)
> +               return -ENOENT;
> +
>         binder_alloc_init(&proc->alloc);
>
>         binder_stats_created(BINDER_STAT_PROC);
> @@ -4779,9 +4837,9 @@ static int binder_open(struct inode *nodp, struct f=
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
> @@ -4917,9 +4975,9 @@ static void binder_deferred_release(struct binder_p=
roc *proc)
>
>         BUG_ON(proc->files);
>
> -       mutex_lock(&binder_procs_lock);
> +       mutex_lock(&ipcns->binder_procs_lock);
>         hlist_del(&proc->proc_node);
> -       mutex_unlock(&binder_procs_lock);
> +       mutex_unlock(&ipcns->binder_procs_lock);
>
>         mutex_lock(&context->context_mgr_node_lock);
>         if (context->binder_context_mgr_node &&
> @@ -5225,7 +5283,7 @@ static void print_binder_proc(struct seq_file *m,
>         struct binder_node *last_node =3D NULL;
>
>         seq_printf(m, "proc %d\n", proc->pid);
> -       seq_printf(m, "context %s\n", proc->context->name);
> +       seq_printf(m, "context %d\n", proc->context->device);
>         header_pos =3D m->count;
>
>         binder_inner_proc_lock(proc);
> @@ -5386,7 +5444,7 @@ static void print_binder_proc_stats(struct seq_file=
 *m,
>                 binder_alloc_get_free_async_space(&proc->alloc);
>
>         seq_printf(m, "proc %d\n", proc->pid);
> -       seq_printf(m, "context %s\n", proc->context->name);
> +       seq_printf(m, "context %d\n", proc->context->device);
>         count =3D 0;
>         ready_threads =3D 0;
>         binder_inner_proc_lock(proc);
> @@ -5471,10 +5529,10 @@ static int binder_state_show(struct seq_file *m, =
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
> @@ -5487,10 +5545,10 @@ static int binder_stats_show(struct seq_file *m, =
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
> @@ -5500,10 +5558,10 @@ static int binder_transactions_show(struct seq_fi=
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
> @@ -5513,14 +5571,14 @@ static int binder_proc_show(struct seq_file *m, v=
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
> @@ -5535,10 +5593,10 @@ static void print_binder_transaction_log_entry(st=
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
> @@ -5601,10 +5659,6 @@ static int __init init_binder_device(const char *n=
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
> @@ -5681,8 +5735,12 @@ static int __init binder_init(void)
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
> index 6ab8c1bada3f..a5a9f9a8f945 100644
> --- a/include/linux/ipc_namespace.h
> +++ b/include/linux/ipc_namespace.h
> @@ -63,6 +63,12 @@ struct ipc_namespace {
>         unsigned int    mq_msg_default;
>         unsigned int    mq_msgsize_default;
>
> +       /* next fields are for binder */
> +       struct mutex      binder_procs_lock;
> +       struct hlist_head binder_procs;
> +       struct mutex      binder_contexts_lock;
> +       struct hlist_head binder_contexts;
> +
>         /* user_ns which owns the ipc ns */
>         struct user_namespace *user_ns;
>         struct ucounts *ucounts;
> @@ -118,6 +124,14 @@ extern int mq_init_ns(struct ipc_namespace *ns);
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
> +
>  #if defined(CONFIG_IPC_NS)
>  extern struct ipc_namespace *copy_ipcs(unsigned long flags,
>         struct user_namespace *user_ns, struct ipc_namespace *ns);
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index 21607791d62c..8b56a6abff59 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -56,6 +56,9 @@ static struct ipc_namespace *create_ipc_ns(struct user_=
namespace *user_ns,
>         ns->ucounts =3D ucounts;
>
>         err =3D mq_init_ns(ns);
> +       if (err)
> +               goto fail_put;
> +       err =3D binder_init_ns(ns);
>         if (err)
>                 goto fail_put;
>
> @@ -120,6 +123,7 @@ static void free_ipc_ns(struct ipc_namespace *ns)
>         sem_exit_ns(ns);
>         msg_exit_ns(ns);
>         shm_exit_ns(ns);
> +       binder_exit_ns(ns);
>
>         dec_ipc_namespaces(ns->ucounts);
>         put_user_ns(ns->user_ns);
> --
> 2.19.1
