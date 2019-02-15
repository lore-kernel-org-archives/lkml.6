Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A366AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712D3222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbfBOCKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:10:44 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38908 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390578AbfBOCKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:10:43 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 25F2EA09AADB702CD946;
        Fri, 15 Feb 2019 10:10:41 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Fri, 15 Feb 2019
 10:10:31 +0800
Subject: Re: [PATCH v2 2/2] staging: erofs: complete POSIX ACL support
From:   Chao Yu <yuchao0@huawei.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>, Chao Yu <chao@kernel.org>
CC:     <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-erofs@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20190125161007.4447-1-gaoxiang25@huawei.com>
 <20190125161007.4447-2-gaoxiang25@huawei.com>
 <94daa491-40c8-4a09-a0b5-55a7e92dc3fc@huawei.com>
 <20190128133302.GI1795@kadam>
 <f1fd2c69-0c5b-c655-3712-48169e87fff8@huawei.com>
 <1eed1e6b-f95e-aa8e-c3e7-e9870401ee23@kernel.org>
 <20190128183053.GK1795@kadam>
 <16373e83-2496-3bf5-7b16-72f3454d294d@huawei.com>
Message-ID: <f08c49d2-c3c1-4b80-f61c-004f911086d8@huawei.com>
Date:   Fri, 15 Feb 2019 10:10:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <16373e83-2496-3bf5-7b16-72f3454d294d@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Any suggestion?

On 2019/2/3 10:52, Chao Yu wrote:
> Sorry for the delay due to business travel.
> 
> On 2019/1/29 2:30, Dan Carpenter wrote:
>> On Tue, Jan 29, 2019 at 12:41:55AM +0800, Chao Yu wrote:
>>> Hi Dan and Xiang,
>>>
>>> On 2019-1-28 21:48, Gao Xiang wrote:
>>>> Hi Dan,
>>>>
>>>> On 2019/1/28 21:33, Dan Carpenter wrote:
>>>>> Hopefully, regular kmalloc() is enough.
>>>>>
>>>>> Do really need the erofs_kmalloc() function?  Regular kmalloc() has
>>>>> fault injection already.  Have you tried to use it?
>>>
>>> Yes, I think we'd better to use erofs_kmalloc(). :)
>>>
>>> Actually, fault injection in erofs_kmalloc only affect erofs module, we can
>>> expect that the range of fault can be limited in erofs code, rather than whole
>>> kernel, so the test point can be aimed at more accurately.
>>>
>>
>> Are you serious?  The standard fault injection doesn't do that???
> 
> Oh, I just realized the common fault injection can inject into specified
> module with function granularity, sorry.
> 
>>
>> Please fix it instead of creating a duplicate better implementation
>> which only your filesystem can use.  I would have thought that obviously
> 
> I agreed that it will be good to make common fault injection better,
> covering more cases, so that it can benefit all modules which need fault
> injection functionality. But rather than injecting kmalloc, there will be
> other injection demands from erofs/f2fs, like injecting in the middle of
> their specified function, how could we do that? Could you give us advice?
> 
> Thanks,
> 
>> any fault injection framework could at least be configured to test
>> specific code...
>>
>> regards,
>> dan carpenter
>>
>>
>> .
>>
> 
> 
> .
> 

