Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303A2C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D898621770
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="07zGZCDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D898621770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbeHCU7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 16:59:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45449 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbeHCU7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 16:59:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id w16-v6so5721811ljh.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 12:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPx2HWtFBioibTR8v5uOLEVigfQFCyE/oiiue74TZrg=;
        b=07zGZCDz2BGnY0FdhTHkkxGCKD2NCJly61SHmaTaz67kJmKsyUuCEY7Hba8wYn3qX9
         +m6i7itsH60eQagyN6sIHRTd9hQ73puY8qdNxGhYvbiWrM/plPbONhZYOpxXahWTJsLj
         sV9F07Sx9byFWvmEihoUyaEhRr+RKHDQSW0c/0Xq+8mUWm8NghPfxKCdMVVGRoB7d3PK
         R9cn3LRSuo2nj26CevBNIB0T+TNgh3S3Y/r8A+ns7WK6M/sEH3zdlxTqwAW2lBv/jKql
         a/gAOfdRkJMTD/yMYd1Pejt048vIG01h4O5y2qpNGdvs+uLE6Yz7GerTrcYVaf5UQ2NE
         ClMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPx2HWtFBioibTR8v5uOLEVigfQFCyE/oiiue74TZrg=;
        b=r5Uymt0wZ50SjeS7949VxvYNiItFFFyywyGIjVxJyLeQ9Czs2rxHQo6J2dqkQeJks5
         WwJl6YCuFcMtaUH85ncgJDxB+guthd4O5vujmB1sZpLoZUvAdNd/rWqIB9lIRCcCOmQI
         7PyJ2+MJFKGEgixGtLw1yeW3wOZglKAD9myAXViq17UUpJfvTAbN8QtYsUAp8YYrEaOj
         5LDu+1ogABFIDAjXpqvIiMir1wlR5LT1Y3WDohTqz/hlk3bOwIG9VYan+6ZlAx+a+GS/
         is7pJXKF/lW6UshnfkWJglVGMuk9AMBtK7n90okDpRG40QSsvdwpwRwO1f2mQHKtgNI7
         N1Eg==
X-Gm-Message-State: AOUpUlHKqYUZAoELwJ2tcDNPHn79onDkThQlCoCH9VKSmdt+RTmEzLFc
        Q6CPz93IOvNPrVwjFEOUa6+3ueQZk3hzUF7Hik4k
X-Google-Smtp-Source: AAOMgpd0qez6EcXbaPxMaqDak3AYHtqOVzaidJ7He/VxtnQZvBbbE6CSmUhjm3PWokgprzd7aaXgGS2ajjca6py2NI0=
X-Received: by 2002:a2e:2d0a:: with SMTP id t10-v6mr6065652ljt.8.1533322887617;
 Fri, 03 Aug 2018 12:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <E490CD805F7529488761C40FD9D26EF12A72A2C9@dggemm507-mbx.china.huawei.com>
In-Reply-To: <E490CD805F7529488761C40FD9D26EF12A72A2C9@dggemm507-mbx.china.huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 3 Aug 2018 15:01:16 -0400
Message-ID: <CAHC9VhS4nwcErVriwBzvvRQTFLZ=U_p8gA7xQnjs1wBKtmSgxQ@mail.gmail.com>
Subject: Re: maybe resource leak in security/selinux/selinuxfs.c
To:     nixiaoming@huawei.com
Cc:     viro@zeniv.linux.org.uk, serge@hallyn.com,
        James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, lizefan@huawei.com,
        miaoxie@huawei.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 5:39 AM Nixiaoming <nixiaoming@huawei.com> wrote:
>
> advisory:
> 1 After creating dentry in d_alloc_name, should I call dput to release resources before the exception exit?
> 2 After calling the new_inode to create an inode, should the inode resource be released before the exception exit?
>
> If the dentry and inode resources need to be actively released, there are multiple resource leaks in security/selinux/selinuxfs.c.

Hello.  Sorry for the delay in responding, comments inline ...

> Example:
> Linux master branch v4.18-rc5
> The function sel_make_avc_files in security/selinux/selinuxfs.c.
>
> 1566 static int sel_make_avc_files(struct dentry *dir)
> .......
> 1580     for (i = 0; i < ARRAY_SIZE(files); i++) {
> 1581         struct inode *inode;
> 1582         struct dentry *dentry;
> 1583
> 1584         dentry = d_alloc_name(dir, files[i].name);
> 1585         if (!dentry)
> /*Resource leak: when i!=0, the release action of dentry and inode resources is missing*/

I don't understand the leak in this case?  If d_alloc_name() fails on
a partially constructed /sys/fs/selinux/avc directory the previously
allocated dentry/inodes are not lost or leaked, d_alloc_name()
attached them to the parent dentry.

> 1586             return -ENOMEM;
> 1587
> 1588         inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
> 1589         if (!inode)
> /*Resource leak: missing dput(dentry)*/
> /*Resource leak: when i!=0, the release action of dentry and inode resources is missing*/

Yes, in this case it does look like we are missing a call to dput().
Would you like to submit a patch to fix this as well as the others in
selinuxfs.c?

> 1590             return -ENOMEM;
> 1591
> 1592         inode->i_fop = files[i].ops;
> 1593         inode->i_ino = ++fsi->last_ino;
> 1594         d_add(dentry, inode);
> 1595     }
> 1596
> 1597     return 0;
> 1598 }
>
> There are similar resource leaking functions:
> Sel_make_bools
> Sel_make_avc_files
> Sel_make_initcon_files
> Sel_make_perm_files
> Sel_make_class_dir_entries
> Sel_make_policycap
> Sel_fill_super
> Sel_make_policy_nodes
> Sel_make_classes

-- 
paul moore
www.paul-moore.com
