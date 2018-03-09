Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbeCIAaT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 19:30:19 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45856 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbeCIAaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 19:30:18 -0500
X-Google-Smtp-Source: AG47ELt4kjHe7+pOKny4EPVUce0RPMwBr1tt3m62v9n00AiYaRYJDUhGas2oyfH/7av0yso5i254ulYnMkWlUbWW4IA=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <a1450ecfc2dd21c347a8a0037a9545a012bf4349.1518603831.git.rgb@redhat.com>
References: <cover.1518603831.git.rgb@redhat.com> <a1450ecfc2dd21c347a8a0037a9545a012bf4349.1518603831.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Mar 2018 19:30:16 -0500
Message-ID: <CAHC9VhQDLuJ-T9=4YR_vrch-KqAGC+54ZVMsb84yNZpHCrj8bw@mail.gmail.com>
Subject: Re: [RFC PATCH ghak21 3/4] audit: add refused symlink to audit_names
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 11:18 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Audit link denied events for symlinks had duplicate PATH records rather
> than just updating the existing PATH record.  Update the symlink's PATH
> record with the current dentry and inode information.
>
> See: https://github.com/linux-audit/audit-kernel/issues/21
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/namei.c | 1 +
>  1 file changed, 1 insertion(+)

Merged.

> diff --git a/fs/namei.c b/fs/namei.c
> index 9cc91fb..0edf133 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -945,6 +945,7 @@ static inline int may_follow_link(struct nameidata *nd)
>         if (nd->flags & LOOKUP_RCU)
>                 return -ECHILD;
>
> +       audit_inode(nd->name, nd->stack[0].link.dentry, 0);
>         audit_log_link_denied("follow_link", &nd->stack[0].link);
>         return -EACCES;
>  }
> --
> 1.8.3.1
>

-- 
paul moore
www.paul-moore.com
