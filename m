Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33751C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7955208DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="RtYmfhWr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FGNNSTDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7955208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeHBIEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:04:54 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39749 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbeHBIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:04:54 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 532C520DE4;
        Thu,  2 Aug 2018 02:15:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 02 Aug 2018 02:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=2Qi64U/ldsfGINuLRcy8PwLwNPh+xXB0BDEhvGwZm3o=; b=RtYmfhWr
        zyYQrCC9LMc8/DB8nBlDkAR/6iYJvBE4apERiCwjJETEX6pQhEJwGJOy2Av+RO1M
        rqTWCuXimLLOZd4Eh6yI+/Avw/KFkaJao4jtg8k2kj5kITKueUm3BD/f8uRjiBw0
        VMuCc4CUFVvO/MrD3AQjOjDQH5Nxa1FlQ17KVFWckqx3GFLXXwO4KrcB3+Hc0Kpm
        q+/nZ2wb03jtvy1jTnH7F1dyr78SAhZA1ZYB5AJsrfFgPAslzVmiYutSxGXiFvCV
        9TfoWY+Mf/YTqlr7zWg08rtmo8+/VcsAXv1Q4W6JjLvye4EqQeO4LeiWmLcAZWQV
        3HVuZi5Ra1IncA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=2Qi64U/ldsfGINuLRcy8PwLwNPh+x
        XB0BDEhvGwZm3o=; b=FGNNSTDNcv3J8Vv5kYdkF8/0Bm7g1qQBohQztGN2NL2yx
        x3N37qeMLTfO7EXZ9iX5LprQEzjxhQ4MG58+wkLFbH5VH3I54Qcz6+ltPdijBVjJ
        K6wVqZ9iziHqDdWL04cd1j6oEsvh28ofk0k4wP747vGjd/6ci0dr7tVwWLbWr1IS
        oQldslr/vJBI10g13OkWHO8Mt76xWIG6Hf6dKi0BrSgzH2Vbw1ryTrVL1J6ZwQob
        wT9cvwxwvgK73t83d0cSoXFxxk+BIqPbIqnFTqyJP9QiRpxBR49IqWwpQHx9/GTz
        zpjjD2slKuKRTkQLuZpWlHvIf7DNlN+knxJS/mlCw==
X-ME-Proxy: <xmx:eaFiW-M6Ti0OKwtwEPepqQYAUuzd99bwKTFIy2FCoHj2jWC8RFJkKg>
    <xmx:eaFiW65NVd4esW1f-LGzIqUCL5SAM9TGqU2c_I6CBM8SXus3SGR6Lw>
    <xmx:eaFiW83kSrjVDilVdFE3l_7vVmrGrUiFG85dk4MOzSfHlqDUo6plgg>
    <xmx:eaFiW7aEBxLQEdWtUCkvqMvRUOnQXd2UuKBgH8Y7UHvYcqTF2kwIRw>
    <xmx:eaFiW0C4y3XHkUjFJNIPtCB4puH8d5e7vjbzKNzPRFgcOw544O84gg>
    <xmx:eqFiWwk75twb-HU6Itqfh9vku9wkOj7AZ6HobNSB_AeGFkElkq0wDw>
X-ME-Sender: <xms:eaFiWzNEJMkUMvQhIowW6jMF9LsrTrctwrbyZHLH43B9XbhuEssHFA>
Received: from localhost (d57e6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.messagingengine.com (Postfix) with ESMTPA id 10F8C10255;
        Thu,  2 Aug 2018 02:15:20 -0400 (EDT)
Date:   Thu, 2 Aug 2018 08:15:18 +0200
From:   Greg KH <greg@kroah.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: linux-next: build failure after merge of the staging tree
Message-ID: <20180802061518.GD3272@kroah.com>
References: <20180730161622.3837cb15@canb.auug.org.au>
 <559c49b8-9d58-e242-20c2-fe1b491664dd@huawei.com>
 <7152b6ba-9ad6-4a9c-3b13-2d5310266ccd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7152b6ba-9ad6-4a9c-3b13-2d5310266ccd@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 05:09:13PM +0800, Chao Yu wrote:
> Hi Stephen,
> 
> On 2018/7/30 14:31, Gao Xiang wrote:
> > Hi Stephen,
> > 
> > On 2018/7/30 14:16, Stephen Rothwell wrote:
> >> Hi Greg,
> >>
> >> After merging the staging tree, today's linux-next build (x86_64
> >> allmodconfig) failed like this:
> >>
> >> drivers/staging/erofs/super.c: In function 'erofs_read_super':
> >> drivers/staging/erofs/super.c:343:17: error: 'MS_RDONLY' undeclared (first use in this function); did you mean 'IS_RDONLY'?
> >>   sb->s_flags |= MS_RDONLY | MS_NOATIME;
> >>                  ^~~~~~~~~
> >>                  IS_RDONLY
> >> drivers/staging/erofs/super.c:343:17: note: each undeclared identifier is reported only once for each function it appears in
> >> drivers/staging/erofs/super.c:343:29: error: 'MS_NOATIME' undeclared (first use in this function); did you mean 'S_NOATIME'?
> >>   sb->s_flags |= MS_RDONLY | MS_NOATIME;
> >>                              ^~~~~~~~~~
> >>                              S_NOATIME
> >> drivers/staging/erofs/super.c: In function 'erofs_mount':
> >> drivers/staging/erofs/super.c:501:10: warning: passing argument 5 of 'mount_bdev' makes integer from pointer without a cast [-Wint-conversion]
> >>    &priv, erofs_fill_super);
> >>           ^~~~~~~~~~~~~~~~
> >> In file included from include/linux/buffer_head.h:12:0,
> >>                  from drivers/staging/erofs/super.c:14:
> >> include/linux/fs.h:2151:23: note: expected 'size_t {aka long unsigned int}' but argument is of type 'int (*)(struct super_block *, void *, int)'
> >>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
> >>                        ^~~~~~~~~~
> >> drivers/staging/erofs/super.c:500:9: error: too few arguments to function 'mount_bdev'
> >>   return mount_bdev(fs_type, flags, dev_name,
> >>          ^~~~~~~~~~
> >> In file included from include/linux/buffer_head.h:12:0,
> >>                  from drivers/staging/erofs/super.c:14:
> >> include/linux/fs.h:2151:23: note: declared here
> >>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
> >>                        ^~~~~~~~~~
> >> drivers/staging/erofs/super.c: At top level:
> >> drivers/staging/erofs/super.c:518:20: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
> >>   .mount          = erofs_mount,
> >>                     ^~~~~~~~~~~
> >> drivers/staging/erofs/super.c:518:20: note: (near initialization for 'erofs_fs_type.mount')
> >> drivers/staging/erofs/super.c: In function 'erofs_remount':
> >> drivers/staging/erofs/super.c:630:12: error: 'MS_RDONLY' undeclared (first use in this function); did you mean 'IS_RDONLY'?
> >>   *flags |= MS_RDONLY;
> >>             ^~~~~~~~~
> >>             IS_RDONLY
> >> drivers/staging/erofs/super.c: At top level:
> >> drivers/staging/erofs/super.c:640:16: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
> >>   .remount_fs = erofs_remount,
> >>                 ^~~~~~~~~~~~~
> >>
> >> Caused by various commits creating erofs in the staging tree interacting
> >> with various commits redoing the mount infrastructure in the vfs tree.
> >>
> >> I have disabed CONFIG_EROFS_FS for now:
> 
> Xiang has submitted several patches as below to fix compiling error on -next
> tree, could you consider to merge those temporary fixes into -next after merging
> staging-next's updates, and reenable CONFIG_EROFS_FS for further integrity
> compiling and test?
> 
> staging: erofs: fix superblock/inode flags (MS_RDONLY -> SB_RDONLY, S_NOATIME)
> https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000282.html
> 
> staging: erofs: remove RADIX_TREE_EXCEPTIONAL_{ENTRY, SHIFT}
> https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000283.html
> 
> staging: erofs: update .mount and .remount_sb
> https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000285.html

Why have these not been submitted to me for inclusion in my tree?

thanks,

greg k-h
