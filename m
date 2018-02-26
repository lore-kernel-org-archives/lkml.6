Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeBZBfC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 20:35:02 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51272 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751918AbeBZBe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 20:34:59 -0500
Subject: Re: [V9fs-developer] [PATCH] fs/9p: don't set SB_NOATIME by default
To: Andrew Morton <akpm@linux-foundation.org>
References: <5A7D3C08.7020309@huawei.com> <5A90D23F.5070601@huawei.com>
CC: <v9fs-developer@lists.sourceforge.net>, <viro@zeniv.linux.org.uk>,
        <ericvh@gmail.com>, <rminnich@sandia.gov>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>, "Greg Kurz" <groug@kaod.org>
From: jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5A936439.9040700@huawei.com>
Date: Mon, 26 Feb 2018 09:34:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <5A90D23F.5070601@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/2/24 10:47, jiangyiwen wrote:
> On 2018/2/9 14:13, jiangyiwen wrote:
>> User use some syscall, for example mmap(v9fs_file_mmap), it will not
>> update atime even if user's mnt_flags have MNT_NOATIME, because
>> v9fs default set SB_NOATIME in v9fs_set_super.
>>
>> For supporting access time is updated when user mount with relatime,
>> we should clear SB_NOATIME by default.
>>
>> Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
>> ---
>>  fs/9p/vfs_super.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
>> index af03c2a..48ce504 100644
>> --- a/fs/9p/vfs_super.c
>> +++ b/fs/9p/vfs_super.c
>> @@ -94,7 +94,7 @@ static int v9fs_set_super(struct super_block *s, void *data)
>>  	if (v9ses->cache)
>>  		sb->s_bdi->ra_pages = (VM_MAX_READAHEAD * 1024)/PAGE_SIZE;
>>
>> -	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC | SB_NOATIME;
>> +	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC;
>>  	if (!v9ses->cache)
>>  		sb->s_flags |= SB_SYNCHRONOUS;
>>
> Hi Alexander Viro and Eric,
> 
> My patch has already sent two weeks, but nobody help me
> to review, I have a question about now who is the v9fs's
> maintainer? Or who can help me review the patch?
> 
> I hope v9fs's maintainer can give me some advices or
> merge into the mainline if it has no problem.
> 
> Thanks,
> Yiwen.
> 
Hi Andrew,

My patch has already sent more than two weeks, but nobody
help me to review, I have a question about now who is the
v9fs's maintainer? Or who can help me review the patch?

I hope v9fs's maintainer can give me some advices or
merge into the mainline if it has no problem.

Thanks,
Yiwen.
