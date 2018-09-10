Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3497C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9455B20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV5/4Lfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9455B20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeIKBtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:49:16 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39833 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeIKBtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:49:15 -0400
Received: by mail-it0-f66.google.com with SMTP id h1-v6so30589573itj.4;
        Mon, 10 Sep 2018 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HEEWvn+bvkhRhhhzC5bfPDtvXkbcfQvSBurqWzW32U4=;
        b=kV5/4LfpxgCJpqOuU8r7eO32iXCAFpZWW7qF4BIqX49Qex0jX7s5tYELfpqicynIFw
         LpE/VEWIwOzhSnil1U4tNlllfoZF+0+60Jyy1YOVw6nhtq9vMc00RiF4KfwXsGLMTZpK
         AFO6moJmUw3gMP+Lf4qc82eKhG2wJijSozNsLnpCG1z4xZXjdh5Z7C1b/JbwREdhwww+
         JRSO/BnSeiAr8+mn9DTxnReXDuRGuspsyDGFs811VmZ9sI8B+Yz2+Knlejn2OXSlCh8Z
         mXAvcELjOiswANhjHljczsx3zfSBQ+Ke15C9K5bnWV3Z0rm3jeHwPdBKeJkks/m31Ayx
         5kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HEEWvn+bvkhRhhhzC5bfPDtvXkbcfQvSBurqWzW32U4=;
        b=kRWMY/PYanaaDE3/Dxdbl6I7wubQ+/Nsn1uETZ05rFyUUqd3ug18OVKbr1njhhwTfR
         6GDBTG/slDK8ZiEDEy1SP1Ioa3UJX8cXTQm2h7kWwzoiSWQQ61DXpydW4+oy7zMXScvN
         tRck1ymI+3bjUCCc5NnSpRYhGSz6PGMHvZ7zDYSp5xTOo5tDScxPthJPdrpxTN2QxKCO
         AIJJl/xii2wESRiMU7A8NGzOTB4S9ygh1sg3kfUsBQJ5iZVDwk7hpd5KsIqG/MOOHIBo
         J+Db1v9oKNejuH4Xysgp3B/cmH3YA9jrS2PIgq29dHtB3CqRxCEyDfzENpd8f8H16AsK
         /jtA==
X-Gm-Message-State: APzg51CeG5QXaQMw1EhvTDx+sfDNWtwuo552fT1rK/YKyrcOFa5mvz4o
        6v737H/5at05/60UQPkn8j93gExl4RBgs2Op+jnBcnH1
X-Google-Smtp-Source: ANB0VdY3XIehXDHrBeANRgcGiqaZd0CMuFgwNz8lvzUGEJzig6DBipqjE/8Lz1bo8a4mAWRqomzU24JuJ88vNA88x1I=
X-Received: by 2002:a24:bcc4:: with SMTP id n187-v6mr18544899ite.144.1536612801772;
 Mon, 10 Sep 2018 13:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LNX.2.20.1809091544070.15534@fanir.tuyoix.net>
In-Reply-To: <alpine.LNX.2.20.1809091544070.15534@fanir.tuyoix.net>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Mon, 10 Sep 2018 22:53:09 +0200
Message-ID: <CAHpGcMJ9jB+Ekfvf6HUvWUr8ipoSJkS+U5arShpMwyjuc4qftg@mail.gmail.com>
Subject: Re: sysfs: Do not return POSIX ACL xattrs via listxattr()
To:     tsi@tuyoix.net
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

Am Mo., 10. Sep. 2018 um 05:03 Uhr schrieb Marc Aurele La France
<tsi@tuyoix.net>:
> Greetings.
>
> Commit 786534b92f3ce68f4afc8a761c80b76887797b0a "tmpfs: listxattr
> should include POSIX ACL xattrs", which first appeared in 4.5 kernels,
> introduced a regression whereby listxattr() syscalls on anything in
> sysfs, or its mountpoint, return the name of the two POSIX ACL xattrs,
> but attempts to retrieve these values are denied with EOPNOTSUP.  For
> example ...
>
>         # getfattr -d --match=3D- /sys
>         /sys: system.posix_acl_access: Operation not supported
>         /sys: system.posix_acl_default: Operation not supported
>         #

I can confirm this regression.

> This inconsistent behaviour confuses rsync(1) (among others) when it
> runs into a sysfs mountpoint, even when told to not descend into it.
> This issue occurs because simple_xattr_list() does not correctly deal
> with cached ACLs.
>
> The suggested fix below was developed with a 4.18.7 kernel, but should
> apply, modulo patch fuzz, to any kernel >=3D 4.7.  A fix for 4.5 <=3D
> kernels < 4.7 is trivially different, but I won't bother given such
> kernels are no longer maintained.
>
> Note that the only other simple_xattr_list() caller, shmem, avoids
> this glitch by previously calling cache_no_acl() on all inodes it
> creates, so perhaps sysfs/kernfs should do the same.
>
> Please Reply-To-All.
>
> Thanks and have a great day.
>
> Marc.
>
> Signed-off-by: Marc Aur=C3=A8le La France <tsi@tuyoix.net>
>
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -949,13 +949,13 @@ ssize_t simple_xattr_list(struct inode *inode, stru=
ct simple_xattrs *xattrs,
>         int err =3D 0;
>
>  #ifdef CONFIG_FS_POSIX_ACL
> -       if (inode->i_acl) {
> +       if (inode->i_acl && !is_uncached_acl(inode->i_acl)) {
>                 err =3D xattr_list_one(&buffer, &remaining_size,
>                                      XATTR_NAME_POSIX_ACL_ACCESS);
>                 if (err)
>                         return err;
>         }
> -       if (inode->i_default_acl) {
> +       if (inode->i_default_acl && !is_uncached_acl(inode->i_default_acl=
)) {
>                 err =3D xattr_list_one(&buffer, &remaining_size,
>                                      XATTR_NAME_POSIX_ACL_DEFAULT);
>                 if (err)

This seems to be a better fix, but I haven't fully verified it, yet:

--- a/fs/inode.c
+++ b/fs/inode.c
@@ -187,7 +187,8 @@ int inode_init_always(struct super_block *sb,
struct inode *inode)
     inode->i_mapping =3D mapping;
     INIT_HLIST_HEAD(&inode->i_dentry);    /* buggered by rcu freeing */
 #ifdef CONFIG_FS_POSIX_ACL
-    inode->i_acl =3D inode->i_default_acl =3D ACL_NOT_CACHED;
+    inode->i_acl =3D inode->i_default_acl =3D
+           (sb->s_flags & SB_POSIXACL) ? ACL_NOT_CACHED : NULL;
 #endif

 #ifdef CONFIG_FSNOTIFY

Thanks,
Andreas
