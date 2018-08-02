Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820B9C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43155208DA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43155208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeHBIBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:01:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10609 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbeHBIBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:01:45 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C434D3B7AB123;
        Thu,  2 Aug 2018 14:12:07 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Thu, 2 Aug 2018
 14:12:02 +0800
Subject: Re: linux-next: build failure after merge of the staging tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Gao Xiang <gaoxiang25@huawei.com>, Greg KH <greg@kroah.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Miao Xie <miaoxie@huawei.com>,
        Linus <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20180730161622.3837cb15@canb.auug.org.au>
 <559c49b8-9d58-e242-20c2-fe1b491664dd@huawei.com>
 <7152b6ba-9ad6-4a9c-3b13-2d5310266ccd@huawei.com>
 <20180802010705.24a72730@canb.auug.org.au>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fb9fb971-c607-c93e-d16f-16534edb8224@huawei.com>
Date:   Thu, 2 Aug 2018 14:12:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802010705.24a72730@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Sorry, yesterday I missed this email due to my email filter.

On 2018/8/1 23:07, Stephen Rothwell wrote:
> Hi Chao,
> 
> On Wed, 1 Aug 2018 17:09:13 +0800 Chao Yu <yuchao0@huawei.com> wrote:
>>
>> Xiang has submitted several patches as below to fix compiling error on -next
>> tree, could you consider to merge those temporary fixes into -next after merging
>> staging-next's updates, and reenable CONFIG_EROFS_FS for further integrity
>> compiling and test?
>>
>> staging: erofs: fix superblock/inode flags (MS_RDONLY -> SB_RDONLY, S_NOATIME)
>> https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000282.html
>>
>> staging: erofs: remove RADIX_TREE_EXCEPTIONAL_{ENTRY, SHIFT}
>> https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000283.html
>>
>> staging: erofs: update .mount and .remount_sb
>> https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000285.html
> 
> OK, I will apply those tomorrow (actually later today :-)) and and stop
> disabling CONFIG_EROFS_FS.

OK, thanks for doing that, I and Xiang will keep an eye on compile result.

> 
>> BTW, for this condition that erofs was not covered by some common vfs
>> stuff changes in other one's tree, who should take care of those
>> missing fixes during coming next merge window?
> 
> It might be easiest for Greg to add the disabling CONFIG_EROFS_FS patch
> to the staging tree itself for his first pull request during the merge
> window and then send a second pull request (after the vfs and maybe the
> Xarray stuff has been merged by Linus) with these patches followed by a
> revert of the disabling patch.

Thanks for the advice, I think that's a good way to solve the issue, let me send
a patch to disable erofs compiling temporarily to avoid conflict during merge
window. :)

Thanks,

> 

