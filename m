Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99683C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E11821945
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="zAwghNZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E11821945
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeHGXvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:51:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36865 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeHGXvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:51:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id j8-v6so97008lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mM6vBbcyQwd6pCccrEpB6Y7vk5k69g7dNBbcndg2fxE=;
        b=zAwghNZv+dW03HlWSvDgEOU4wU/TBiAXbHkj1Aiw3xEHJKTK+jZh4J9L9Qk44BFuWf
         sL6Q9ysM9wPRJ63XPiNXQvAmuryLLogN1sRaG1T672M1Cwypz7Kp2G5jsTgBDFzdRT7N
         i5gY3VN+GATtw3gbiwDOTBXGW9qIFmtXrZ/tkwTN7snICY+7lTKpdH9U2OxsOwHQXACn
         kYJql3F9cKP4FtGTU0fskN4Ae8dcZyVg+xgtqU3TTCanIDWg06h76N/mIFldLJQ93z/I
         CFrpxm8jyEkRQW7C2oP/NxnnxkU41zZy3qckk2IS5U+4DRZQuyw1sRBXB2aCeJtL3kSb
         6B/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mM6vBbcyQwd6pCccrEpB6Y7vk5k69g7dNBbcndg2fxE=;
        b=kU559D5BLEs9RobkOz6fu+HgCBgdDQa4lhhpddA3Wp9vh3rfohWVIXNAn1i1KXc9gK
         cnf7gw7/7vRAWQISjSI/QHwAhL5M4J4EISc4NNTY1edj1RDmE9bDTjyl4cg4ZbZUgMyH
         ZwFqGcR7TjOYuP+/+Bt6wkbDo7tjssZ0ZtvASFe6tV2Y4FIIo/+o4t/h2RobMZ4cFJ8s
         ZWqUWf8AMJ1zT273CdZnY8LGphdz8KQ+70XUGpXDuLw6kqsmyZNVSq76Yh/Mwwd1zoaP
         g0uGdfOxhzff2uF/DE9kYSR/iwHtOVW9fbcesAB+Zon36+5J1TVmv89O73Eucisqv5ej
         Jy6g==
X-Gm-Message-State: AOUpUlFrAphC0oEwWOrQXZBgnTPP0hVNBVwi+bjXgJhZfARzgGzARIhz
        tv702qzu/G6T7vmDG5slyrHOGbiP5jfFHA6gYrqR
X-Google-Smtp-Source: AA+uWPy7CTaHA5XYXDrPwbHyg/KMepTJX0NR1yPUBhdt7yR91w84wS7QgzhDsvPBAO4pucLdfV4x2csZ+mulkjSMY8Y=
X-Received: by 2002:a19:de4e:: with SMTP id v75-v6mr92295lfg.14.1533677717848;
 Tue, 07 Aug 2018 14:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180805091036.30035-1-nixiaoming@huawei.com>
In-Reply-To: <20180805091036.30035-1-nixiaoming@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Aug 2018 17:35:06 -0400
Message-ID: <CAHC9VhQKBphcPi3Oya58f4-tfK6GYkufotstduhkTaQw8NTw2Q@mail.gmail.com>
Subject: Re: [PATCH] selinuxfs: Fix the resource leak in the failed branch of sel_make_inode
To:     nixiaoming@huawei.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>, serge@hallyn.com,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 5, 2018 at 5:48 AM nixiaoming <nixiaoming@huawei.com> wrote:
> If the resource requested by d_alloc_name is not added to the linked
> list through d_add, then dput needs to be called to release the
> subsequent abnormal branch to avoid resource leakage.
>
> Add missing dput to selinuxfs.c
>
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> ---
>  security/selinux/selinuxfs.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)

Thanks for the quick follow-up on this patch.  It looks okay to me,
assuming my test kernel works correctly (it's building now) I'll merge
this into selinux/next.

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 79d3709..0b66d728 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1365,13 +1365,18 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
>
>                 ret = -ENOMEM;
>                 inode = sel_make_inode(dir->d_sb, S_IFREG | S_IRUGO | S_IWUSR);
> -               if (!inode)
> +               if (!inode) {
> +                       dput(dentry);
>                         goto out;
> +               }
>
>                 ret = -ENAMETOOLONG;
>                 len = snprintf(page, PAGE_SIZE, "/%s/%s", BOOL_DIR_NAME, names[i]);
> -               if (len >= PAGE_SIZE)
> +               if (len >= PAGE_SIZE) {
> +                       dput(dentry);
> +                       iput(inode);
>                         goto out;
> +               }
>
>                 isec = (struct inode_security_struct *)inode->i_security;
>                 ret = security_genfs_sid(fsi->state, "selinuxfs", page,
> @@ -1586,8 +1591,10 @@ static int sel_make_avc_files(struct dentry *dir)
>                         return -ENOMEM;
>
>                 inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
> -               if (!inode)
> +               if (!inode) {
> +                       dput(dentry);
>                         return -ENOMEM;
> +               }
>
>                 inode->i_fop = files[i].ops;
>                 inode->i_ino = ++fsi->last_ino;
> @@ -1632,8 +1639,10 @@ static int sel_make_initcon_files(struct dentry *dir)
>                         return -ENOMEM;
>
>                 inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
> -               if (!inode)
> +               if (!inode) {
> +                       dput(dentry);
>                         return -ENOMEM;
> +               }
>
>                 inode->i_fop = &sel_initcon_ops;
>                 inode->i_ino = i|SEL_INITCON_INO_OFFSET;
> @@ -1733,8 +1742,10 @@ static int sel_make_perm_files(char *objclass, int classvalue,
>
>                 rc = -ENOMEM;
>                 inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
> -               if (!inode)
> +               if (!inode) {
> +                       dput(dentry);
>                         goto out;
> +               }
>
>                 inode->i_fop = &sel_perm_ops;
>                 /* i+1 since perm values are 1-indexed */
> @@ -1763,8 +1774,10 @@ static int sel_make_class_dir_entries(char *classname, int index,
>                 return -ENOMEM;
>
>         inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
> -       if (!inode)
> +       if (!inode) {
> +               dput(dentry);
>                 return -ENOMEM;
> +       }
>
>         inode->i_fop = &sel_class_ops;
>         inode->i_ino = sel_class_to_ino(index);
> @@ -1838,8 +1851,10 @@ static int sel_make_policycap(struct selinux_fs_info *fsi)
>                         return -ENOMEM;
>
>                 inode = sel_make_inode(fsi->sb, S_IFREG | 0444);
> -               if (inode == NULL)
> +               if (inode == NULL) {
> +                       dput(dentry);
>                         return -ENOMEM;
> +               }
>
>                 inode->i_fop = &sel_policycap_ops;
>                 inode->i_ino = iter | SEL_POLICYCAP_INO_OFFSET;
> @@ -1932,8 +1947,10 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>
>         ret = -ENOMEM;
>         inode = sel_make_inode(sb, S_IFCHR | S_IRUGO | S_IWUGO);
> -       if (!inode)
> +       if (!inode) {
> +               dput(dentry);
>                 goto err;
> +       }
>
>         inode->i_ino = ++fsi->last_ino;
>         isec = (struct inode_security_struct *)inode->i_security;
> --
> 2.10.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
paul moore
www.paul-moore.com
