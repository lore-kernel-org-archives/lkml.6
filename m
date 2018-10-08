Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D29C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5344E2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5344E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeJHWOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:14:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbeJHWOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:14:35 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 48AE4134D9C3C;
        Mon,  8 Oct 2018 23:02:21 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 8 Oct 2018
 23:02:12 +0800
Subject: Re: [PATCH v2] staging: erofs: add SPDX identifer
To:     =?UTF-8?Q?lo=c3=afc_tourlonias?= <loic.tourlonias@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>,
        <linux-erofs@lists.ozlabs.org>, <yuchao0@huawei.com>,
        <loic.tourlonias.lkml@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20181008141409.2624-1-loic.tourlonias.lkml@gmail.com>
 <20181008142228.GB13359@kroah.com>
 <e9620bf6-5f3f-108d-b9f1-91af1ad603d6@huawei.com>
 <20181008144335.GA15968@kroah.com>
 <a460f98f-d566-1d9d-b395-e8604519b442@huawei.com>
 <CA+XxOSG+cJ3FZ4S7qcRWWDcktDpStuoa7nTuAUOr+U-uTTUcYg@mail.gmail.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <c65f81ba-a411-1444-effc-7b8cfb0b53b1@huawei.com>
Date:   Mon, 8 Oct 2018 23:02:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CA+XxOSG+cJ3FZ4S7qcRWWDcktDpStuoa7nTuAUOr+U-uTTUcYg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,

On 2018/10/8 23:00, loïc tourlonias wrote:
> Hi Gao,
> On Mon, Oct 8, 2018 at 4:48 PM Gao Xiang <gaoxiang25@huawei.com> wrote:
>>
>> Hi Greg,
>>
>> On 2018/10/8 22:43, Greg Kroah-Hartman wrote:
>>> On Mon, Oct 08, 2018 at 10:36:39PM +0800, Gao Xiang wrote:
>>>> Hi Greg,
>>>>
>>>> On 2018/10/8 22:22, Greg Kroah-Hartman wrote:
>>>>> Why delete that line?
>>>>>
>>>>> But wait, why do we even have this file at all?  What's wrong with the
>>>>> lib/lz4/ code that we have in the kernel today?  Shouldn't the code
>>>>> using these files be moved over to use the lib/ code instead and this
>>>>> file be deleted?
>>>>
>>>> EROFS uses customized LZ4 decompression code for now (which has been offically
>>>> supported in lz4 1.8.3, I have updated it in
>>>> https://ozlabs.org/~akpm/mmots/broken-out/lib-lz4-update-lz4-decompressor-module.patch
>>>> if it is shown up in Linux 4.20, I will remove all the customized LZ4 decompression code),
>>>> but lib/ code lz4def.h isn't export to include/.
>>>
>>> It should show up in 4.20, so you should be able to remove this all
>>> then.
>>
>> Yes, that is correct. I will fix it in 4.20 if the updated LZ4 is already there. :)
> 
> So no need to update the patch since the file will be removed. Am I correct?
> 
> Too bad, I'll make my first patch later... ^^

I think you could make the patch if you want :)
It is up to Greg whether take this patch or not since it is actually a cleanup attempt.

I will also do more cleanups beside my current work, yet EROFS is now busy in productization.

Thanks,
Gao Xiang

> 
> Thanks
> Loic
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
