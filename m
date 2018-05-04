Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeEDGI4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 02:08:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45364 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeEDGIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 02:08:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FC2D607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH] gpu: drm: bridge: adv7511: Replace mdelay with
 usleep_range in adv7511_probe
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: a.hajda@samsung.com, airlied@linux.ie, daniel.vetter@ffwll.ch,
        bhumirks@gmail.com, narmstrong@baylibre.com, inki.dae@samsung.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1523435622-4329-1-git-send-email-baijiaju1990@gmail.com>
 <5009396.5p49gfLLAe@avalon>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <4cc08136-b05f-89d9-6e6f-dcd12ebc86d3@codeaurora.org>
Date: Fri, 4 May 2018 11:38:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5009396.5p49gfLLAe@avalon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday 27 April 2018 03:46 AM, Laurent Pinchart wrote:
> Hi Jia-Ju,
> 
> Thank you for the patch.
> 
> On Wednesday, 11 April 2018 11:33:42 EEST Jia-Ju Bai wrote:
>> adv7511_probe() is never called in atomic context.
>> This function is only set as ".probe" in struct i2c_driver.
>>
>> Despite never getting called from atomic context, adv7511_probe()
>> calls mdelay() to busily wait.
>> This is not necessary and can be replaced with usleep_range() to
>> avoid busy waiting.
>>
>> This is found by a static analysis tool named DCNS written by myself.
>> And I also manually check it.
> 
> Nice work ! Is the tool open-source ?
> 
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
>> b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c index b2431ae..2cf7fa1
>> 100644
>> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
>> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
>> @@ -1054,7 +1054,7 @@ static int adv7511_probe(struct i2c_client *i2c, const
>> struct i2c_device_id *id) }
>>
>>   	if (adv7511->gpio_pd) {
>> -		mdelay(5);
>> +		usleep_range(5000, 6000);
>>   		gpiod_set_value_cansleep(adv7511->gpio_pd, 0);
>>   	}
> 
> The patch looks good to me.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

queued to drm-misc-next

Thanks,
Archit
