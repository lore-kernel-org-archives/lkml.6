Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF53C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A9021533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5bRd7aB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A9021533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbeITUQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727633AbeITUQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:16:04 -0400
Received: from [192.168.0.101] (unknown [117.62.222.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2364021531;
        Thu, 20 Sep 2018 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537453938;
        bh=8+dYL2qbHngWEQxEZTonAdohTYNw6EU9KAAeMHeS9dE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=i5bRd7aBOw++DK96nszW4c2P9jycdvxbyd9fZMs/FEUJ8fCc7ensPvV/VDeyspx2w
         dxpIYE2BInc0K7eG7AEPoo0G7+qm6h8VR7+Goti+g+J6QTuQIiQvoXkd39Cz8rJ3pn
         aA4QM2bhuTnp51ybAPuJ8cS1w6bDC6NrE22jP+po=
Subject: Re: [PATCH] jfs: remove redundant dquot_initialize() in
 jfs_evict_inode()
To:     Dave Kleikamp <dave.kleikamp@oracle.com>,
        Chao Yu <yuchao0@huawei.com>,
        "open list:JFS FILESYSTEM" <jfs-discussion@lists.sourceforge.net>,
        open list <linux-kernel@vger.kernel.org>
References: <20180917071221.13187-1-yuchao0@huawei.com>
 <be3a41fb-9a83-19a8-b3da-ca91500471fc@kernel.org>
 <d6360818-2808-d5a6-119d-97cb506b7d15@oracle.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <aa505360-1d45-58c1-6ecf-3897799d6a04@kernel.org>
Date:   Thu, 20 Sep 2018 22:32:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d6360818-2808-d5a6-119d-97cb506b7d15@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/20 22:24, Dave Kleikamp wrote:
> On 9/20/18 9:18 AM, Chao Yu wrote:
>> Ping,
>>
>> Any comments?
> 
> Sorry for putting it off. It looks good to me. I'll push it upstream.

Thanks for your review. ;)

Thanks,

> 
> Thanks,
> Dave
> 
>>
>> On 2018/9/17 15:12, Chao Yu wrote:
>>> We don't need to call dquot_initialize() twice in jfs_evict_inode(),
>>> remove one of them for cleanup.
>>>
>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>> ---
>>>  fs/jfs/inode.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
>>> index 054cc761b426..805ae9e8944a 100644
>>> --- a/fs/jfs/inode.c
>>> +++ b/fs/jfs/inode.c
>>> @@ -166,7 +166,6 @@ void jfs_evict_inode(struct inode *inode)
>>>  			/*
>>>  			 * Free the inode from the quota allocation.
>>>  			 */
>>> -			dquot_initialize(inode);
>>>  			dquot_free_inode(inode);
>>>  		}
>>>  	} else {
>>>
