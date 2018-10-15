Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CC6C71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13B6208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t2ts88jd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13B6208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeJPBIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:08:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45996 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeJPBIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:08:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id u22so19643009ota.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CbEb1e3mwKSvma+9YwGkjqAvQdatskY8dzJ6X7LycxU=;
        b=t2ts88jdrgOX1w/+lLSIIWxq00U4iJtUzYC54TrHIEDU7+gZN2eZsY94IR9ewZ5GhF
         iJJsmO2CBN1YM0xrL1xrzYTsfE8b6AwUOoIULA3A3TnfvAK1qJyvlVHyOI8TYMbnd0Hr
         VCvtPMAeRP+J+PLmMMc3bXC8PHUMA9ISj8TLLtldYi5r3K+UUkFMTQ3BBOp2tnXO2K7Y
         hOVygbBXl5RAfWktGjDQKXHHhDNIa2v+/cTfk1Kfj8Kabn+ncRiU0e0sFQv01UAgUWQ1
         9zlsF0qjFHW+v87qVoULudyLKXkhNB03CITZAyrypuCVg7W9en6aT5+FIPnXTxf9Lx5/
         Cr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CbEb1e3mwKSvma+9YwGkjqAvQdatskY8dzJ6X7LycxU=;
        b=G8rqYpZgPBRDGJxxadpXLGhl/IHwOL411/JFnw5+cZb4IpkIdqFXfvukkvm8xlPjkM
         JHBWwsLYh8AqlaqW3sVMRn/HH/7XD2JkJbgN1wptdFJlbXtnpGRlD9XqDgtX/bCBUM7G
         EiyW5zylBKzH6y95LXQOElHug+9YreW0bnWMe5R7XHeLAdRzIGUg7jJq9MeUKIf4Se9T
         5YL81kYv2XWbCrKPA0BGOagwds+M4DLaM1ZpKOvkFxo2b19loVn1rO0lNacmHcjpQsKf
         YIifSAIXIce2aPgydAvQMmkZEqd8fREPBMgs7FP6udQr8ALks1bUEx2Xep7GRBbV8j8P
         n1FA==
X-Gm-Message-State: ABuFfojniPXjIpGBs5Wip2OCCAfZuYkEQT4cUxi3CyXOzL/7qLTanNwJ
        zITZAEj60tvnjTtr7nbaAcxRYPOXpMS/+d+sa5aWsQ==
X-Google-Smtp-Source: ACcGV62kbA7nDWVp+UgWLAnaZwJ8cQc+LtnlgkFOxJqDhXGTleZwgY3k9v1IbFyJD0M1oynPTdEsDpTATD6To31xN38=
X-Received: by 2002:a9d:2641:: with SMTP id a59mr12135188otb.35.1539624158832;
 Mon, 15 Oct 2018 10:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <1539623427-10789-1-git-send-email-nagarathnam.muthusamy@oracle.com>
In-Reply-To: <1539623427-10789-1-git-send-email-nagarathnam.muthusamy@oracle.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 15 Oct 2018 19:22:12 +0200
Message-ID: <CAG48ez2cHT1U5nn+dNCAg3Lk5047=Tr20T8HkKhBUt1Mv+gNeg@mail.gmail.com>
Subject: Re: [RFC] Allow user namespace inside chroot
To:     Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Serge Hallyn <serge.hallyn@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 7:10 PM <nagarathnam.muthusamy@oracle.com> wrote:
> Following commit disables the creation of user namespace inside
> the chroot environment.
>
> userns: Don't allow creation if the user is chrooted
>
> commit 3151527ee007b73a0ebd296010f1c0454a919c7d
>
> Consider a system in which a non-root user creates a combination
> of user, pid and mount namespaces and confines a process to it.
> The system will have multiple levels of nested namespaces.
> The root namespace in the system will have lots of directories
> which should not be exposed to the child confined to the set of
> namespaces.
>
> Without chroot, we will have to hide all unwanted directories
> individually using bind mounts and mount namespace.

IMO what you really should be doing is to create a tmpfs, bind-mount
the directories you want into it, and then pivot_root() into that, not
the other way around.

> Chroot enables
> us to expose a handpicked list of directories which the child
> can see but if we use chroot we wont be able to create nested
> namespaces.

Uh, are you aware that pivot_root() exists? That's what you should be using.

The kernel makes pretty much no security guarantees about chroot(). If
you're using chroot() for security, you're almost certainly doing it
wrong. If you want security, use pivot_root().

> Allowing a process to create user namespace within a chroot
> environment will enable it to chroot, which in turn can be used
> to escape the jail.
>
> This patch drops the chroot privilege when user namespace is
> created within the chroot environment so the process cannot
> use it to escape the chroot jail.

"cannot" is a strong expression. More like "might not be able to".

> The process can still modify
> the view of the file system using mount namespace but for those
> modifications to be useful, it needs to run a setuid program with
> that intented uid directly mapped into the user namespace as it is
> which is not possible for an unprivileged process.
>
> If there were any other corner cases which were considered while
> deciding to disable the creation of user namespace as a whole
> within the chroot environment please let me know.
>
> Signed-off-by: Nagarathnam Muthusamy<nagarathnam.muthusamy@oracle.com>
> ---
>  kernel/user_namespace.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index e5222b5..83d2a70 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -44,7 +44,7 @@ static void dec_user_namespaces(struct ucounts *ucounts)
>         return dec_ucount(ucounts, UCOUNT_USER_NAMESPACES);
>  }
>
> -static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
> +static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns, int is_chrooted)
>  {
>         /* Start with the same capabilities as init but useless for doing
>          * anything as the capabilities are bound to the new user namespace.
> @@ -55,6 +55,11 @@ static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
>         cred->cap_effective = CAP_FULL_SET;
>         cred->cap_ambient = CAP_EMPTY_SET;
>         cred->cap_bset = CAP_FULL_SET;
> +       if (is_chrooted) {
> +               cap_lower(cred->cap_permitted, CAP_SYS_CHROOT);
> +               cap_lower(cred->cap_effective, CAP_SYS_CHROOT);
> +               cap_lower(cred->cap_bset, CAP_SYS_CHROOT);
> +       }

This isn't going to work. For example, if the attacker can use
pivot_root() (which checks for CAP_SYS_ADMIN), you're still screwed.

>  #ifdef CONFIG_KEYS
>         key_put(cred->request_key_auth);
>         cred->request_key_auth = NULL;
> @@ -78,6 +83,7 @@ int create_user_ns(struct cred *new)
>         kgid_t group = new->egid;
>         struct ucounts *ucounts;
>         int ret, i;
> +       int is_chrooted = 0;
>
>         ret = -ENOSPC;
>         if (parent_ns->level > 32)
> @@ -88,14 +94,12 @@ int create_user_ns(struct cred *new)
>                 goto fail;
>
>         /*
> -        * Verify that we can not violate the policy of which files
> -        * may be accessed that is specified by the root directory,
> -        * by verifing that the root directory is at the root of the
> -        * mount namespace which allows all files to be accessed.
> +        * Drop the chroot privilege when a user namespace is created inside
> +        * chrooted environment so that the file system view presented to a
> +        * non-admin process is preserved.
>          */
> -       ret = -EPERM;
>         if (current_chrooted())
> -               goto fail_dec;
> +               is_chrooted = 1;
>
>         /* The creator needs a mapping in the parent user namespace
>          * or else we won't be able to reasonably tell userspace who
> @@ -140,7 +144,7 @@ int create_user_ns(struct cred *new)
>         if (!setup_userns_sysctls(ns))
>                 goto fail_keyring;
>
> -       set_cred_user_ns(new, ns);
> +       set_cred_user_ns(new, ns, is_chrooted);
>         return 0;
>  fail_keyring:
>  #ifdef CONFIG_PERSISTENT_KEYRINGS
> @@ -1281,7 +1285,7 @@ static int userns_install(struct nsproxy *nsproxy, struct ns_common *ns)
>                 return -ENOMEM;
>
>         put_user_ns(cred->user_ns);
> -       set_cred_user_ns(cred, get_user_ns(user_ns));
> +       set_cred_user_ns(cred, get_user_ns(user_ns), 0);

This looks bogus. With this, I think your restriction can be bypassed
if process A forks a child B, B creates a new user namespace, then A
enters the user namespace with setns() and has full capabilities. Am I
missing something?
