Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77951C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446CC20874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="twAYXpOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeLRLyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:54:06 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37930 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeLRLyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:54:04 -0500
Received: by mail-it1-f193.google.com with SMTP id h65so3860552ith.3;
        Tue, 18 Dec 2018 03:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XG561vlEbhMFJiYgq/xx1pNfBZk+bYzH3azxFJSzktE=;
        b=twAYXpOWHOc8Ev3iieU3LRN88jEk/k2yMqsr9KNJM4mjNMAxX3iZyEDgtOEX4CsmIy
         y2X/JsvPU2lQzTDNEep9K80srNSSes74E2kPIP4cFnlUXxfJ5KsTPr8hWQ+aqz+C2Kyl
         e6v4tVVJ5rOuDjcTTLTJXHQHjfzNWoyqwvAP24N4Gju9fw144lx+YTc5hopN0g9hT7mY
         SRZFatDiqh9Oeaph12HRxHb6B+TEIWsLfMPsOiuyKvd4GD393J1AWdoPdO7NH6PN5HaF
         scg0WsFRpmbdHFZFAW97BnJe94u49DfJdGLtqjiz5LxE2bnGhjrnnxQRX7aWR6O4tiSX
         M+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XG561vlEbhMFJiYgq/xx1pNfBZk+bYzH3azxFJSzktE=;
        b=TaLXRCwonQuSLZHnaUJQDg6G2zrEoK7l49JQA6Iaib/WW5+J0WCwBnEheMgHiDCFD6
         guFvlz582WG5vICGiMFLm4Lv6OgInGi0UOnNDwdxAepbSbZI/I+1JaMPU5jaLUHVrx6W
         jcFjAfcsQ7YJtaYMXf3DoSeGVUQE4s0I4HEiJYttO/DFSvAerd5pH7lJ2lH3Nu6+Hzzl
         SqH4aTJLaOrWH1PRbDPl1BI7Oz8EliFDrrCKtpeOn9qInmXFQiilujO8hePMqlKxq4BY
         bQEBQU3yp8KApKdkrDG6e4hZJeAY2YT0qCqsXvY/2apwThU0G890fdYOLdMmj2NSSlty
         +T6Q==
X-Gm-Message-State: AA+aEWaitnngaCEqqNLVR8tXwH+ibxKwQzQdNS/+u8l3XQRAqH+7wrBr
        wHXNL3zV+Vd9yk3Kg5w3u7DP9PfR
X-Google-Smtp-Source: AFSGD/U8gsfhbflXkdhkuLa1MolcSzK4CF6J0JLIu6dUoaBH64RfzPLiKdqaqKWclx02vo9+sPB4IA==
X-Received: by 2002:a24:ad0:: with SMTP id 199mr2511963itw.142.1545134042735;
        Tue, 18 Dec 2018 03:54:02 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.24? ([2402:f000:1:1501:200:5efe:a66f:4718])
        by smtp.gmail.com with ESMTPSA id 79sm1551366itx.11.2018.12.18.03.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 03:54:02 -0800 (PST)
Subject: Re: [PATCH] r8a66597: Fix a possible concurrency use-after-free bug
 in r8a66597_endpoint_disable()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181218100020.26250-1-baijiaju1990@gmail.com>
 <20181218111149.GA979@kroah.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <e94fc8ed-9f18-7da7-5768-e768153e1d7d@gmail.com>
Date:   Tue, 18 Dec 2018 19:53:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181218111149.GA979@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/12/18 19:11, Greg KH wrote:
> On Tue, Dec 18, 2018 at 06:00:20PM +0800, Jia-Ju Bai wrote:
>> The function r8a66597_endpoint_disable() and r8a66597_urb_enqueue() may
>> be concurrently executed.
>> The two functions both access a possible shared variable "hep->hcpriv".
>>
>> This shared variable is freed by r8a66597_endpoint_disable() via the
>> call path:
>> r8a66597_endpoint_disable
>>    kfree(hep->hcpriv) (line 1995 in Linux-4.19)
>>
>> This variable is read by r8a66597_urb_enqueue() via the call path:
>> r8a66597_urb_enqueue
>>    spin_lock_irqsave(&r8a66597->lock);
>>    init_pipe_info
>>      enable_r8a66597_pipe
>>        pipe = hep->hcpriv (line 802 in Linux-4.19)
>>
>> The read operation is protected by a spinlock, but the free operation
>> is not protected by this spinlock, thus a concurrency use-after-free bug
>> may occur.
>>
>> To fix this bug, the spin-lock and spin-unlock function calls in
>> r8a66597_endpoint_disable() are moved to protect the free operation.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   drivers/usb/host/r8a66597-hcd.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
>> index 984892dd72f5..1495ce14ad22 100644
>> --- a/drivers/usb/host/r8a66597-hcd.c
>> +++ b/drivers/usb/host/r8a66597-hcd.c
>> @@ -1991,13 +1991,14 @@ static void r8a66597_endpoint_disable(struct usb_hcd *hcd,
>>   		return;
>>   	pipenum = pipe->info.pipenum;
>>   
>> +	spin_lock_irqsave(&r8a66597->lock, flags);
> Don't you also need the __aquires/__releases markings on this function
> in order to properly annotate it, like the rest of the driver has?

Okay, thanks for this suggestion :)
I will send a v2 patch.


Best wishes,
Jia-Ju Bai
