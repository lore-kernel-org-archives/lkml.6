Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFD3ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C42206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C42206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388916AbeIUHYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:24:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56872 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388788AbeIUHYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:24:46 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4AD67B30D126C;
        Fri, 21 Sep 2018 09:38:20 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 09:38:18 +0800
Message-ID: <5BA44B89.6090006@huawei.com>
Date:   Fri, 21 Sep 2018 09:38:17 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <jdelvare@suse.com>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: remove redundant continue
References: <1537431070-38261-1-git-send-email-zhongjiang@huawei.com> <20180920173045.GA15272@roeck-us.net>
In-Reply-To: <20180920173045.GA15272@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/21 1:30, Guenter Roeck wrote:
> On Thu, Sep 20, 2018 at 04:11:10PM +0800, zhong jiang wrote:
>> The continue will not truely skip any code. hence it is safe to
>> remove it.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> The proper subject line would be
>
> hwmon: (scpi-hwmon) <summary>
>
> Since it now happened several times that I got a patch without proper
> subject (ie where the subject does not even mention the affected driver),
> I am no longer going to accept patches if the affected driver is missing,
> sorry.
I will fix that and resend.  Thanks

Sincerely,
zhong jiang
> Guenter
>
>> ---
>>  drivers/hwmon/scpi-hwmon.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
>> index 7e49da5..111d521 100644
>> --- a/drivers/hwmon/scpi-hwmon.c
>> +++ b/drivers/hwmon/scpi-hwmon.c
>> @@ -286,10 +286,8 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>>  		 * any thermal zones or if the thermal subsystem is
>>  		 * not configured.
>>  		 */
>> -		if (IS_ERR(z)) {
>> +		if (IS_ERR(z))
>>  			devm_kfree(dev, zone);
>> -			continue;
>> -		}
>>  	}
>>  
>>  	return 0;
>> -- 
>> 1.7.12.4
>>
>


