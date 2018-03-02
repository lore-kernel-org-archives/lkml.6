Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164185AbeCBCPy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 21:15:54 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54252 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163939AbeCBCPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 21:15:52 -0500
Subject: Re: [Ocfs2-devel] [PATCH] Correct a comment error
To: Changwei Ge <ge.changwei@h3c.com>, Larry Chen <lchen@suse.com>,
        "mfasheh@versity.com" <mfasheh@versity.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>
References: <20180228101720.20725-1-lchen@suse.com>
 <5A97F88E.4010303@huawei.com>
 <63ADC13FD55D6546B7DECE290D39E373F292C0FC@H3CMLB12-EX.srv.huawei-3com.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
From: piaojun <piaojun@huawei.com>
Message-ID: <5A98B3BB.3040408@huawei.com>
Date: Fri, 2 Mar 2018 10:15:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <63ADC13FD55D6546B7DECE290D39E373F292C0FC@H3CMLB12-EX.srv.huawei-3com.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Changwei,

On 2018/3/2 9:59, Changwei Ge wrote:
> Hi Jun,
> I think the comments for both two functions are OK.
> No need to rework them.
> As we know, ocfs2 lock name(lock id) are composed of several parts including 
> block number.
I looked though the comments involved 'lockid', and found 'lockid' is a
concept in dlm level, so ocfs2 level should not be aware of it.

thanks,
Jun
> 
> Thanks,
> Changw2ei
> 
> On 2018/3/1 20:58, piaojun wrote:
>> Hi Larry,
>>
>> There is the same mistake in ocfs2_reflink_inodes_lock(), could you help
>> fixing them all?
>>
>> thanks,
>> Jun
>>
>> On 2018/2/28 18:17, Larry Chen wrote:
>>> The function ocfs2_double_lock tries to lock the inode with lower
>>> blockid first, not lockid.
>>>
>>> Signed-off-by: Larry Chen <lchen@suse.com>
>>> ---
>>>   fs/ocfs2/namei.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
>>> index c801eddc4bf3..30d454de35a8 100644
>>> --- a/fs/ocfs2/namei.c
>>> +++ b/fs/ocfs2/namei.c
>>> @@ -1133,7 +1133,7 @@ static int ocfs2_double_lock(struct ocfs2_super *osb,
>>>   	if (*bh2)
>>>   		*bh2 = NULL;
>>>   
>>> -	/* we always want to lock the one with the lower lockid first.
>>> +	/* we always want to lock the one with the lower blockid first.
>>>   	 * and if they are nested, we lock ancestor first */
>>>   	if (oi1->ip_blkno != oi2->ip_blkno) {
>>>   		inode1_is_ancestor = ocfs2_check_if_ancestor(osb, oi2->ip_blkno,
>>>
>>
>> _______________________________________________
>> Ocfs2-devel mailing list
>> Ocfs2-devel@oss.oracle.com
>> https://oss.oracle.com/mailman/listinfo/ocfs2-devel
>>
> .
> 
