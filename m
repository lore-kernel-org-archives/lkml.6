Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B52C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 17:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD523208A5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 17:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC7y9QsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD523208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754361AbeGHRgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 13:36:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36536 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754281AbeGHRgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 13:36:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so18483966wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8VSazNXmQLXhdqvjhGoAieTdQQ6jbQdwEKVfVGcVz/I=;
        b=mC7y9QsNMMh69rPXqcwCnfw/ricKwwq/UCwhWytfBsfjRF2WvkPeta/K3JeUOWfa6U
         /BCQnf/be47x//tPafX6hN3RLuGbnhHtHjbVRQq9t3qd4GtLx66BK1kU1hwwJ2x/q8SP
         gjm56VofVrFqOP7zis0rm/CSsrUCfa6lNNDWopBDpNHZR8l+mg2Aagxvh8E0gLlLzywK
         03lVMAaFYUgvb4n7trjtxHSmShN4fDx9barckVmuNJ/WcsRZQBccmsfWLuSpilY/bweM
         tc57tBl+9GCJYsBjtFXw45+pD6CpqyxgEDqIEuTactPsdK3BXCQIk0EcE/gXFnEJKaLM
         m8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8VSazNXmQLXhdqvjhGoAieTdQQ6jbQdwEKVfVGcVz/I=;
        b=dZVWuCbs5oxW6M4gS2U944I7OIjxhdhDw/cn80P82svMqkUHqsWItLzUJifsYfXx7h
         Ls6tno/UGIZslcVnzkUzoX0Eer/YsfIUQ5ton1ky6VI07KnTKAJfKEksp7mqvFMYap9s
         FMADf1kqhbm09NDlxqpSU6d8BRWqdzjPp80ltFzS2W/eHG4aNx5WmKTtbuTkU3KfRFpD
         BDQTLMI5H9GSxEF4pkJXJuhd/aVFGCgotgW8qL+KbMMk070cPnMXaWyHmybd0y5eIQ9m
         4R7DdcYuLjgunTgNcXKHjamzjved/UHHH30P/WsfiwriPdwADsH6h+BoAK/tUK0qZ38z
         hQGg==
X-Gm-Message-State: APt69E0kqFzQobr1OmD591Y+7JMRn4uh12LswJ1ytXbG92yT9+ve4Bie
        NbDuQg+qpfvNf4vOqAR2mrKzSRnnFpw=
X-Google-Smtp-Source: AAOMgpeuWgUI4HkxaoKRGO4nvDCBKllzPEadYwoVPms8/z3+ayTcq7PQPB7qSQGlDjtXhVX4wSPJyA==
X-Received: by 2002:a1c:87c9:: with SMTP id j192-v6mr9786524wmd.71.1531071375136;
        Sun, 08 Jul 2018 10:36:15 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:e571:8dc2:bb09:5229? ([2a02:8108:85c0:57c8:e571:8dc2:bb09:5229])
        by smtp.gmail.com with ESMTPSA id 31-v6sm959170wra.26.2018.07.08.10.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 10:36:14 -0700 (PDT)
Subject: Re: [PATCH 3/6] staging: rtl8723bs: fix indentation
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180708103855.12473-1-straube.linux@gmail.com>
 <20180708103855.12473-3-straube.linux@gmail.com>
 <194c5239a1ef9a1f472bad7c5bcc6e3b7675b0ec.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <b7468cdd-1555-ef61-b475-3d4677aa423a@gmail.com>
Date:   Sun, 8 Jul 2018 19:36:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <194c5239a1ef9a1f472bad7c5bcc6e3b7675b0ec.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/18 18:46, Joe Perches wrote:
> On Sun, 2018-07-08 at 12:38 +0200, Michael Straube wrote:
>> Remove unrequired extra indentations.
> []
>> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> []
>> @@ -69,16 +69,16 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
>>   
>>   uint rtw_is_cckrates_included(u8 *rate)
>>   {
>> -		u32 i = 0;
>> +	u32 i = 0;
>>   
>> -		while (rate[i] !=  0) {
>> -			if  ((((rate[i]) & 0x7f) == 2)	|| (((rate[i]) & 0x7f) == 4) ||
>> -			     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
>> -				return true;
>> -			i++;
>> -		}
>> +	while (rate[i] !=  0) {
>> +		if  ((((rate[i]) & 0x7f) == 2)	|| (((rate[i]) & 0x7f) == 4) ||
>> +		     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
>> +			return true;
>> +		i++;
>> +	}
>>   
>> -		return false;
>> +	return false;
>>   }
> 
> Hi Michael.
> 
> Please try to improve the code for human readers and/or
> reduce overall object size over merely shutting up checkpatch
> style warnings.
> 

Hi Joe,

I agree that it's better to improve the code than just silence
warnings.

Thanks for your advice.

> For instance:
> 
> You could reduce object size a little by eliminating the
> multiple use of 0x7f and index and dereferencing the
> pointer instead.
> 
> $ size drivers/staging/rtl8723bs/core/rtw_ieee80211.o*
>     text	   data	    bss	    dec	    hex	filename
>    10085	     76	      0	  10161	   27b1	drivers/staging/rtl8723bs/core/rtw_ieee80211.o.new
>    10149	     76	      0	  10225	   27f1	drivers/staging/rtl8723bs/core/rtw_ieee80211.o.old
> 
> Something like:
> 
> uint rtw_is_cckrates_included(u8 *rate)
> {
> 	while (*rate) {
> 		u8 r = *rate & 0x7f;
> 
> 		if (r == 2 || r == 4 || r == 11 || r == 22)
> 			return true;
> 		rate++;
> 	}
> 
> 	return false;
> }
> 
> uint rtw_is_cckratesonly_included(u8 *rate)
> {
> 	while (*rate) {
> 		u8 r = *rate & 0x7f;
> 
> 		if (r != 2 && r != 4 && r != 11 && r != 22)
> 			return false;
> 		rate++;
> 	}
> 
> 	return true;
> }
> 

The patch has been added to staging-testing already.
I will send patches with your suggestions the next days.

Thanks again.

Michael
