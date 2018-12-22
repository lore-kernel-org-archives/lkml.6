Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D747DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 00:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6962173B
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 00:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393038AbeLWA3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 19:29:36 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50025 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387711AbeLWA3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 19:29:36 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8D2425AE94266;
        Sat, 22 Dec 2018 16:43:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.33.43) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Sat, 22 Dec 2018
 16:43:22 +0800
Subject: Re: [PATCH] debugfs: remove no need inc_nlink
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20181222034111.15214-1-yangerkun@huawei.com>
 <20181222073205.GA21053@kroah.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <16b85779-5939-eff9-72a4-eb1e6159b2e4@huawei.com>
Date:   Sat, 22 Dec 2018 16:43:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181222073205.GA21053@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.33.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Greg KH wrote on 2018/12/22 15:32:
> On Sat, Dec 22, 2018 at 11:41:11AM +0800, yangerkun wrote:
>> Remove inc_nlink in debugfs_create_automount, or this inode will never
>> be free.
>>
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> ---
>>   fs/debugfs/inode.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
>> index 13b0135..9e6e225 100644
>> --- a/fs/debugfs/inode.c
>> +++ b/fs/debugfs/inode.c
>> @@ -516,8 +516,6 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
>>   	inode->i_op = &simple_dir_inode_operations;
>>   	inode->i_fop = &simple_dir_operations;
>>   
>> -	/* directory inodes start off with i_nlink == 2 (for "." entry) */
>> -	inc_nlink(inode);
> 
> Really?  How did you test this and why does removing this line directly
> go against what the comment says?
So sorry for this, the fuction should be modify is 
debugfs_create_automount. Patch will coming soon.

Thanks,
Kun.

> 
> this feels really wrong...
> 
> greg k-h
> 
> .
> 

