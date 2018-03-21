Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeCUPtH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:49:07 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45123 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752512AbeCUPtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:49:04 -0400
X-Google-Smtp-Source: AG47ELvC6Fds+Wf+IQLLYxzx9FPv0TZI7QVNwyNlrWvn4pddwD0Ha6QBUBhYG9t6rkLgZ4yW/xJ8v5iKnpUYuFnN3kU=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <e372c38adc4d2f43ff45b411b8a6b61c9b71b086.1521620371.git.rgb@redhat.com>
References: <cover.1521620371.git.rgb@redhat.com> <e372c38adc4d2f43ff45b411b8a6b61c9b71b086.1521620371.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Mar 2018 11:49:02 -0400
Message-ID: <CAHC9VhTFqY7p2zfX4y91cGpFg832sgyf7RRKw9YY3mARgz2GbA@mail.gmail.com>
Subject: Re: [PATCH ghak21 V4 2/2] audit: add refused symlink to audit_names
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 4:42 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Audit link denied events for symlinks had duplicate PATH records rather
> than just updating the existing PATH record.  Update the symlink's PATH
> record with the current dentry and inode information.
>
> See: https://github.com/linux-audit/audit-kernel/issues/21
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/namei.c | 1 +
>  1 file changed, 1 insertion(+)

Merged.  Thanks for the audit log examples.

> diff --git a/fs/namei.c b/fs/namei.c
> index e3682bb..5f8e8e2 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -945,6 +945,7 @@ static inline int may_follow_link(struct nameidata *nd)
>         if (nd->flags & LOOKUP_RCU)
>                 return -ECHILD;
>
> +       audit_inode(nd->name, nd->stack[0].link.dentry, 0);
>         audit_log_link_denied("follow_link");
>         return -EACCES;
>  }
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
