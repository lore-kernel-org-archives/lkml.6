Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeDLBef (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 21:34:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39113 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbeDLBed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 21:34:33 -0400
X-Google-Smtp-Source: AIpwx4/Te17K10OzP5YUZNRyh7e7X0NiGXhJ9PUNoP6bD362/qxMZd2O5Ruhlbe5QHUIVLszvdmVBA==
Subject: Re: [PATCH 1/3] mmc: wbsd: Replace mdelay with usleep_range in
 wbsd_init
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pierre Ossman <pierre@ossman.eu>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1523414803-2626-1-git-send-email-baijiaju1990@gmail.com>
 <CAPDyKFq4hL6TRaovv9O1NLXBmd7QJQcuVGmc5kSO3Na-2gcT1g@mail.gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <13f0f859-0331-c770-80ba-bc332b32582f@gmail.com>
Date: Thu, 12 Apr 2018 09:34:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq4hL6TRaovv9O1NLXBmd7QJQcuVGmc5kSO3Na-2gcT1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/4/11 23:04, Ulf Hansson wrote:
> On 11 April 2018 at 04:46, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>> wbsd_init() is never called in atomic context.
>>
>> The call chains ending up at wbsd_init() are:
>> [1] wbsd_init() <- wbsd_probe()
>> [2] wbsd_init() <- wbsd_pnp_probe()
>>
>> wbsd_probe() is set as ".probe" in struct platform_driver.
>> wbsd_pnp_probe() is set as ".probe" in struct pnp_driver.
>> These functions are not called in atomic context.
>>
>> Despite never getting called from atomic context, wbsd_init()
>> calls mdelay() to busily wait.
>> This is not necessary and can be replaced with usleep_range() to
>> avoid busy waiting.
>>
>> This is found by a static analysis tool named DCNS written by myself.
>> And I also manually check it.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> The patch is good, however I think you should squash all three in this
> series into one. For obvious reasons.

Hello, Ulf.
Thanks for your reply and advice :)
I will follow it in my future patches.


Best wishes,
Jia-Ju Bai
