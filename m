Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4EBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45918218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbfBRMKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:10:20 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730631AbfBRMKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:10:20 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5F67B3F4A3668C11CFFE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 20:10:17 +0800 (CST)
Received: from [127.0.0.1] (10.57.71.8) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Feb 2019
 20:10:09 +0800
Subject: Re: possible deadlock in console_unlock
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <ebc01f4f-5b1d-4f8a-1d0d-463d5218ee45@huawei.com>
 <20190216072127.GA1945@tigerII.localdomain>
 <20190216073856.GA9979@tigerII.localdomain>
 <71b097a7-03c5-8a65-76fa-24312b452b51@huawei.com>
 <20190218054649.GA26686@jagdpanzerIV>
From:   Yao HongBo <yaohongbo@huawei.com>
Message-ID: <fd3c5c63-912c-a11f-9282-c46211c98521@huawei.com>
Date:   Mon, 18 Feb 2019 20:09:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190218054649.GA26686@jagdpanzerIV>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.71.8]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/2019 1:46 PM, Sergey Senozhatsky wrote:
> Hi,
> 
> On (02/16/19 15:59), Yao HongBo wrote:
>>> GFP_NOWARN is probably the best option for now. Yes, it, maybe,
>>> will not work for fault-injection cases; but printk_safe approach
>>> is harder to push for, especially given that printk_safe maybe will
>>> not even exist in the future.
>>
>> I have tried GFP_NOWARN, but the problem still exists.
>> Only print_safe contexts for tty locks can solve the problem.
>> My test scenario is falt-injection.
> 
> Oh, I see. Yes, fault-injection is special.
> 
> I suspect that this patch series can be helpful then
> https://lore.kernel.org/lkml/20181016050428.17966-1-sergey.senozhatsky@gmail.com/T/#u

ok, i'll try it.
Thanks.

> but first we need to figure out if printk_safe will
> stay in the kernel (this will take some time).
> 
> 	-ss
> 
> 

