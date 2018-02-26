Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeBZF2i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 00:28:38 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40231 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbeBZF2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 00:28:35 -0500
X-Google-Smtp-Source: AH8x227QqQ98RukVZv4uzjHinPOCSRUA+6sklNq71V5SXYvXEHQTvjZ4vYuReOxMlUPW0wQGDicwCg==
Date: Mon, 26 Feb 2018 00:28:31 -0500
From: Bo YU <tsu.yubo@gmail.com>
To: jiangyiwen <jiangyiwen@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        v9fs-developer@lists.sourceforge.net, viro@zeniv.linux.org.uk,
        ericvh@gmail.com, rminnich@sandia.gov, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
        Greg Kurz <groug@kaod.org>
Subject: Re: [V9fs-developer] [PATCH] fs/9p: don't set SB_NOATIME by default
Message-ID: <20180226052831.GA26535@yubo-2>
References: <5A7D3C08.7020309@huawei.com>
 <5A90D23F.5070601@huawei.com>
 <5A936439.9040700@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <5A936439.9040700@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I think you would better to modify the subject line without
[V9fs-developers].
On Mon, Feb 26, 2018 at 09:34:49AM +0800, jiangyiwen wrote:
>On 2018/2/24 10:47, jiangyiwen wrote:
>> On 2018/2/9 14:13, jiangyiwen wrote:
>>> User use some syscall, for example mmap(v9fs_file_mmap), it will not
>>> update atime even if user's mnt_flags have MNT_NOATIME, because
>>> v9fs default set SB_NOATIME in v9fs_set_super.
>>>
>>> For supporting access time is updated when user mount with relatime,
>>> we should clear SB_NOATIME by default.
>>>
>>> Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
>>> ---
>>>  fs/9p/vfs_super.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
>>> index af03c2a..48ce504 100644
>>> --- a/fs/9p/vfs_super.c
>>> +++ b/fs/9p/vfs_super.c
>>> @@ -94,7 +94,7 @@ static int v9fs_set_super(struct super_block *s, void *data)
>>>  	if (v9ses->cache)
>>>  		sb->s_bdi->ra_pages = (VM_MAX_READAHEAD * 1024)/PAGE_SIZE;
>>>
>>> -	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC | SB_NOATIME;
>>> +	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC;
>>>  	if (!v9ses->cache)
>>>  		sb->s_flags |= SB_SYNCHRONOUS;
>>>
>> Hi Alexander Viro and Eric,
>>
>> My patch has already sent two weeks, but nobody help me
>> to review, I have a question about now who is the v9fs's
>> maintainer? Or who can help me review the patch?
>>
>> I hope v9fs's maintainer can give me some advices or
>> merge into the mainline if it has no problem.
>>
>> Thanks,
>> Yiwen.
>>
>Hi Andrew,
>
>My patch has already sent more than two weeks, but nobody
>help me to review, I have a question about now who is the
>v9fs's maintainer? Or who can help me review the patch?
>
There is no maintainer with V9fs  in get_maintain.pl and V9fs git tree
laterest commit before two years.so,situation become bad.
Maybe you eamil linus directly,although this is't good
>I hope v9fs's maintainer can give me some advices or
>merge into the mainline if it has no problem.
>
>Thanks,
>Yiwen.
>
>--
>To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
