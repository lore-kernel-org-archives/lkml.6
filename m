Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E49ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9616520861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f8UnlBYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9616520861
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeINQhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:37:41 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32782 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeINQhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:37:41 -0400
Received: by mail-oi0-f66.google.com with SMTP id 8-v6so12551287oip.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 04:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4sCm5Y8h2U5Q5g3HJy9ItefL8uJBoguZXvJUHp+r+3A=;
        b=f8UnlBYyu4zFGLkTLc44Xvq+ehxDm3Uz8hxRrVlZ7WwEbBHgVR6CrCfnWRdjHSpBVe
         0+8bJfehv5SEJTP+ehQ6X4mzfq9nGNE7KwHHZjbTCz5vBl452MwtAgJfoLbhhD1oaBas
         emTA1S/5IrovDKfc226+vN0HlMqwI70NPlSUbXpQv8Ub42Hp2YPbdzJVP/39nSszHtkF
         BJQlIhDM8QYpO7UYTiKRJdwmisxXVmhgBxak2ShRLewMa1ysc9cfWfsrZYNLuOEARB5i
         H10jJL8+MXmNICAVYUaHYGk8qoAL2R/IgRS15CFJeTaQjSS1qAMzIOyshD9xFMocMGu1
         l/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4sCm5Y8h2U5Q5g3HJy9ItefL8uJBoguZXvJUHp+r+3A=;
        b=O6i4a2AiJetAqedkfUdATMO/Udv9DMerFGSqqpis6wgY+cW/sKmiQNSjNeYG/0ZKjN
         06Q44WB9MvGHm0i6dvnr2AC8JGbx16EmwOaOfReJ5xYm4ula7QDo7yIdiEUs5276LPdo
         MZVEYfhGHNXU8CNgvtsVrstWbkf9ih9Mk2DQZ9qu5m7OZS2VoIXI1uPIw1KsA5AxZ1YL
         7HvmGntw7rJQAimSRauzYX8Xsg4Eez9bSda5ZtSdtRd4WcrgaCLqWqjbdaMegX4liofM
         81rK57vCVUYtH4m94WfiV3HiSocoSswwYPjAL3yKwSbvoK/oAykUS00IcWD5rFfKeFvD
         vuzA==
X-Gm-Message-State: APzg51Ct76VTge+xI+qAZltjxMLSKMHc2nIpqv/gS2XLfUZpUBO89wZw
        4p76Qf4QlKwK4gm2/K0Fr71zEV21uT+faSGl8ya3fw==
X-Google-Smtp-Source: ANB0VdYHuPdyWuwXitzD0c8TMZPMLedZweeD1Q3jnJxA9E7jwL9KZW+2W1moqLtlxIkSErEsD84ABiCJ2I+efhmGtbg=
X-Received: by 2002:aca:a94c:: with SMTP id s73-v6mr8986747oie.68.1536924217633;
 Fri, 14 Sep 2018 04:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <1536922536-5803-1-git-send-email-18650033736@163.com>
In-Reply-To: <1536922536-5803-1-git-send-email-18650033736@163.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 14 Sep 2018 13:23:10 +0200
Message-ID: <CAG48ez3o+v6=FcEy40MbbQzpLYXPz4ehQ-z8VRsEvU3ghWxzZA@mail.gmail.com>
Subject: Re: [PATCH] kernel: prevent submission of creds with higher
 privileges inside container
To:     18650033736@163.com
Cc:     kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 1:14 PM My Name <18650033736@163.com> wrote:
> Adversaries often attack the Linux kernel via using
> commit_creds(prepare_kernel_cred(0)) to submit ROOT
> credential for the purpose of privilege escalation.
> For processes inside the Linux container, the above
> approach also works, because the container and the
> host share the same Linux kernel. Therefore, we en-
> force a check in commit_creds() before updating the
> cred of the caller process. If the process is insi-
> de a container (judging from the Namespace ID) and
> try to submit credentials with higher privileges t-
> han current (judging from the uid, gid, and cap_bset
> in the new cred), we will stop the modification. We
> consider that if the namespace ID of the process is
> different from the init Namespace ID (enumed in /i-
> nclude/linux/proc_ns.h), the process is inside a c-
> ontainer. And if the uid/gid in the new cred is sm-
> aller or the cap_bset (capability bounding set) in
> the new cred is larger, it may be a privilege esca-
> lation operation.

You only sent this patch to the LKML list without CC'ing anyone.
People are unlikely to see your patches this way; you may want to, for
example, CC the kernel-hardening list and people who have touched the
files your patch changes in the past. More information on this is at
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#select-the-recipients-for-your-patch
.

You sent five different versions of this patch; when you send multiple
versions of a patch, please ensure that the subject line contains the
version of the patch, as described in
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
.

I also disagree with the fundamental approach taken in your patch; in
my opinion, it is pointless to attempt to prevent kernel exploitation
by restricting usage of one specific function.

> Signed-off-by: Xin Lin <18650033736@163.com>
> ---
>  kernel/cred.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/kernel/cred.c b/kernel/cred.c
> index ecf0365..b9a313d 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -19,6 +19,12 @@
>  #include <linux/security.h>
>  #include <linux/binfmts.h>
>  #include <linux/cn_proc.h>
> +#include <linux/proc_ns.h>
> +#include <linux/ipc_namespace.h>
> +#include "../fs/mount.h"
> +#include <net/net_namespace.h>
> +#include <linux/capability.h>
> +#include <linux/cgroup.h>
>
>  #if 0
>  #define kdebug(FMT, ...)                                               \
> @@ -33,6 +39,8 @@ do {                                                                  \
>  } while (0)
>  #endif
>
> +bool flag = true;
> +static struct net *initnet;
>  static struct kmem_cache *cred_jar;
>
>  /* init to 2 - one for init_task, one to ensure it is never freed */
> @@ -425,6 +433,22 @@ int commit_creds(struct cred *new)
>         struct task_struct *task = current;
>         const struct cred *old = task->real_cred;
>
> +       if (flag) {
> +               initnet = get_net_ns_by_pid(1);
> +               flag = false;
> +       }
> +       if (task->nsproxy->uts_ns->ns.inum != PROC_UTS_INIT_INO ||
> +       task->nsproxy->ipc_ns->ns.inum != PROC_IPC_INIT_INO ||
> +       task->nsproxy->mnt_ns->ns.inum != 0xF0000000U ||
> +       task->nsproxy->pid_ns_for_children->ns.inum != PROC_PID_INIT_INO ||
> +       task->nsproxy->net_ns->ns.inum != initnet->ns.inum ||
> +       old->user_ns->ns.inum != PROC_USER_INIT_INO ||
> +       task->nsproxy->cgroup_ns->ns.inum != PROC_CGROUP_INIT_INO) {
> +               if (new->uid.val < old->uid.val || new->gid.val < old->gid.val
> +               || new->cap_bset.cap[0] > old->cap_bset.cap[0])
> +                       return 0;
> +       }
> +
>         kdebug("commit_creds(%p{%d,%d})", new,
>                atomic_read(&new->usage),
>                read_cred_subscribers(new));
> --
> 2.7.4
>
>
>
