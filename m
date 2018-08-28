Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7588C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD7F2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTGBbbkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD7F2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeH1M4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:56:46 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45883 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeH1M4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:56:46 -0400
Received: by mail-io0-f196.google.com with SMTP id e12-v6so763733iok.12;
        Tue, 28 Aug 2018 02:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SuRpIrdCE6fFlmTlu/FK2z56JrIrqY8rAiUGQVt2q8w=;
        b=JTGBbbkOqmC5bDe01hCUse90F+0Hxoa7ZllXRaxd/3KDwZYYNeJMPBMth8NjnPvbOD
         79UMPN+fsNQUjilBH4HNcutE1EceTvGiDpx4wtKam18H8xYq+9g9nlOQCC8Dj71R4YWd
         p5YTybAWiAxP5Geo58WLUo7CwFkLYya1tVqLzSULF7HiqvAEddHnlWOu/DtqCcCR9rEL
         UFqiFyA0zhPWoD2pzthzGpwfD6crvDs8K1GaD9y80xFQZATNUhv4hDk2tENJeuviqMr5
         c8qa4eKbaAXQamiBEwasvILgwy4UVN5TrLjbLefioPncfs0axPRXeAxqN0Xmojw7ATPw
         v31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SuRpIrdCE6fFlmTlu/FK2z56JrIrqY8rAiUGQVt2q8w=;
        b=VLvgFV9TJiRcAAg86YFsfA7HMxKYEYi519MRlkyQueXM0PDCgA1Bq3djNm3NJXdSGq
         BqrJUYOrr0VTs7kQVNwi10qV5BptCkXOt/Tq9dM0lC8mxwNQVVBZc8ZHnukDc87JMsZI
         NCpYRR+iNvvzvI4g6tM6qawQ+Z1vOLtSTRaB/Ga1yhigQRTSvnYpmfbOT38FCfUha0du
         1Az7of5yNae0fUv9Ywb4MF6QRWLx3OdG29wdrq40RucQNKGEnOZsYlVMIcnu3CEsvi5B
         B/yYSTVYxQIy6n7f1a+jkFGSx+tLD1jkzyFznTx4YPddomxU013LvDh1h7+qL9mWu/Zg
         q/7g==
X-Gm-Message-State: APzg51D743sXHMvui5wpcQkH7Mh9ICiN6GQ6MJXvSCmqjK1+tisdKnx/
        z+CY+sqgBlyLHw4vUtBaBRV1jAV+
X-Google-Smtp-Source: ANB0VdZ7W43Hy6P9QQLdcvOwhKdkgcnMO0+k+iC2OvlzA2yTtdWRsm1ZBwISuDLBnhZRXhGScaSNMg==
X-Received: by 2002:a6b:2147:: with SMTP id h68-v6mr469824ioh.192.1535447164496;
        Tue, 28 Aug 2018 02:06:04 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.15? ([2402:f000:1:1501:200:5efe:a66f:470f])
        by smtp.gmail.com with ESMTPSA id f8-v6sm296416ioq.10.2018.08.28.02.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:06:04 -0700 (PDT)
Subject: Re: [PATCH] rtc: rtc-omap: Replace mdelay() with msleep() in
 omap_rtc_power_off()
To:     Johan Hovold <johan@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     j-keerthy@ti.com, a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180730135314.9336-1-baijiaju1990@gmail.com>
 <20180827205517.GD24549@piout.net> <20180828084940.GA28861@localhost>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <72f42d57-90d1-83d5-3d1d-e82a2250a8ff@gmail.com>
Date:   Tue, 28 Aug 2018 17:06:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180828084940.GA28861@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/28 16:49, Johan Hovold wrote:
> On Mon, Aug 27, 2018 at 10:55:17PM +0200, Alexandre Belloni wrote:
>> Hi,
>>
>> On 30/07/2018 21:53:14+0800, Jia-Ju Bai wrote:
>>> omap_rtc_power_off() is never called in atomic context.
>>> It calls mdelay() to busily wait, which is not necessary.
>>> mdelay() can be replaced with msleep().
>>>
>>> This is found by a static analysis tool named DCNS written by myself.
>>>
>>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>>> ---
>>>   drivers/rtc/rtc-omap.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
>>> index 39086398833e..ef3d09525d0f 100644
>>> --- a/drivers/rtc/rtc-omap.c
>>> +++ b/drivers/rtc/rtc-omap.c
>>> @@ -476,7 +476,7 @@ static void omap_rtc_power_off(void)
>>>   	 * power off the system. Add a 500 ms margin for external latencies
>>>   	 * (e.g. debounce circuits).
>>>   	 */
>>> -	mdelay(2500);
>>> +	msleep(2500);
>> I'm not sure about that one because this is a poweroff function so it
>> doesn't really make sense to sleep versus busy waiting (all the drivers
>> in power/reset use mdelay())
> This power-off handler is called with interrupts disabled (as mentioned
> in the function header) and must not sleep.

Thanks for your reply :)

I check the code again, and find that you are right.
Sorry for my incorrect report.


Best wishes,
Jia-Ju Bai
