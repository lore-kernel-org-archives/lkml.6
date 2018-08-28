Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C827DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A56208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A56208E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeH1KTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 06:19:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45983 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726994AbeH1KTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 06:19:09 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CD7FFE721F9DD;
        Tue, 28 Aug 2018 14:28:59 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 28 Aug
 2018 14:28:51 +0800
Subject: Re: [PATCH] Revert "staging: erofs: disable compiling temporarile"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>,
        Matthew Wilcox <willy@infradead.org>,
        "David Howells" <dhowells@redhat.com>,
        Chao Yu <yuchao0@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>
References: <1535427588-69630-1-git-send-email-gaoxiang25@huawei.com>
 <20180828054444.GA4453@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <0c701b3c-5553-cf4c-c0b3-ad151b84662c@huawei.com>
Date:   Tue, 28 Aug 2018 14:28:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180828054444.GA4453@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/8/28 13:44, Greg Kroah-Hartman wrote:
> On Tue, Aug 28, 2018 at 11:39:48AM +0800, Gao Xiang wrote:
>> This reverts commit 156c3df8d4db4e693c062978186f44079413d74d.
>>
>> Since XArray and the new mount apis aren't merged in 4.19-rc1
>> merge window, the BROKEN mark can be reverted directly without
>> any problems.
>>
>> Fixes: 156c3df8d4db ("staging: erofs: disable compiling temporarile")
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: David Howells <dhowells@redhat.com>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>>
>> Hi Greg,
>>
>>  Could you please apply this patch to enable EROFS from 4.19-rc2, thanks...
>>
>>  p.s. We would like to provide a more stable EROFS when linux-4.19 is out,
>>       and there are also two patchsets (the one is already sent out by Chao
>>       and me, the other is previewing in linux-erofs mailing list and it will
>>       be sent out after gathering enough testdata and feedback from community
>>       and carefully reviewed), could you also please consider applying these
>>       two patchsets in the later 4.19-rc (both >2, or the first patchset
>>       could be in rc2 in advance) if it is convenient to do so, or the next
>>       4.20 is also ok...
>>
>>  LINK: https://lore.kernel.org/lkml/20180821144937.20555-1-chao@kernel.org/
>>        https://lore.kernel.org/lkml/1535076160-99466-1-git-send-email-gaoxiang25@huawei.com/
> 
> I applied those patch sets to my -next branch already, right?  So those

Yes, Thank you for applying those patches. :)

> would be going into 4.20-rc1, it is time now for "bugfixes only" for
> 4.19-final.
> 
> So perhaps we should just leave it as "BROKEN" for now for 4.19 and add
> this to my tree now and let people work on it for the next few months in
> linux-next so that 4.20 has a solid base to start with?
> 

EROFS is be marked as "BROKEN" just because of conflict with
XArray and the new mount apis, as Stephen Rothwell suggested in

https://lore.kernel.org/lkml/20180802010705.24a72730@canb.auug.org.au/

> It might be easiest for Greg to add the disabling CONFIG_EROFS_FS patch
> to the staging tree itself for his first pull request during the merge
> window and then send a second pull request (after the vfs and maybe the
> Xarray stuff has been merged by Linus) with these patches followed by a
> revert of the disabling patch.

But these two features was still discussing in the mailing list even at the
last time of 4.19-rc1 merge window. I cannot decide whether they were eventually
get merged in 4.19 or not. But it seems that it is regretful that linux-4.19
is out without XArray and the new mount apis.

Therefore, I think EROFS should work for linux-4.19 without any modification
if just revert the BROKEN mark.

EROFS works fine with the 4.19-rc1 code except that it has some __GFP_NOFAIL
and BUG_ONs on error handling paths and very rarely race between memory
reclaiming and decompression... :( I personally think it is complete enough
for people to test since it is an independent and staging filesystem driver (no
other influence...) Anyway, removing EROFS BROKEN mark at 4.20 is also ok of course...

On the other head, if XArray and the new mount apis is still pending for 4.20,
should EROFS uses the same policy as Stephen suggested? I have no idea how to do next...


I would like to hear your and Chao's suggestions....Thanks in advance...

Thanks,
Gao Xiang

> thanks,
> 
> greg k-h
> 
