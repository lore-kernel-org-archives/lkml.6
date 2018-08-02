Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C601C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB95208DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="08dpHx4b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W0HEIeIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB95208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeHBJEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:04:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57617 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbeHBJEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:04:45 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6C7BD21ADF;
        Thu,  2 Aug 2018 03:14:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 02 Aug 2018 03:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=nDCyK0EXY9re7g2UFNgF9sWwitp4tfZb/9bcySxm4VE=; b=08dpHx4b
        rSvNzcTiPXfq/SGEQshY6dTAzidQAooblqm5SkxZD8pchRbiiVJTFsb8S0BeW85N
        J1JdOayAbgYqxWlU7zafIQW49Z+GhdBXtCVV+PbQWHp7PsYlazev0NKlpV1V5iCm
        Bwf8609oKV+JQYZS/0h8DEHNCg0cdxTSvmVuQeg4HoP9gzKcHOvcdEb62j62tn8i
        qAFcnSz8C0c/M9RoB48qkiiHd2+9y6SYH/ptSl9Ivp8L9NVI/ofkhX3mdErGWSIt
        Y92DOc0r9DHUGHmJ79i2O+GJ+fc1MTbKD0jFEPwKYU6c+NmtysFKuEzD4XWYf/fJ
        Ww+g+8oe+UQe4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=nDCyK0EXY9re7g2UFNgF9sWwitp4t
        fZb/9bcySxm4VE=; b=W0HEIeIx75XTwK4mV5KvtPY/s6DgCG+QdO3GHryotRZzw
        Llln3UaHiZR0Ge6VP7R9If1A2IPZGz20uLbrWSvKEaN8/UwXtJ5ztSaM4qjT8jZX
        xV5js8S1HB1ye4p3rzLQlvxfqUdo0gCRQQsevqoCSFuCdeNk7cTivBf2sVfDlkQT
        kTPMVNuArMLhntMALOwyAg7ZWmEb4lMrnF8oDp619yvNyGrKlf1fzBNjFso6FgVn
        GPU2FB6ASlg8fv3UhOpkMfZYz/S0o6yndsH5EUUlQKTAUPWkvJ3TxrA/WQSLgNw5
        hYgtvH0F94VbRRd7CVpNylc9NNKqDTnBP1VPnDBTw==
X-ME-Proxy: <xmx:cK9iW4_dn7P3aQWa1gvDleLIQNeFs6RWR-v5WHJ3B5jWtGwK51Ymhg>
    <xmx:cK9iW-gsYGJBeybx-utjqaaMC30xJpok_9hl6G-q8PT3ciOiO5Ev-g>
    <xmx:cK9iW-4NDgKWJdZfv_FqNIxLC6EEirqByCPNQPm22avRE5yT28cUBg>
    <xmx:cK9iWzbJvxIuF5wKduMnPbi9IEKPglJiXLnTIGG8qUFcLKbyy5Jwnw>
    <xmx:cK9iWzfn54NRPMsuUxf5Gpdu_NVQMqqT_PRs9n0OaVE3xvEiDatHgA>
    <xmx:ca9iW6AQWP2o-bxMb_F0dJvs-O-0BedxhqvbyrYTtaXfOJuva81NRQ>
X-ME-Sender: <xms:b69iW6JiTVkdVNGOCUjlVJ6ZE-TSLvaBMBciBjOl5CTEqSmCwaIzbw>
Received: from localhost (d57e6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8230F1026B;
        Thu,  2 Aug 2018 03:14:55 -0400 (EDT)
Date:   Thu, 2 Aug 2018 09:14:54 +0200
From:   Greg KH <greg@kroah.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <chao@kernel.org>
Subject: Re: linux-next: build failure after merge of the staging tree
Message-ID: <20180802071453.GA25644@kroah.com>
References: <20180730161622.3837cb15@canb.auug.org.au>
 <559c49b8-9d58-e242-20c2-fe1b491664dd@huawei.com>
 <7152b6ba-9ad6-4a9c-3b13-2d5310266ccd@huawei.com>
 <20180802061518.GD3272@kroah.com>
 <78a6edc0-fd04-1750-d860-3c068fa1b67d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78a6edc0-fd04-1750-d860-3c068fa1b67d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 03:01:59PM +0800, Chao Yu wrote:
> Hi Greg,
> 
> On 2018/8/2 14:15, Greg KH wrote:
> > On Wed, Aug 01, 2018 at 05:09:13PM +0800, Chao Yu wrote:
> >> Hi Stephen,
> >>
> >> On 2018/7/30 14:31, Gao Xiang wrote:
> >>> Hi Stephen,
> >>>
> >>> On 2018/7/30 14:16, Stephen Rothwell wrote:
> >>>> Hi Greg,
> >>>>
> >>>> After merging the staging tree, today's linux-next build (x86_64
> >>>> allmodconfig) failed like this:
> >>>>
> >>>> drivers/staging/erofs/super.c: In function 'erofs_read_super':
> >>>> drivers/staging/erofs/super.c:343:17: error: 'MS_RDONLY' undeclared (first use in this function); did you mean 'IS_RDONLY'?
> >>>>   sb->s_flags |= MS_RDONLY | MS_NOATIME;
> >>>>                  ^~~~~~~~~
> >>>>                  IS_RDONLY
> >>>> drivers/staging/erofs/super.c:343:17: note: each undeclared identifier is reported only once for each function it appears in
> >>>> drivers/staging/erofs/super.c:343:29: error: 'MS_NOATIME' undeclared (first use in this function); did you mean 'S_NOATIME'?
> >>>>   sb->s_flags |= MS_RDONLY | MS_NOATIME;
> >>>>                              ^~~~~~~~~~
> >>>>                              S_NOATIME
> >>>> drivers/staging/erofs/super.c: In function 'erofs_mount':
> >>>> drivers/staging/erofs/super.c:501:10: warning: passing argument 5 of 'mount_bdev' makes integer from pointer without a cast [-Wint-conversion]
> >>>>    &priv, erofs_fill_super);
> >>>>           ^~~~~~~~~~~~~~~~
> >>>> In file included from include/linux/buffer_head.h:12:0,
> >>>>                  from drivers/staging/erofs/super.c:14:
> >>>> include/linux/fs.h:2151:23: note: expected 'size_t {aka long unsigned int}' but argument is of type 'int (*)(struct super_block *, void *, int)'
> >>>>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
> >>>>                        ^~~~~~~~~~
> >>>> drivers/staging/erofs/super.c:500:9: error: too few arguments to function 'mount_bdev'
> >>>>   return mount_bdev(fs_type, flags, dev_name,
> >>>>          ^~~~~~~~~~
> >>>> In file included from include/linux/buffer_head.h:12:0,
> >>>>                  from drivers/staging/erofs/super.c:14:
> >>>> include/linux/fs.h:2151:23: note: declared here
> >>>>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
> >>>>                        ^~~~~~~~~~
> >>>> drivers/staging/erofs/super.c: At top level:
> >>>> drivers/staging/erofs/super.c:518:20: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
> >>>>   .mount          = erofs_mount,
> >>>>                     ^~~~~~~~~~~
> >>>> drivers/staging/erofs/super.c:518:20: note: (near initialization for 'erofs_fs_type.mount')
> >>>> drivers/staging/erofs/super.c: In function 'erofs_remount':
> >>>> drivers/staging/erofs/super.c:630:12: error: 'MS_RDONLY' undeclared (first use in this function); did you mean 'IS_RDONLY'?
> >>>>   *flags |= MS_RDONLY;
> >>>>             ^~~~~~~~~
> >>>>             IS_RDONLY
> >>>> drivers/staging/erofs/super.c: At top level:
> >>>> drivers/staging/erofs/super.c:640:16: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
> >>>>   .remount_fs = erofs_remount,
> >>>>                 ^~~~~~~~~~~~~
> >>>>
> >>>> Caused by various commits creating erofs in the staging tree interacting
> >>>> with various commits redoing the mount infrastructure in the vfs tree.
> >>>>
> >>>> I have disabed CONFIG_EROFS_FS for now:
> >>
> >> Xiang has submitted several patches as below to fix compiling error on -next
> >> tree, could you consider to merge those temporary fixes into -next after merging
> >> staging-next's updates, and reenable CONFIG_EROFS_FS for further integrity
> >> compiling and test?
> >>
> >> staging: erofs: fix superblock/inode flags (MS_RDONLY -> SB_RDONLY, S_NOATIME)
> >> https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000282.html
> >>
> >> staging: erofs: remove RADIX_TREE_EXCEPTIONAL_{ENTRY, SHIFT}
> >> https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000283.html
> >>
> >> staging: erofs: update .mount and .remount_sb
> >> https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000285.html
> > 
> > Why have these not been submitted to me for inclusion in my tree?
> Oh, let me explain, that is because the compiling error only occurs in -next
> tree, since -next collects and merges developing patches including common vfs
> stuff from multi-trees, but those patches didn't cover erofs, such as:
> 
> ('vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled")
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=109b45090d7d3ce2797bb1ef7f70eead5bfe0ff3
> 
> ("vfs: Require specification of size of mount data for internal mounts")
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=0a191e4505a4f255e6513b49426213da69bf0e80
> 
> As I checked, above vfs related patches has not been merged in staging tree, if
> I submit those erofs patches to you and after including them in
> staging-{test,nexts} tree, it can easily cause compiling error. So I just send
> them to Stephen first for fixing integrity compiling error.
> 
> Then I'd like to ask how to handle this condition to avoid potential conflict in
> between erofs and vfs changes during merging window. As Stephen suggested, we
> can disabling CONFIG_EROFS_FS temporarily to pass merge window, and after that
> we reenable CONFIG_EROFS_FS and apply those fixing patches.

Ok, doing that will work.

> I'd like to ask and make sure, do you agree that we can handle the condition by
> this way? or do you have any suggestion about solving this issue?

This is a side affect of being in the staging tree only at this point in
time.  It will get easier once things get merged correctly.

thanks,

greg k-h
