Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC1BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A272086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Gf8oNfv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A272086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbeKTIYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:24:51 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34300 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731287AbeKTIYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:24:51 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so22458509lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 13:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bdvoJfQCmlyT53ihtTtVDZOx4t24oweEc2riqLZynS4=;
        b=Gf8oNfv8CKaPxwpvctWIptSiqskqe+3tnhJSHxy+kuIOou/2XzyiOVp/1Xl60gcdDZ
         62pieRHDnI4E7GZgORTPpPr5gmP2tcIA8oi3755J+DspInW/3/VEPu/4KDI+sidaMtxM
         OuWzw/3NY+UF7ZpRVDOx9lD4aYGOJqwKwnKJtWuCQJ2P1oauokvIfBmL1td1n86V2V0o
         xz9zRbB/7LDZyP4KH9yiDRN3k8g1FiQaVRR7tYu4NESPe3V3ypx/A/SXAwJTThZekuGD
         yzCpZKuhx4MFA9Y08Utnaou5BhkX0/crLpN39ec/Jp9Jd+PTyuD41ERjnCIoOFN6TNT8
         RFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bdvoJfQCmlyT53ihtTtVDZOx4t24oweEc2riqLZynS4=;
        b=YBLm8sXzhLYfAccFuRt+Es1lI/VUzWevRp+XP75YH02ldVqHs+nIHQv2zvf4tv3m1c
         f/SgSLedY+oIIoFmzMbU2EhRk6z1oCLxJoWmhXoalhJagft6/RXB0afch0tPr+uJAHVy
         u8eO+X4pkhQT//96UEVueDkrSUZtolhUWdrEK9KlBRQOWhg0ttK/TX0zC+REaLkDO5yv
         kGxBX25rm0r9fSOz58o2tOj1n/O44oOBu7BWI9MiJyeesJqDkGGL+1AvtZHtdKGK8lFo
         iABXYJ3ChUqKbFAOzk7Rbfg2wtB5YUOtEF8a5smNtHzX/oVOvDsQEc0MGIBFfMA9esZt
         aEwg==
X-Gm-Message-State: AGRZ1gKdgT80t3Czj2fX2iGlMlm3WpoYWaukLSQy+vNzGpsC9KKfdB8k
        kOKOEWVmdvd6+ezmNLSLV5jFCoLdiJnVjjzn6+OP
X-Google-Smtp-Source: AJdET5dKdv+zkYVdWoW+I/CIoqy6gN1kx8TWmIMG65zmtQJ6Hrw4aSP0jXEYtGMOAooPHxsJgROBADsUwQT9qX2tBzw=
X-Received: by 2002:a19:6719:: with SMTP id b25mr10828677lfc.38.1542664747907;
 Mon, 19 Nov 2018 13:59:07 -0800 (PST)
MIME-Version: 1.0
References: <a00bbc558e81d18cb9d36211fa2e2aee033aa191.1542218518.git.rgb@redhat.com>
In-Reply-To: <a00bbc558e81d18cb9d36211fa2e2aee033aa191.1542218518.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Nov 2018 16:58:56 -0500
Message-ID: <CAHC9VhSLhs9v-DFuDvTGcx_vSatwkLxoCWy=XJpvEHF-09HTOg@mail.gmail.com>
Subject: Re: [PATCH] audit: remove WATCH and TREE config options
To:     rgb@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Eric Paris <eparis@redhat.com>, sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 12:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Remove the CONFIG_AUDIT_WATCH and CONFIG_AUDIT_TREE config options since
> they are both dependent on CONFIG_AUDITSYSCALL and force
> CONFIG_FSNOTIFY.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  init/Kconfig     |  9 ---------
>  kernel/Makefile  |  4 +---
>  kernel/audit.h   |  6 +++---
>  kernel/auditsc.c | 10 ----------
>  4 files changed, 4 insertions(+), 25 deletions(-)

Merged into audit/next.

> diff --git a/init/Kconfig b/init/Kconfig
> index a4112e95724a..7eb2538e6ca0 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -335,15 +335,6 @@ config HAVE_ARCH_AUDITSYSCALL
>  config AUDITSYSCALL
>         def_bool y
>         depends on AUDIT && HAVE_ARCH_AUDITSYSCALL
> -
> -config AUDIT_WATCH
> -       def_bool y
> -       depends on AUDITSYSCALL
> -       select FSNOTIFY
> -
> -config AUDIT_TREE
> -       def_bool y
> -       depends on AUDITSYSCALL
>         select FSNOTIFY
>
>  source "kernel/irq/Kconfig"
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 7343b3a9bff0..9dc7f519129d 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -76,9 +76,7 @@ obj-$(CONFIG_IKCONFIG) += configs.o
>  obj-$(CONFIG_SMP) += stop_machine.o
>  obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
>  obj-$(CONFIG_AUDIT) += audit.o auditfilter.o
> -obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
> -obj-$(CONFIG_AUDIT_WATCH) += audit_watch.o audit_fsnotify.o
> -obj-$(CONFIG_AUDIT_TREE) += audit_tree.o
> +obj-$(CONFIG_AUDITSYSCALL) += auditsc.o audit_watch.o audit_fsnotify.o audit_tree.o
>  obj-$(CONFIG_GCOV_KERNEL) += gcov/
>  obj-$(CONFIG_KCOV) += kcov.o
>  obj-$(CONFIG_KPROBES) += kprobes.o
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 9a3828bd387b..0b5295aeaebb 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -268,7 +268,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
>  extern void audit_put_tty(struct tty_struct *tty);
>
>  /* audit watch functions */
> -#ifdef CONFIG_AUDIT_WATCH
> +#ifdef CONFIG_AUDITSYSCALL
>  extern void audit_put_watch(struct audit_watch *watch);
>  extern void audit_get_watch(struct audit_watch *watch);
>  extern int audit_to_watch(struct audit_krule *krule, char *path, int len, u32 op);
> @@ -301,9 +301,9 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
>  #define audit_mark_compare(m, i, d) 0
>  #define audit_exe_compare(t, m) (-EINVAL)
>  #define audit_dupe_exe(n, o) (-EINVAL)
> -#endif /* CONFIG_AUDIT_WATCH */
> +#endif /* CONFIG_AUDITSYSCALL */
>
> -#ifdef CONFIG_AUDIT_TREE
> +#ifdef CONFIG_AUDITSYSCALL
>  extern struct audit_chunk *audit_tree_lookup(const struct inode *inode);
>  extern void audit_put_chunk(struct audit_chunk *chunk);
>  extern bool audit_tree_match(struct audit_chunk *chunk, struct audit_tree *tree);
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 1513873e23bd..605f2d825204 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -200,7 +200,6 @@ static int audit_match_filetype(struct audit_context *ctx, int val)
>   * References in it _are_ dropped - at the same time we free/drop aux stuff.
>   */
>
> -#ifdef CONFIG_AUDIT_TREE
>  static void audit_set_auditable(struct audit_context *ctx)
>  {
>         if (!ctx->prio) {
> @@ -245,12 +244,10 @@ static int grow_tree_refs(struct audit_context *ctx)
>         ctx->tree_count = 31;
>         return 1;
>  }
> -#endif
>
>  static void unroll_tree_refs(struct audit_context *ctx,
>                       struct audit_tree_refs *p, int count)
>  {
> -#ifdef CONFIG_AUDIT_TREE
>         struct audit_tree_refs *q;
>         int n;
>         if (!p) {
> @@ -274,7 +271,6 @@ static void unroll_tree_refs(struct audit_context *ctx,
>         }
>         ctx->trees = p;
>         ctx->tree_count = count;
> -#endif
>  }
>
>  static void free_tree_refs(struct audit_context *ctx)
> @@ -288,7 +284,6 @@ static void free_tree_refs(struct audit_context *ctx)
>
>  static int match_tree_refs(struct audit_context *ctx, struct audit_tree *tree)
>  {
> -#ifdef CONFIG_AUDIT_TREE
>         struct audit_tree_refs *p;
>         int n;
>         if (!tree)
> @@ -305,7 +300,6 @@ static int match_tree_refs(struct audit_context *ctx, struct audit_tree *tree)
>                         if (audit_tree_match(p->c[n], tree))
>                                 return 1;
>         }
> -#endif
>         return 0;
>  }
>
> @@ -1602,7 +1596,6 @@ void __audit_syscall_exit(int success, long return_code)
>
>  static inline void handle_one(const struct inode *inode)
>  {
> -#ifdef CONFIG_AUDIT_TREE
>         struct audit_context *context;
>         struct audit_tree_refs *p;
>         struct audit_chunk *chunk;
> @@ -1627,12 +1620,10 @@ static inline void handle_one(const struct inode *inode)
>                 return;
>         }
>         put_tree_ref(context, chunk);
> -#endif
>  }
>
>  static void handle_path(const struct dentry *dentry)
>  {
> -#ifdef CONFIG_AUDIT_TREE
>         struct audit_context *context;
>         struct audit_tree_refs *p;
>         const struct dentry *d, *parent;
> @@ -1685,7 +1676,6 @@ static void handle_path(const struct dentry *dentry)
>                 return;
>         }
>         rcu_read_unlock();
> -#endif
>  }
>
>  static struct audit_names *audit_alloc_name(struct audit_context *context,
> --
> 1.8.3.1
>


-- 
paul moore
www.paul-moore.com
