Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A76C282D7
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 02:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02622084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 02:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfBCCww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 21:52:52 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55894 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726738AbfBCCwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 21:52:51 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D0DAF18BF9BC35BB3B68;
        Sun,  3 Feb 2019 10:52:48 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Sun, 3 Feb 2019
 10:52:37 +0800
Subject: Re: [PATCH v2 2/2] staging: erofs: complete POSIX ACL support
To:     Dan Carpenter <dan.carpenter@oracle.com>, Chao Yu <chao@kernel.org>
CC:     Gao Xiang <gaoxiang25@huawei.com>, <devel@driverdev.osuosl.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, <linux-erofs@lists.ozlabs.org>
References: <20190125161007.4447-1-gaoxiang25@huawei.com>
 <20190125161007.4447-2-gaoxiang25@huawei.com>
 <94daa491-40c8-4a09-a0b5-55a7e92dc3fc@huawei.com>
 <20190128133302.GI1795@kadam>
 <f1fd2c69-0c5b-c655-3712-48169e87fff8@huawei.com>
 <1eed1e6b-f95e-aa8e-c3e7-e9870401ee23@kernel.org>
 <20190128183053.GK1795@kadam>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <16373e83-2496-3bf5-7b16-72f3454d294d@huawei.com>
Date:   Sun, 3 Feb 2019 10:52:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190128183053.GK1795@kadam>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay due to business travel.

On 2019/1/29 2:30, Dan Carpenter wrote:
> On Tue, Jan 29, 2019 at 12:41:55AM +0800, Chao Yu wrote:
>> Hi Dan and Xiang,
>>
>> On 2019-1-28 21:48, Gao Xiang wrote:
>>> Hi Dan,
>>>
>>> On 2019/1/28 21:33, Dan Carpenter wrote:
>>>> Hopefully, regular kmalloc() is enough.
>>>>
>>>> Do really need the erofs_kmalloc() function?  Regular kmalloc() has
>>>> fault injection already.  Have you tried to use it?
>>
>> Yes, I think we'd better to use erofs_kmalloc(). :)
>>
>> Actually, fault injection in erofs_kmalloc only affect erofs module, we can
>> expect that the range of fault can be limited in erofs code, rather than whole
>> kernel, so the test point can be aimed at more accurately.
>>
> 
> Are you serious?  The standard fault injection doesn't do that???

Oh, I just realized the common fault injection can inject into specified
module with function granularity, sorry.

> 
> Please fix it instead of creating a duplicate better implementation
> which only your filesystem can use.  I would have thought that obviously

I agreed that it will be good to make common fault injection better,
covering more cases, so that it can benefit all modules which need fault
injection functionality. But rather than injecting kmalloc, there will be
other injection demands from erofs/f2fs, like injecting in the middle of
their specified function, how could we do that? Could you give us advice?

Thanks,

> any fault injection framework could at least be configured to test
> specific code...
> 
> regards,
> dan carpenter
> 
> 
> .
> 

