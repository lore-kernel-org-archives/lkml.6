Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919B8C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 12:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4936F217C7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 12:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4936F217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeHEPEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 11:04:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726159AbeHEPEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 11:04:10 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9AAD434399CF5;
        Sun,  5 Aug 2018 20:59:34 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Sun, 5 Aug 2018
 20:59:34 +0800
Message-ID: <5B66F4B5.8030908@huawei.com>
Date:   Sun, 5 Aug 2018 20:59:33 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4/mballoc: Remove unneeded variable "err"
References: <1533380696-16325-1-git-send-email-zhongjiang@huawei.com> <20180804212426.GE4461@thunk.org>
In-Reply-To: <20180804212426.GE4461@thunk.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/5 5:24, Theodore Y. Ts'o wrote:
> On Sat, Aug 04, 2018 at 07:04:56PM +0800, zhong jiang wrote:
>> The err is not used after initalization. So just remove the variable.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> I'll apply this patch, but how did you generate the diff?  The
> function name here is all wrong:
>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 8b24d3d..e29fce2 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -3801,7 +3801,6 @@ static int ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>                                    ^^^^^^^^^^^^^^^^^^^^^^^^^
>
> The lines in question are from ext4_mb_release_inode_pa(), *not*
> ext4_mb_new_preallocation().  So when I inspected the patch visually,
> my first reaction was, "there's no way this patch would apply".
>
> But then I looked at the C code changed by the patch, and I was
> surprised to see that it applied correctly in a completely different
> function, and when I regenerated the patch, the line numbers matched
> yours --- so the only thing "wrong" in your patch is the function name.
>
> So that raises the question --- how did you create the diff in this-rc
> patch?  What version of git?  And what version of the kernel?
>
> Regards,
>
> 					- Ted
>
> .
>
 I  create the diff in this patch again ,but get the same result .  the git version is git version 1.7.12.4
 but I create  the diff in git version 1.8.3.1. It shows the correct function name.

The kernel version is  4.18-rc7.   I will upgrade the git version.

Thanks,
zhong jiang

