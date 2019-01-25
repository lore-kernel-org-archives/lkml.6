Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58746C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E383217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="NDxw0WFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfAYVhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:37:08 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35186 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfAYVhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:37:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so9588640ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 13:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xbWElydTIz4lHfhABOToHbhS2Rhx09BYo0d31gjTvdk=;
        b=NDxw0WFUtx1wqCg8ed+xUB83Q+nLfx7ielu8kAvO4uROpCW0dNRoe0ztymw3b+HN4R
         hbaMdqOqQKWqh4w+2avP9J1OGYub87IcaWXs47RxzeYvbHVvx4zLtQ4o5wJS3wPQZS/D
         Q4AoPYkZ8aEwt25hJ72TonafyTH0yPnOsMjXHygQDc38vjzn95NEDU2js1N/E+cDjWe3
         Lf0lgcoTAhvPYnX6bJ2OLRMYpSBoy6KeKSdQYWF5r4SbzlsDnjpuCQv+HDVMXqh4poU3
         Q0seMBM/Luzzd0Zbmk8FO5pF3G9wBXI6EucKZlnz5NhRRJ30ZzQIpoUKCWxFfNHtilC2
         hZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbWElydTIz4lHfhABOToHbhS2Rhx09BYo0d31gjTvdk=;
        b=nNyfbiXnKGBlho0L6AijIXJPFZuPxy7REfhMtjhLJLYxzeMSJ/gtNJejvZvH+xcPh+
         e+xKJV5K1d0Wuyxe6TymG6AycJ/l5sAkCtrzKzfCLl6qeB+ni+sCZEPiaK4kF130Wx4Q
         BhcpWy9gWG+rB+17OwcXnbB0PhbbLOJbDnQbLcKwvZ1cC7nugAI856Asw4OzItfoYpmu
         IL236qxJOndW/wEouIVs0all1pkR0AF0YJGL/jYhcg8+aehtANgLE/1iw3hH8GiTI9CD
         85nxr705C4QMd1a6fD2ziwHSVfpmuBjt0bBcS+OHDjOqIgMxMBmAWC/xuXK4PbYfFgbm
         tIDQ==
X-Gm-Message-State: AJcUukfa1AqFUM8Oq24lCqI8JKcKttcow1h0uFjUGkOII0Kpt5tB2+J0
        vRGrDmNoAuGaR4ezcrN4tyjaEbBL2aGHXDNAG6XL
X-Google-Smtp-Source: ALg8bN4FsrztxFvgu+pbvSuhoKaKf4V8VvBC8pjE0/ISOCr+NIbcD9eqf+2ALd6HPxIT8peffvEgrLCuuAx2wrXySwo=
X-Received: by 2002:a2e:9cd2:: with SMTP id g18-v6mr10213802ljj.161.1548452224392;
 Fri, 25 Jan 2019 13:37:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548196083.git.rgb@redhat.com> <9f7ee0de1f6e4a349b75003f52376f82561956dd.1548196083.git.rgb@redhat.com>
In-Reply-To: <9f7ee0de1f6e4a349b75003f52376f82561956dd.1548196083.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Jan 2019 16:36:53 -0500
Message-ID: <CAHC9VhSHcpKAm+hPY5f-z+eL4O0sAX8AmYJE1rxuOPLwbLXbKA@mail.gmail.com>
Subject: Re: [PATCH ghak100 V2 1/2] audit: more filter PATH records keyed on
 filesystem magic
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 1:35 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Like commit 42d5e37654e4 ("audit: filter PATH records keyed on
> filesystem magic") that addresses
> https://github.com/linux-audit/audit-kernel/issues/8
>
> Any user or remote filesystem could become unavailable and effectively
> block on a forced unmount.
>
>     -a always,exit -S umount2 -F key=umount2
>
> Provide a method to ignore these user and remote filesystems to prevent
> them from being impossible to unmount.
>
> Extend the "AUDIT_FILTER_FS" filter that uses the field type
> AUDIT_FSTYPE keying off the filesystem 4-octet hexadecimal magic
> identifier to filter specific filesystems to cover audit_inode() to address
> this blockage.
>
> An example rule would look like:
>     -a never,filesystem -F fstype=0x517B -F key=ignore_smb
>     -a never,filesystem -F fstype=0x6969 -F key=ignore_nfs
>
> Arguably the better way to address this issue is to disable auditing
> processes that touch removable filesystems.
>
> Note: refactor __audit_inode_child() to remove two levels of if
> indentation.
>
> Please see the github issue tracker
> https://github.com/linux-audit/audit-kernel/issues/100
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)

Thanks, merged.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index b585ceb2f7a2..3d05d5fc6240 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1763,10 +1763,31 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
>         struct inode *inode = d_backing_inode(dentry);
>         struct audit_names *n;
>         bool parent = flags & AUDIT_INODE_PARENT;
> +       struct audit_entry *e;
> +       struct list_head *list = &audit_filter_list[AUDIT_FILTER_FS];
> +       int i;
>
>         if (!context->in_syscall)
>                 return;
>
> +       rcu_read_lock();
> +       if (!list_empty(list)) {
> +               list_for_each_entry_rcu(e, list, list) {
> +                       for (i = 0; i < e->rule.field_count; i++) {
> +                               struct audit_field *f = &e->rule.fields[i];
> +
> +                               if (f->type == AUDIT_FSTYPE
> +                                   && audit_comparator(inode->i_sb->s_magic,
> +                                                       f->op, f->val)
> +                                   && e->rule.action == AUDIT_NEVER) {
> +                                       rcu_read_unlock();
> +                                       return;
> +                               }
> +                       }
> +               }
> +       }
> +       rcu_read_unlock();
> +
>         if (!name)
>                 goto out_alloc;
>
> @@ -1875,14 +1896,12 @@ void __audit_inode_child(struct inode *parent,
>                         for (i = 0; i < e->rule.field_count; i++) {
>                                 struct audit_field *f = &e->rule.fields[i];
>
> -                               if (f->type == AUDIT_FSTYPE) {
> -                                       if (audit_comparator(parent->i_sb->s_magic,
> -                                           f->op, f->val)) {
> -                                               if (e->rule.action == AUDIT_NEVER) {
> -                                                       rcu_read_unlock();
> -                                                       return;
> -                                               }
> -                                       }
> +                               if (f->type == AUDIT_FSTYPE
> +                                   && audit_comparator(parent->i_sb->s_magic,
> +                                                       f->op, f->val)
> +                                   && e->rule.action == AUDIT_NEVER) {
> +                                       rcu_read_unlock();
> +                                       return;
>                                 }
>                         }
>                 }
> --
> 1.8.3.1
>


-- 
paul moore
www.paul-moore.com
