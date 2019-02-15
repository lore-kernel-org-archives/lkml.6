Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5BEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0672A206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404985AbfBOJb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:31:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727555AbfBOJb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:31:27 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2C723EC645EF888B6F92;
        Fri, 15 Feb 2019 17:31:24 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Fri, 15 Feb 2019
 17:31:13 +0800
Subject: Re: [PATCH v2 2/2] staging: erofs: complete POSIX ACL support
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Chao Yu <chao@kernel.org>, <devel@driverdev.osuosl.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
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
 <f08c49d2-c3c1-4b80-f61c-004f911086d8@huawei.com>
 <20190215073644.GD2326@kadam>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <388add9e-8643-b08f-2eec-9742c5411cc0@huawei.com>
Date:   Fri, 15 Feb 2019 17:31:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190215073644.GD2326@kadam>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/15 15:36, Dan Carpenter wrote:
> On Fri, Feb 15, 2019 at 10:10:34AM +0800, Chao Yu wrote:
>> Hi Dan,
>>
>> Any suggestion?
>>
> 
> I won't NAK whatever you decide.  But my opinion is that you should
> just use normal kernel memory allocators even though it means you have
> to use two different fault injection frameworks.

Thanks for the suggestion.

There is only one injection type in erofs injection framework, I don't want
to remove all framework codes with kmalloc type, so I think we can do this
step by step:
a. use erofs_kamloc to keep all codes consistent.
b. add at least one erofs private injection type.
c. remove erofs_kmalloc and related type.

> 
> Over time it would be good to improve and expand the standard kernel
> error injection frameworks to cover more types.

Agreed.

Thanks,

> 
> regards,
> dan carpenter
> 
> 
> 

