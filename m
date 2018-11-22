Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8846AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F70320672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F70320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395001AbeKVXk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:40:56 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15133 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732044AbeKVXk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:40:56 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A85B19060B560;
        Thu, 22 Nov 2018 21:01:34 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 22 Nov
 2018 21:01:30 +0800
Subject: Re: [PATCH 07/10] staging: erofs: separate into init_once / always
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-8-gaoxiang25@huawei.com>
 <20181122102339.GG3189@kroah.com>
 <66b90226-5d0e-7344-5220-908aa243b014@huawei.com>
 <20181122110500.GC5287@kroah.com>
 <ef49bf11-b937-46b4-1b9a-c068182aa7d9@huawei.com>
 <20181122112645.GA7527@kroah.com>
 <448b2d41-8156-3fe8-a037-29a31771721e@huawei.com>
Message-ID: <c6ec315b-6f80-911f-3abe-ee056e730fc9@huawei.com>
Date:   Thu, 22 Nov 2018 21:01:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <448b2d41-8156-3fe8-a037-29a31771721e@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/11/22 20:00, Gao Xiang wrote:
> Hi Greg,
> 
> On 2018/11/22 19:26, Greg Kroah-Hartman wrote:
>> Don't make people rebuild your code with different options for
>> debugging.  That will never work in the 'real world' when people start
>> using the code.  You need to have things enabled for people all the
>> time, which is why we have dynamic debugging in the kernel now, and not
>> a zillion different "DRIVER_DEBUG" build options anymore.
> Actually, current erofs handle differently for beta users (in eng mode)
> and commercial users.
> 
> CONFIG_EROFS_FS_DEBUG is enable for all beta users, after an observed
> expression is false, we could get the whole memorydump as early as possible.
> But for commercial users, there are no such observing points to promise
> the kernel stability and performance.
> 
> It has helped us to find several bug, and I cannot find some alternative way
> to get the the first scene of the accident...

I'm about to send v2 of this patchset... I need to get your opinion...

I think for the current erofs development state, I tend to leave such a
developping switch because the code could be modified frequently,
many potential bugs could be avoid when this debugging mode is on and
it will be dropped after erofs becomes more stable...

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
