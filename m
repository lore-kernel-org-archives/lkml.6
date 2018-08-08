Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2AAC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE0C21765
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="EyzOds8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE0C21765
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeHHSAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:00:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46054 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeHHSAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:00:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id w16-v6so2055475ljh.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4hhiODN7cTyFLH5gTWk+jd1FEZsBWmZzCgpV/3+Ag8=;
        b=EyzOds8/AF9WChl5eQ4sEZJ90utn7x60C/4bhvAzVv5cI5PgaqfLZyDfIkd+6KGKDQ
         39w8idSZbSRj3p50b46NklZ9aalV8qgYpTT97kelcT66zK2cojEANbqPECbAq1KP/WHe
         /nVsYvVLSsEK8L8MJvXGvdxJODBHByJ9v/cOWL/LtMOEFB/L3GmjxAN1+bS9IHsO8dsu
         TYTIARNj0TEVSWUPVc3f0uG1eENLn4EgazrbLSTpbvYWIl/DgnhQh9f3RL/QI0m2EUlE
         kFGl/UGFngwJ4cPl+06p3rYi5M83vUYqOBv6qU2bl2PyPuRswvaUb8tdwJszfkg+1tAw
         RP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4hhiODN7cTyFLH5gTWk+jd1FEZsBWmZzCgpV/3+Ag8=;
        b=Vds6Zi/Z2+TqZYw2t23ujy4N0zlLh3tCvcLJTevyevBBwOALWGq/zv6pRXEFUmZbzm
         BWzx74zWET2HBIgXumMercdco6GVs08VJEG7h+iHUle1JVSbmJdXqdtAdfwVeFz69R2J
         xwUr1elfhhLI+rObrF+xRPz+9NlJqzFJlMML+waPwN0UW8w017Uw+EZmh3hmt283oHQr
         h9fGGDXyXD5JxdLHIQt3T9p5w4IlbSYm1MhKqxk7TiaRkSa4/hbWt4B9EC/RRIM6pWdY
         FY48fRNRl7BkbDhHTli7lN2/b0igHe9F/7xBXhgwx8re4YkUt3ysw2K1q+t3dfdLRR76
         ELYg==
X-Gm-Message-State: AOUpUlGO+5RZS0G3FBfBLXt/Zr7N47BIXDIN57hdr1yhM9CMojq2hxZ6
        qMOPV0csGFDcGEc+mFI2Sno5SdorLbL6nHc363BB
X-Google-Smtp-Source: AA+uWPw25lV32wFoD+QizgxYHngwHv+x7xz5e0j93aRn8RjfrQoYE8UIprel1/Te8ZE1tkBRw+b21VGXeAhitCckhwo=
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr2385773ljj.139.1533742801874;
 Wed, 08 Aug 2018 08:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180805091036.30035-1-nixiaoming@huawei.com> <CAHC9VhQKBphcPi3Oya58f4-tfK6GYkufotstduhkTaQw8NTw2Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQKBphcPi3Oya58f4-tfK6GYkufotstduhkTaQw8NTw2Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Aug 2018 11:39:50 -0400
Message-ID: <CAHC9VhREuOwOKODWuh06mGmLYMhCdrzB+kv-2GegAsixz8GL2Q@mail.gmail.com>
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

On Tue, Aug 7, 2018 at 5:35 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Sun, Aug 5, 2018 at 5:48 AM nixiaoming <nixiaoming@huawei.com> wrote:
> > If the resource requested by d_alloc_name is not added to the linked
> > list through d_add, then dput needs to be called to release the
> > subsequent abnormal branch to avoid resource leakage.
> >
> > Add missing dput to selinuxfs.c
> >
> > Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> > ---
> >  security/selinux/selinuxfs.c | 33 +++++++++++++++++++++++++--------
> >  1 file changed, 25 insertions(+), 8 deletions(-)
>
> Thanks for the quick follow-up on this patch.  It looks okay to me,
> assuming my test kernel works correctly (it's building now) I'll merge
> this into selinux/next.

Merged into selinux/next, thanks!

> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> > index 79d3709..0b66d728 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -1365,13 +1365,18 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
> >
> >                 ret = -ENOMEM;
> >                 inode = sel_make_inode(dir->d_sb, S_IFREG | S_IRUGO | S_IWUSR);
> > -               if (!inode)
> > +               if (!inode) {
> > +                       dput(dentry);
> >                         goto out;
> > +               }
> >
> >                 ret = -ENAMETOOLONG;
> >                 len = snprintf(page, PAGE_SIZE, "/%s/%s", BOOL_DIR_NAME, names[i]);
> > -               if (len >= PAGE_SIZE)
> > +               if (len >= PAGE_SIZE) {
> > +                       dput(dentry);
> > +                       iput(inode);
> >                         goto out;
> > +               }
> >
> >                 isec = (struct inode_security_struct *)inode->i_security;
> >                 ret = security_genfs_sid(fsi->state, "selinuxfs", page,
> > @@ -1586,8 +1591,10 @@ static int sel_make_avc_files(struct dentry *dir)
> >                         return -ENOMEM;
> >
> >                 inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
> > -               if (!inode)
> > +               if (!inode) {
> > +                       dput(dentry);
> >                         return -ENOMEM;
> > +               }
> >
> >                 inode->i_fop = files[i].ops;
> >                 inode->i_ino = ++fsi->last_ino;
> > @@ -1632,8 +1639,10 @@ static int sel_make_initcon_files(struct dentry *dir)
> >                         return -ENOMEM;
> >
> >                 inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
> > -               if (!inode)
> > +               if (!inode) {
> > +                       dput(dentry);
> >                         return -ENOMEM;
> > +               }
> >
> >                 inode->i_fop = &sel_initcon_ops;
> >                 inode->i_ino = i|SEL_INITCON_INO_OFFSET;
> > @@ -1733,8 +1742,10 @@ static int sel_make_perm_files(char *objclass, int classvalue,
> >
> >                 rc = -ENOMEM;
> >                 inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
> > -               if (!inode)
> > +               if (!inode) {
> > +                       dput(dentry);
> >                         goto out;
> > +               }
> >
> >                 inode->i_fop = &sel_perm_ops;
> >                 /* i+1 since perm values are 1-indexed */
> > @@ -1763,8 +1774,10 @@ static int sel_make_class_dir_entries(char *classname, int index,
> >                 return -ENOMEM;
> >
> >         inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
> > -       if (!inode)
> > +       if (!inode) {
> > +               dput(dentry);
> >                 return -ENOMEM;
> > +       }
> >
> >         inode->i_fop = &sel_class_ops;
> >         inode->i_ino = sel_class_to_ino(index);
> > @@ -1838,8 +1851,10 @@ static int sel_make_policycap(struct selinux_fs_info *fsi)
> >                         return -ENOMEM;
> >
> >                 inode = sel_make_inode(fsi->sb, S_IFREG | 0444);
> > -               if (inode == NULL)
> > +               if (inode == NULL) {
> > +                       dput(dentry);
> >                         return -ENOMEM;
> > +               }
> >
> >                 inode->i_fop = &sel_policycap_ops;
> >                 inode->i_ino = iter | SEL_POLICYCAP_INO_OFFSET;
> > @@ -1932,8 +1947,10 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
> >
> >         ret = -ENOMEM;
> >         inode = sel_make_inode(sb, S_IFCHR | S_IRUGO | S_IWUGO);
> > -       if (!inode)
> > +       if (!inode) {
> > +               dput(dentry);
> >                 goto err;
> > +       }
> >
> >         inode->i_ino = ++fsi->last_ino;
> >         isec = (struct inode_security_struct *)inode->i_security;
> > --
> > 2.10.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> paul moore
> www.paul-moore.com



-- 
paul moore
www.paul-moore.com
