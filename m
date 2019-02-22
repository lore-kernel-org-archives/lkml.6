Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07782C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C123F207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfBVB3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 20:29:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfBVB3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 20:29:22 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B2B63B253EADBC8A8A83;
        Fri, 22 Feb 2019 09:29:20 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 22 Feb
 2019 09:29:14 +0800
Subject: Re: [PATCH] staging/erofs: fix sparse's warnings on undeclared
 symbols in erofs
To:     <yuzibode@126.com>
References: <20190221142845.13604-1-tsu.yubo@gmail.com>
 <05254fc6-6bd7-7c30-cfcc-2ddff4ac13b6@huawei.com>
 <20190222005753.eibd4zj62askcuad@yubo-2>
CC:     <yuchao0@huawei.com>, <gregkh@linuxfoundation.org>,
        <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        "fangwei (I)" <fangwei1@huawei.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <b1f9747b-3276-8139-2997-24836c37bdb8@huawei.com>
Date:   Fri, 22 Feb 2019 09:28:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190222005753.eibd4zj62askcuad@yubo-2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/2/22 8:57, YU Bo wrote:
> Hi,
> On Thu, Feb 21, 2019 at 10:35:01PM +0800, Gao Xiang wrote:
>> Hi Bo,
>>
>> On 2019/2/21 22:28, Bo YU wrote:
>>> From: Bo Yu <tsu.yubo@gmail.com>
>>>
>>> Fix sparse warnings:
>>>
>>> drivers/staging/erofs/utils.c:134:6: warning: symbol
>>> 'erofs_try_to_release_workgroup' was not declared. Should it be static?
>>>
>>> Fixes: 51232df5e4b26("staging: erofs: fix race when the managed cache is enabled")
>>> Cc: Gao Xiang <gaoxiang25@huawei.com>
>>> Cc: Chao Yu <yuchao0@huawei.com>
>>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
>>> ---
>>>  drivers/staging/erofs/utils.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
>>> index b535898ca753..33cd5ad55cb8 100644
>>> --- a/drivers/staging/erofs/utils.c
>>> +++ b/drivers/staging/erofs/utils.c
>>> @@ -131,7 +131,7 @@ static void erofs_workgroup_unfreeze_final(struct erofs_workgroup *grp)
>>>      __erofs_workgroup_free(grp);
>>>  }
>>>
>>> -bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
>>> +static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
>>>                      struct erofs_workgroup *grp,
>>>                      bool cleanup)
>>>  {
>>>
>>
>> Have you looked the latest kernel code?
> Emm...yeah.But i pulled linus tree not staging tree :(
> Sorry for the noise.

That is ok. staging tree or linux-next includes the latest source code,
you can check them out :)

Thanks,
Gao Xiang

> 
>> It seems erofs_try_to_release_workgroup is already be claimed as static...
>>
>> See:
>> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/erofs/utils.c?h=staging-next#n148
>>
>> Thanks,
>> Gao Xiang
>>
