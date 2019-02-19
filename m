Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E56C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE55217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfBSCty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:49:54 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48798 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbfBSCtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:49:53 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2353679DB71B2FDBEBE3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 10:49:51 +0800 (CST)
Received: from [127.0.0.1] (10.57.71.8) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 10:49:08 +0800
Subject: Re: possible deadlock in console_unlock
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <ebc01f4f-5b1d-4f8a-1d0d-463d5218ee45@huawei.com>
 <20190216072127.GA1945@tigerII.localdomain>
 <20190216073856.GA9979@tigerII.localdomain>
 <71b097a7-03c5-8a65-76fa-24312b452b51@huawei.com>
 <20190218054649.GA26686@jagdpanzerIV>
 <3fece106-baed-92f6-1389-62b8f2c4578b@huawei.com>
 <20190219013254.GA20023@jagdpanzerIV>
From:   Yao HongBo <yaohongbo@huawei.com>
Message-ID: <bf816f3a-d975-193e-93c8-9931ad0dad71@huawei.com>
Date:   Tue, 19 Feb 2019 10:48:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190219013254.GA20023@jagdpanzerIV>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.71.8]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/2019 9:32 AM, Sergey Senozhatsky wrote:
> On (02/18/19 22:07), Yao HongBo wrote:
>>>> I have tried GFP_NOWARN, but the problem still exists.
>>>> Only print_safe contexts for tty locks can solve the problem.
>>>> My test scenario is falt-injection.
>>>
>>> Oh, I see. Yes, fault-injection is special.
>>>
>>> I suspect that this patch series can be helpful then
>>> https://lore.kernel.org/lkml/20181016050428.17966-1-sergey.senozhatsky@gmail.com/T/#u
>>
>> hi, sergey.
> 
> Hello,
> 
>> I merged this patch series on linux-4.19.18, but it didn't work for the fault-injection cases.
> 
> Thanks!
> 
>> The failure seems to be the same as before.
> 
> OK... So tty_port lock must switch to printk_safe, after all...
> I had it in one of the previous versions of the patchset which you
> have tested, but people were strictly against new locking rules
> in TTY, so I dropped that part. Need to think what we can do here.
> 
> BTW,
> we are now looking at a completely new printk implementation; which
> would not use printk_safe at all:
> https://lore.kernel.org/lkml/20190212143003.48446-1-john.ogness@linutronix.de/T/#u

Ok, i understand it.
Anyway, thank you for your help.
Best regards,
Hongbo.

> 	-ss
> 
> 

