Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44052C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0617219C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0617219C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeHFEqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:46:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10667 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726408AbeHFEqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:46:53 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4125D3E0CD75D;
        Mon,  6 Aug 2018 10:39:57 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Mon, 6 Aug 2018
 10:39:54 +0800
Message-ID: <5B67B4FB.4080405@huawei.com>
Date:   Mon, 6 Aug 2018 10:39:55 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Joe Perches <joe@perches.com>
CC:     <clm@fb.com>, <jbacik@fb.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] fs/btrfs/disk-io: Remove unneeded variable "err"
References: <1533481371-21349-1-git-send-email-zhongjiang@huawei.com>  <1533481371-21349-2-git-send-email-zhongjiang@huawei.com> <5b2806ada98cfca4346e48f1943aca6da0cda4a6.camel@perches.com>
In-Reply-To: <5b2806ada98cfca4346e48f1943aca6da0cda4a6.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/5 23:27, Joe Perches wrote:
> On Sun, 2018-08-05 at 23:02 +0800, zhong jiang wrote:
>> The err is not used after initalization, So remove it and make
>> the function to be void function.
> []
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> []
>> @@ -4193,7 +4192,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
>>  	if (atomic_read(&delayed_refs->num_entries) == 0) {
>>  		spin_unlock(&delayed_refs->lock);
>>  		btrfs_info(fs_info, "delayed_refs has NO entry");
>> -		return ret;
> Think a little more about this please.
> This is not a sensible removal.
 I am sorry for stupid mistake.  I  will repost.

Thanks,
zhong jiang
>>  	}
>>  
>>  	while ((node = rb_first(&delayed_refs->href_root)) != NULL) {
>
> .
>


