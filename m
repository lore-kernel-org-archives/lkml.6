Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932266AbeCLPMm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:12:42 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36387 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbeCLPMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:12:41 -0400
X-Google-Smtp-Source: AG47ELt/WiL7v1KCz+WO/cT7dtiS4nGI9VkOiaphZpWiUfBwlHfO4XfRzEDgzdClD+neyV8GySwhmBUacKjYP3pwecY=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <ce98e9600a8d7d0169067ae9f3e3a5ae2fb1f54a.1520835596.git.rgb@redhat.com>
References: <cover.1520835596.git.rgb@redhat.com> <ce98e9600a8d7d0169067ae9f3e3a5ae2fb1f54a.1520835596.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Mar 2018 11:12:39 -0400
Message-ID: <CAHC9VhRh094wMJkiBY+iStfwMEotHMrOCWUSW23gva_ccknuqg@mail.gmail.com>
Subject: Re: [PATCH ghak21 V2 3/4] audit: add refused symlink to audit_names
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 2:31 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Audit link denied events for symlinks had duplicate PATH records rather
> than just updating the existing PATH record.  Update the symlink's PATH
> record with the current dentry and inode information.
>
> See: https://github.com/linux-audit/audit-kernel/issues/21
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/namei.c | 1 +
>  1 file changed, 1 insertion(+)

Why didn't you include this in patch 4/4 like I asked during the
previous review?

> diff --git a/fs/namei.c b/fs/namei.c
> index 50d2533..00f5041 100644
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

-- 
paul moore
www.paul-moore.com
