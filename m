Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC36C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D4520846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3MKz/rL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D4520846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbeFTKFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:05:42 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36864 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeFTKFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:05:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id y5-v6so1362570pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 03:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ybZ6l0/FKbOA/dhRErV7E4i06mHDeHq7tUIEdJJDjVc=;
        b=g3MKz/rLD3wxc1Cp1K6/6xItkcLDpBLYjUu/B+QosH71gaxpHSjwnZ1ZUjYu7NAcI/
         obRPfSFlU+jJQO349xYAwTfPFJU4njKeefWgqxdJSADPgA1BT+pmDYntj3IFVBKq6G2V
         PsQpndt0nAOT2Q01pzBi26OlltFekx/ssGAtIXdI+sDZuRrkTO4Gsv1MT5LxU2zixMsV
         pBAI9yUS6j0OqHOQHjhV0SE6rUsDryDjrWgha2IPqNy3ptqSY7Gk4qiAG9z5ohT0H0yL
         vllCLOylCpA5k849XUWHUwBZSAGUrhm0Wlzt6wMJqk8stwvVABPpgfkJ38RjvoomtaCD
         /xjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ybZ6l0/FKbOA/dhRErV7E4i06mHDeHq7tUIEdJJDjVc=;
        b=pg0KzXZ5CBlwzvTt7nj+nF+YRgV/EQoPF5ko/Ow+IOGsjTFplaWDnsspd0eeYPWTbm
         dalswRgiKmceruuPqSrIggJLLQLeVAmLgcls5Vp7ZMy/CSnS5azp36Q6LnPgSivSSLcg
         gM+PJnArxeJ39UeNSoh/UfoCbgrrKMr014G9ArYHX3v4JESvu1WZErnDZbeaVzWbklGZ
         uTMk1Jq6T+pr3NMjGI7IP6z8x28FJT/ts0s8pz0WBF9/wYK450caPMdLHgYs41elErSq
         cV2eZJ0H0Olq0Oeteu5ihtge61EvDEIsnaEDt6RS/M0kZ75owvcAlUr4t3gWDeIcl+qF
         usLg==
X-Gm-Message-State: APt69E3yUAccobXa/wbes0x02K5UXBLcOJGt/HYjvhw8g2+oMhZ3/1Pl
        J3X9j9zAmDYIuYaXas9k4G06AZss
X-Google-Smtp-Source: ADUXVKKH08tmavmryE9N17NBxodG3kt0OD9fx/al+evuNvoLfmVP9zzn3mCgH8RrNkSvjMdBw+gnuA==
X-Received: by 2002:a65:538e:: with SMTP id x14-v6mr18053625pgq.330.1529489138600;
        Wed, 20 Jun 2018 03:05:38 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.70.11? ([2402:f000:1:1501:200:5efe:a66f:460b])
        by smtp.gmail.com with ESMTPSA id g4-v6sm1924943pgc.8.2018.06.20.03.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 03:05:38 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: Fix two possible
 sleep-in-atomic-context bugs in translate_scan()
To:     Dan Carpenter <dan.carpenter@oracle.com>, cocci@systeme.lip6.fr,
        Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     gregkh@linuxfoundation.org, quytelda@tamalin.org,
        Larry.Finger@lwfinger.net, harshasharmaiitr@gmail.com,
        arushisinghal19971997@gmail.com, amitoj1606@gmail.com,
        jeremy.lefaure@lse.epita.fr, teo.dacquet@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180620095016.8484-1-baijiaju1990@gmail.com>
 <20180620095650.fga6xi7fyjgybs76@mwanda>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <dd6eaaad-413e-bd5d-d0f4-0a6d05438395@gmail.com>
Date:   Wed, 20 Jun 2018 18:05:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180620095650.fga6xi7fyjgybs76@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/6/20 17:56, Dan Carpenter wrote:
> On Wed, Jun 20, 2018 at 05:50:16PM +0800, Jia-Ju Bai wrote:
>> The driver may sleep with holding a spinlock.
>> The function call paths (from bottom to top) in Linux-4.16.7 are:
>>
>> [FUNC] kzalloc(GFP_KERNEL)
>> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 323:
>> 		kzalloc in translate_scan
>> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 1554:
>> 		translate_scan in rtw_wx_get_scan
>> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 1533:
>> 		spin_lock_bh in rtw_wx_get_scan
>>
>> [FUNC] kzalloc(GFP_KERNEL)
>> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 455:
>> 		kzalloc in translate_scan
>> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 1554:
>> 		translate_scan in rtw_wx_get_scan
>> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 1533:
>> 		spin_lock_bh in rtw_wx_get_scan
>>
>> To fix these bugs, GFP_KERNEL is replaced with GFP_ATOMIC.
>>
>> These bugs are found by my static analysis tool (DSAC-2) and checked by
>> my code review.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
>> index b26533983864..7632b8974563 100644
>> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
>> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
>> @@ -321,7 +321,7 @@ static char *translate_scan(struct adapter *padapter,
>>   		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.Ssid.Ssid));
>>   		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
>>   
>> -		buf = kzalloc(MAX_WPA_IE_LEN*2, GFP_KERNEL);
>> +		buf = kzalloc(MAX_WPA_IE_LEN*2, GFP_ATOMIC);
>>   		if (!buf)
>>   			return start;
> Thanks!  It occurs to me that another way to detect this bug is that
> one of the allocations in this function already uses GFP_ATOMIC.  It
> doesn't normally make sense to mix GFP_ATOMIC and GFP_KERNEL when there
> isn't any locking in the function.

Yes, this pattern is interesting for bug finding :)
But to fix the bugs of this pattern, we need to decide whether 
GFP_ATOMIC or GFP_KERNEL should be used here.


Best wishes,
Jia-Ju Bai
