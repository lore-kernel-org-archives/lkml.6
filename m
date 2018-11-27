Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F471C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC4E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC4E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeK0OJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 09:09:07 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57036 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727784AbeK0OJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 09:09:06 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AA0F6C6A2FB9F;
        Tue, 27 Nov 2018 11:12:41 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Tue, 27 Nov 2018
 11:12:41 +0800
Subject: Re: [PATCH] f2fs: read page index before freeing
To:     PanBian <bianpan2016@163.com>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1542884326-74903-1-git-send-email-bianpan2016@163.com>
 <3ebe6814-586e-77e8-52fa-47fb61d760f5@huawei.com> <20181126102841.GA94853@bp>
 <f8957864-fd65-6c45-de07-9e94459bed52@huawei.com>
 <20181127002247.GA109273@bp>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <28fc6dc0-6f91-1551-57bb-769dc18b9f7b@huawei.com>
Date:   Tue, 27 Nov 2018 11:12:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181127002247.GA109273@bp>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/27 8:22, PanBian wrote:
> On Mon, Nov 26, 2018 at 07:07:08PM +0800, Chao Yu wrote:
>> On 2018/11/26 18:28, PanBian wrote:
>>> On Mon, Nov 26, 2018 at 05:13:53PM +0800, Chao Yu wrote:
>>>> Hi Pan,
>>>>
>>>> On 2018/11/22 18:58, Pan Bian wrote:
>>>>> The function truncate_node frees the page with f2fs_put_page. However,
>>>>> the page index is read after that. So, the patch reads the index before
>>>>> freeing the page.
>>>>
>>>> I notice that you found another use-after-free bug in ext4, out of
>>>> curiosity, I'd like to ask how do you find those bugs? by tool or code review?
>>>
>>> I found such bugs by the aid of a tool I wrote recently. I designed a method 
>>> to automatically find paired alloc/free functions. With such functions, I
>>> wrote two checkers, one to check mismatched alloc/free bugs, the other to
>>> check use-after-free and double-free bugs.
>>
>> Excellent! Do you have any plan to open its source or announce it w/ binary
>> to linux kernel developers, I think w/ it we can help to improve kernel's
>> code quality efficiently.
> 
> Yes. I am now writing a paper about the method. I will open the source code
> as soon as I complete the paper and some optimizations.

Cool, if there is any progress, please let f2fs guys know, thank you in
advance. :)

Thanks,

> 
> Best,
> Pan
> 
> 
> .
> 

