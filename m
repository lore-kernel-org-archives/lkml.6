Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24477C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE9A20842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A560CY+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE9A20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeIYMC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:02:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40046 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeIYMC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:02:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id c126-v6so12805783qkd.7;
        Mon, 24 Sep 2018 22:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p5wRxfrGUTN94F2kK06xIrqSDe5xMnoclhyDyyHCZA8=;
        b=A560CY+MFmwbYgoWaJ7PgugwIwxd9VpfRSvDEqRd34Wm1qu2jxnlHlH1veXG+Te9ZC
         GQhuZLTexuPXMM5C6ucKvsWTPOCN2qRW51iJzNSR8ognFBPz9H6wLnwsObYSOHqgfDq2
         Vi5CEZrs6IQS30iKkG65D+18KZkbRSFL9PKzMTbna1ftIFSbM8DlIncjJ83k0ubQTVjC
         MA0lnvuG8EUgWl82dOg2m1cHQjYMy6+JsuwN+0bdSfzyabk+OaXiaaEgnHiSII7vSLkf
         5SNBDmkCLNiIuLkQAVOVIf7QajRsOpCrnf03+QIW7mHFEjP89LGBRtwKRFsZ9keDJmop
         mfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p5wRxfrGUTN94F2kK06xIrqSDe5xMnoclhyDyyHCZA8=;
        b=e0SqsyQqTleOqLwrylfdarYdP4g5Q6+savRqU13Su7DWbgTOgc+oI0YVZDmKj/W1YI
         MqX/xUF7cG+a8WgNbb3DsVLwomrb6mW604jlrjcc8r/7P/udoXZyrf05nLZ/V+UESe8y
         4KIxhi76Y1AQpeVpD5fGKM4WG+MsnuSnuReN6NpzfQtip3Ggwz9gPiHFvxTdkuqz+G6t
         kV79QTAp06bvAbS4T77ILVKLeyUU9F6qCp+sNdPaBtdbdOKfEeZqbbKOKdIoNGRt3HcG
         2l21d0l4DpEgmPrtPKB6C6oQyTRvx5WkHZDyvpIJPgyHXcPCm2AGSOQ+fxEHMUMgUeGc
         nOdg==
X-Gm-Message-State: ABuFfojW18FaPeMw8FfqGv2uIgrXPmNRW6o/t8ag+gIGSMl0R7Jli2gi
        Mn6hW1okAbBDCcSE+CPiZQwA58NdW5IKMwvjqyQ=
X-Google-Smtp-Source: ACcGV61NAM9H3q1VYfxJsrfp3YdBv0U2B+EzHe77eCdH0Vsbb1Ac1Go63AzTikCC4BFy8u+ghWKQD8wkJACiy7pIN9M=
X-Received: by 2002:a37:b246:: with SMTP id b67-v6mr1445869qkf.284.1537854991479;
 Mon, 24 Sep 2018 22:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180921171353.11050-1-guro@fb.com>
In-Reply-To: <20180921171353.11050-1-guro@fb.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 24 Sep 2018 22:56:20 -0700
Message-ID: <CAPhsuW6X2UexmQ4_d_ncO6Gq7iDZWoRePF9abwHj=T2X64FEpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/9] bpf: extend cgroup bpf core to allow
 multiple cgroup storage types
To:     guro@fb.com
Cc:     Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, Kernel-team@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 10:17 AM Roman Gushchin <guro@fb.com> wrote:
>
> In order to introduce per-cpu cgroup storage, let's generalize
> bpf cgroup core to support multiple cgroup storage types.
> Potentially, per-node cgroup storage can be added later.
>
> This commit is mostly a formal change that replaces
> cgroup_storage pointer with a array of cgroup_storage pointers.
> It doesn't actually introduce a new storage type,
> it will be done later.
>
> Each bpf program is now able to have one cgroup storage of each type.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  include/linux/bpf-cgroup.h | 38 ++++++++++++++------
>  include/linux/bpf.h        | 11 ++++--
>  kernel/bpf/cgroup.c        | 74 ++++++++++++++++++++++++++------------
>  kernel/bpf/helpers.c       | 15 ++++----
>  kernel/bpf/local_storage.c | 18 ++++++----
>  kernel/bpf/syscall.c       |  9 +++--
>  kernel/bpf/verifier.c      |  8 +++--
>  net/bpf/test_run.c         | 20 +++++++----
>  8 files changed, 136 insertions(+), 57 deletions(-)
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index f91b0f8ff3a9..e9871b012dac 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -2,6 +2,7 @@
>  #ifndef _BPF_CGROUP_H
>  #define _BPF_CGROUP_H
>
> +#include <linux/bpf.h>
>  #include <linux/errno.h>
>  #include <linux/jump_label.h>
>  #include <linux/percpu.h>
> @@ -22,7 +23,10 @@ struct bpf_cgroup_storage;
>  extern struct static_key_false cgroup_bpf_enabled_key;
>  #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
>
> -DECLARE_PER_CPU(void*, bpf_cgroup_storage);
> +DECLARE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
> +
> +#define for_each_cgroup_storage_type(stype) \
> +       for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
>
>  struct bpf_cgroup_storage_map;
>
> @@ -43,7 +47,7 @@ struct bpf_cgroup_storage {
>  struct bpf_prog_list {
>         struct list_head node;
>         struct bpf_prog *prog;
> -       struct bpf_cgroup_storage *storage;
> +       struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
>  };
>
>  struct bpf_prog_array;
> @@ -101,18 +105,29 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
>  int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
>                                       short access, enum bpf_attach_type type);
>
> -static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage)
> +static inline enum bpf_cgroup_storage_type cgroup_storage_type(
> +       struct bpf_map *map)
>  {
> +       return BPF_CGROUP_STORAGE_SHARED;
> +}
> +
> +static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage
> +                                         *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
> +{
> +       enum bpf_cgroup_storage_type stype;
>         struct bpf_storage_buffer *buf;
>
> -       if (!storage)
> -               return;
> +       for_each_cgroup_storage_type(stype) {
> +               if (!storage[stype])
> +                       continue;
>
> -       buf = READ_ONCE(storage->buf);
> -       this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
> +               buf = READ_ONCE(storage[stype]->buf);
> +               this_cpu_write(bpf_cgroup_storage[stype], &buf->data[0]);
> +       }
>  }
>
> -struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog);
> +struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
> +                                       enum bpf_cgroup_storage_type stype);
>  void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
>  void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
>                              struct cgroup *cgroup,
> @@ -265,13 +280,14 @@ static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
>         return -EINVAL;
>  }
>
> -static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage) {}
> +static inline void bpf_cgroup_storage_set(
> +       struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE]) {}
>  static inline int bpf_cgroup_storage_assign(struct bpf_prog *prog,
>                                             struct bpf_map *map) { return 0; }
>  static inline void bpf_cgroup_storage_release(struct bpf_prog *prog,
>                                               struct bpf_map *map) {}
>  static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
> -       struct bpf_prog *prog) { return 0; }
> +       struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return 0; }
>  static inline void bpf_cgroup_storage_free(
>         struct bpf_cgroup_storage *storage) {}
>
> @@ -293,6 +309,8 @@ static inline void bpf_cgroup_storage_free(
>  #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type,major,minor,access) ({ 0; })
>
> +#define for_each_cgroup_storage_type(stype) for (; false; )
> +
>  #endif /* CONFIG_CGROUP_BPF */
>
>  #endif /* _BPF_CGROUP_H */
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 988a00797bcd..b457fbe7b70b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -272,6 +272,13 @@ struct bpf_prog_offload {
>         u32                     jited_len;
>  };
>
> +enum bpf_cgroup_storage_type {
> +       BPF_CGROUP_STORAGE_SHARED,
> +       __BPF_CGROUP_STORAGE_MAX
> +};
> +
> +#define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
> +
>  struct bpf_prog_aux {
>         atomic_t refcnt;
>         u32 used_map_cnt;
> @@ -289,7 +296,7 @@ struct bpf_prog_aux {
>         struct bpf_prog *prog;
>         struct user_struct *user;
>         u64 load_time; /* ns since boottime */
> -       struct bpf_map *cgroup_storage;
> +       struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
>         char name[BPF_OBJ_NAME_LEN];
>  #ifdef CONFIG_SECURITY
>         void *security;
> @@ -358,7 +365,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   */
>  struct bpf_prog_array_item {
>         struct bpf_prog *prog;
> -       struct bpf_cgroup_storage *cgroup_storage;
> +       struct bpf_cgroup_storage *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
>  };
>
>  struct bpf_prog_array {
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 6a7d931bbc55..065c3d9ff8eb 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -25,6 +25,7 @@ EXPORT_SYMBOL(cgroup_bpf_enabled_key);
>   */
>  void cgroup_bpf_put(struct cgroup *cgrp)
>  {
> +       enum bpf_cgroup_storage_type stype;
>         unsigned int type;
>
>         for (type = 0; type < ARRAY_SIZE(cgrp->bpf.progs); type++) {
> @@ -34,8 +35,10 @@ void cgroup_bpf_put(struct cgroup *cgrp)
>                 list_for_each_entry_safe(pl, tmp, progs, node) {
>                         list_del(&pl->node);
>                         bpf_prog_put(pl->prog);
> -                       bpf_cgroup_storage_unlink(pl->storage);
> -                       bpf_cgroup_storage_free(pl->storage);
> +                       for_each_cgroup_storage_type(stype) {
> +                               bpf_cgroup_storage_unlink(pl->storage[stype]);
> +                               bpf_cgroup_storage_free(pl->storage[stype]);
> +                       }
>                         kfree(pl);
>                         static_branch_dec(&cgroup_bpf_enabled_key);
>                 }
> @@ -97,6 +100,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
>                                    enum bpf_attach_type type,
>                                    struct bpf_prog_array __rcu **array)
>  {
> +       enum bpf_cgroup_storage_type stype;
>         struct bpf_prog_array *progs;
>         struct bpf_prog_list *pl;
>         struct cgroup *p = cgrp;
> @@ -125,7 +129,9 @@ static int compute_effective_progs(struct cgroup *cgrp,
>                                 continue;
>
>                         progs->items[cnt].prog = pl->prog;
> -                       progs->items[cnt].cgroup_storage = pl->storage;
> +                       for_each_cgroup_storage_type(stype)
> +                               progs->items[cnt].cgroup_storage[stype] =
> +                                       pl->storage[stype];
>                         cnt++;
>                 }
>         } while ((p = cgroup_parent(p)));
> @@ -232,7 +238,9 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
>  {
>         struct list_head *progs = &cgrp->bpf.progs[type];
>         struct bpf_prog *old_prog = NULL;
> -       struct bpf_cgroup_storage *storage, *old_storage = NULL;
> +       struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE],
> +               *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {NULL};
> +       enum bpf_cgroup_storage_type stype;
>         struct bpf_prog_list *pl;
>         bool pl_was_allocated;
>         int err;
> @@ -254,34 +262,44 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
>         if (prog_list_length(progs) >= BPF_CGROUP_MAX_PROGS)
>                 return -E2BIG;
>
> -       storage = bpf_cgroup_storage_alloc(prog);
> -       if (IS_ERR(storage))
> -               return -ENOMEM;
> +       for_each_cgroup_storage_type(stype) {
> +               storage[stype] = bpf_cgroup_storage_alloc(prog, stype);
> +               if (IS_ERR(storage[stype])) {
> +                       storage[stype] = NULL;
> +                       for_each_cgroup_storage_type(stype)
> +                               bpf_cgroup_storage_free(storage[stype]);
> +                       return -ENOMEM;
> +               }
> +       }
>
>         if (flags & BPF_F_ALLOW_MULTI) {
>                 list_for_each_entry(pl, progs, node) {
>                         if (pl->prog == prog) {
>                                 /* disallow attaching the same prog twice */
> -                               bpf_cgroup_storage_free(storage);
> +                               for_each_cgroup_storage_type(stype)
> +                                       bpf_cgroup_storage_free(storage[stype]);
>                                 return -EINVAL;
>                         }
>                 }
>
>                 pl = kmalloc(sizeof(*pl), GFP_KERNEL);
>                 if (!pl) {
> -                       bpf_cgroup_storage_free(storage);
> +                       for_each_cgroup_storage_type(stype)
> +                               bpf_cgroup_storage_free(storage[stype]);
>                         return -ENOMEM;
>                 }
>
>                 pl_was_allocated = true;
>                 pl->prog = prog;
> -               pl->storage = storage;
> +               for_each_cgroup_storage_type(stype)
> +                       pl->storage[stype] = storage[stype];
>                 list_add_tail(&pl->node, progs);
>         } else {
>                 if (list_empty(progs)) {
>                         pl = kmalloc(sizeof(*pl), GFP_KERNEL);
>                         if (!pl) {
> -                               bpf_cgroup_storage_free(storage);
> +                               for_each_cgroup_storage_type(stype)
> +                                       bpf_cgroup_storage_free(storage[stype]);
>                                 return -ENOMEM;
>                         }
>                         pl_was_allocated = true;
> @@ -289,12 +307,15 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
>                 } else {
>                         pl = list_first_entry(progs, typeof(*pl), node);
>                         old_prog = pl->prog;
> -                       old_storage = pl->storage;
> -                       bpf_cgroup_storage_unlink(old_storage);
> +                       for_each_cgroup_storage_type(stype) {
> +                               old_storage[stype] = pl->storage[stype];
> +                               bpf_cgroup_storage_unlink(old_storage[stype]);
> +                       }
>                         pl_was_allocated = false;
>                 }
>                 pl->prog = prog;
> -               pl->storage = storage;
> +               for_each_cgroup_storage_type(stype)
> +                       pl->storage[stype] = storage[stype];
>         }
>
>         cgrp->bpf.flags[type] = flags;
> @@ -304,21 +325,27 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
>                 goto cleanup;
>
>         static_branch_inc(&cgroup_bpf_enabled_key);
> -       if (old_storage)
> -               bpf_cgroup_storage_free(old_storage);
> +       for_each_cgroup_storage_type(stype) {
> +               if (!old_storage[stype])
> +                       continue;
> +               bpf_cgroup_storage_free(old_storage[stype]);
> +       }
>         if (old_prog) {
>                 bpf_prog_put(old_prog);
>                 static_branch_dec(&cgroup_bpf_enabled_key);
>         }
> -       bpf_cgroup_storage_link(storage, cgrp, type);
> +       for_each_cgroup_storage_type(stype)
> +               bpf_cgroup_storage_link(storage[stype], cgrp, type);
>         return 0;
>
>  cleanup:
>         /* and cleanup the prog list */
>         pl->prog = old_prog;
> -       bpf_cgroup_storage_free(pl->storage);
> -       pl->storage = old_storage;
> -       bpf_cgroup_storage_link(old_storage, cgrp, type);
> +       for_each_cgroup_storage_type(stype) {
> +               bpf_cgroup_storage_free(pl->storage[stype]);
> +               pl->storage[stype] = old_storage[stype];
> +               bpf_cgroup_storage_link(old_storage[stype], cgrp, type);
> +       }
>         if (pl_was_allocated) {
>                 list_del(&pl->node);
>                 kfree(pl);
> @@ -339,6 +366,7 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
>                         enum bpf_attach_type type, u32 unused_flags)
>  {
>         struct list_head *progs = &cgrp->bpf.progs[type];
> +       enum bpf_cgroup_storage_type stype;
>         u32 flags = cgrp->bpf.flags[type];
>         struct bpf_prog *old_prog = NULL;
>         struct bpf_prog_list *pl;
> @@ -385,8 +413,10 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
>
>         /* now can actually delete it from this cgroup list */
>         list_del(&pl->node);
> -       bpf_cgroup_storage_unlink(pl->storage);
> -       bpf_cgroup_storage_free(pl->storage);
> +       for_each_cgroup_storage_type(stype) {
> +               bpf_cgroup_storage_unlink(pl->storage[stype]);
> +               bpf_cgroup_storage_free(pl->storage[stype]);
> +       }
>         kfree(pl);
>         if (list_empty(progs))
>                 /* last program was detached, reset flags to zero */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 1991466b8327..9070b2ace6aa 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -194,16 +194,18 @@ const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
>         .ret_type       = RET_INTEGER,
>  };
>
> -DECLARE_PER_CPU(void*, bpf_cgroup_storage);
> +#ifdef CONFIG_CGROUP_BPF
> +DECLARE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
>
>  BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
>  {
> -       /* map and flags arguments are not used now,
> -        * but provide an ability to extend the API
> -        * for other types of local storages.
> -        * verifier checks that their values are correct.
> +       /* flags argument is not used now,
> +        * but provides an ability to extend the API.
> +        * verifier checks that its value is correct.
>          */
> -       return (unsigned long) this_cpu_read(bpf_cgroup_storage);
> +       enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
> +
> +       return (unsigned long) this_cpu_read(bpf_cgroup_storage[stype]);
>  }
>
>  const struct bpf_func_proto bpf_get_local_storage_proto = {
> @@ -214,3 +216,4 @@ const struct bpf_func_proto bpf_get_local_storage_proto = {
>         .arg2_type      = ARG_ANYTHING,
>  };
>  #endif
> +#endif
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 22ad967d1e5f..0bd9f19fc557 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -7,7 +7,7 @@
>  #include <linux/rbtree.h>
>  #include <linux/slab.h>
>
> -DEFINE_PER_CPU(void*, bpf_cgroup_storage);
> +DEFINE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
>
>  #ifdef CONFIG_CGROUP_BPF
>
> @@ -251,6 +251,7 @@ const struct bpf_map_ops cgroup_storage_map_ops = {
>
>  int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_map)
>  {
> +       enum bpf_cgroup_storage_type stype = cgroup_storage_type(_map);
>         struct bpf_cgroup_storage_map *map = map_to_storage(_map);
>         int ret = -EBUSY;
>
> @@ -258,11 +259,12 @@ int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_map)
>
>         if (map->prog && map->prog != prog)
>                 goto unlock;
> -       if (prog->aux->cgroup_storage && prog->aux->cgroup_storage != _map)
> +       if (prog->aux->cgroup_storage[stype] &&
> +           prog->aux->cgroup_storage[stype] != _map)
>                 goto unlock;
>
>         map->prog = prog;
> -       prog->aux->cgroup_storage = _map;
> +       prog->aux->cgroup_storage[stype] = _map;
>         ret = 0;
>  unlock:
>         spin_unlock_bh(&map->lock);
> @@ -272,24 +274,26 @@ int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_map)
>
>  void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *_map)
>  {
> +       enum bpf_cgroup_storage_type stype = cgroup_storage_type(_map);
>         struct bpf_cgroup_storage_map *map = map_to_storage(_map);
>
>         spin_lock_bh(&map->lock);
>         if (map->prog == prog) {
> -               WARN_ON(prog->aux->cgroup_storage != _map);
> +               WARN_ON(prog->aux->cgroup_storage[stype] != _map);
>                 map->prog = NULL;
> -               prog->aux->cgroup_storage = NULL;
> +               prog->aux->cgroup_storage[stype] = NULL;
>         }
>         spin_unlock_bh(&map->lock);
>  }
>
> -struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog)
> +struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
> +                                       enum bpf_cgroup_storage_type stype)
>  {
>         struct bpf_cgroup_storage *storage;
>         struct bpf_map *map;
>         u32 pages;
>
> -       map = prog->aux->cgroup_storage;
> +       map = prog->aux->cgroup_storage[stype];
>         if (!map)
>                 return NULL;
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index b3c2d09bcf7a..8c91d2b41b1e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -988,10 +988,15 @@ static int find_prog_type(enum bpf_prog_type type, struct bpf_prog *prog)
>  /* drop refcnt on maps used by eBPF program and free auxilary data */
>  static void free_used_maps(struct bpf_prog_aux *aux)
>  {
> +       enum bpf_cgroup_storage_type stype;
>         int i;
>
> -       if (aux->cgroup_storage)
> -               bpf_cgroup_storage_release(aux->prog, aux->cgroup_storage);
> +       for_each_cgroup_storage_type(stype) {
> +               if (!aux->cgroup_storage[stype])
> +                       continue;
> +               bpf_cgroup_storage_release(aux->prog,
> +                                          aux->cgroup_storage[stype]);
> +       }
>
>         for (i = 0; i < aux->used_map_cnt; i++)
>                 bpf_map_put(aux->used_maps[i]);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8ccbff4fff93..e75f36de91d6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5171,11 +5171,15 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
>  /* drop refcnt of maps used by the rejected program */
>  static void release_maps(struct bpf_verifier_env *env)
>  {
> +       enum bpf_cgroup_storage_type stype;
>         int i;
>
> -       if (env->prog->aux->cgroup_storage)
> +       for_each_cgroup_storage_type(stype) {
> +               if (!env->prog->aux->cgroup_storage[stype])
> +                       continue;
>                 bpf_cgroup_storage_release(env->prog,
> -                                          env->prog->aux->cgroup_storage);
> +                       env->prog->aux->cgroup_storage[stype]);
> +       }
>
>         for (i = 0; i < env->used_map_cnt; i++)
>                 bpf_map_put(env->used_maps[i]);
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index f4078830ea50..0c423b8cd75c 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -12,7 +12,7 @@
>  #include <linux/sched/signal.h>
>
>  static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx,
> -                                           struct bpf_cgroup_storage *storage)
> +               struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
>  {
>         u32 ret;
>
> @@ -28,13 +28,20 @@ static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx,
>
>  static u32 bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *time)
>  {
> -       struct bpf_cgroup_storage *storage = NULL;
> +       struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = { 0 };
> +       enum bpf_cgroup_storage_type stype;
>         u64 time_start, time_spent = 0;
>         u32 ret = 0, i;
>
> -       storage = bpf_cgroup_storage_alloc(prog);
> -       if (IS_ERR(storage))
> -               return PTR_ERR(storage);
> +       for_each_cgroup_storage_type(stype) {
> +               storage[stype] = bpf_cgroup_storage_alloc(prog, stype);
> +               if (IS_ERR(storage[stype])) {
> +                       storage[stype] = NULL;
> +                       for_each_cgroup_storage_type(stype)
> +                               bpf_cgroup_storage_free(storage[stype]);
> +                       return -ENOMEM;
> +               }
> +       }
>
>         if (!repeat)
>                 repeat = 1;
> @@ -53,7 +60,8 @@ static u32 bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *time)
>         do_div(time_spent, repeat);
>         *time = time_spent > U32_MAX ? U32_MAX : (u32)time_spent;
>
> -       bpf_cgroup_storage_free(storage);
> +       for_each_cgroup_storage_type(stype)
> +               bpf_cgroup_storage_free(storage[stype]);
>
>         return ret;
>  }
> --
> 2.17.1
>
