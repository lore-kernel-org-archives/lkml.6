Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E37C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 01:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1591D2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 01:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1591D2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeJPJWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 05:22:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36369 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726946AbeJPJWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 05:22:09 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 25683F7D31A45;
        Tue, 16 Oct 2018 09:34:14 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Tue, 16 Oct 2018
 09:34:10 +0800
Subject: Re: [PATCH 2/2] f2fs: update REQ_TIME in f2fs_cross_rename()
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Sahitya Tummala <stummala@codeaurora.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1538716660-31572-1-git-send-email-stummala@codeaurora.org>
 <1538716660-31572-2-git-send-email-stummala@codeaurora.org>
 <fa825846-ba41-31d2-c819-476e9245b7a8@huawei.com>
 <20181015230357.GA1296@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <93a29c62-8115-607c-5b69-a506c9b9a3a1@huawei.com>
Date:   Tue, 16 Oct 2018 09:34:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015230357.GA1296@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/16 7:03, Jaegeuk Kim wrote:
> On 10/15, Chao Yu wrote:
>> On 2018/10/5 13:17, Sahitya Tummala wrote:
>>> Update REQ_TIME in the missing path - f2fs_cross_rename().
>>
>> Needs to cover f2fs_rename() as well?
> 
> Hi, I've added this in f2fs_rename().

Oh, I see, it looks okay to me now. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>> ---
>>>  fs/f2fs/namei.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>>> index a146327..e37af23 100644
>>> --- a/fs/f2fs/namei.c
>>> +++ b/fs/f2fs/namei.c
>>> @@ -1154,6 +1154,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>>>  
>>>  	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
>>>  		f2fs_sync_fs(sbi->sb, 1);
>>> +
>>> +	f2fs_update_time(sbi, REQ_TIME);
>>>  	return 0;
>>>  out_new_dir:
>>>  	if (new_dir_entry) {
>>>
> 
> .
> 

