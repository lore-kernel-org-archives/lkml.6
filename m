Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6571C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540722174D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540722174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeHXNmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 09:42:52 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:10421 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeHXNmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 09:42:51 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5b7fd9284e7-dc1bd; Fri, 24 Aug 2018 18:08:40 +0800 (CST)
X-RM-TRANSID: 2eec5b7fd9284e7-dc1bd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.21.81] (unknown[112.25.154.148])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75b7fd926b29-49d4b;
        Fri, 24 Aug 2018 18:08:40 +0800 (CST)
X-RM-TRANSID: 2ee75b7fd926b29-49d4b
Subject: Re: [PATCH] staging: greybus: Fix null pointer dereference
To:     Johan Hovold <johan@kernel.org>
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <1535083631-1892-1-git-send-email-dingxiang@cmss.chinamobile.com>
 <20180824062930.GS14967@localhost>
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
Message-ID: <e7ff8e83-1982-a0bc-e959-2657adf0647e@cmss.chinamobile.com>
Date:   Fri, 24 Aug 2018 18:08:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180824062930.GS14967@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Johan

     sorry, it's my fault.


On 8/24/2018 2:29 PM, Johan Hovold wrote:
> On Fri, Aug 24, 2018 at 12:07:11AM -0400, Ding Xiang wrote:
>> If fw is null then fw->size will trigger null pointer dereference
>>
>> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
>> ---
>>   drivers/staging/greybus/bootrom.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
>> index e85ffae..3af28a0 100644
>> --- a/drivers/staging/greybus/bootrom.c
>> +++ b/drivers/staging/greybus/bootrom.c
>> @@ -297,7 +297,7 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
>>   
>>   queue_work:
>>   	/* Refresh timeout */
>> -	if (!ret && (offset + size == fw->size))
>> +	if (!ret && fw && (offset + size == fw->size))
>>   		next_request = NEXT_REQ_READY_TO_BOOT;
>>   	else
>>   		next_request = NEXT_REQ_GET_FIRMWARE;
> How could fw be NULL when ret is 0 here?
>
> It may not be as obvious as one might have wished, but the current code
> looks correct to me.
>
> Johan
>




