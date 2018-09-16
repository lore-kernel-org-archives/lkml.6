Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B19AECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 14:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F0F2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 14:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F0F2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeIPUTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 16:19:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40599 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726852AbeIPUTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 16:19:52 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7864B1A039B6;
        Sun, 16 Sep 2018 22:56:32 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Sun, 16 Sep 2018
 22:56:32 +0800
Message-ID: <5B9E6F1F.5030908@huawei.com>
Date:   Sun, 16 Sep 2018 22:56:31 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <kronos.it@gmail.com>, <jdelvare@suse.com>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: Use PTR_ERR_OR_ZERO instead of reimplementing
 its function
References: <20180916004318.GA30797@roeck-us.net>
In-Reply-To: <20180916004318.GA30797@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/16 8:43, Guenter Roeck wrote:
> On Tue, Sep 11, 2018 at 08:03:37PM +0800, zhong jiang wrote:
>> PTR_ERR_OR_ZERO has implemented the same function. We prefer to use
>> inlined function rather than code-opened implementation.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> Applied to hwmon-next. For future patches, please also refer to the
> affected driver in the Subject line, unless the change is in the
> subsystem core code.
Get it.  Thanks.

Sincerely,
zhong jiang
> Thanks,
> Guenter
>
>> ---
>>  drivers/hwmon/asus_atk0110.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
>> index a6636fe..a7cf008 100644
>> --- a/drivers/hwmon/asus_atk0110.c
>> +++ b/drivers/hwmon/asus_atk0110.c
>> @@ -1210,10 +1210,8 @@ static int atk_register_hwmon(struct atk_data *data)
>>  	data->hwmon_dev = hwmon_device_register_with_groups(dev, "atk0110",
>>  							    data,
>>  							    data->attr_groups);
>> -	if (IS_ERR(data->hwmon_dev))
>> -		return PTR_ERR(data->hwmon_dev);
>>  
>> -	return 0;
>> +	return PTR_ERR_OR_ZERO(data->hwmon_dev);
>>  }
>>  
>>  static int atk_probe_if(struct atk_data *data)
>> -- 
>> 1.7.12.4
>>
>


