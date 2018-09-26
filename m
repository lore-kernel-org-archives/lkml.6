Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4280C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A42C20684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A42C20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeIZUgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:36:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13128 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727399AbeIZUgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:36:36 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CAF9F94A3D599;
        Wed, 26 Sep 2018 22:23:19 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Wed, 26 Sep 2018
 22:23:17 +0800
Message-ID: <5BAB9655.6080100@huawei.com>
Date:   Wed, 26 Sep 2018 22:23:17 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>, <sameo@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] NFC: st-nci: remove a redundant null pointer check
References: <1537965050-16579-1-git-send-email-zhongjiang@huawei.com> <20180926140311.GU15943@smile.fi.intel.com>
In-Reply-To: <20180926140311.GU15943@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/26 22:03, Andy Shevchenko wrote:
> On Wed, Sep 26, 2018 at 08:30:50PM +0800, zhong jiang wrote:
>> The dev is impossible is NULL. hence the check is redundant. We
>> never will hit it.
>>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks.
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>> v1->v2:
>>  -  According to Greg's suggestion. just remove the null pointer will be better.
>>
>>  drivers/nfc/st-nci/spi.c | 7 -------
>>  1 file changed, 7 deletions(-)
>>
>> diff --git a/drivers/nfc/st-nci/spi.c b/drivers/nfc/st-nci/spi.c
>> index 1470559..864fd90 100644
>> --- a/drivers/nfc/st-nci/spi.c
>> +++ b/drivers/nfc/st-nci/spi.c
>> @@ -233,13 +233,6 @@ static int st_nci_spi_probe(struct spi_device *dev)
>>  	dev_dbg(&dev->dev, "%s\n", __func__);
>>  	dev_dbg(&dev->dev, "IRQ: %d\n", dev->irq);
>>  
>> -	/* Check SPI platform functionnalities */
>> -	if (!dev) {
>> -		pr_debug("%s: dev is NULL. Device is not accessible.\n",
>> -			__func__);
>> -		return -ENODEV;
>> -	}
>> -
>>  	phy = devm_kzalloc(&dev->dev, sizeof(struct st_nci_spi_phy),
>>  			   GFP_KERNEL);
>>  	if (!phy)
>> -- 
>> 1.7.12.4
>>


