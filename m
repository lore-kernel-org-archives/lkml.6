Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeBKGQa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 01:16:30 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46632 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750787AbeBKGQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 01:16:29 -0500
Subject: Re: [PATCH] f2fs: set_code_data in move_data_block
To: Chao Yu <yuchao0@huawei.com>, <jaegeuk@kernel.org>, <chao@kernel.org>,
        <yunlong.song@icloud.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1518093217-123705-1-git-send-email-yunlong.song@huawei.com>
 <a55bc2f7-fc46-4f4a-cb30-d6eb61b30785@huawei.com>
 <520ce370-daa0-0654-3992-be01e8d82607@huawei.com>
From: Yunlong Song <yunlong.song@huawei.com>
Message-ID: <8856fc96-03a8-b2d8-8639-512ba2ecb893@huawei.com>
Date: Sun, 11 Feb 2018 14:15:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <520ce370-daa0-0654-3992-be01e8d82607@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.111.220.140]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, Got it.

On 2018/2/11 11:50, Chao Yu wrote:
> On 2018/2/11 11:34, Yunlong Song wrote:
>> Ping...
>>
>> move_data_block misses set_cold_data, then the F2FS_WB_CP_DATA will
>> lack these data pages in move_data_block, and write_checkpoint can
>> not make sure this pages committed to the flash.
> 
> Hmm.. data block migration is running based on meta inode, so it will
> be safe since checkpoint will flush all meta pages including encrypted
> pages cached in meta inode?
> 
> Thanks,
> 
>>
>> On 2018/2/8 20:33, Yunlong Song wrote:
>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>> ---
>>>    fs/f2fs/gc.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index b9d93fd..2095630 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -692,6 +692,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>>    	fio.op = REQ_OP_WRITE;
>>>    	fio.op_flags = REQ_SYNC;
>>>    	fio.new_blkaddr = newaddr;
>>> +	set_cold_data(fio.page);
>>>    	err = f2fs_submit_page_write(&fio);
>>>    	if (err) {
>>>    		if (PageWriteback(fio.encrypted_page))
>>>
>>
> 
> 
> .
> 

-- 
Thanks,
Yunlong Song
