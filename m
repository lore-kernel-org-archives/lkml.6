Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8808AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1377214F0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1377214F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbeHPEZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 00:25:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52070 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725925AbeHPEZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 00:25:18 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A139DD41308AB;
        Thu, 16 Aug 2018 09:30:23 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Thu, 16 Aug 2018
 09:30:20 +0800
Message-ID: <5B74D3AB.8010605@huawei.com>
Date:   Thu, 16 Aug 2018 09:30:19 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     <alcooperx@gmail.com>, <kishon@ti.com>, <robh@kernel.org>,
        <hauke@hauke-m.de>, <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] phy:phy-brcm-us: Use PTR_ERR_OR_ZERO to replace the
 open code
References: <1534159486-25008-1-git-send-email-zhongjiang@huawei.com> <1534159486-25008-2-git-send-email-zhongjiang@huawei.com> <7ba3b0be-4538-87a1-15f4-f2cbc6e12e66@gmail.com>
In-Reply-To: <7ba3b0be-4538-87a1-15f4-f2cbc6e12e66@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/16 7:23, Florian Fainelli wrote:
> On 08/13/2018 04:24 AM, zhong jiang wrote:
>> PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR, So
>> just replace them rather than duplicating its implement.
> Subject should be:
>
> phy: phy-brcm-usb: Use PTR_ERR_OR_ZERO to replace open coded version
 Thank you for tips. It is my mistake.:-[

 Sincerely,
 zhong jiang
> Thank you
>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/phy/broadcom/phy-brcm-usb.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
>> index d1dab36..f59b1dc 100644
>> --- a/drivers/phy/broadcom/phy-brcm-usb.c
>> +++ b/drivers/phy/broadcom/phy-brcm-usb.c
>> @@ -372,10 +372,8 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
>>  	clk_disable(priv->usb_30_clk);
>>  
>>  	phy_provider = devm_of_phy_provider_register(dev, brcm_usb_phy_xlate);
>> -	if (IS_ERR(phy_provider))
>> -		return PTR_ERR(phy_provider);
>>  
>> -	return 0;
>> +	return PTR_ERR_OR_ZERO(phy_provider);
>>  }
>>  
>>  #ifdef CONFIG_PM_SLEEP
>>
>


