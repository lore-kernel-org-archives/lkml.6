Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965597AbeCACut (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 21:50:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5689 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965520AbeCACur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 21:50:47 -0500
Subject: Re: [PATCH] f2fs: fix to restore whint_mode in ->remount_fs
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20180228140120.8758-1-chao@kernel.org>
 <20180301024515.GB18665@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <7b8a2429-974d-e6d0-f5cc-9bd12a09ebf9@huawei.com>
Date: Thu, 1 Mar 2018 10:54:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180301024515.GB18665@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

On 2018/3/1 10:45, Jaegeuk Kim wrote:
> On 02/28, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> If we fail in ->remount_fs, it needs to restore old whint_mode as other
>> mount options.
>>
>> Fixes: e25afe01822f ("f2fs: support passing down write hints given by users to block layer")
> 
> Hi Chao,
> 
> It was not merged, so please allow me to integrate this into the original
> patch.

No problem, please go ahead. ;)

Thanks,

> 
> Thanks,
> 
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/super.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 89abe4087e66..8a93f78efca2 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1512,6 +1512,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>  		sbi->s_qf_names[i] = s_qf_names[i];
>>  	}
>>  #endif
>> +	sbi->whint_mode = old_whint_mode;
>>  	sbi->mount_opt = org_mount_opt;
>>  	sbi->active_logs = active_logs;
>>  	sb->s_flags = old_sb_flags;
>> -- 
>> 2.14.1.145.gb3622a4ee
> 
> .
> 
