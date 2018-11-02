Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A00C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122012081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R//5mYNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122012081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbeKBTJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 15:09:35 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42434 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBTJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 15:09:35 -0400
Received: by mail-yw1-f68.google.com with SMTP id l2-v6so538615ywb.9;
        Fri, 02 Nov 2018 03:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OATFUJF2ZSJH2nAlrXd3RN/ZPKkh3GJDMhC3e/7S5Js=;
        b=R//5mYNbgBHDwiyJ1BjnVeaSkk5Sh8HUGiBHnpQPd/q+MZTOU8c4hyBGm3RPp9QksS
         Fu/M1INmS5n446Wz3/2iRY0xmdtd9JLoDKhnDFLQ12Zqm3qduxzhRw/v98GHMJIGltrK
         BhpAaGSX7haT6raIYK1oCxXgFwA1LU2Scv3Yt1pFaMQlTQPhka1GJAo0gF8FSIE9vQUc
         1EAszVbKYLdv9AOUXMkW6lMccUuOlC5lZiSS1givV8yOVj+t9e2GLi/0CuwIm9CmaWvU
         uDizudW7zTHQp9pcnVl6z06u61LMjSVaWjxI8fD8nrEZGsHr6oL3y5RZRHq1cWqhBfL4
         x9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OATFUJF2ZSJH2nAlrXd3RN/ZPKkh3GJDMhC3e/7S5Js=;
        b=tNH3FcnyC6UmHdkVo6+eMiAhrPGsLrJUyLnVmDdv6ImHnpFTf4qkeSaM05AIV8YbbE
         PJLZhHP3PJmfK1SSrujUgsUChGp/pZJM9dsKdwNqOhGODpb+ah0xNYWa7DxI6I7HnAfi
         ANCyUF8AxdLNYwW1AKlAExCNNyoGwyP9zS6mX/D881pIynozMD+pZmwckeuUnT36Vvn+
         29XSJJfc+2bCxtxGX8wxrjQvCJOVmeX16HWKe+AcTjWaeq7N4JfAmt+SzGmmXEjoCnzZ
         tUtlL13x06g0OPB1+/oINfDKK91l4/0oISsTp/QkCtUn41dMr9Ylxm+IZ16BhOL4gZhg
         fgUw==
X-Gm-Message-State: AGRZ1gKOHC7uBjpDuLtwx7kcVPmhi4SuA1a7dgN15+PuRdaZhTdAmiKu
        ZEsSleR9yBmGlhxRedeypnINAeIsgl4InHKnuvg=
X-Google-Smtp-Source: AJdET5dCeiQE+bW1W8Sqa9Onb4/r82mja6rnSLks7UUSgBPDtA8jJDGYhyfVo8RIub3zjUigefIeFtY4ckl/3VDMtvg=
X-Received: by 2002:a0d:d181:: with SMTP id t123-v6mr10605426ywd.241.1541152977257;
 Fri, 02 Nov 2018 03:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181101214856.4563-1-seth.forshee@canonical.com> <20181101214856.4563-7-seth.forshee@canonical.com>
In-Reply-To: <20181101214856.4563-7-seth.forshee@canonical.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 2 Nov 2018 12:02:45 +0200
Message-ID: <CAOQ4uxhkH+0tchHkrgvBZGYzeLD2fGGgtkKstt3JmhPDaGW_dg@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] shiftfs: support nested shiftfs mounts
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 11:49 PM Seth Forshee <seth.forshee@canonical.com> wrote:
>
> shiftfs mounts cannot be nested for two reasons -- global
> CAP_SYS_ADMIN is required to set up a mark mount, and a single
> functional shiftfs mount meets the filesystem stacking depth
> limit.
>
> The CAP_SYS_ADMIN requirement can be relaxed. All of the kernel
> ids in a mount must be within that mount's s_user_ns, so all that
> is needed is CAP_SYS_ADMIN within that s_user_ns.
>
> The stack depth issue can be worked around with a couple of
> adjustments. First, a mark mount doesn't really need to count
> against the stacking depth as it doesn't contribute to the call
> stack depth during filesystem operations. Therefore the mount
> over the mark mount only needs to count as one more than the
> lower filesystems stack depth.

That's true, but it also highlights the point that the "mark" sb is
completely unneeded and it really is just a nice little hack.
All the information it really stores is a lower mount reference,
a lower root dentry and a declarative statement "I am shiftable!".

Come to think about it, "container shiftable" really isn't that different from
NFS export with "no_root_squash" and auto mounted USB drive.
I mean the shifting itself is different of course, but the
declaration, not so much.
If I am allowing sudoers on another machine to mess with root owned
files visible
on my machine, I am pretty much have the same issues as container admins
accessing root owned files on my init_user_ns filesystem. In all those cases,
I'd better not be executing suid binaries from the untrusted "external" source.

Instead of mounting a dummy filesystem to make the declaration, you could
get the same thing with:
   mount(path, path, "none", MS_BIND | MS_EXTERN | MS_NOEXEC)
and all you need to do is add MS_EXTERN (MS_SHIFTABLE MS_UNTRUSTED
or whatnot)  constant to uapi and manage to come up good man page description.

Then users could actually mount a filesystem in init_user_ns MS_EXTERN and
avoid the extra bind mount step (for a full filesystem tree export).
Declaring a mounted image MS_EXTERN has merits on its own even without
containers and shitfs, for example with pluggable storage. Other LSMs could make
good use of that declaration.

>
> Second, when the lower mount is shiftfs we can just skip down to
> that mount's lower filesystem and shift ids relative to that.
> There is no reason to shift ids twice, and the lower path has
> already been marked safe for id shifting by a user privileged
> towards all ids in that mount's user ns.
>
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> ---
>  fs/shiftfs.c | 68 +++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 22 deletions(-)
>
> diff --git a/fs/shiftfs.c b/fs/shiftfs.c
> index b19af7b2fe75..008ace2842b9 100644
> --- a/fs/shiftfs.c
> +++ b/fs/shiftfs.c
> @@ -930,7 +930,7 @@ static int shiftfs_fill_super(struct super_block *sb, void *raw_data,
>         struct shiftfs_data *data = raw_data;
>         char *name = kstrdup(data->path, GFP_KERNEL);
>         int err = -ENOMEM;
> -       struct shiftfs_super_info *ssi = NULL;
> +       struct shiftfs_super_info *ssi = NULL, *mp_ssi;
>         struct path path;
>         struct dentry *dentry;
>
> @@ -946,11 +946,7 @@ static int shiftfs_fill_super(struct super_block *sb, void *raw_data,
>         if (err)
>                 goto out;
>
> -       /* to mark a mount point, must be real root */
> -       if (ssi->mark && !capable(CAP_SYS_ADMIN))
> -               goto out;
> -
> -       /* else to mount a mark, must be userns admin */
> +       /* to mount a mark, must be userns admin */
>         if (!ssi->mark && !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
>                 goto out;

Isn't this check performed by vfs anyway? i.e. in mount_nodev() -> sget()

>
> @@ -962,41 +958,66 @@ static int shiftfs_fill_super(struct super_block *sb, void *raw_data,
>
>         if (!S_ISDIR(path.dentry->d_inode->i_mode)) {
>                 err = -ENOTDIR;
> -               goto out_put;
> -       }
> -
> -       sb->s_stack_depth = path.dentry->d_sb->s_stack_depth + 1;
> -       if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> -               printk(KERN_ERR "shiftfs: maximum stacking depth exceeded\n");
> -               err = -EINVAL;
> -               goto out_put;
> +               goto out_put_path;
>         }
>
>         if (ssi->mark) {
> +               struct super_block *lower_sb = path.mnt->mnt_sb;
> +
> +               /* to mark a mount point, must root wrt lower s_user_ns */
> +               if (!ns_capable(lower_sb->s_user_ns, CAP_SYS_ADMIN))
> +                       goto out_put_path;
> +
> +
>                 /*
>                  * this part is visible unshifted, so make sure no
>                  * executables that could be used to give suid
>                  * privileges
>                  */
>                 sb->s_iflags = SB_I_NOEXEC;

As commented on cover letter, why allow access to any files besides root at all?
In fact, the only justification for a dummy sb (instead of bind mount with
MS_EXTERN flag) would be in order to override inode operations with noop ops
to prevent access to unshifted files from within container.

Thanks,
Amir.
