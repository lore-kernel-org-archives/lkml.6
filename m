Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5041C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E45320C0B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E45320C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeHBJiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:38:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbeHBJiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:38:50 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7C57BEAF9A918;
        Thu,  2 Aug 2018 15:48:50 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Thu, 2 Aug 2018
 15:48:43 +0800
Subject: Re: linux-next: build failure after merge of the staging tree
To:     Greg KH <greg@kroah.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Linux-Next Mailing List" <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <chao@kernel.org>
References: <20180730161622.3837cb15@canb.auug.org.au>
 <559c49b8-9d58-e242-20c2-fe1b491664dd@huawei.com>
 <7152b6ba-9ad6-4a9c-3b13-2d5310266ccd@huawei.com>
 <20180802061518.GD3272@kroah.com>
 <78a6edc0-fd04-1750-d860-3c068fa1b67d@huawei.com>
 <20180802071453.GA25644@kroah.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b23a8a97-d9c2-6973-8c55-52bedee8d258@huawei.com>
Date:   Thu, 2 Aug 2018 15:48:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802071453.GA25644@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/2 15:14, Greg KH wrote:
> On Thu, Aug 02, 2018 at 03:01:59PM +0800, Chao Yu wrote:
>> Hi Greg,
>>
>> On 2018/8/2 14:15, Greg KH wrote:
>>> On Wed, Aug 01, 2018 at 05:09:13PM +0800, Chao Yu wrote:
>>>> Hi Stephen,
>>>>
>>>> On 2018/7/30 14:31, Gao Xiang wrote:
>>>>> Hi Stephen,
>>>>>
>>>>> On 2018/7/30 14:16, Stephen Rothwell wrote:
>>>>>> Hi Greg,
>>>>>>
>>>>>> After merging the staging tree, today's linux-next build (x86_64
>>>>>> allmodconfig) failed like this:
>>>>>>
>>>>>> drivers/staging/erofs/super.c: In function 'erofs_read_super':
>>>>>> drivers/staging/erofs/super.c:343:17: error: 'MS_RDONLY' undeclared (first use in this function); did you mean 'IS_RDONLY'?
>>>>>>   sb->s_flags |= MS_RDONLY | MS_NOATIME;
>>>>>>                  ^~~~~~~~~
>>>>>>                  IS_RDONLY
>>>>>> drivers/staging/erofs/super.c:343:17: note: each undeclared identifier is reported only once for each function it appears in
>>>>>> drivers/staging/erofs/super.c:343:29: error: 'MS_NOATIME' undeclared (first use in this function); did you mean 'S_NOATIME'?
>>>>>>   sb->s_flags |= MS_RDONLY | MS_NOATIME;
>>>>>>                              ^~~~~~~~~~
>>>>>>                              S_NOATIME
>>>>>> drivers/staging/erofs/super.c: In function 'erofs_mount':
>>>>>> drivers/staging/erofs/super.c:501:10: warning: passing argument 5 of 'mount_bdev' makes integer from pointer without a cast [-Wint-conversion]
>>>>>>    &priv, erofs_fill_super);
>>>>>>           ^~~~~~~~~~~~~~~~
>>>>>> In file included from include/linux/buffer_head.h:12:0,
>>>>>>                  from drivers/staging/erofs/super.c:14:
>>>>>> include/linux/fs.h:2151:23: note: expected 'size_t {aka long unsigned int}' but argument is of type 'int (*)(struct super_block *, void *, int)'
>>>>>>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
>>>>>>                        ^~~~~~~~~~
>>>>>> drivers/staging/erofs/super.c:500:9: error: too few arguments to function 'mount_bdev'
>>>>>>   return mount_bdev(fs_type, flags, dev_name,
>>>>>>          ^~~~~~~~~~
>>>>>> In file included from include/linux/buffer_head.h:12:0,
>>>>>>                  from drivers/staging/erofs/super.c:14:
>>>>>> include/linux/fs.h:2151:23: note: declared here
>>>>>>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
>>>>>>                        ^~~~~~~~~~
>>>>>> drivers/staging/erofs/super.c: At top level:
>>>>>> drivers/staging/erofs/super.c:518:20: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>>>>>>   .mount          = erofs_mount,
>>>>>>                     ^~~~~~~~~~~
>>>>>> drivers/staging/erofs/super.c:518:20: note: (near initialization for 'erofs_fs_type.mount')
>>>>>> drivers/staging/erofs/super.c: In function 'erofs_remount':
>>>>>> drivers/staging/erofs/super.c:630:12: error: 'MS_RDONLY' undeclared (first use in this function); did you mean 'IS_RDONLY'?
>>>>>>   *flags |= MS_RDONLY;
>>>>>>             ^~~~~~~~~
>>>>>>             IS_RDONLY
>>>>>> drivers/staging/erofs/super.c: At top level:
>>>>>> drivers/staging/erofs/super.c:640:16: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>>>>>>   .remount_fs = erofs_remount,
>>>>>>                 ^~~~~~~~~~~~~
>>>>>>
>>>>>> Caused by various commits creating erofs in the staging tree interacting
>>>>>> with various commits redoing the mount infrastructure in the vfs tree.
>>>>>>
>>>>>> I have disabed CONFIG_EROFS_FS for now:
>>>>
>>>> Xiang has submitted several patches as below to fix compiling error on -next
>>>> tree, could you consider to merge those temporary fixes into -next after merging
>>>> staging-next's updates, and reenable CONFIG_EROFS_FS for further integrity
>>>> compiling and test?
>>>>
>>>> staging: erofs: fix superblock/inode flags (MS_RDONLY -> SB_RDONLY, S_NOATIME)
>>>> https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000282.html
>>>>
>>>> staging: erofs: remove RADIX_TREE_EXCEPTIONAL_{ENTRY, SHIFT}
>>>> https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000283.html
>>>>
>>>> staging: erofs: update .mount and .remount_sb
>>>> https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000285.html
>>>
>>> Why have these not been submitted to me for inclusion in my tree?
>> Oh, let me explain, that is because the compiling error only occurs in -next
>> tree, since -next collects and merges developing patches including common vfs
>> stuff from multi-trees, but those patches didn't cover erofs, such as:
>>
>> ('vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled")
>> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=109b45090d7d3ce2797bb1ef7f70eead5bfe0ff3
>>
>> ("vfs: Require specification of size of mount data for internal mounts")
>> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=0a191e4505a4f255e6513b49426213da69bf0e80
>>
>> As I checked, above vfs related patches has not been merged in staging tree, if
>> I submit those erofs patches to you and after including them in
>> staging-{test,nexts} tree, it can easily cause compiling error. So I just send
>> them to Stephen first for fixing integrity compiling error.
>>
>> Then I'd like to ask how to handle this condition to avoid potential conflict in
>> between erofs and vfs changes during merging window. As Stephen suggested, we
>> can disabling CONFIG_EROFS_FS temporarily to pass merge window, and after that
>> we reenable CONFIG_EROFS_FS and apply those fixing patches.
> 
> Ok, doing that will work.
> 
>> I'd like to ask and make sure, do you agree that we can handle the condition by
>> this way? or do you have any suggestion about solving this issue?
> 
> This is a side affect of being in the staging tree only at this point in
> time.  It will get easier once things get merged correctly.

Yeah, that's correct, so let me send one patch to disable CONFIG_EROFS_FS
temporarily. :)

Thanks,

> 
> thanks,
> 
> greg k-h
> 
> .
> 

