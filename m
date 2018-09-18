Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35192C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E214D21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E214D21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeIRSxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:53:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728718AbeIRSxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:53:38 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DBD581F922905;
        Tue, 18 Sep 2018 21:20:58 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 18 Sep
 2018 21:20:53 +0800
Subject: Re: [PATCH 0/8] staging: erofs: error handing and more tracepoints
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     <devel@driverdev.osuosl.org>, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        <linux-erofs@lists.ozlabs.org>
References: <1536936030-62362-1-git-send-email-gaoxiang25@huawei.com>
 <20180918111953.GA3585@kroah.com>
 <aab26d0e-f8dc-cc83-46eb-7a93a833eaae@huawei.com>
 <20180918121413.GA499@kroah.com>
 <e940cdaf-faeb-7f60-b5ca-5f4d6af450be@huawei.com>
 <20180918130337.jtq6ziqp6efr3fq4@mwanda> <20180918130911.GA16187@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <173c5e62-6e4f-066c-5526-afd12c53c051@huawei.com>
Date:   Tue, 18 Sep 2018 21:20:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180918130911.GA16187@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/18 21:09, Greg Kroah-Hartman wrote:
> On Tue, Sep 18, 2018 at 04:03:37PM +0300, Dan Carpenter wrote:
>> On Tue, Sep 18, 2018 at 08:31:22PM +0800, Gao Xiang wrote:
>>> (I have no clang environment to build kernel yet... :( I will try later, but I have no idea why it happens,
>>> and it seems a false warning).
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>>
>>>> Or is gcc just being "dumb" here?  What about clang, have you tried
>>>> building it with that compiler as well?
>>
>> Yeah.  Gcc is wrong.  Gcc used to be extra conservative and missed a
>> bunch of bugs, but I guess now they're going in to opposite direction?
>>
>> Smatch gets this correct, but you have to rebuild the cross function DB
>> twice to make the warning go away.  It could be because it starts out
>> with the old vle_get_logical_extent_head() information so it thinks it
>> knows how that function works.

Hi Dan,
Thanks for taking time to confirm this and the detailed explanation ;)

> 
> Ok, thanks for checking (both of you).  Just initialize the variable to
> keep gcc from printing foolish warnings.

Hi Greg,

Ok, if you don't tend to use `uninitialized_var(...)', I will initialize a 
dumb value...but I think it is really useless to initialize it... :(

I will resend the related false warning patch independently soon...

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
> 
