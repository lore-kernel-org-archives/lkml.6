Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A584C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70EF205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70EF205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbeIFGlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:41:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbeIFGlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:41:14 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EE962FAB2895D;
        Thu,  6 Sep 2018 10:08:13 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 6 Sep 2018
 10:08:06 +0800
Subject: Re: [PATCH] Revert "staging: erofs: disable compiling temporarile"
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, <weidu.du@huawei.com>,
        <linux-erofs@lists.ozlabs.org>
References: <1535427588-69630-1-git-send-email-gaoxiang25@huawei.com>
 <20180828054444.GA4453@kroah.com>
 <0c701b3c-5553-cf4c-c0b3-ad151b84662c@huawei.com>
 <f12ae5df-3130-f293-5863-3d9ff0802e92@huawei.com>
 <20180828130559.GA5427@kroah.com>
 <16974cb6-2eed-7c12-9e27-c65a32b81673@huawei.com>
 <20180829094403.3a3bf19b@canb.auug.org.au>
 <20180906092504.282d5f62@canb.auug.org.au>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <3f6be9d2-d7ed-2bfa-13af-d020270dc13b@huawei.com>
Date:   Thu, 6 Sep 2018 10:06:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180906092504.282d5f62@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, Al,

On 2018/9/6 7:25, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 29 Aug 2018 09:44:03 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> On Tue, 28 Aug 2018 22:13:02 +0800 Chao Yu <yuchao0@huawei.com> wrote:
>>>
>>> On 2018/8/28 21:05, Greg Kroah-Hartman wrote:  
>>>> On Tue, Aug 28, 2018 at 04:56:43PM +0800, Chao Yu wrote:    
>>>>>
>>>>> On 2018/8/28 14:28, Gao Xiang wrote:    
>>>>>>
>>>>>> On 2018/8/28 13:44, Greg Kroah-Hartman wrote:    
>>>>>>> On Tue, Aug 28, 2018 at 11:39:48AM +0800, Gao Xiang wrote:    
>>>>>>>> This reverts commit 156c3df8d4db4e693c062978186f44079413d74d.
>>>>>>>>
>>>>>>>> Since XArray and the new mount apis aren't merged in 4.19-rc1
>>>>>>>> merge window, the BROKEN mark can be reverted directly without
>>>>>>>> any problems.
>>>>>>>>
>>>>>>>> Fixes: 156c3df8d4db ("staging: erofs: disable compiling temporarile")
>>>>>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>>>>>> Cc: David Howells <dhowells@redhat.com>
>>>>>>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>>>>>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> Hi Greg,
>>>>>>>>
>>>>>>>>  Could you please apply this patch to enable EROFS from 4.19-rc2, thanks...
>>>>>>>>
>>>>>>>>  p.s. We would like to provide a more stable EROFS when linux-4.19 is out,
>>>>>>>>       and there are also two patchsets (the one is already sent out by Chao
>>>>>>>>       and me, the other is previewing in linux-erofs mailing list and it will
>>>>>>>>       be sent out after gathering enough testdata and feedback from community
>>>>>>>>       and carefully reviewed), could you also please consider applying these
>>>>>>>>       two patchsets in the later 4.19-rc (both >2, or the first patchset
>>>>>>>>       could be in rc2 in advance) if it is convenient to do so, or the next
>>>>>>>>       4.20 is also ok...
>>>>>>>>
>>>>>>>>  LINK: https://lore.kernel.org/lkml/20180821144937.20555-1-chao@kernel.org/
>>>>>>>>        https://lore.kernel.org/lkml/1535076160-99466-1-git-send-email-gaoxiang25@huawei.com/    
>>>>>>>
>>>>>>> I applied those patch sets to my -next branch already, right?  So those    
>>>>>>
>>>>>> Yes, Thank you for applying those patches. :)
>>>>>>    
>>>>>>> would be going into 4.20-rc1, it is time now for "bugfixes only" for
>>>>>>> 4.19-final.
>>>>>>>
>>>>>>> So perhaps we should just leave it as "BROKEN" for now for 4.19 and add
>>>>>>> this to my tree now and let people work on it for the next few months in    
>>>>>
>>>>> I'm worry about that once we plan to reenable erofs in next x.xx-rc1, in the
>>>>> merge window, if there are any other features change common api or structure in
>>>>> vfs/mm/block, but related patch didn't cover erofs, that would make conflict
>>>>> with erofs.
>>>>>
>>>>> So if that happens, we can just reminder them to cover erofs? or we should
>>>>> handle this by just delay removing 'BROKEN' state?
>>>>>
>>>>> Thanks,
>>>>>    
>>>>>>> linux-next so that 4.20 has a solid base to start with?
>>>>>>>    
>>>>>>
>>>>>> EROFS is be marked as "BROKEN" just because of conflict with
>>>>>> XArray and the new mount apis, as Stephen Rothwell suggested in
>>>>>>
>>>>>> https://lore.kernel.org/lkml/20180802010705.24a72730@canb.auug.org.au/
>>>>>>    
>>>>>>> It might be easiest for Greg to add the disabling CONFIG_EROFS_FS patch
>>>>>>> to the staging tree itself for his first pull request during the merge
>>>>>>> window and then send a second pull request (after the vfs and maybe the
>>>>>>> Xarray stuff has been merged by Linus) with these patches followed by a
>>>>>>> revert of the disabling patch.    
>>>>>>
>>>>>> But these two features was still discussing in the mailing list even at the
>>>>>> last time of 4.19-rc1 merge window. I cannot decide whether they were eventually
>>>>>> get merged in 4.19 or not. But it seems that it is regretful that linux-4.19
>>>>>> is out without XArray and the new mount apis.
>>>>>>
>>>>>> Therefore, I think EROFS should work for linux-4.19 without any modification
>>>>>> if just revert the BROKEN mark.    
>>>>
>>>> Ok, you are right, I'll go apply this.
>>>>     
>>>>>> EROFS works fine with the 4.19-rc1 code except that it has some __GFP_NOFAIL
>>>>>> and BUG_ONs on error handling paths and very rarely race between memory
>>>>>> reclaiming and decompression... :( I personally think it is complete enough
>>>>>> for people to test since it is an independent and staging filesystem driver (no
>>>>>> other influence...) Anyway, removing EROFS BROKEN mark at 4.20 is also ok of course...
>>>>>>
>>>>>> On the other head, if XArray and the new mount apis is still pending for 4.20,
>>>>>> should EROFS uses the same policy as Stephen suggested? I have no idea how to do next...    
>>>>
>>>> As the code is now part of the common tree that everyone works off of,
>>>> any filesystem changes that happen will normally cover erofs as well.
>>>> So this shouldn't be an issue anymore.    
>>>
>>> Thanks very much for the help and explanation, we will keep an eye on those vfs
>>> changes. :)  
>>
>> Unfortunately, those vfs changes are still in the vfs tree in
>> linux-next and cause a build failure in the erofs code.  I have
>> disabled the build of erofs again for today.
>>
>> Dave, Al, it would be good if you could add a patch/revise the series
>> that adds the necessary erofs changes.
> 
> I still have to disable erofs .....
> 

Is there some plan to fix erofs in the new mount-api patchset?
Or should I send erofs patches based on the dhowells/mount-api branch? and could you please help review and merge them?

Thanks in advance.

Thanks,
Gao Xiang
