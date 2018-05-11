Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4022440-1526046580-2-12903486810672019861
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526046579; b=g3oQIbKqJjHDq8jYSiWagTidtbP6YCQi7bGsUfIvgvd0gtXrOe
    tcnXoZteE3hS97HHEernunL3P532oEvT80ksEL3V0VtY8t4bv6/aqb8wSrxmW5+9
    MYabpM1BaFLwQ6pIpKEhqeuSrTAMomrX/dXwud4+a1veowfK/QnzWnXu0ovvHTDD
    l1ACgEdN4nijrOF6gZHQJfQR4S9SGrUcUzNaQv5L1c7w/ys/dlA476YYzieMmt2s
    J4+GSNMEyy++TonJL5PwDh6Xn/z8eruqSxb4FiT1FJFdUuM52QMIoWd0zwwCXbWl
    +473xvGbIL6gaatOM3A7+9W6biP8eCz7r2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526046579; bh=Hrcf1An0dIWUOQ408yjc3vL9jAjptFpdUgg0r+2M+6
    c=; b=mTTAcH7yFBKsRDdMpZnMCUJCiH15lVDuu9d58qNrEEwng/KAeFXOqMYmi7
    1oI7pzmdGSeqbKp+YYTSBYKgllKL7rp3A8QEPaN2dZzkpGPJ1Am+DVB1LvDoGGOP
    239tf154C0cLkBjsey+lj/uIO3wHctDQ4zlq7S3fX8Ej/M9mw0km3UWqSxWBdj/5
    kyTJsQISD0pc2XCVZFRhwAIkKAR6sO/ryp009bR/vXTIEdD56wYjyGizoNI0qsoH
    Sk5ZiqZI66XeNyPpXLkMyTHXb53cEciWK5sFSTFE5Lr/lfa0HMd/Ngi4t09TAsQF
    fn7OHscNW10azfn7VlSh8N57nbbA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=u5pURFmC x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=TniXEvFe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=u5pURFmC x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=TniXEvFe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHTjfGSETFA7PLFzqydG9JGCOvz8ooSHewmBp19YTaVUPv7SgqbeoC7DUTNcU6BXlajNIOJD1dQwpJ87ssrDHldO1ZyqZbUMuVyWE7DmXqFqvn7781Fm
    cYo/zAxKW8/2PDCkNeO6YenXVIVd/gR5inBTNgEArrh/Z13Oi7LqBNEO4MR1WwnUGafuNNa0k9ppxsBOH3GpIg/fagFGTyjzXPA+aQ8JRQlZDmqplsZSsfAH
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=uP1ucDPQAAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8
    a=f-77BN9sPglN-m0HxzQA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=9a9ggB8z3XFZH39hjkD6:22 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeEKNtg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 09:49:36 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44094 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753130AbeEKNte (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 09:49:34 -0400
X-Google-Smtp-Source: AB8JxZoodQahIig8BYmkPRueXUK0GG07nAYu+MhbpDiIcJB09oXyo8s4mm92lvIZ3W5vZtwNtQw+ngd9YsMpsPJ3QvY=
MIME-Version: 1.0
In-Reply-To: <20180511093445.GA1008@comp-core-i7-2640m-0182e6>
References: <20180511093445.GA1008@comp-core-i7-2640m-0182e6>
From: Jann Horn <jannh@google.com>
Date: Fri, 11 May 2018 15:49:13 +0200
Message-ID: <CAG48ez3xYHsKMkPJhjq-yrrTxMHmrHDov-P7bTy8T2xf_7=OAQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] proc: add proc_fs_info struct to store proc information
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        Ingo Molnar <mingo@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        aniel Micay <danielmicay@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, bfields@fieldses.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Solar Designer <solar@openwall.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Djalal Harouni <tixxdz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 11:34 AM, Alexey Gladkov
<gladkov.alexey@gmail.com> wrote:
> From: Djalal Harouni <tixxdz@gmail.com>
>
> This is a preparation patch that adds proc_fs_info to be able to store
> different procfs options and informations. Right now some mount options
> are stored inside the pid namespace which makes it hard to change or
> modernize procfs without affecting pid namespaces. Plus we do want to
> treat proc as more of a real mount point and filesystem. procfs is part
> of Linux API where it offers some features using filesystem syscalls and
> in order to support some features where we are able to have multiple
> instances of procfs, each one with its mount options inside the same pid
> namespace, we have to separate these procfs instances.
>
> This is the same feature that was also added to other Linux interfaces
> like devpts in order to support containers, sandboxes, and to have
> multiple instances of devpts filesystem [1].
>
> [1] http://lxr.free-electrons.com/source/Documentation/filesystems/devpts.txt?v=3.14
>
> Cc: Kees Cook <keescook@chromium.org>
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> ---
[...]
>  static struct dentry *proc_mount(struct file_system_type *fs_type,
>         int flags, const char *dev_name, void *data)
>  {
> +       int error;
> +       struct super_block *sb;
>         struct pid_namespace *ns;
> +       struct proc_fs_info *fs_info;
> +
> +       /*
> +        * Don't allow mounting unless the caller has CAP_SYS_ADMIN over
> +        * the namespace.
> +        */
> +       if (!(flags & MS_KERNMOUNT) && !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> +               return ERR_PTR(-EPERM);

Is this correct?

The old code invoked a check with the same comment through mount_ns();
however, this patch changes the semantics of the check.
The old code checked that the caller has privileges over the user
namespace that contains the PID namespace; in other words, it checked
that the caller has privileges over the PID namespace. The current
code just checks that the caller is privileged over its own user
namespace.

As far as I can tell, this means that by doing something like this:

    unshare(CLONE_NEWNS|CLONE_NEWUSER);
    mount("none", "/", NULL, MS_REC|MS_PRIVATE, NULL);
    mount("proc", "/proc", "proc", 0, "newinstance,pids=all");

any process could create a new unrestricted procfs mount for its PID
namespace, even if it is only supposed to have access to a more
restricted procfs mount.

> +       fs_info = kzalloc(sizeof(*fs_info), GFP_NOFS);
> +       if (!fs_info)
> +               return ERR_PTR(-ENOMEM);
>
>         if (flags & SB_KERNMOUNT) {
>                 ns = data;
> @@ -98,20 +128,47 @@ static struct dentry *proc_mount(struct file_system_type *fs_type,
>                 ns = task_active_pid_ns(current);
>         }
>
> -       return mount_ns(fs_type, flags, data, ns, ns->user_ns, proc_fill_super);
> +       fs_info->pid_ns = ns;
> +
> +       sb = sget_userns(fs_type, proc_test_super, proc_set_super, flags,
> +                        ns->user_ns, fs_info);
> +       if (IS_ERR(sb)) {
> +               error = PTR_ERR(sb);
> +               goto error_fs_info;
> +       }
> +
> +       if (sb->s_root) {
> +               kfree(fs_info);
> +       } else {
> +               error = proc_fill_super(sb, data, flags & MS_SILENT ? 1 : 0);
> +               if (error) {
> +                       deactivate_locked_super(sb);
> +                       goto error;
> +               }
> +
> +               sb->s_flags |= MS_ACTIVE;
> +       }
> +
> +       return dget(sb->s_root);
> +
> +error_fs_info:
> +       kfree(fs_info);
> +error:
> +       return ERR_PTR(error);
>  }
