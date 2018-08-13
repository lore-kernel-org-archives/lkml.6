Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EEAC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41782154D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41782154D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbeHMOPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:15:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42052 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728661AbeHMOPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:15:14 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 971494346645B;
        Mon, 13 Aug 2018 19:33:18 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Mon, 13 Aug 2018
 19:33:15 +0800
Message-ID: <5B716C79.8060809@huawei.com>
Date:   Mon, 13 Aug 2018 19:33:13 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>, NeilBrown <neil@brown.name>,
        <peter.vernia@gmail.com>, <oliver.huebers@web.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging:pci-mt7621: Use PTR_ERR_OR_ZERO to replace the
 open code
References: <1534157699-23637-1-git-send-email-zhongjiang@huawei.com> <CAMhs-H9+FBfjvtYb0ehoAz7hHaaoKiO6-Ypmb+q-aXRO-xYG6Q@mail.gmail.com>
In-Reply-To: <CAMhs-H9+FBfjvtYb0ehoAz7hHaaoKiO6-Ypmb+q-aXRO-xYG6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/13 19:26, Sergio Paracuellos wrote:
> On Mon, Aug 13, 2018 at 12:54 PM, zhong jiang <zhongjiang@huawei.com> wrote:
>> PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR, So
>> just replace them rather than duplicating its implement.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/staging/mt7621-pci/pci-mt7621.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
>> index a49e279..9a8ff1d 100644
>> --- a/drivers/staging/mt7621-pci/pci-mt7621.c
>> +++ b/drivers/staging/mt7621-pci/pci-mt7621.c
>> @@ -403,10 +403,8 @@ static int mt7621_pcie_parse_dt(struct mt7621_pcie *pcie)
>>         }
>>
>>         pcie->base = devm_ioremap_resource(dev, &regs);
>> -       if (IS_ERR(pcie->base))
>> -               return PTR_ERR(pcie->base);
>>
>> -       return 0;
>> +       return PTR_ERR_OR_ZERO(pcie->base);
>>  }
> Hi Zhong,
>
> Thanks for this. This driver is in the middle of cleanup and this
> function is not doing all the DT parse
> yet, so this patch looks good but after applying this series (if they
> work and are good enough to be applied)
> has no sense.
>
> See: http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-August/124890.html
>
> Best regards,
>     Sergio Paracuellos
Thank you for let me know that.

Sincerely,
zhong jiang
>>  static int mt7621_pcie_request_resources(struct mt7621_pcie *pcie,
>> --
>> 1.7.12.4
>>
> .
>


